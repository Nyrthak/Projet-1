'Systeme: Permet de s'incrire à des activitées pour le site CSL
'Auteurs: Lawrence Dubé et Katherine Vandal
'Fonctionnalités:
'       -Ajout/modification/suppression d'un groupe d'âge
'Intrants:
'       le nom
'Extrants: Elle affiche une de groupe d'âge
'       le nom
'       le numéro
'Dernière mise à jours: 6 novembre 2012
Imports Model
Partial Class Admin_GererGroupesDAge
    Inherits page

#Region "Page"
    Private Shared lecontext As ModelContainer = Nothing
    Protected Sub page_load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub
#End Region

#Region "EntityDataSource"
    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
       Handles entiDataSourceGroupesDAge.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles entiDataSourceGroupesDAge.ContextDisposing
        e.Cancel = True
    End Sub
#End Region

#Region "Contrôle d'erreur"
    Protected Sub lViewGroupesDAge_ItemDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeleteEventArgs) Handles lViewGroupesDAge.ItemDeleting
        Dim noGroupeDAge As Integer = e.Keys(0)
        If (From unCours In lecontext.Cours Where unCours.GroupeDAge.noGroupeDAge = noGroupeDAge Select unCours).Count > 0 Then
            Dim leGroupeDAge As GroupeDAge = (From unGroupeDAge In lecontext.GroupeDAge Where unGroupeDAge.noGroupeDAge = noGroupeDAge Select unGroupeDAge).FirstOrDefault
            lbMessage.Text = "Vous ne pouvez supprimer le groupe d'âge " & leGroupeDAge.NomGroupeDAge & ", car il est relié à au moins un cours."
            e.Cancel = True
        End If
    End Sub

    Protected Sub lViewGroupesDAge_ItemEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewEditEventArgs) Handles lViewGroupesDAge.ItemEditing
        lbMessage.Text = ""
    End Sub

    Protected Sub lViewGroupesDAge_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lViewGroupesDAge.ItemDeleted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "suppression")
        Else
            lbMessage.Text = "Le groupe d'âge a été supprimé."
        End If
    End Sub

    Protected Sub lViewGroupesDAge_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewInsertedEventArgs) Handles lViewGroupesDAge.ItemInserted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "insertion")
        Else
            lbMessage.Text = "Le groupe d'âge " & e.Values(0) & " a été ajouté."
        End If
    End Sub

    Protected Sub lViewGroupesDAge_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewGroupesDAge.ItemUpdated
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "mise à jour")
            e.KeepInEditMode = True
            e.ExceptionHandled = True
        Else
            lbMessage.Text = "Le groupe d'âge " & e.NewValues(0) & " a été modifié."
        End If
    End Sub
#End Region

#Region "Contrôles"
#End Region

End Class
