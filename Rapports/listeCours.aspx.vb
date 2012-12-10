Imports Model
Partial Class Admin_ListeCours
    Inherits pageMaster
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
        Dim url As String = "imprimListeCours.aspx?"
        For Each critere As ListItem In chkBoxCours.Items
            url &= "&" & critere.Value & "=" & critere.Selected
        Next
        For Each critere As ListItem In chkBoxGroupe.Items
            url &= "&" & critere.Value & "=" & critere.Selected
        Next
        For Each typeTri As ListItem In ddListTriCours.Items
            If typeTri.Selected Then
                url &= "&triCours=" & typeTri.Value
            End If
        Next
        For Each typeTri As ListItem In ddListTriGroupe.Items
            If typeTri.Selected Then
                url &= "&triGroupe=" & typeTri.Value
            End If
        Next
        Response.Redirect(url)
    End Sub
#End Region
End Class
