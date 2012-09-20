Imports Model

Partial Class Admin_AjoutCours
    Inherits System.Web.UI.Page

    Private Shared lecontext As ModelContainer = Nothing
    Protected Sub page_load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        lecontext = New ModelContainer()
    End Sub
    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
        Handles EntityDataSourceCategorie.ContextCreating, EntityDataSourceCours.ContextCreating, EntityDataSourceGroupeDAge.ContextCreating, EntityDataSourcePrerequis.ContextCreating, EntityDataSourceSession.ContextCreating

        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub
    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles EntityDataSourceCategorie.ContextDisposing, EntityDataSourceCours.ContextDisposing, EntityDataSourceGroupeDAge.ContextDisposing, EntityDataSourcePrerequis.ContextDisposing, EntityDataSourceSession.ContextDisposing

        e.Cancel = True
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

    Protected Sub btnAjoutCours_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAjoutCours.Click
        Dim leCoursAjouté As Cours = New Cours()
        leCoursAjouté.Nom = txtNomDuCours.Text
        leCoursAjouté.Prix = Convert.ToDouble(txtPrix.Text)
        leCoursAjouté.Description = txtDescription.Text
        leCoursAjouté.Catégorie = (From dl In lecontext.CatégorieSet
                                         Where dl.noCatégorie = dDListCategorie.SelectedValue
                                         Select dl).First
        leCoursAjouté.GroupeDAge = lecontext.GroupeDAgeSet(dDListGroupeDAge.SelectedValue)
        leCoursAjouté.Session = lecontext.SessionSet(dDListSession.SelectedValue)

        lecontext.AddObject("Cours", leCoursAjouté)
        lecontext.SaveChanges()
    End Sub
End Class
