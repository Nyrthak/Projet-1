'Systeme: Permet de s'incrire à des activitées pour le site CSL
'Auteurs: Lawrence Dubé et Katherine Vandal
'Fonctionnalités:
'       -Inscription d'un client et paiement de l'inscription
'Intrants:
'       le courriel
'       le mot de passe
'Extrants: Aucun, cette page n'est qu'un formulaire
'Dernière mise à jours: 6 novembre 2012


Imports Model
Imports System.Net.Mail

Partial Class login
    Inherits pageMaster

    Private Shared lecontext As ModelContainer = Nothing

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
        loginCtrl.UserNameLabelText = "Adresse courriel:"
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        If Session.Count > 0 Then
            Response.Redirect("~/prepose/modifComptePrep.aspx")
        End If
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

    Protected Sub loginCtrl_Authenticate(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.AuthenticateEventArgs) Handles loginCtrl.Authenticate
        If (From dl In lecontext.Compte Where dl.Email = loginCtrl.UserName).Count > 0 Then
            For Each compte As Compte In (From dl In lecontext.Compte Where dl.Email = loginCtrl.UserName)
                If compte.Actif = True Then
                    Dim salt = "manan"
                    If compte.motDePasseCrypté = CreatePasswordHash(loginCtrl.Password, salt) Then
                        e.Authenticated = True
                        Session.Add("userOnline", loginCtrl.UserName)
                        Session.Add("userType", compte.Type)
                        Session.Add("noCompte", compte.noCompte)
                        Session.Timeout = 25
                    Else
                        loginCtrl.FailureText = "Le mot de passe ou l'adresse courriel n'est pas valide"
                    End If
                Else
                    e.Authenticated = False
                    loginCtrl.FailureText = "Votre compte est désactivé, contacter un préposé."
                End If
            Next
        Else
            loginCtrl.FailureText = "Le mot de passe ou l'adresse n'est pas valide"
        End If
    End Sub


    Protected Sub loginCtrl_LoggedIn(ByVal sender As Object, ByVal e As System.EventArgs) Handles loginCtrl.LoggedIn
        If Session("userType") = 1 Then
            Dim noCompte As Integer = Session("noCompte")
            Dim compteParent As Compte = (From unCompte In lecontext.Compte Where unCompte.noCompte = noCompte Select unCompte).FirstOrDefault
            Dim lesMembres As New List(Of Membre)(From unMembre In lecontext.Membre Where unMembre.Compte.noCompte = noCompte Select unMembre)
            For Each leMembre As Membre In lesMembres
                If Not leMembre.Parent And leMembre.DateNaissance <= Date.Now.AddYears(-18) Then
                    Dim compteAjoute As Compte = New Compte()
                    Dim membreAjoute As Membre = New Membre()

                    compteAjoute.Type = 1
                    compteAjoute.Adresse = compteParent.Adresse
                    compteAjoute.Ville = compteParent.Ville
                    compteAjoute.CodePostal = compteParent.CodePostal
                    compteAjoute.ModePaiement = "Non payé"
                    compteAjoute.motDePasseCrypté = compteParent.motDePasseCrypté
                    compteAjoute.Email = leMembre.Prenom & "@csl.csl"
                    compteAjoute.noTelephone = compteParent.noTelephone
                    compteAjoute.Province = compteParent.Province
                    compteAjoute.Pays = compteParent.Pays

                    membreAjoute.Nom = leMembre.Nom
                    membreAjoute.Prenom = leMembre.Prenom
                    membreAjoute.DateNaissance = leMembre.DateNaissance
                    membreAjoute.Proprietaire = True
                    membreAjoute.Parent = True

                    lecontext.Membre.DeleteObject(leMembre)
                    compteAjoute.Membre.Add(membreAjoute)
                    lecontext.AddObject("Compte", compteAjoute)
                    lecontext.SaveChanges()

                    Dim strFrom As String = "nyrthak24@gmail.com"
                    Dim SmtpServer As New SmtpClient()
                    SmtpServer.Credentials = New Net.NetworkCredential(strFrom, "faladomi")
                    SmtpServer.Port = 587
                    SmtpServer.Host = "smtp.gmail.com"
                    SmtpServer.EnableSsl = True
                    Dim mail As New MailMessage(strFrom, compteParent.Email)
                    mail.IsBodyHtml = True
                    mail.Body = "<h2>CSL - Nouveau compte.</h2><br />" &
                                "Nous avons créé automatiquement un compte pour " & leMembre.Nom & ", car il vient d'avoir 18 ans aujourd'hui. <br /> " &
                                "Nous lui souhaitons bonne fête.<br />" &
                                "Pour l'activé vous devez entrer en contact avec un préposé par téléphone ou en personne.<br />" &
                                "Numéro de téléphone: (450) 111-2222 <br />" &
                                "Adresse: 48 rue Principal, Granby, Québec <br />" &
                                "<h2>Merci de nous faire confiance!</h2>"

                    mail.Subject = "Nouveau compte - " & leMembre.Nom
                    SmtpServer.Send(mail)
                End If
            Next
            Page.Response.Redirect("~/Default.aspx")
        End If
        If Session("userType") = 2 Then
            Response.Redirect("~/prepose/modifComptePrep.aspx")
        End If
        If Session("userType") = 3 Then
            Response.Redirect("~/admin/default.aspx")
        End If
    End Sub
End Class
