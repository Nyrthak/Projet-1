'Systeme: Permet de s'incrire à des activitées pour le site CSL
'Auteurs: Lawrence Dubé et Katherine Vandal
'Fonctionnalités:
'       -Ajoute/suppression d'une session
'Intrants:
'       le nom
'       date de début
'Extrants: Elle affiche une liste des catégorie déjà ajouté
'       -le numéro
'       -le nom
'       -Date de début
'Dernière mise à jours: 6 novembre 2012
Imports Model
Partial Class Admin_GererSessions
    Inherits page

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
       Handles entiDataSourceSessions.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles entiDataSourceSessions.ContextDisposing
        e.Cancel = True
    End Sub
#End Region

#Region "Contrôle d'erreur"
    Protected Sub lViewSessions_ItemDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeleteEventArgs) Handles lViewSessions.ItemDeleting
        Dim noSession As Integer = e.Keys(0)
        If (From unGroupe In lecontext.Groupe Where unGroupe.Session.noSession = noSession Select unGroupe).Count > 0 Then
            Dim laSession As Session = (From uneSession In lecontext.Session Where uneSession.noSession = noSession Select uneSession).FirstOrDefault
            lbMessage.Text = "Vous ne pouvez supprimer la session " & laSession.NomSession & ", car elle est reliée à au moins un groupe."
            e.Cancel = True
        End If
    End Sub

    Protected Sub lViewSessions_ItemEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewEditEventArgs) Handles lViewSessions.ItemEditing
        lbMessage.Text = ""
    End Sub

    Protected Sub lViewSessions_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lViewSessions.ItemDeleted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "suppression")
        Else
            lbMessage.Text = "La session a été supprimée."
        End If
    End Sub

    Protected Sub lViewSessions_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewInsertedEventArgs) Handles lViewSessions.ItemInserted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "insertion")
        Else
            lbMessage.Text = "La session " & e.Values(0) & " a été ajoutée."
        End If
    End Sub

    Protected Sub lViewSessions_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewSessions.ItemUpdated
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "mise à jour")
            e.KeepInEditMode = True
            e.ExceptionHandled = True
        Else
            lbMessage.Text = "La session " & e.NewValues(0) & " a été modifiée."
        End If
    End Sub
#End Region

#Region "Contrôles"
#End Region

End Class
