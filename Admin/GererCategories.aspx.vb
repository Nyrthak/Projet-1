'Systeme: Permet de s'incrire à des activitées pour le site CSL
'Auteurs: Lawrence Dubé et Katherine Vandal
'Fonctionnalités:
'       -Ajoute/suppression d'une catégorie
'Intrants:
'       le nom
'Extrants: Elle affiche une liste des catégorie déjà ajouté
'       -le numéro
'       -le nom
'Dernière mise à jours: 6 novembre 2012

Imports Model
Partial Class Admin_GererCategories
    Inherits pageMaster

#Region "Page"
    Private Shared lecontext As ModelContainer = Nothing
    Protected Sub page_load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        verificationTypeUser(3)
    End Sub
#End Region

#Region "EntityDataSource"
    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
       Handles entiDataSourcecategorie.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles entiDataSourcecategorie.ContextDisposing
        e.Cancel = True
    End Sub
#End Region

#Region "Contrôle d'erreur"

    Protected Sub lViewCategorie_ItemDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeleteEventArgs) Handles lViewCategorie.ItemDeleting
        Dim noCategorie As Integer = e.Keys(0)
        If (From unCours In lecontext.Cours Where unCours.Categorie.noCategorie = noCategorie Select unCours).Count > 0 Then
            Dim laCategorie As Categorie = (From uneCategorie In lecontext.Catégorie Where uneCategorie.noCategorie = noCategorie Select uneCategorie).FirstOrDefault
            lbMessage.Text = "Vous ne pouvez supprimer la catégorie " & laCategorie.Nom & ", car elle est reliée à au moins un cours."
            e.Cancel = True
        End If
    End Sub

    Protected Sub lViewCategorie_ItemEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewEditEventArgs) Handles lViewCategorie.ItemEditing
        lbMessage.Text = ""
    End Sub

    Protected Sub lViewCategorie_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lViewCategorie.ItemDeleted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "suppression")
        Else
            lbMessage.Text = "La catégorie a été supprimée."
        End If
    End Sub

    Protected Sub lViewCategorie_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewInsertedEventArgs) Handles lViewCategorie.ItemInserted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "insertion")
        Else
            lbMessage.Text = "La catégorie " & e.Values(0) & " a été ajoutée."
        End If
    End Sub

    Protected Sub lViewCategorie_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewCategorie.ItemUpdated
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "mise à jour")
            e.KeepInEditMode = True
            e.ExceptionHandled = True
        Else
            lbMessage.Text = "La catégorie " & e.NewValues(0) & " a été modifiée."
        End If
    End Sub

    Protected Sub entiDataSourcecategorie_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourcecategorie.Selected
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub
#End Region

#Region "Contrôles"
#End Region


End Class
