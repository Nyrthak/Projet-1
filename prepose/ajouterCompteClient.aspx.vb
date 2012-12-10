Imports Model
'Systeme: Permet de s'incrire à des activitées pour le site CSL
'Auteurs: Lawrence Dubé et Katherine Vandal
'Fonctionnalités:
'       -Permet d'ajouter un compte client
'Intrants:
'       le nom
'       le prénom
'       adresse courriel
'       date de naissance
'       mot de passe
'       confirmation de mot de passe
'       numéro de téléphone
'       adresse
'       code postale
'       ville
'       province
'       pays
'       type de paiement
'Extrants: Aucun, ce n'est qu'un formulaire
'Dernière mise à jours: 6 novembre 2012

Partial Class prepose_ajouterCompteClient
    Inherits page
    Private Shared lecontext As ModelContainer = Nothing

    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
    Handles entityDataSourceProvince.ContextCreating

        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    'Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
    '    verificationTypeUser(2)
    'End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
    Handles entityDataSourceProvince.ContextDisposing
        e.Cancel = True
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        rangeValidatorDateNaissance.MinimumValue = Now.AddYears(-150).ToShortDateString
        rangeValidatorDateNaissance.MaximumValue = Now.AddYears(-18).ToShortDateString
        lecontext = New ModelContainer()
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

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

        If Me.IsValid Then
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
End Class
>>>>>>> Ajout des commentaires
