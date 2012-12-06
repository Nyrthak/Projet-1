Imports Model

Partial Class CompteClient
    Inherits page
    Private Shared lecontext As ModelContainer = Nothing

    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
    Handles entiDataSourceCompte.ContextCreating, entiDataSourceMembre.ContextCreating, entiDataSourceAjouterMembre.ContextCreating

        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
    Handles entiDataSourceCompte.ContextDisposing, entiDataSourceMembre.ContextDisposing, entiDataSourceAjouterMembre.ContextDisposing
        e.Cancel = True
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lbErreur.Text = ""
        lecontext = New ModelContainer()
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        verificationTypeUser(1)      
    End Sub

    'Protected Sub listViewMembres_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles listViewMembres.ItemCommand
    '    If e.CommandName = "supprime" Then
    '        Dim noMembre As Integer = e.CommandArgument
    '        Dim present As Boolean = False
    '        For Each membreDeleter As Membre In lecontext.Membre
    '            If membreDeleter.noMembre = noMembre Then
    '                present = True
    '            End If
    '        Next
    '        If present = True Then
    '            'Supprime le membre qui dont le nom est "Entrez un nom"
    '            Dim leMembreADeleter As Membre = (From monMembre In lecontext.Membre Where monMembre.noMembre = noMembre Select monMembre).First
    '            If leMembreADeleter.Propriétaire = False Then
    '                lecontext.Membre.DeleteObject(leMembreADeleter)
    '                lecontext.SaveChanges()
    '                Response.Redirect("~/client/compteClient.aspx")
    '            Else
    '                lbErreur.Text = "Vous ne pouvez pas supprimer le propriétaire du compte."
    '            End If
    '        End If
    '    End If
    'End Sub

    Protected Sub btnAjouter_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAjouter.Click
        Dim ajouterMembre As Membre = New Membre()
        Dim noCompte As Integer = Session("noCompte")

        ajouterMembre.Nom = "Entrez un nom"
        ajouterMembre.Prénom = "Entrez un prénom"
        ajouterMembre.DateNaissance = Date.Now
        ajouterMembre.Propriétaire = False
        ajouterMembre.Parent = True
        ajouterMembre.Compte = (From dl In lecontext.Compte Where dl.noCompte = noCompte Select dl).First

        lecontext.AddObject("Membre", ajouterMembre)
        lecontext.SaveChanges()
        multiViewMembre.ActiveViewIndex = 1
        lViewAjoutMembre.EditIndex = 0
        hiddenFieldNoMembre.Value = ajouterMembre.noMembre
    End Sub


    Protected Sub lViewAjoutMembre_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewAjoutMembre.ItemCommand
        Dim noCompteCourant As Integer = Session("noCompte")
        If e.CommandName = "Cancel" Then
            'Teste si le membre a déleter est bien dans la base de donnée
            Dim noMembre As String = hiddenFieldNoMembre.Value
            Dim present As Boolean = False
            For Each membreDeleter As Membre In lecontext.Membre
                If membreDeleter.noMembre = noMembre Then
                    present = True
                End If
            Next
            If present = True Then
                'Supprime le membre qui dont le nom est "Entrez un nom" lorsqu'on cancel un ajout
                Dim leMembreADeleter As Membre = (From monMembre In lecontext.Membre Where monMembre.noMembre = noMembre Select monMembre).First
                If leMembreADeleter.Nom = "Entrez un nom" Then
                    lecontext.Membre.DeleteObject(leMembreADeleter)
                    lecontext.SaveChanges()
                End If
            End If
            multiViewMembre.ActiveViewIndex = 0
        End If
        'Vérifie si le compte à déjà 2 parents, si oui, il ne peut pas ajouter un membre "parent". Il peut tout de même ajouter un membre "Enfant"
        If CType(lViewAjoutMembre.Items(0).FindControl("rbListeTypeMembre"), RadioButtonList).SelectedValue = "True" Then
            If e.CommandName = "Update" Then
                Dim noMembre As String = hiddenFieldNoMembre.Value
                Dim nombreParent As Integer = (From unMembre As Membre In lecontext.Membre Where (unMembre.Compte.noCompte = noCompteCourant And unMembre.Parent = True And Not unMembre.noMembre = noMembre) Select unMembre).Count
                If nombreParent >= 2 Then
                    Dim validatorNombreParent As CustomValidator = New CustomValidator
                    validatorNombreParent.ValidationGroup = "A"
                    validatorNombreParent.ErrorMessage = "Il ne peut pas y avoir plus de deux parents."
                    validatorNombreParent.IsValid = False
                    Me.Validators.Add(validatorNombreParent)
                End If
            End If
        End If
    End Sub

    Protected Sub lViewAjoutMembre_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewAjoutMembre.ItemUpdated
        multiViewMembre.ActiveViewIndex = 0
        listViewMembres.DataBind()
    End Sub

    Protected Sub lViewAjoutMembre_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles lViewAjoutMembre.PreRender
        CType(lViewAjoutMembre.Items(0).FindControl("rangeValidatorDateNaissance"), RangeValidator).MaximumValue = Now.Date.ToShortDateString
        CType(lViewAjoutMembre.Items(0).FindControl("rangeValidatorDateNaissance"), RangeValidator).MinimumValue = Now.AddYears(-150).ToShortDateString
    End Sub

    Protected Sub viewMembres_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles viewMembres.Load
        'Supprime les membre qui dont le nom est "Entrez un nom"
        If Not multiViewMembre.ActiveViewIndex = 1 Then
            For Each membre As Membre In (From monMembre In lecontext.Membre Select monMembre)
                If membre.Nom = "Entrez un nom" Then
                    lecontext.Membre.DeleteObject(membre)
                End If
            Next
            lecontext.SaveChanges()
        End If
    End Sub
End Class
