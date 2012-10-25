Imports Model
Partial Class Admin_listesDattente
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
    'Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
    '    Handles EntityDataSourceGroupeDAge.ContextCreating
    '    'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
    '    If Not lecontext Is Nothing Then
    '        e.Context = lecontext
    '    End If
    'End Sub

    'Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
    '   Handles EntityDataSourceCategorie.ContextDisposing
    '    e.Cancel = True
    'End Sub

#End Region

#Region "Contrôle d'erreur"

#End Region

#Region "Contrôles"
    Protected Sub mViewListeDAttente_ActiveViewChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles mViewListeDAttente.ActiveViewChanged
        If mViewListeDAttente.ActiveViewIndex = 1 Then
            Dim leGroupe As Groupe = (From unGroupe In lecontext.Groupe Where unGroupe.noGroupe = hFieldNoGroupe.Value Select unGroupe).FirstOrDefault
            lblDetailListe.Text = leGroupe.Cours.Nom & " - Groupe " & leGroupe.noGroupe
        End If
    End Sub

    Protected Sub lviewListesDattente_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lviewListesDattente.ItemCommand
        If e.CommandName = "SelectionListe" Then
            hFieldNoGroupe.Value = e.CommandArgument
            mViewListeDAttente.ActiveViewIndex = 1
        End If
    End Sub
#End Region
End Class
