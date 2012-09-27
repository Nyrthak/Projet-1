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
        If Session.Contents("userType") IsNot Nothing Then
            siteMapDataSource.SiteMapProvider = "siteMapLogged"
        Else
            siteMapDataSource.SiteMapProvider = "siteMapDefault"
        End If
    End Sub

    Protected Sub laginStatus_LoggingOut(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.LoginCancelEventArgs) Handles laginStatus.LoggingOut
        Session.Abandon()
    End Sub

End Class