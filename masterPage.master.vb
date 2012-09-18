
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
End Class

