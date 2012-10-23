Imports Model

Partial Class coursDefault
    Inherits System.Web.UI.Page

    Private Shared lecontext As ModelContainer = Nothing
    Protected Sub page_load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
    End Sub

    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
        Handles entityDataSourceCatégorie.ContextCreating, entityDataSourceCours.ContextCreating, entityDataSourceGroupes.ContextCreating, entityDataSourceListeCours.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles EntityDataSourceCatégorie.ContextDisposing, entityDataSourceCours.ContextDisposing, entityDataSourceGroupes.ContextDisposing, entityDataSourceListeCours.ContextDisposing
        e.Cancel = True
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

    Protected Sub btnRechercher_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRechercher.Click
        mViewCours.ActiveViewIndex = 0
    End Sub

    Protected Sub lViewCatégorie_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewCatégorie.ItemCommand
        If e.CommandName = "ClickCatégorie" Then
            hFieldNoCategorie.Value = e.CommandArgument
            mViewCours.ActiveViewIndex = 0
        End If
    End Sub

    Protected Sub lViewListeCours_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewListeCours.ItemCommand
        If e.CommandName = "Selection" Then
            hFieldnoCours.Value = e.CommandArgument
            mViewCours.ActiveViewIndex = 1
            lviewCours.DataBind()
            Dim leNoCours As String = hFieldnoCours.Value
            Dim leCours As Cours = (From monCours In lecontext.Cours Where monCours.noCours = leNoCours Select monCours).First
            If leCours.lePrerequis Is Nothing Then
                CType(lviewCours.Items(0).FindControl("lblPrerequis"), Label).Text = "Aucun"
            End If
        End If
    End Sub

    Protected Sub lviewGroupes_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles lviewGroupes.DataBound
        If Session("noCompte") Is Nothing Then
            For Each leGroupe As ListViewDataItem In lviewGroupes.Items
                CType(leGroupe.FindControl("dDListMembres"), DropDownList).Visible = False
                CType(leGroupe.FindControl("btnSinscrire"), Button).Visible = False
            Next
        End If
    End Sub

    Protected Sub lviewGroupes_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lviewGroupes.ItemCommand
        If e.CommandName = "Selection" Then
            mViewCours.ActiveViewIndex = 2
            hFieldnoGroupe2.Value = e.CommandArgument
        ElseIf e.CommandName = "Inscription" Then
            Dim leNoGroupe = e.CommandArgument
            Dim leGroupe = (From monGroupe In lecontext.Groupe Where monGroupe.noGroupe = leNoGroupe Select monGroupe)
            Dim leNoMembre = CType(e.Item.FindControl("dDListMembres"), DropDownList).SelectedValue
        End If
    End Sub

    Protected Sub btnRetour_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRetour.Click
        mViewCours.ActiveViewIndex = 1
    End Sub

    Protected Sub lviewLeGroupe_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles lviewLeGroupe.DataBound
        If Session("noCompte") Is Nothing Then
            dDListMembres.Visible = False
            btnSinscrire.Visible = False
        End If
    End Sub
End Class
