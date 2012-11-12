'Cette page permet d'afficher, ajouter, modifier et supprimer les provinces.
Imports Model
Partial Class Admin_GererProvinces
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
       Handles entiDataSourceProvinces.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles entiDataSourceProvinces.ContextDisposing
        e.Cancel = True
    End Sub
#End Region

#Region "Contrôle d'erreur"
    Protected Sub lViewProvinces_ItemDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeleteEventArgs) Handles lViewProvinces.ItemDeleting
        Dim noProvince As Integer = e.Keys(0)
        If (From unCompte In lecontext.Compte Where unCompte.Province.noProvince = noProvince Select unCompte).Count > 0 Or (From unAnimateur In lecontext.Animateur Where unAnimateur.Province.noProvince = noProvince Select unAnimateur).Count > 0 Then
            Dim laProvince As Province = (From uneProvince In lecontext.Province Where uneProvince.noProvince = noProvince Select uneProvince).FirstOrDefault
            lbMessage.Text = "Vous ne pouvez supprimer la province " & laProvince.Nom & ", car elle est reliée à au moins un animateur ou un compte."
            e.Cancel = True
        End If

    End Sub

    Protected Sub lViewProvinces_ItemEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewEditEventArgs) Handles lViewProvinces.ItemEditing
        lbMessage.Text = ""
    End Sub

    Protected Sub lViewProvinces_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lViewProvinces.ItemDeleted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "suppression")
        Else
            lbMessage.Text = "La province a été supprimée."
        End If
    End Sub

    Protected Sub lViewProvinces_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewInsertedEventArgs) Handles lViewProvinces.ItemInserted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "insertion")
        Else
            lbMessage.Text = "La province " & e.Values(0) & " a été ajoutée."
        End If
    End Sub

    Protected Sub lViewProvinces_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewProvinces.ItemUpdated
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "mise à jour")
            e.KeepInEditMode = True
            e.ExceptionHandled = True
        Else
            lbMessage.Text = "La province " & e.NewValues(0) & " a été modifiée."
        End If
    End Sub
#End Region

#Region "Contrôles"
#End Region

End Class
