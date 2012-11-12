'Cette page permet d'afficher, ajouter, modifier et supprimer les jours.
Imports Model
Partial Class Admin_GererJours
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
       Handles entiDataSourceJours.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles entiDataSourceJours.ContextDisposing
        e.Cancel = True
    End Sub
#End Region

#Region "Contrôle d'erreur"
    Protected Sub lViewJours_ItemDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeleteEventArgs) Handles lViewJours.ItemDeleting
        Dim noJour As Integer = e.Keys(0)
        If (From unHoraire In lecontext.Horaire Where unHoraire.Jour.noJour = noJour Select unHoraire).Count > 0 Then
            Dim leJour As Jour = (From unJour In lecontext.Jour Where unJour.noJour = noJour Select unJour).FirstOrDefault
            lbMessage.Text = "Vous ne pouvez supprimer le jour " & leJour.nomJour & ", car il est relié à au moins un horaire."
            e.Cancel = True
        End If
    End Sub

    Protected Sub lViewJours_ItemEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewEditEventArgs) Handles lViewJours.ItemEditing
        lbMessage.Text = ""
    End Sub

    Protected Sub lViewJours_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lViewJours.ItemDeleted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "suppression")
        Else
            lbMessage.Text = "Le jour a été supprimé."
        End If
    End Sub

    Protected Sub lViewJours_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewInsertedEventArgs) Handles lViewJours.ItemInserted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "insertion")
        Else
            lbMessage.Text = "Le jour " & e.Values(0) & " a été ajouté."
        End If
    End Sub

    Protected Sub lViewJours_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewJours.ItemUpdated
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "mise à jour")
            e.KeepInEditMode = True
            e.ExceptionHandled = True
        Else
            lbMessage.Text = "Le jour " & e.NewValues(0) & " a été modifié."
        End If
    End Sub
#End Region

#Region "Contrôles"
#End Region

End Class
