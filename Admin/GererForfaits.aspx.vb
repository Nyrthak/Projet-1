'Systeme: Permet de s'incrire à des activitées pour le site CSL
'Auteurs: Lawrence Dubé et Katherine Vandal
'Fonctionnalités:
'       -Ajout/suppression d'un forfait par un admin
'Intrants:
'       le nombre d'enfant
'       le pourcentage de réduction
'Extrants: Elle affiche une liste de forfait déjà ajouté
'       le nombre d'enfant
'       le pourcentage de réduction
'Dernière mise à jours: 6 novembre 2012

Imports Model
Partial Class Admin_GererForfaits
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
       Handles entiDataSourceForfaits.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles entiDataSourceForfaits.ContextDisposing
        e.Cancel = True
    End Sub
#End Region

#Region "Contrôle d'erreur"
    Protected Sub lViewForfaits_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lViewForfaits.ItemDeleted
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "suppression")
        Else
            lblMessage.Text = "Le forfait pour " & e.Keys(0) & " inscrits a été supprimé."
        End If
    End Sub

    Protected Sub lViewForfaits_ItemEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewEditEventArgs) Handles lViewForfaits.ItemEditing
        lblMessage.Text = ""
    End Sub

    Protected Sub lViewForfaits_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewInsertedEventArgs) Handles lViewForfaits.ItemInserted
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "insertion")
        Else
            lblMessage.Text = "Le forfait " & e.Values(0) & " inscrits a été ajouté."
        End If
    End Sub

    Protected Sub lViewForfaits_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewForfaits.ItemUpdated
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "mise à jour")
            e.KeepInEditMode = True
            e.ExceptionHandled = True
        Else
            lblMessage.Text = "Le forfait " & e.NewValues(0) & " inscrits a été modifié."
        End If
    End Sub
#End Region

#Region "Contrôles"
    Sub customV_NbInscrits(ByVal sender As Object, ByVal e As ServerValidateEventArgs)
        Dim nbInscrits = e.Value
        If (From unForfait In lecontext.Forfait Where unForfait.nbInscrits = nbInscrits Select unForfait).Count > 0 Then
            e.IsValid = False
        Else
            e.IsValid = True
        End If
    End Sub
#End Region
End Class
