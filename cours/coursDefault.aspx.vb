Imports Model

Partial Class coursDefault
    Inherits System.Web.UI.Page

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
        Handles entityDataSourceCatégorie.ContextCreating, entityDataSourceCours.ContextCreating, entityDataSourceGroupes.ContextCreating, entityDataSourceListeCours.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles entityDataSourceCatégorie.ContextDisposing, entityDataSourceCours.ContextDisposing, entityDataSourceGroupes.ContextDisposing, entityDataSourceListeCours.ContextDisposing
        e.Cancel = True
    End Sub
#End Region

#Region "Contrôle d'erreur"
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

    Protected Sub lviewGroupes_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lviewGroupes.ItemCommand
        If e.CommandName = "Selection" Then
            mViewCours.ActiveViewIndex = 2
            hFieldnoGroupe2.Value = e.CommandArgument
        ElseIf e.CommandName = "Inscription" Then
            Dim leNoGroupe As Integer = e.CommandArgument
            Dim leGroupe As Groupe = (From monGroupe In lecontext.Groupe Where monGroupe.noGroupe = leNoGroupe Select monGroupe).FirstOrDefault
            Dim leNoMembre As Integer = CType(e.Item.FindControl("dDListMembres"), DropDownList).SelectedValue
            Dim leMembre As Membre = (From monMembre In lecontext.Membre Where monMembre.noMembre = leNoMembre Select monMembre).FirstOrDefault

            'Valider si le client s'est déja inscrit
            Dim dejaInscrit As Boolean = False
            For Each lePaiementBD As Paiement In lecontext.Paiement
                If lePaiementBD.Groupe.Cours.noCours = leGroupe.Cours.noCours And lePaiementBD.Membre.noMembre = leMembre.noMembre Then
                    dejaInscrit = True
                    lbMessage.Text = "Vous ne pouvez pas vous inscrire 2 fois au même Cours"
                End If
            Next
            'Valider si le client possède le prérequis
            Dim peutSinscrire As Boolean = True
            If Not leGroupe.Cours.lePrerequis Is Nothing Then
                peutSinscrire = False
                lbMessage.Text = "Vous ne possédez pas le prérequis " & leGroupe.Cours.lePrerequis.Nom & ", nécéssaire au cours."
                For Each lePaiementBd As Paiement In leMembre.Paiement
                    If lePaiementBd.Groupe.Cours.noCours = leGroupe.Cours.lePrerequis.noCours Then
                        peutSinscrire = True
                    End If
                Next
            End If

            If peutSinscrire Then
                lbMessage.Text = leMembre.Prénom & " " & leMembre.Nom & " est inscrit au Groupe " & leGroupe.noGroupe & " du cours de " & leGroupe.Cours.Nom & "."
                Dim lePaiement As New Paiement
                lePaiement.Groupe = leGroupe
                lePaiement.Membre = leMembre
                lePaiement.ModePaiement = "Comptant"
                lePaiement.noPaypal = "3jfh3jdh"
                lePaiement.Prix = CType(lviewCours.Items(0).FindControl("lblPrix"), Label).Text
                lecontext.Paiement.AddObject(lePaiement)
                lecontext.SaveChanges()
            End If
        End If
    End Sub
#End Region

#Region "Contrôles"
    Protected Sub btnRechercher_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRechercher.Click
        mViewCours.ActiveViewIndex = 0
    End Sub

    
    Protected Sub lviewGroupes_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles lviewGroupes.DataBound
        If Session("noCompte") Is Nothing Then
            For Each leGroupe As ListViewDataItem In lviewGroupes.Items
                CType(leGroupe.FindControl("dDListMembres"), DropDownList).Visible = False
                CType(leGroupe.FindControl("btnSinscrire"), Button).Visible = False
            Next
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

    Protected Sub mViewCours_ActiveViewChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles mViewCours.ActiveViewChanged
        lbMessage.Text = ""
    End Sub
#End Region

    Protected Sub btnSinscrire_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSinscrire.Click
        Dim leNoGroupe As Integer = hFieldnoGroupe2.Value
        Dim leGroupe As Groupe = (From monGroupe In lecontext.Groupe Where monGroupe.noGroupe = leNoGroupe Select monGroupe).FirstOrDefault
        Dim leNoMembre As Integer = dDListMembres.SelectedValue
        Dim leMembre As Membre = (From monMembre In lecontext.Membre Where monMembre.noMembre = leNoMembre Select monMembre).FirstOrDefault

        'Valider si le client s'est déja inscrit
        Dim dejaInscrit As Boolean = False
        For Each lePaiementBD As Paiement In lecontext.Paiement
            If lePaiementBD.Groupe.Cours.noCours = leGroupe.Cours.noCours And lePaiementBD.Membre.noMembre = leMembre.noMembre Then
                dejaInscrit = True
                lbMessage.Text = "Vous ne pouvez pas vous inscrire 2 fois au même Cours"
            End If
        Next
        'Valider si le client possède le prérequis
        Dim peutSinscrire As Boolean = True
        If Not leGroupe.Cours.lePrerequis Is Nothing Then
            peutSinscrire = False
            For Each lePaiementBd As Paiement In leMembre.Paiement
                If lePaiementBd.Groupe.Cours.noCours = leGroupe.Cours.lePrerequis.noCours Then
                    peutSinscrire = True
                End If
            Next
        End If

        If Not dejaInscrit And peutSinscrire Then
            lbMessage.Text = leMembre.Prénom & " " & leMembre.Nom & " est inscrit au Groupe " & leGroupe.noGroupe & " du cours de " & leGroupe.Cours.Nom & "."
            Dim lePaiement As New Paiement
            lePaiement.Groupe = leGroupe
            lePaiement.Membre = leMembre
            lePaiement.ModePaiement = "Comptant"
            lePaiement.noPaypal = "3jfh3jdh"
            lePaiement.Prix = CType(lviewCours.Items(0).FindControl("lblPrix"), Label).Text
            lecontext.Paiement.AddObject(lePaiement)
            lecontext.SaveChanges()
        End If
    End Sub
End Class
