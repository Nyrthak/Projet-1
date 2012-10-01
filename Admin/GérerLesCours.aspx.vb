Imports Model

Partial Class Admin_GérerLesCours
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
        hFieldNoCours.Value = leCoursAjouté.noCours
        mViewCours.ActiveViewIndex = 1
    End Sub

    Protected Sub lViewCours_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewCours.ItemCommand
        Dim leNoCours As String = e.CommandArgument
        If e.CommandName = "Delete" Then
            Dim leCoursADeleter As Cours = (From monCours In lecontext.CoursSet Where monCours.noCours = leNoCours Select monCours).First
            lecontext.CoursSet.DeleteObject(leCoursADeleter)
            lecontext.SaveChanges()
            Response.Redirect("~/Admin/GérerLesCours.aspx")
        ElseIf e.CommandName = "Modifier" Then
            hFieldNoCours.Value = e.CommandArgument
            lViewModifierCours.EditIndex = 0
            mViewCours.ActiveViewIndex = 1
        End If

    End Sub

    Protected Sub lViewModifierCours_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewModifierCours.ItemCommand
        If e.CommandName = "Annuler" Then
            Dim leNoCours As String = hFieldNoCours.Value
            Dim leCoursADeleter As Cours = (From monCours In lecontext.CoursSet Where monCours.noCours = leNoCours Select monCours).First
            If leCoursADeleter.Nom = "Entrez un nom" Then
                lecontext.CoursSet.DeleteObject(leCoursADeleter)
                lecontext.SaveChanges()
                mViewCours.ActiveViewIndex = 0
            End If
        End If
        mViewCours.ActiveViewIndex = 0
    End Sub

    Protected Sub lViewModifierCours_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewModifierCours.ItemUpdated
        mViewCours.ActiveViewIndex = 0
        lViewCours.DataBind()
    End Sub

End Class