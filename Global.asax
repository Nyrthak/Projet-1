<%@ Application Language="VB" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Threading" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code qui s’exécute au démarrage de l’application
    End Sub
    
    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code qui s’exécute à l’arrêt de l’application
    End Sub
        
    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        Dim lastError As Exception = Server.GetLastError
        File.AppendAllText(Server.MapPath("~\App_Data\Error.log"), "Erreur survenue le " + Now().ToLongDateString + vbCrLf)
        File.AppendAllText(Server.MapPath("~\App_Data\Error.log"), "  " + lastError.ToString + vbCrLf + vbCrLf)
        Response.Redirect("~\erreur.aspx", True)
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code qui s’exécute lorsqu’une nouvelle session démarre
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code qui s’exécute lorsqu’une session se termine. 
        ' Remarque : l’événement Session_End est déclenché uniquement lorsque le mode sessionstate
        ' a la valeur InProc dans le fichier Web.config. Si le mode de session a la valeur StateServer 
        ' ou SQLServer, l’événement n’est pas déclenché.
    End Sub
    
    
    Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
        Dim aCookie As HttpCookie = Request.Cookies("langues")
        Dim langue As String = "FR"
        If aCookie IsNot Nothing Then
            langue = aCookie.Values("langue")
            
            Thread.CurrentThread.CurrentUICulture = CultureInfo.GetCultureInfo(langue & "-ca")
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(langue & "-ca")
        Else
            Thread.CurrentThread.CurrentUICulture = CultureInfo.GetCultureInfo(langue & "-ca")
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(langue & "-ca")
        End If
        Thread.CurrentThread.CurrentCulture.DateTimeFormat.ShortDatePattern = "dd-MM-yyyy"
        Thread.CurrentThread.CurrentCulture.DateTimeFormat.DateSeparator = "-"
    End Sub
       
</script>