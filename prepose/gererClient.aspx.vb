Imports Model
Partial Class prepose_gererClient
    Inherits page
    Private Shared lecontext As ModelContainer = Nothing

    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
    Handles entiDataSourceMembre.ContextCreating, entiDataSourceCompte.ContextCreating

        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
    Handles entiDataSourceMembre.ContextDisposing, entiDataSourceCompte.ContextDisposing
        e.Cancel = True
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

    Protected Sub lviewCompte_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lviewCompte.ItemCommand
        If e.CommandName = "inscription" Then
            lviewCompte.DataBind()
            hFieldNoCompte.Value = e.CommandArgument
            mViewActionCompte.ActiveViewIndex = 1

        End If

        If e.CommandName = "modifier" Then
            mViewActionCompte.ActiveViewIndex = 2
        End If

        If e.CommandName = "prerequis" Then
            hFieldNoCompte.Value = e.CommandArgument
            lViewMembrePrerequis.DataBind()
            For Each item In lViewMembrePrerequis.Items
                CType(item.FindControl("lViewPaiementPrerequis"), ListView).DataBind()
            Next
            mViewActionCompte.ActiveViewIndex = 3

        End If
    End Sub

    Protected Sub btnRetour_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRetourInscription.Click, _
        btnRetourModifier.Click, btnRetourPrerequis.Click
        mViewActionCompte.ActiveViewIndex = 0
    End Sub

    Protected Sub deletePaiement(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceChangedEventArgs)
        Response.Redirect("~/prepose/gererClient.aspx")
    End Sub

    Protected Sub ajoutePaiement()
        lviewCompte.DataBind()
        Response.Redirect("~/prepose/gererClient.aspx")
    End Sub

    Protected Sub deletingPaiement(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceChangingEventArgs)
        Dim leNoPaiement As Integer = CType(e.Entity, Paiement).noPaiement
        Dim lePaiement As Paiement = (From unPaiement In lecontext.Paiement Where unPaiement.noPaiement = leNoPaiement Select unPaiement).FirstOrDefault
        Dim leGroupe As Groupe = (From unGroupe In lecontext.Groupe Where unGroupe.noGroupe = lePaiement.Groupe.noGroupe Select unGroupe).FirstOrDefault
        If leGroupe.ListeDAttente IsNot Nothing Then
            Dim lAttente As ListeDAttente = (From uneAttente In leGroupe.ListeDAttente Select uneAttente Order By uneAttente.DateAjout).FirstOrDefault
            Dim paiementAjout As Paiement = New Paiement
            paiementAjout.Groupe = leGroupe
            paiementAjout.Membre = lAttente.Membre
            paiementAjout.ModePaiement = "Non Payé"
            paiementAjout.noPaypal = "Non payé"
            paiementAjout.Prix = leGroupe.Cours.Prix
            lecontext.Paiement.AddObject(paiementAjout)
            lecontext.ListeDAttente.DeleteObject(lAttente)
            lecontext.SaveChanges()
        End If
    End Sub
End Class
