Imports Model

Partial Class Admin_GérerLesCours
    Inherits System.Web.UI.Page

    Private Shared lecontext As ModelContainer = Nothing
    Protected Sub page_load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        lecontext = New ModelContainer()
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

    Protected Sub btnAjouterUnCours_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAjouterUnCours.Click
        Dim leCoursAjouté As Cours = New Cours()
        leCoursAjouté.Nom = "Entrez un nom"
        leCoursAjouté.Prix = 0
        leCoursAjouté.Description = ""
        leCoursAjouté.Catégorie = (From dl In lecontext.CatégorieSet
                                         Where dl.noCatégorie = 1
                                         Select dl).First
        leCoursAjouté.GroupeDAge = (From dl In lecontext.GroupeDAgeSet
                                         Where dl.noGroupeDAge = 1
                                         Select dl).First
        leCoursAjouté.Session = (From dl In lecontext.SessionSet
                                         Where dl.noSession = 1
                                         Select dl).First
        leCoursAjouté.noCoursRequis = 0
        lecontext.AddObject("CoursSet", leCoursAjouté)
        lecontext.SaveChanges()
        Dim url As String = "~/Admin/ModifierCours.aspx?noCours=" & leCoursAjouté.noCours
        Response.Redirect(url)
    End Sub

    Protected Sub lViewCours_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewCours.ItemCommand
        Dim leNoCours As String = e.CommandArgument
        If e.CommandName = "Delete" Then
            Dim leCoursADeleter As Cours = (From monCours In lecontext.CoursSet Where monCours.noCours = leNoCours Select monCours).First
            lecontext.CoursSet.DeleteObject(leCoursADeleter)
            lecontext.SaveChanges()
            Response.Redirect("~/Admin/GérerLesCours.aspx")
        End If
    End Sub
End Class