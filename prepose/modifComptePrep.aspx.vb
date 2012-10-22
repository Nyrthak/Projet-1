Imports Model
Partial Class prepose_modifComptePrep
    Inherits page
    Private Shared lecontext As ModelContainer = Nothing

    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
    Handles entiDataSourceMembre.ContextCreating, entiDataSourceProvince.ContextCreating

        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
    Handles entiDataSourceProvince.ContextDisposing, entiDataSourceMembre.ContextDisposing
        e.Cancel = True
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
        lbMessage.Text = ""
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        verificationTypeUser(2)
    End Sub

    Protected Sub lViewCompte_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewCompte.ItemUpdated
        lbMessage.Text = "Votre compte à bien été modifié."
    End Sub

    Protected Sub lViewMembre_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles lViewMembre.PreRender
        CType(lViewMembre.Items(0).FindControl("rangeValidatorDateNaissance"), RangeValidator).MaximumValue = Now.Date.ToShortDateString
        CType(lViewMembre.Items(0).FindControl("rangeValidatorDateNaissance"), RangeValidator).MinimumValue = Now.AddYears(-150).ToShortDateString
    End Sub

    Protected Sub lViewCompte_ItemUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdateEventArgs) Handles lViewCompte.ItemUpdating
        
    End Sub

    Protected Sub lViewCompte_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles lViewCompte.PreRender
        CType(lViewCompte.Items(0).FindControl("dropDownListProvince"), DropDownList).Items.Insert(0, "")
    End Sub

    Protected Sub btnEnregistrer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEnregistrer.Click 
        Dim noCompte As String = Session("noCompte")
        For Each courriel As String In (From dl In lecontext.Compte Where dl.noCompte <> noCompte Select dl.Email)
            If CType(lViewCompte.Items(0).FindControl("tbCourriel"), TextBox).Text = courriel Then
                Dim validatorEmail As CustomValidator = New CustomValidator
                validatorEmail.ErrorMessage = "Votre email est déja utilisé."
                validatorEmail.IsValid = False
                Me.Validators.Add(validatorEmail)
            End If
        Next
        If Me.IsValid Then
            lViewMembre.UpdateItem(0, True)
            lViewCompte.UpdateItem(0, True)
            lViewCompte.EditIndex = 0
            lViewMembre.EditIndex = 0
        End If
    End Sub

    Protected Sub btnModiMotDePasse_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnModiMotDePasse.Click
        multiViewModiCompte.ActiveViewIndex = 1
    End Sub

    Protected Sub btnEnregistrerPW_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEnregistrerPW.Click
        Dim salt = Session("userOnline").Substring(0, 3)
        Dim noCompte As String = Session("noCompte")
        Dim compte As Compte = (From monCompte In lecontext.Compte Where monCompte.noCompte = noCompte).First
        If tbNouvMotDePasse.Text.Count < 6 Then
            Dim validatorMotDePasse As CustomValidator = New CustomValidator
            validatorMotDePasse.ErrorMessage = "Votre nouveau mot de passe doit contenir plus de 5 caractères"
            validatorMotDePasse.IsValid = False
            Me.Validators.Add(validatorMotDePasse)
        End If
        If compte.motDePasseCrypté = CreatePasswordHash(tbMotDePasse.Text, salt) Then
            Dim hash As String = CreatePasswordHash(tbNouvMotDePasse.Text, salt)
            compte.motDePasseCrypté = hash
            lbMessage.Text = "Votre mot de passe à bien été changé."
        Else
            lbMessage.Text = "Votre ancient mot de passe n'est pas valide."
        End If
        If Me.IsValid Then
            lecontext.SaveChanges()
        End If
    End Sub

    Protected Sub btnAnnuler_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAnnuler.Click
        multiViewModiCompte.ActiveViewIndex = 0
    End Sub
End Class
