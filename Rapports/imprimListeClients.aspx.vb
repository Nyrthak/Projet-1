
Partial Class Rapports_imprimListeClients
    Inherits pageMaster

    Protected Sub lViewComptes_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles lViewComptes.ItemCreated
        If Not Request.QueryString("triCompte") = "" Then
            CType(e.Item.FindControl("entiDataSourceMembres"), EntityDataSource).OrderBy = "it.[" & Request.QueryString("triMembre") & "]"
        End If
    End Sub

    Protected Sub entiDataSourceComptes_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles entiDataSourceComptes.Load
        If Not Request.QueryString("noCompte") = "" Then
            entiDataSourceComptes.OrderBy = "it.[" & Request.QueryString("triCompte") & "]"

            If Request.QueryString("noCompte") = "False" Then
                lViewComptes.FindControl("tdTitreNoCompte").Visible = False
                For Each unCompte In lViewComptes.Items
                    unCompte.FindControl("tdNoCompte").Visible = False
                Next
            End If
            If Request.QueryString("Email") = "False" Then
                lViewComptes.FindControl("tdTitreEmail").Visible = False
                For Each unCompte In lViewComptes.Items
                    unCompte.FindControl("tdEmail").Visible = False
                Next
            End If
            If Request.QueryString("Type") = "False" Then
                lViewComptes.FindControl("tdTitreTypeCompte").Visible = False
                For Each unCompte In lViewComptes.Items
                    unCompte.FindControl("tdTypeCompte").Visible = False
                Next
            End If
            If Request.QueryString("ModePaiement") = "False" Then
                lViewComptes.FindControl("tdTitreModePaiement").Visible = False
                For Each unCompte In lViewComptes.Items
                    unCompte.FindControl("tdModePaiement").Visible = False
                Next
            End If
            If Request.QueryString("noTelephone") = "False" Then
                lViewComptes.FindControl("tdTitreTelephone").Visible = False
                For Each unCompte In lViewComptes.Items
                    unCompte.FindControl("tdTelephone").Visible = False
                Next
            End If
            If Request.QueryString("Adresse") = "False" Then
                lViewComptes.FindControl("tdTitreAdresse").Visible = False
                For Each unCompte In lViewComptes.Items
                    unCompte.FindControl("tdAdresse").Visible = False
                Next
            End If
            If Request.QueryString("Actif") = "False" Then
                lViewComptes.FindControl("tdTitreActif").Visible = False
                For Each unCompte In lViewComptes.Items
                    unCompte.FindControl("tdActif").Visible = False
                Next
            End If
            If Request.QueryString("CodePostal") = "False" Then
                lViewComptes.FindControl("tdTitreCodePostal").Visible = False
                For Each unCompte In lViewComptes.Items
                    unCompte.FindControl("tdCodePostal").Visible = False
                Next
            End If
            If Request.QueryString("Ville") = "False" Then
                lViewComptes.FindControl("tdTitreVille").Visible = False
                For Each unCompte In lViewComptes.Items
                    unCompte.FindControl("tdVille").Visible = False
                Next
            End If
            If Request.QueryString("Province.Nom") = "False" Then
                lViewComptes.FindControl("tdTitreProvince").Visible = False
                For Each unCompte In lViewComptes.Items
                    unCompte.FindControl("tdProvince").Visible = False
                Next
            End If
            If Request.QueryString("Pays") = "False" Then
                lViewComptes.FindControl("tdTitrePays").Visible = False
                For Each unCompte In lViewComptes.Items
                    unCompte.FindControl("tdPays").Visible = False
                Next
            End If
            '*************************MEMBRE*************************
            For Each unCompte In lViewComptes.Items
                If Request.QueryString("noMembre") = "False" Then
                    lViewComptes.FindControl("tdTitreNoMembre").Visible = False
                    For Each unMembre In CType(unCompte.FindControl("lViewMembres"), ListView).Items
                        unMembre.FindControl("tdNoMembre").Visible = False
                    Next
                End If
                If Request.QueryString("Prénom") = "False" Then
                    lViewComptes.FindControl("tdTitrePrenom").Visible = False
                    For Each unMembre In CType(unCompte.FindControl("lViewMembres"), ListView).Items
                        unMembre.FindControl("tdPrenom").Visible = False
                    Next
                End If
                If Request.QueryString("Nom") = "False" Then
                    lViewComptes.FindControl("tdTitreNom").Visible = False
                    For Each unMembre In CType(unCompte.FindControl("lViewMembres"), ListView).Items
                        unMembre.FindControl("tdNom").Visible = False
                    Next
                End If
                If Request.QueryString("DateNaissance") = "False" Then
                    lViewComptes.FindControl("tdTitreDateNaissance").Visible = False
                    For Each unMembre In CType(unCompte.FindControl("lViewMembres"), ListView).Items
                        unMembre.FindControl("tdDateNaissance").Visible = False
                    Next
                End If
                If Request.QueryString("Propriétaire") = "False" Then
                    lViewComptes.FindControl("tdTitreProprio").Visible = False
                    For Each unMembre In CType(unCompte.FindControl("lViewMembres"), ListView).Items
                        unMembre.FindControl("tdProprio").Visible = False
                    Next
                End If
                If Request.QueryString("Parent") = "False" Then
                    lViewComptes.FindControl("tdTitreTypeMembre").Visible = False
                    For Each unMembre In CType(unCompte.FindControl("lViewMembres"), ListView).Items
                        unMembre.FindControl("tdTypeMembre").Visible = False
                    Next
                End If
            Next
        End If
    End Sub

    Protected Sub lbTitre_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbTitre.Load
        lbTitre.Text &= Date.Today
    End Sub
End Class
