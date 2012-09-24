Imports Model

Partial Class Admin_AjoutCours
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

    Protected Sub btnAjoutCours_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAjoutCours.Click
        Dim leCoursAjouté As Cours = New Cours()
        leCoursAjouté.Nom = txtNomDuCours.Text
        leCoursAjouté.Prix = Convert.ToDouble(txtPrix.Text)
        leCoursAjouté.Description = txtDescription.Text
        leCoursAjouté.Catégorie = (From dl In lecontext.CatégorieSet
                                         Where dl.noCatégorie = dDListCategorie.SelectedValue
                                         Select dl).First
        leCoursAjouté.GroupeDAge = (From dl In lecontext.GroupeDAgeSet
                                         Where dl.noGroupeDAge = dDListGroupeDAge.SelectedValue
                                         Select dl).First
        leCoursAjouté.Session = (From dl In lecontext.SessionSet
                                         Where dl.noSession = dDListSession.SelectedValue
                                         Select dl).First
        If Not dDListPrerequis.SelectedValue = 0 Then
            leCoursAjouté.noCoursRequis = dDListPrerequis.SelectedValue
        End If


        lecontext.AddObject("CoursSet", leCoursAjouté)
        lecontext.SaveChanges()

        txtNomDuCours.Text = ""
        txtPrix.Text = ""
        txtDescription.Text = ""
        dDListCategorie.SelectedIndex = 0
        dDListGroupeDAge.SelectedIndex = 0
        dDListSession.SelectedIndex = 0
        dDListPrerequis.DataBind()
        dDListPrerequis.SelectedIndex = 0
    End Sub

    Protected Sub dDListPrerequis_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dDListPrerequis.DataBound
        dDListPrerequis.Items.Insert(0, New ListItem("Aucun", "0"))
    End Sub
End Class
