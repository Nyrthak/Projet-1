Imports Model

Partial Class login
    Inherits page

    Private Shared lecontext As ModelContainer = Nothing

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
        loginCtrl.UserNameLabelText = "Adresse courriel:"
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

    Protected Sub loginCtrl_Authenticate(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.AuthenticateEventArgs) Handles loginCtrl.Authenticate
        If (From dl In lecontext.Compte Where dl.Email = loginCtrl.UserName).Count > 0 Then
            For Each compte As Compte In (From dl In lecontext.Compte Where dl.Email = loginCtrl.UserName)
                Dim salt = "manan"
                If compte.motDePasseCrypté = CreatePasswordHash(loginCtrl.Password, salt) Then
                    e.Authenticated = True
                    Session.Add("userOnline", loginCtrl.UserName)
                    Session.Add("userType", compte.Type)
                    Session.Add("noCompte", compte.noCompte)
                Else
                    loginCtrl.FailureText = "Le mot de passe ou l'adresse courriel n'est pas valide"
                End If
            Next
        Else
            loginCtrl.FailureText = "Le mot de passe ou l'adresse n'est pas valide"
        End If
    End Sub


    Protected Sub loginCtrl_LoggedIn(ByVal sender As Object, ByVal e As System.EventArgs) Handles loginCtrl.LoggedIn
        If Session("userType") = 1 Then
            Page.Response.Redirect("~/Default.aspx")
        End If
        If Session("userType") = 2 Then
            Response.Redirect("~/prepose/modifComptePrep.aspx")
        End If
        If Session("userType") = 3 Then
            Response.Redirect("~/admin/default.aspx")
        End If
    End Sub
End Class
