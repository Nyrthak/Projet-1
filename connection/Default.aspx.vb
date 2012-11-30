
Partial Class connection_Default
    Inherits System.Web.UI.Page

    ' PAYPAL PAYMENTS PRO
    ' DIRECT PAYMENT
    ' IL EST INTERDIT DE STOCKER LE NO DE CARTE DE CRÉDIT
    '
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        doTransaction("4583279825118372",
                      "Visa",
                      "112017",
                      "123",
                      "1.01",
                      "Test",
                      "User",
                      "235, rue Saint-Jacques",
                      "Granby",
                      "QC",
                      "J2G9H7")
    End Sub

    Protected Sub doTransaction(ByVal ccNumber As String,
                                ByVal ccType As String,
                                ByVal expireDate As String,
                                ByVal cvvNum As String,
                                ByVal amount As String,
                                ByVal firstName As String,
                                ByVal lastName As String,
                                ByVal street As String,
                                ByVal city As String,
                                ByVal state As String,
                                ByVal zip As String)

        'API INFORMATIONS (3)
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
            'AFFICHE LA RÉPONSE

            If strAck = "Success" OrElse
                strAck = "SuccessWithWarning" Then
                Dim strAmt As String = htResponse("AMT").ToString()
                Dim strCcy As String = htResponse("CURRENCYCODE").ToString()
                Dim strTransactionID As String = htResponse("TRANSACTIONID").ToString()
                For Each i In htResponse
                    Response.Write(i.Key & ": " & i.Value & "<br />")
                Next
                'Dim strSuccess As String = "Merci pour votre commande de : $" & strAmt & " " & strCcy & ", celle-ci a bien été traitée."
                'successLabel.Text = strSuccess
            Else

                'Dim strErr As String = "Error: " & htResponse("L_LONGMESSAGE0").ToString()
                'Dim strErrcode As String = "Error code: " & htResponse("L_ERRORCODE0").ToString()

                'Response.Write(strErr & "&lt;br /&gt;" & strErrcode)</span>
                For Each i In htResponse
                    Response.Write(i.Key & ": " & i.Value & "<br />")
                Next

            End If
        Catch

            ' FAITES QQCHOSE
        End Try

    End Sub

End Class
