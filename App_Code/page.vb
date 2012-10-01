Imports Microsoft.VisualBasic
Imports System.Drawing.ColorTranslator
Public Class page
    Inherits System.Web.UI.Page
    Protected Friend Function validationRequisToutLesChamps(ByVal page As Control, ByVal validator As CustomValidator, ByVal compteur As Integer) As Boolean
        For Each ctrl As Control In page.Controls
            If TypeOf ctrl Is TextBox Then
                If (CType(ctrl, TextBox).Text) = "" Then
                    compteur += 1
                    CType(ctrl, TextBox).BorderColor = Drawing.Color.Red
                    validator.IsValid = False
                    validator.ErrorMessage = "Veuillez remplir tous les champs(" & compteur & ")"
                Else
                    CType(ctrl, TextBox).BorderColor = Nothing
                End If
            Else
                If ctrl.Controls.Count > 0 Then
                    validationRequisToutLesChamps(ctrl, validator, compteur)
                End If
            End If
        Next
        Return validator.IsValid
    End Function

    Protected Friend Function CreatePasswordHash(ByVal pwd As String, ByVal salt As String) As String
        Dim saltAndPwd As String = String.Concat(pwd, salt)
        Dim hashedPwd As String = FormsAuthentication.HashPasswordForStoringInConfigFile(saltAndPwd, "sha1")
        Return hashedPwd
    End Function


    Protected Friend Function verificationTypeUser(ByVal type As Integer) As Boolean
        Dim bonType As Boolean = False
        If Session("userType") = type Then
            bonType = True
        Else
            Response.Redirect("~/pageError.aspx")
        End If
        Return bonType
    End Function
End Class
