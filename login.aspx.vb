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
        For Each username As Compte In (From dl In lecontext.CompteSet Where dl.Email = loginCtrl.UserName)
            Dim salt = loginCtrl.UserName.Substring(0, 3)
            'If username.motDePasseCrypté = CreatePasswordHash(loginCtrl.Password, salt) Then
            '    Session.Contents("userOnline") = loginCtrl.UserName
            '    If username.Type = 1 Then
            '        Session.Contents("userType") = "Client"
            '    End If
            '    If username.type = 2 Then
            '        Session.Contents("userType") = "Prepose"
            '    End If
            '    If username.type = 3 Then
            '        Session.Contents("userType") = "Admin"
            '    End If
            '    Label1.Text = "YAYAYAYAYYAYA")
            'End If
        Next
        e.Authenticated = True
    End Sub


    Protected Sub loginCtrl_LoggingIn(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.LoginCancelEventArgs) Handles loginCtrl.LoggingIn

    End Sub
End Class
