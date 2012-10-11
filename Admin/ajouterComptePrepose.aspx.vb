Imports Model
Partial Class Admin_ajouterComptePrepose
    Inherits page
    Private Shared lecontext As ModelContainer = Nothing

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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()

        rangeValidatorDateNaissance.MinimumValue = Now.AddYears(-150)
        rangeValidatorDateNaissance.MaximumValue = Now.Date
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub


    Protected Sub btnEnregistrerInscription_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEnregistrerInscription.Click
        Dim compteur As Integer = 0
        Dim salt As String = ""
        'Dim aCookie As New HttpCookie("online")
        For Each courriel As String In (From dl In lecontext.CompteSet Select dl.Email)
            If tbCourriel.Text = courriel Then
                Dim validatorEmail As CustomValidator = New CustomValidator
                validatorEmail.ErrorMessage = "L'email est déja utilisé."
                validatorEmail.IsValid = False
                Me.Validators.Add(validatorEmail)
            Else
                salt = tbCourriel.Text.Substring(0, 3)
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
            compteAjoute.Abonnement = False
            compteAjoute.ModePaiement = "Visa"
            compteAjoute.motDePasseCrypté = hash
            compteAjoute.Email = tbCourriel.Text
            compteAjoute.noTelephone = tbNumeroTelephone.Text
            compteAjoute.Province = (From dl In lecontext.ProvinceSet Where dl.noProvince = dropDownListProvince.SelectedValue Select dl).First
            compteAjoute.Pays = tbPays.Text

            membreAjoute.Nom = tbNom.Text
            membreAjoute.Prénom = tbPrenom.Text
            membreAjoute.DateNaissance = DateTime.Parse(tbDateNaissance.Text)
            membreAjoute.Propriétaire = True

            compteAjoute.Membre.Add(membreAjoute)
            lecontext.AddObject("CompteSet", compteAjoute)
            lecontext.SaveChanges()

            Page.Response.Redirect("~/connection/inscriptionReusi.aspx")

        End If
    End Sub
    Protected Sub dropDownListProvince_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dropDownListProvince.DataBound
        dropDownListProvince.Items.Insert(0, "")
    End Sub
End Class
