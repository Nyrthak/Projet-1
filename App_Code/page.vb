Imports Microsoft.VisualBasic
Imports System.Drawing.ColorTranslator
Imports System.Net.Mail

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

    Protected Function traiteErreur(ByVal ex As Exception, ByVal quoi As String) As String
        Dim message As String = ""

        If ex IsNot Nothing Then
            message = "Il y a eut un problème lors de la " & quoi & "..."

            If ex.InnerException IsNot Nothing Then
                Dim inner As Exception = ex.InnerException

                If TypeOf inner Is System.Data.Common.DbException Then
                    message &= _
                       "Notre serveur de base de données a  actuellement des problèmes." & _
                       "Veuillez réessayer plus tard."
                ElseIf TypeOf inner _
                 Is System.Data.NoNullAllowedException Then
                    message &= _
                       "Un des champs dont la valeur est requise n'a pas été saisit."
                ElseIf TypeOf inner Is ArgumentException Then
                    Dim paramName As String = CType(inner, ArgumentException).ParamName
                    message &= _
                        String.Concat("La valeur de ", paramName, " est illégale.")
                ElseIf TypeOf inner Is ApplicationException Then
                    message &= inner.Message
                Else
                    message &= ex.ToString
                End If
            Else
                message &= ex.ToString
            End If
        End If

        ' LE LOGGÉ DANS UN FICHIER TEXTE SERAIT AUSSI UNE BONNE IDÉE. N' en afficher que la forme abrégée.
        Return message
    End Function

    Protected Function doTransaction(ByVal ccNumber As String,
                                    ByVal ccType As String,
                                    ByVal expireDate As String,
                                    ByVal cvvNum As String,
                                    ByVal amount As String,
                                    ByVal firstName As String,
                                    ByVal lastName As String,
                                    ByVal street As String,
                                    ByVal city As String,
                                    ByVal state As String,
                                    ByVal zip As String) As string

        Dim strUsername As String = "law_du_1354029082_biz_api1.hotmail.com"
        Dim strPassword As String = "1354029149"
        Dim strSignature As String = "AbxdJ4e-vQVe1Goo2pY7XD4uF17OAAdnyeQmBeJTAyiVy9k2uRheZNHQ"
        Dim strCredentials As String = "USER=" & strUsername & "&PWD=" & strPassword & "&SIGNATURE=" & strSignature
        Dim strNVPSandboxServer As String = "https://api-3t.sandbox.paypal.com/nvp"
        Dim strAPIVersion As String = "2.3"

        'credit card types: Visa, MasterCard, Discover, Amex
        Dim strNVP = strCredentials & "&METHOD=DoDirectPayment" & _
           "&CREDITCARDTYPE=" & ccType & _
           "&ACCT=" & ccNumber & _
           "&EXPDATE=" & expireDate & _
           "&CVV2=" & cvvNum & _
           "&AMT=" & amount & _
           "&CUSTOM=1234" & _
           "&CURRENCYCODE=CAD" & _
           "&FIRSTNAME=" & firstName & _
           "&LASTNAME=" & lastName & _
           "&STREET=" & street & _
           "&CITY=" & city & _
           "&STATE=" & state & _
           "&ZIP=" & zip & _
           "&COUNTRYCODE=CA" & _
           "&PAYMENTACTION=Sale" & _
           "&VERSION=" & strAPIVersion
        Try
            'Cree la requête
            Dim wrWebRequest As System.Net.HttpWebRequest = DirectCast(System.Net.WebRequest.Create(strNVPSandboxServer), 
                System.Net.HttpWebRequest)
            wrWebRequest.Method = "POST"
            Dim requestWriter As New System.IO.StreamWriter(wrWebRequest.GetRequestStream())
            requestWriter.Write(strNVP)
            requestWriter.Close()
            'Obtient la réponse
            Dim hwrWebResponse As System.Net.HttpWebResponse = DirectCast(wrWebRequest.GetResponse(), System.Net.HttpWebResponse)
            Dim responseReader As New System.IO.StreamReader(wrWebRequest.GetResponse().GetResponseStream())
            ' Lit la réponse
            Dim dataReturned As String = responseReader.ReadToEnd()
            responseReader.Close()
            Dim result As String = Server.UrlDecode(dataReturned)
            Dim arrResult As String() = result.Split("&"c)
            Dim htResponse As New Hashtable()
            Dim arrayReturned As String()
            For Each item As String In arrResult
                arrayReturned = item.Split("="c)
                htResponse.Add(arrayReturned(0), arrayReturned(1))
            Next

            Dim strAck As String = htResponse("ACK").ToString()
            Dim noPaypal As String = htResponse("TRANSACTIONID").ToString()
            'AFFICHE LA RÉPONSE

            If strAck = "Success" OrElse
                strAck = "SuccessWithWarning" Then

                Dim strAmt As String = htResponse("AMT").ToString()
                Dim strCcy As String = htResponse("CURRENCYCODE").ToString()
                Dim strTransactionID As String = htResponse("TRANSACTIONID").ToString()
                'For Each i In htResponse
                '    Response.Write(i.Key & ": " & i.Value & "<br />")
                'Next
                Return noPaypal

            Else

                'For Each i In htResponse
                '    Response.Write(i.Key & ": " & i.Value & "<br />")
                'Next
                Return ""
            End If

        Catch

            ' FAITES QQCHOSE
        End Try
        Return ""
    End Function

    Sub envoyerMailPaiementInscription(ByVal email As String,
                                       ByVal nomCours As String,
                                       ByVal nomGroupe As String,
                                       ByVal cout As Double,
                                       ByVal modePaiement As String,
                                       ByVal ville As String,
                                       ByVal province As String,
                                       ByVal codePostale As String,
                                       ByVal adresse As String)

        Dim strFrom As String = "nyrthak24@gmail.com"
        Dim SmtpServer As New SmtpClient()
        SmtpServer.Credentials = New Net.NetworkCredential(strFrom, "faladomi")
        SmtpServer.Port = 587
        SmtpServer.Host = "smtp.gmail.com"
        SmtpServer.EnableSsl = True
        Dim mail As New MailMessage(strFrom, email)
        mail.IsBodyHtml = True
        mail.Body = "<h2>CSL - Voici votre facture pour le cours " & nomCours & ".</h2><br />" &
                    "<h3>Information du cours</h3>" &
                    "Nom du cours: " & nomCours & "<br />" &
                    "Nom du groupe: " & nomGroupe & "<br />" &
                    "Total: " & cout & "$." &
                    "<br /><br />" &
                    "<h3>Informations de facturation" & "</h3><br />" &
                    "Adresse: " & adresse & "<br />" &
                    "Ville : " & ville & "<br />" &
                    "Province : " & province & "<br />" &
                    "Code postale : " & codePostale & "<br />" &
                    "Mode de paiement : " & modePaiement & "<br/>" &
                    "<h2>Merci de nous faire confiance!</h2>"
        mail.Subject = "Facture Cours " & nomCours
        SmtpServer.Send(mail)
    End Sub

    Sub envoyerMailPayerInscription(ByVal email As String,
                                     ByVal nomCours As String,
                                     ByVal nomGroupe As String,
                                     ByVal nomMembre As String)

        Dim strFrom As String = "nyrthak24@gmail.com"
        Dim SmtpServer As New SmtpClient()
        'Dim lien As String = +"/connection/login.aspx"
        SmtpServer.Credentials = New Net.NetworkCredential(strFrom, "faladomi")
        SmtpServer.Port = 587
        SmtpServer.Host = "smtp.gmail.com"
        SmtpServer.EnableSsl = True
        Dim mail As New MailMessage(strFrom, email)
        mail.IsBodyHtml = True
        mail.Body = "<h2>CSL - Nouvelle place.</h2><br />" &
                    "<h3>Une nouvelle place est disponible pour " & nomMembre & " pour le " & nomGroupe & " du cours " & nomCours & ".</h3><br />" &
                    "Veulliez vous rendre sur votre page de compte, ensuite dans 'Inscriptions non payés' pour payer votre inscription.<br />" &
                    "<a href=''>Connection.</a><br />" &
                    "<h2>Merci de nous faire confiance!</h2>"

        mail.Subject = "Nouvelle place - " & nomCours
        SmtpServer.Send(mail)
    End Sub

End Class
