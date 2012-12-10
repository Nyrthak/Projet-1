Imports Model
Partial Class Rapports_imprimListeCours
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

    Protected Sub lViewCours_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles lViewCours.ItemCreated
        If Not Request.QueryString("triCours") = "" Then
            CType(e.Item.FindControl("entiDataSourceGroupes"), EntityDataSource).OrderBy = "it.[" & Request.QueryString("triGroupe") & "]"
        End If
    End Sub

    Protected Sub entiDataSourceCours_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles entiDataSourceCours.Load
        If Not Request.QueryString("noCours") = "" Then
            entiDataSourceCours.OrderBy = "it.[" & Request.QueryString("triCours") & "]"

            If Request.QueryString("NomCours") = "False" Then
                lViewCours.FindControl("tdTitreNomCours").Visible = False
                For Each unCours In lViewCours.Items
                    unCours.FindControl("tdNomCours").Visible = False
                Next
            End If
            If Request.QueryString("Prix") = "False" Then
                lViewCours.FindControl("tdTitrePrix").Visible = False
                For Each unCours In lViewCours.Items
                    unCours.FindControl("tdPrix").Visible = False
                Next
            End If
            If Request.QueryString("ActifCours") = "False" Then
                lViewCours.FindControl("tdTitreActifCours").Visible = False
                For Each unCours In lViewCours.Items
                    unCours.FindControl("tdActifCours").Visible = False
                Next
            End If
            If Request.QueryString("Categorie") = "False" Then
                lViewCours.FindControl("tdTitreCategorie").Visible = False
                For Each unCours In lViewCours.Items
                    unCours.FindControl("tdCategorie").Visible = False
                Next
            End If
            If Request.QueryString("GroupeDAge") = "False" Then
                lViewCours.FindControl("tdTitreGroupeDAge").Visible = False
                For Each unCours In lViewCours.Items
                    unCours.FindControl("tdGroupeDAge").Visible = False
                Next
            End If
            If Request.QueryString("Prerequis") = "False" Then
                lViewCours.FindControl("tdTitrePrerequis").Visible = False
                For Each unCours In lViewCours.Items
                    unCours.FindControl("tdPrerequis").Visible = False
                Next
            End If
            If Request.QueryString("Description") = "False" Then
                lViewCours.FindControl("tdTitreDescription").Visible = False
                For Each unCours In lViewCours.Items
                    unCours.FindControl("tdDescription").Visible = False
                Next
            End If
            '*************************GROUPE*************************
            For Each unCours In lViewCours.Items
                If Request.QueryString("noGroupe") = "False" Then
                    lViewCours.FindControl("tdTitreNoGroupe").Visible = False
                    For Each unGroupe In CType(unCours.FindControl("lViewGroupes"), ListView).Items
                        unGroupe.FindControl("tdNoGroupe").Visible = False
                    Next
                End If
                If Request.QueryString("NomGroupe") = "False" Then
                    lViewCours.FindControl("tdTitreNomGroupe").Visible = False
                    For Each unGroupe In CType(unCours.FindControl("lViewGroupes"), ListView).Items
                        unGroupe.FindControl("tdNomGroupe").Visible = False
                    Next
                End If
                If Request.QueryString("ActifGroupe") = "False" Then
                    lViewCours.FindControl("tdTitreActifGroupe").Visible = False
                    For Each unGroupe In CType(unCours.FindControl("lViewGroupes"), ListView).Items
                        unGroupe.FindControl("tdActifGroupe").Visible = False
                    Next
                End If
                If Request.QueryString("NbMaxInscrits") = "False" Then
                    lViewCours.FindControl("tdTitreNbMaxInscrits").Visible = False
                    For Each unGroupe In CType(unCours.FindControl("lViewGroupes"), ListView).Items
                        unGroupe.FindControl("tdNbMaxInscrits").Visible = False
                    Next
                End If
                If Request.QueryString("Age") = "False" Then
                    lViewCours.FindControl("tdTitreAge").Visible = False
                    For Each unGroupe In CType(unCours.FindControl("lViewGroupes"), ListView).Items
                        unGroupe.FindControl("tdAge").Visible = False
                    Next
                End If
                If Request.QueryString("Session") = "False" Then
                    lViewCours.FindControl("tdTitreSession").Visible = False
                    For Each unGroupe In CType(unCours.FindControl("lViewGroupes"), ListView).Items
                        unGroupe.FindControl("tdSession").Visible = False
                    Next
                End If
                If Request.QueryString("DateLimInscription") = "False" Then
                    lViewCours.FindControl("tdTitreDateLimInscription").Visible = False
                    For Each unGroupe In CType(unCours.FindControl("lViewGroupes"), ListView).Items
                        unGroupe.FindControl("tdDateLimInscription").Visible = False
                    Next
                End If
                If Request.QueryString("DateDebut") = "False" Then
                    lViewCours.FindControl("tdTitreDateDebut").Visible = False
                    For Each unGroupe In CType(unCours.FindControl("lViewGroupes"), ListView).Items
                        unGroupe.FindControl("tdDateDebut").Visible = False
                    Next
                End If
                If Request.QueryString("DateFin") = "False" Then
                    lViewCours.FindControl("tdTitreDateFin").Visible = False
                    For Each unGroupe In CType(unCours.FindControl("lViewGroupes"), ListView).Items
                        unGroupe.FindControl("tdDateFin").Visible = False
                    Next
                End If
                If Request.QueryString("Local") = "False" Then
                    lViewCours.FindControl("tdTitreLocal").Visible = False
                    For Each unGroupe In CType(unCours.FindControl("lViewGroupes"), ListView).Items
                        unGroupe.FindControl("tdLocal").Visible = False
                    Next
                End If
                If Request.QueryString("Animateur") = "False" Then
                    lViewCours.FindControl("tdTitreAnimateur").Visible = False
                    For Each unGroupe In CType(unCours.FindControl("lViewGroupes"), ListView).Items
                        unGroupe.FindControl("tdAnimateur").Visible = False
                    Next
                End If
            Next
        End If
    End Sub

    Protected Sub lbTitre_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbTitre.Load
        lbTitre.Text &= Date.Today
    End Sub
End Class
