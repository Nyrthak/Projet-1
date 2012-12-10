'Systeme: Permet de s'incrire à des activitées pour le site CSL
'Auteurs: Lawrence Dubé et Katherine Vandal
'Fonctionnalités:
'       -Inscription d'un client et paiement de l'inscription
'Intrants:
'       le nom
'       le prénom
'       le courriel
'       la date de naissance
'       le mot de passe
'       le mot de passe de confirmation
'       le numéro de téléphone
'       l'adresse
'       le code postale
'       la ville
'       la province
'       le pays
'       le type de carte
'       le numéro de sécurité
'       la date d'expiration
'       le nom du détenteur
'       le prénom du détenteur
'Extrants: Aucun, cette page n'est qu'un formulaire
'Dernière mise à jours: 6 novembre 2012

Imports System.Reflection
Imports System.Drawing
Imports Model
Imports System.Windows.Forms
Imports System.Net.Mail

Partial Class inscription
    Inherits page
    Private Shared lecontext As ModelContainer = Nothing

#Region "Page"
    Protected Sub page_load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Session("userOnline") = "" Then
            Page.Response.Redirect("~/Default.aspx")
        End If

        lecontext = New ModelContainer()

        'Remplissage du dropdownlist annee
        Dim i As Integer = 0
        dropDownListAnnee.Items.Add("")
        While i < 12
            dropDownListAnnee.Items.Add(Now.AddYears(i).Year)
            i += 1
        End While
        rangeValidatorDateNaissance.MinimumValue = Now.AddYears(-150).ToShortDateString
        rangeValidatorDateNaissance.MaximumValue = Now.AddYears(-18).ToShortDateString
    End Sub
    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

#End Region
#Region "EntityDataSource"
    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
    Handles entityDataSourceProvince.ContextCreating

        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub
    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
    Handles entityDataSourceProvince.ContextDisposing
        e.Cancel = True
    End Sub

#End Region        
#Region "Controle"
    Protected Sub btnEnregistrerInscription_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEnregistrerInscription.Click
        Dim compteur As Integer = 0
        Dim salt As String = "manan"
        'Dim aCookie As New HttpCookie("online")
        For Each courriel As String In (From dl In lecontext.Compte Select dl.Email)
            If tbCourriel.Text = courriel Then
                Dim validatorEmail As CustomValidator = New CustomValidator
                validatorEmail.ErrorMessage = "Votre email est déja utilisé."
                validatorEmail.IsValid = False
                Me.Validators.Add(validatorEmail)
            End If
        Next
        If tbMotDePasse.Text.Count < 6 Then
            Dim validatorMotDePasse As CustomValidator = New CustomValidator
            validatorMotDePasse.ErrorMessage = "Votre mot de passe doit contenir plus de 5 caractères"
            validatorMotDePasse.IsValid = False
            Me.Validators.Add(validatorMotDePasse)
        End If
        'teste sur la carte de crédit

        If Me.IsValid Then
            Dim noPaypal As String = doTransaction(tbNumeroCartePaiement.Text, rbListeTypeCarte.SelectedItem.Text, dropDownListMois.SelectedItem.Text & dropDownListAnnee.SelectedItem.Text, tbNumeroSecuriteCarte.Text, "50", tbPrenomPaiement.Text, tbNomPaiement.Text, tbAdresse.Text, _
                             tbVille.Text, dropDownListProvince.SelectedItem.Text, tbCodePostal.Text)
            If Not noPaypal = "" Then
                Dim hash As String = CreatePasswordHash(tbMotDePasse.Text, salt)

                Dim compteAjoute As Compte = New Compte()
                Dim membreAjoute As Membre = New Membre()

                compteAjoute.Type = 1
                compteAjoute.Adresse = tbAdresse.Text
                compteAjoute.Ville = tbVille.Text
                compteAjoute.CodePostal = tbCodePostal.Text
                compteAjoute.ModePaiement = rbListeTypeCarte.SelectedValue
                compteAjoute.motDePasseCrypté = hash
                compteAjoute.Email = tbCourriel.Text
                compteAjoute.noTelephone = tbNumeroTelephone.Text
                compteAjoute.Province = (From dl In lecontext.Province Where dl.noProvince = dropDownListProvince.SelectedValue Select dl).First
                compteAjoute.Pays = tbPays.Text
                compteAjoute.Actif = True

                membreAjoute.Nom = tbNom.Text
                membreAjoute.Prenom = tbPrenom.Text
                membreAjoute.DateNaissance = DateTime.Parse(tbDateNaissance.Text)
                membreAjoute.Proprietaire = True
                membreAjoute.Parent = True

                compteAjoute.Membre.Add(membreAjoute)
                lecontext.AddObject("Compte", compteAjoute)
                lecontext.SaveChanges()

                Dim strFrom As String = "nyrthak24@gmail.com"
                Dim SmtpServer As New SmtpClient()
                SmtpServer.Credentials = New Net.NetworkCredential(strFrom, "faladomi")
                SmtpServer.Port = 587
                SmtpServer.Host = "smtp.gmail.com"
                SmtpServer.EnableSsl = True
                Dim mail As New MailMessage(strFrom, tbCourriel.Text)
                mail.IsBodyHtml = True
                mail.Body = "<h2>CSL - Bienvenue!.</h2><br />" &
                            "Votre email de connection: " & compteAjoute.Email & ".<br />" &
                            "Vous avez payé votre inscription de 50$ de la façon suivante : " & compteAjoute.ModePaiement &
                            "Pour commencer à vous inscrire à une activitée, rendez vous à l'adresse suivante : <a href=''>Connection.</a>"
                mail.Subject = "Nouvelle inscription"
                SmtpServer.Send(mail)


                Page.Response.Redirect("~/connection/inscriptionReusi.aspx")
            Else
                Dim validatorErrorPaiement As CustomValidator = New CustomValidator
                validatorErrorPaiement.ErrorMessage = "Les informations de paiement que vous avez entré ne sont pas valide."
                validatorErrorPaiement.IsValid = False
                Me.Validators.Add(validatorErrorPaiement)
            End If
        End If
    End Sub
#End Region
#Region "Controle d'erreur"
    Protected Sub entityDataSourceProvince_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entityDataSourceProvince.Selected
        If e.Exception IsNot Nothing Then
            traiteErreur(e.Exception, "sélection")
        End If
    End Sub
#End Region
End Class
