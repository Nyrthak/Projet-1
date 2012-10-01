Imports Model

Partial Class monCompteClient
    Inherits page

    Private Shared lecontext As ModelContainer = Nothing

    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
    Handles entiDataSourceCompte.ContextCreating, entiDataSourceMembre.ContextCreating

        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
    Handles entiDataSourceCompte.ContextDisposing, entiDataSourceMembre.ContextDisposing
        e.Cancel = True
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        verificationTypeUser(1)
    End Sub

    Protected Sub listViewMembres_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles listViewMembres.ItemCommand
        If e.CommandName = "Ajout" Then
                multiViewMembre.ActiveViewIndex = 1
        End If

        If e.CommandName = "Enregistrer" Then
            listViewAjout.EditIndex = 0
        End If
    End Sub

    Protected Sub listViewMembres_ItemDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeleteEventArgs) Handles listViewMembres.ItemDeleting
        If e.ItemIndex = 0 Then
            e.Cancel = True
            lbErreur.Text = "Vous ne pouvez pas supprimer le propriétaire du compte."
        End If
    End Sub
End Class
