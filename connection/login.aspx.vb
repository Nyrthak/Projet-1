Imports Model

Partial Class login
    Inherits page

    Private Shared lecontext As ModelContainer = Nothing

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
        loginCtrl.UserNameLabelText = "Adresse courriel:"
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

    Protected Sub loginCtrl_Authenticate(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.AuthenticateEventArgs) Handles loginCtrl.Authenticate
        If (From dl In lecontext.Compte Where dl.Email = loginCtrl.UserName).Count > 0 Then
            For Each compte As Compte In (From dl In lecontext.Compte Where dl.Email = loginCtrl.UserName)
                Dim salt = "manan"
                If compte.motDePasseCrypté = CreatePasswordHash(loginCtrl.Password, salt) Then
                    e.Authenticated = True
                    Session.Add("userOnline", loginCtrl.UserName)
                    Session.Add("userType", compte.Type)
                    Session.Add("noCompte", compte.noCompte)
                Else
                    loginCtrl.FailureText = "Le mot de passe ou l'adresse courriel n'est pas valide"
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
            For Each leMembre As Membre In compteParent.Membre
                If Not leMembre.Parent And leMembre.DateNaissance <= Date.Now.AddYears(-18) Then
                    Dim compteAjoute As Compte = New Compte()
                    Dim membreAjoute As Membre = New Membre()

                    compteAjoute.Type = 1
                    compteAjoute.Adresse = compteParent.Adresse
                    compteAjoute.Ville = compteParent.Ville
                    compteAjoute.CodePostal = compteParent.CodePostal
                    compteAjoute.ModePaiement = "Non payé"
                    compteAjoute.motDePasseCrypté = "Adulte"
                    compteAjoute.Email = "Entrez un email"
                    compteAjoute.noTelephone = compteParent.noTelephone
                    compteAjoute.Province = compteParent.Province
                    compteAjoute.Pays = compteParent.Pays

                    membreAjoute.Nom = leMembre.Nom
                    membreAjoute.Prénom = leMembre.Prénom
                    membreAjoute.DateNaissance = leMembre.DateNaissance
                    membreAjoute.Propriétaire = True
                    membreAjoute.Parent = True

                    lecontext.Membre.DeleteObject(leMembre)
                    compteAjoute.Membre.Add(membreAjoute)
                    lecontext.AddObject("Compte", compteAjoute)
                    lecontext.SaveChanges()
                    'Envoyer un email pour qu'il set son mot de passe
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
