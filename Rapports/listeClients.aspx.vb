Imports Model
Partial Class Admin_ListeClients
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
#End Region

#Region "Contrôle d'erreur"

#End Region

#Region "Contrôles"
    Protected Sub lnkGenerer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkGenerer.Click
        Dim url As String = "imprimListeClients.aspx?"
        For Each critere As ListItem In chkBoxCompte.Items
            url &= "&" & critere.Value & "=" & critere.Selected
        Next
        For Each critere As ListItem In chkBoxMembre.Items
            url &= "&" & critere.Value & "=" & critere.Selected
        Next
        For Each typeTri As ListItem In ddListTriComptes.Items
            If typeTri.Selected Then
                url &= "&triCompte=" & typeTri.Value
            End If
        Next
        For Each typeTri As ListItem In ddListTriMembres.Items
            If typeTri.Selected Then
                url &= "&triMembre=" & typeTri.Value
            End If
        Next
        Response.Redirect(url)
    End Sub
#End Region   
End Class
