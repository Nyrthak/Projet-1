﻿Imports Model

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

            If username.motDePasseCrypté = CreatePasswordHash(loginCtrl.Password, salt) Then
                e.Authenticated = True
                Session.Add("userOnline", loginCtrl.UserName)
                Session.Add("userType", username.Type)
            End If
        Next
    End Sub


    Protected Sub loginCtrl_LoggedIn(ByVal sender As Object, ByVal e As System.EventArgs) Handles loginCtrl.LoggedIn
        If Session("userType") = 1 Then
            Page.Response.Redirect("~/Default.aspx")
        End If
        If Session("userType") = 2 Then
            Response.Redirect("~/prepose/pagePrepose.aspx")
        End If
        If Session("userType") = 3 Then
            Response.Redirect("~/admin/default.aspx")
        End If


    End Sub
End Class
