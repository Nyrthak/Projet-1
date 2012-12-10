'Systeme: Permet de s'incrire à des activitées pour le site CSL
'Auteurs: Lawrence Dubé et Katherine Vandal
'Fonctionnalités:
'       -Ajout/suppression d'un preposé
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
'       spécialité
'Extrants: aucun
'Dernière mise à jours: 6 novembre 2012
Imports Model
Partial Class Admin_ajouterComptePrepose
    Inherits pageMaster
    Private Shared lecontext As ModelContainer = Nothing

#Region "Page"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()

        rangeValidatorDateNaissance.MinimumValue = Now.AddYears(-150).ToShortDateString
        rangeValidatorDateNaissance.MaximumValue = Now.Date.ToShortDateString
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        verificationTypeUser(3)
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
#Region "Controle d'erreur"
    Protected Sub entityDataSourceProvince_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entityDataSourceProvince.Selected
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
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
                validatorEmail.ErrorMessage = "L'email est déja utilisé."
                validatorEmail.IsValid = False
                Me.Validators.Add(validatorEmail)
            End If
        Next
        If tbMotDePasse.Text.Count < 6 Then
            Dim validatorMotDePasse As CustomValidator = New CustomValidator
            validatorMotDePasse.ErrorMessage = "Le mot de passe doit contenir plus de 5 caractères"
            validatorMotDePasse.IsValid = False
            Me.Validators.Add(validatorMotDePasse)
        End If
        'teste sur la carte de crédit

        If Me.IsValid Then
            Dim hash As String = CreatePasswordHash(tbMotDePasse.Text, salt)

            Dim compteAjoute As Compte = New Compte()
            Dim membreAjoute As Membre = New Membre()

            compteAjoute.Type = 2
            compteAjoute.Adresse = tbAdresse.Text
            compteAjoute.Ville = tbVille.Text
            compteAjoute.CodePostal = tbCodePostal.Text
            compteAjoute.ModePaiement = "Visa"
            compteAjoute.motDePasseCrypté = hash
            compteAjoute.Email = tbCourriel.Text
            compteAjoute.noTelephone = tbNumeroTelephone.Text
            compteAjoute.Province = (From dl In lecontext.Province Where dl.noProvince = dropDownListProvince.SelectedValue Select dl).First
            compteAjoute.Pays = tbPays.Text
            compteAjoute.Actif = True

            membreAjoute.Parent = True
            membreAjoute.Nom = tbNom.Text
            membreAjoute.Prenom = tbPrenom.Text
            membreAjoute.DateNaissance = DateTime.Parse(tbDateNaissance.Text)
            membreAjoute.Proprietaire = True

            compteAjoute.Membre.Add(membreAjoute)
            lecontext.AddObject("Compte", compteAjoute)
            lecontext.SaveChanges()

            Page.Response.Redirect("~/connection/inscriptionReusi.aspx")

        End If
    End Sub
#End Region



End Class
