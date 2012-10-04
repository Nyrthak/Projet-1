Partial Class coursDefault
    Inherits System.Web.UI.Page

    Protected Sub btnRechercher_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRechercher.Click
        mViewCours.ActiveViewIndex = 1
    End Sub

    Protected Sub lViewCatégorie_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewCatégorie.ItemCommand
        If e.CommandName = "ClickCatégorie" Then
            hFieldNoCategorie.Value = e.CommandArgument
            mViewCours.ActiveViewIndex = 1
        End If
    End Sub

    Protected Sub lViewListeCours_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewListeCours.ItemCommand
        If e.CommandName = "Selection" Then
            mViewCours.ActiveViewIndex = 2
            hFieldnoCours.Value = e.CommandArgument
            lviewCours.DataBind()
        End If
    End Sub
End Class
