Partial Class masterPage
    Inherits System.Web.UI.MasterPage


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Changement du sitemapprovider en fonction de si un utilisateur soit logger

        If Session("userType") IsNot Nothing Then
            siteMapDataSource.SiteMapProvider = "siteMapLogged"
        Else
            siteMapDataSource.SiteMapProvider = "siteMapDefault"
        End If
    End Sub

    Protected Sub laginStatus_LoggedOut(ByVal sender As Object, ByVal e As System.EventArgs) Handles laginStatus.LoggedOut
        Response.Redirect("~/default.aspx")
    End Sub

    Protected Sub laginStatus_LoggingOut(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.LoginCancelEventArgs) Handles laginStatus.LoggingOut
        Session.Abandon()
    End Sub


    Protected Sub menuTop_MenuItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.MenuEventArgs) Handles menuTop.MenuItemDataBound
        'Teste si le user est un préposé ou un admin, si oui, il ne peut pas cliquer sur le menu "monCompte"

        If e.Item.Text = "Mon compte" Then
            If Session("userType") = 2 Then
                e.Item.NavigateUrl = "~/prepose/modifComptePrep.aspx"
            End If
            If Session("userType") = 3 Then
                e.Item.NavigateUrl = "~/admin/default.aspx"
            End If
        End If
    End Sub

    Protected Sub menuTop_MenuItemClick(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.MenuEventArgs) Handles menuTop.MenuItemClick
        Dim assdsad As String = "blabla"
    End Sub
End Class