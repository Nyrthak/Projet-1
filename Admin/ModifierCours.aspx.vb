Imports Model
Partial Class Admin_ModifierCours
    Inherits System.Web.UI.Page
    Private Shared lecontext As ModelContainer = Nothing
    Protected Sub page_load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        lecontext = New ModelContainer()
    End Sub
    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
        Handles EntityDataSourceCategorie.ContextCreating, EntityDataSourceGroupeDAge.ContextCreating, EntityDataSourcePrerequis.ContextCreating, EntityDataSourceSession.ContextCreating

        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub
    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles EntityDataSourceCategorie.ContextDisposing, EntityDataSourceGroupeDAge.ContextDisposing, EntityDataSourcePrerequis.ContextDisposing, EntityDataSourceSession.ContextDisposing

        e.Cancel = True
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

    Protected Sub lViewCours_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewCours.ItemCommand
        If e.CommandName = "Annuler" Then
            Dim queryString As String = Request.QueryString("noCours")
            Dim leCoursADeleter As Cours = (From monCours In lecontext.CoursSet Where monCours.noCours = queryString Select monCours).First
            lecontext.CoursSet.DeleteObject(leCoursADeleter)
            lecontext.SaveChanges()
            Response.Redirect("~/Admin/GérerLesCours.aspx")
        End If
    End Sub
End Class
