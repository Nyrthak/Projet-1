'Cette page permet d'afficher, ajouter, modifier et supprimer les animateurs.
Imports Model
Partial Class Admin_GererAnimateurs
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
       Handles entiDataSourceAnimateurs.ContextCreating, entiDataSourceProvince.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles entiDataSourceAnimateurs.ContextDisposing, entiDataSourceProvince.ContextDisposing
        e.Cancel = True
    End Sub
#End Region

#Region "Contrôle d'erreur"

    Protected Sub lViewAnimateurs_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lViewAnimateurs.ItemDeleted
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "suppression")
        Else
            lblMessage.Text = "L'animateur a été supprimé."
        End If
    End Sub

    Protected Sub lViewAnimateurs_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewInsertedEventArgs) Handles lViewAnimateurs.ItemInserted
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "insertion")
        Else
            lblMessage.Text = "L'animateur " & e.Values(0) & " " & e.Values(1) & " a été ajouté."
        End If
    End Sub

    Protected Sub lViewAnimateurs_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewInsertEventArgs) Handles lViewAnimateurs.ItemInserting
        If e.Values(6) = Nothing Then
            Dim validateProvince As CustomValidator = New CustomValidator()
            validateProvince.ErrorMessage = "Veuillez ajouter au moins une province dans la base de données avant d'ajouter un animateur."
            validateProvince.ValidationGroup = "Insert"
            validateProvince.IsValid = False
            Page.Validators.Add(validateProvince)
            e.Cancel = True
        End If
    End Sub

    Protected Sub lViewAnimateurs_ItemEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewEditEventArgs) Handles lViewAnimateurs.ItemEditing
        lblMessage.Text = ""
    End Sub

    Protected Sub lViewAnimateurs_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewAnimateurs.ItemUpdated
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "mise à jour")
            e.KeepInEditMode = True
            e.ExceptionHandled = True
        Else
            lblMessage.Text = "L'animateur " & e.NewValues(0) & " " & e.NewValues(1) & " a été modifié."
        End If
    End Sub

    Protected Sub lViewAnimateurs_ItemDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeleteEventArgs) Handles lViewAnimateurs.ItemDeleting
        Dim noAnimateur As Integer = e.Keys(0)
        If (From unGroupe In lecontext.Groupe Where unGroupe.Animateur.noAnimateur = noAnimateur Select unGroupe).Count > 0 Then
            Dim lAnimateur As Animateur = (From unAnimateur In lecontext.Animateur Where unAnimateur.noAnimateur = noAnimateur Select unAnimateur).FirstOrDefault
            lblMessage.Text = "Vous ne pouvez supprimer l'animateur " & lAnimateur.Prénom & " " & lAnimateur.Nom & ", car il est relié à au moins un groupe."
            e.Cancel = True
        End If
    End Sub
#End Region

#Region "Contrôles"
    Protected Sub lViewAnimateurs_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewAnimateurs.ItemCommand
        If e.CommandName = "AnnulerSelect" Then
            lblMessage.Text = ""
            lViewAnimateurs.SelectedIndex = -1
        End If
    End Sub

    Protected Sub lViewAnimateurs_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lViewAnimateurs.SelectedIndexChanged
        lblMessage.Text = ""
    End Sub

    Sub customV_province(ByVal sender As Object, ByVal e As ServerValidateEventArgs)
        If e.Value = -1 Then
            e.IsValid = False
        End If
    End Sub
#End Region
End Class
