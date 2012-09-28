Partial Class masterPage
    Inherits System.Web.UI.MasterPage

    Protected Sub lnkBtLangue_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkBtLangue.Click
        Dim culture As String = ""
        If lnkBtLangue.Text = "English" Then

            If lnkBtLangue.Text = "English" Then
                culture = "EN"
            Else
                culture = "FR"
            End If

            Dim aCookie As New HttpCookie("langues")
            aCookie.Values("langue") = culture
            aCookie.Expires = System.DateTime.Now.AddDays(3650)
            Response.Cookies.Add(aCookie)
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("userType") = 1 Then
            lnkButtonPagePreposeAdmin.Text = ""
            lnkButtonPagePreposeAdmin.Visible = False
            lnkButtonPagePreposeAdmin.PostBackUrl = ""
        End If
        If Session("userType") = 2 Then
            lnkButtonPagePreposeAdmin.Text = "Page Préposé"
            lnkButtonPagePreposeAdmin.Visible = True
            lnkButtonPagePreposeAdmin.PostBackUrl = "~/prepose/pagePrepose.aspx"
        End If
        If Session("userType") = 3 Then
            lnkButtonPagePreposeAdmin.Text = "Page Admin"
            lnkButtonPagePreposeAdmin.Visible = True
            lnkButtonPagePreposeAdmin.PostBackUrl = "~/admin/default.aspx"
        End If

        If Session.Contents("userType") IsNot Nothing Then
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
        'Text si le user est un préposé ou un admin, si oui, il ne peut pas cliquer sur le menu "monCompte"
        If Session("userType") = 2 Or Session("userType") = 3 Then
            If e.Item.Text = "Mon compte" Then
                e.Item.Selectable = False
            End If
        End If
        If e.Item.Text = "Mon compte" Then
            e.Item.Selected = True
        End If
    End Sub
End Class