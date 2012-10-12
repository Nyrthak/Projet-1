Imports Model

Partial Class coursDefault
    Inherits System.Web.UI.Page

    Private Shared lecontext As ModelContainer = Nothing
    Protected Sub page_load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
    End Sub

    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
        Handles EntityDataSourceCatégorie.ContextCreating, entityDataSourceCours.ContextCreating, entityDataSourceGroupes.ContextCreating, entityDataSourceListeCours.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles EntityDataSourceCatégorie.ContextDisposing, entityDataSourceCours.ContextDisposing, entityDataSourceGroupes.ContextDisposing, entityDataSourceListeCours.ContextDisposing
        e.Cancel = True
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

    Protected Sub btnRechercher_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRechercher.Click
        mViewCours.ActiveViewIndex = 0
    End Sub

    Protected Sub lViewCatégorie_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewCatégorie.ItemCommand
        If e.CommandName = "ClickCatégorie" Then
            hFieldNoCategorie.Value = e.CommandArgument
            mViewCours.ActiveViewIndex = 0
        End If
    End Sub

    Protected Sub lViewListeCours_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewListeCours.ItemCommand
        If e.CommandName = "Selection" Then
            mViewCours.ActiveViewIndex = 1
            hFieldnoCours.Value = e.CommandArgument
            lviewCours.DataBind()
        End If
    End Sub

    Protected Sub lviewGroupes_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lviewGroupes.ItemCommand
        If e.CommandName = "Selection" Then
            mViewCours.ActiveViewIndex = 2
            hFieldnoGroupe2.Value = e.CommandArgument
        End If
    End Sub

    Protected Sub btnRetour_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRetour.Click
        mViewCours.ActiveViewIndex = 1
    End Sub
End Class
