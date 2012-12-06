'Cette page permet d'afficher, ajouter, modifier et supprimer les specialités.
Imports Model
Partial Class Admin_GererSpecialites
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
       Handles entiDataSourceSpecialites.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles entiDataSourceSpecialites.ContextDisposing
        e.Cancel = True
    End Sub
#End Region

#Region "Contrôle d'erreur"
    Protected Sub lViewSpecialites_ItemDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeleteEventArgs) Handles lViewSpecialites.ItemDeleting
        Dim noSpecialite As Integer = e.Keys(0)
        If (From uneSpecAnimateur In lecontext.SpécialitéAnimateur Where uneSpecAnimateur.Specialite.noSpecialite = noSpecialite Select uneSpecAnimateur).Count > 0 Then
            Dim laSpecialite As Specialite = (From uneSpecialite In lecontext.Spécialité Where uneSpecialite.noSpecialite = noSpecialite Select uneSpecialite).FirstOrDefault
            lbMessage.Text = "Vous ne pouvez supprimer la spécialité " & laSpecialite.nomSpecialite & ", car elle est reliée à au moins un animateur."
            e.Cancel = True
        End If
    End Sub

    Protected Sub lViewSpecialites_ItemEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewEditEventArgs) Handles lViewSpecialites.ItemEditing
        lbMessage.Text = ""
    End Sub

    Protected Sub lViewSpecialites_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lViewSpecialites.ItemDeleted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "suppression")
        Else
            lbMessage.Text = "La spécialité a été supprimée."
        End If
    End Sub

    Protected Sub lViewSpecialites_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewInsertedEventArgs) Handles lViewSpecialites.ItemInserted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "insertion")
        Else
            lbMessage.Text = "La spécialité " & e.Values(0) & " a été ajoutée."
        End If
    End Sub

    Protected Sub lViewSpecialites_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewSpecialites.ItemUpdated
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "mise à jour")
            e.KeepInEditMode = True
            e.ExceptionHandled = True
        Else
            lbMessage.Text = "La spécialité " & e.NewValues(0) & " a été modifiée."
        End If
    End Sub
#End Region

#Region "Contrôles"
#End Region

End Class
