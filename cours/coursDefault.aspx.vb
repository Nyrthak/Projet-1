Imports Model

Partial Class coursDefault
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
        Handles entityDataSourceCategorie.ContextCreating, entityDataSourceCours.ContextCreating, entityDataSourceGroupes.ContextCreating, entityDataSourceListeCours.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles entityDataSourceCategorie.ContextDisposing, entityDataSourceCours.ContextDisposing, entityDataSourceGroupes.ContextDisposing, entityDataSourceListeCours.ContextDisposing
        e.Cancel = True
    End Sub
#End Region

#Region "Contrôle d'erreur"
    Protected Sub lViewCategorie_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewCategorie.ItemCommand
        If e.CommandName = "ClickCatégorie" Then
            hFieldNoCategorie.Value = e.CommandArgument
            mViewCours.ActiveViewIndex = 0
        End If
    End Sub

    Protected Sub lViewListeCours_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewListeCours.ItemCommand
        If e.CommandName = "Selection" Then
            hFieldnoCours.Value = e.CommandArgument
            entityDataSourceGroupes.WhereParameters("Ya6mois").DefaultValue = Date.Now.AddMonths(-6)
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
            hFieldnoGroupe2.Value = e.CommandArgument
            mViewCours.ActiveViewIndex = 2
        ElseIf e.CommandName = "Inscription" Then
            Dim leNoGroupe As Integer = e.CommandArgument
            hFieldnoGroupe2.Value = e.CommandArgument
            Dim leGroupe As Groupe = (From monGroupe In lecontext.Groupe Where monGroupe.noGroupe = leNoGroupe Select monGroupe).FirstOrDefault
            Dim leNoMembre As Integer = CType(e.Item.FindControl("dDListMembres"), DropDownList).SelectedValue
            hFieldnoMembre.Value = leNoMembre
            Dim leMembre As Membre = (From monMembre In lecontext.Membre Where monMembre.noMembre = leNoMembre Select monMembre).FirstOrDefault
            Dim leNoCompte As Integer = leMembre.Compte.noCompte

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
                        lbMessage.Text = ""
                    End If
                Next
            End If

            'Valider si le client est dans la tranche dage requise
            Dim ageCorrect As Boolean = True
            Dim ageMembre As Integer = (Date.Now - leMembre.DateNaissance).TotalDays / 365.25
            If Not leGroupe.AgeMinimum <= ageMembre Or Not leGroupe.Agemaximum >= ageMembre Then
                ageCorrect = False
                lbMessage.Text = "Vous n'êtes pas dans la tranche d'âge requis pour vous inscrire à ce cours."
            End If

            If Not dejaInscrit And peutSinscrire And ageCorrect Then
                mViewCours.ActiveViewIndex = 3
            End If
        ElseIf e.CommandName = "InscriptionAttente" Then
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
            'Valider si le client s'est déja inscrit sur la liste d'attente
            Dim dejaInscritAttente As Boolean = False
            For Each lInscriptionAttenteBD As ListeDAttente In lecontext.ListeDAttente
                If lInscriptionAttenteBD.Groupe.Cours.noCours = leGroupe.Cours.noCours And lInscriptionAttenteBD.Membre.noMembre = leMembre.noMembre Then
                    dejaInscritAttente = True
                    lbMessage.Text = "Vous ne pouvez pas vous inscrire 2 fois au même cours"
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
                        lbMessage.Text = ""
                    End If
                Next
            End If

            'Valider si le client est dans la tranche dage requise
            Dim ageCorrect As Boolean = True
            Dim ageMembre As Integer = (Date.Now - leMembre.DateNaissance).TotalDays / 365.25
            If Not leGroupe.AgeMinimum <= ageMembre Or Not leGroupe.Agemaximum >= ageMembre Then
                ageCorrect = False
                lbMessage.Text = "Vous n'êtes pas dans la tranche d'âge requis pour vous inscrire à ce cours."
            End If

            If Not dejaInscrit And Not dejaInscritAttente And peutSinscrire And ageCorrect Then
                lbMessage.Text = leMembre.Prenom & " " & leMembre.Nom & " est inscrit sur la liste d'attente du Groupe " & leGroupe.noGroupe & " du cours de " & leGroupe.Cours.Nom & "."
                Dim laListeAttente As New ListeDAttente
                laListeAttente.Accepte = False
                laListeAttente.DateAjout = Date.Now
                laListeAttente.Groupe = leGroupe
                laListeAttente.Membre = leMembre
                lecontext.ListeDAttente.AddObject(laListeAttente)
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
        If Session("noCompte") Is Nothing Or Session("userType") = 2 Then
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
        Dim leNoGroupe As Integer = hFieldnoGroupe2.Value
        Dim leGroupe As Groupe = (From unGroupe In lecontext.Groupe Where unGroupe.noGroupe = leNoGroupe Select unGroupe).FirstOrDefault
        If Session("noCompte") Is Nothing Or Session("userType") = 2 Then
            dDListMembres.Visible = False
            btnSinscrire.Visible = False
            lnkInscriptionListeDAttente.Visible = False
        ElseIf leGroupe.DateLimiteInscription < Date.Today Then
            btnSinscrire.Text = "Fermé"
            btnSinscrire.Enabled = False
            lnkInscriptionListeDAttente.Visible = False
        ElseIf leGroupe.Paiement.Count >= leGroupe.nbMaxInscrits Then
            btnSinscrire.Text = "Complet"
            btnSinscrire.Enabled = False
            lnkInscriptionListeDAttente.Visible = True
        Else
            lnkInscriptionListeDAttente.Visible = False
        End If
    End Sub

    Protected Sub mViewCours_ActiveViewChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles mViewCours.ActiveViewChanged
        lbMessage.Text = ""
        If mViewCours.ActiveViewIndex = 2 Then
            If Session("noCompte") IsNot Nothing Then
                Dim noCompte As Integer = Session("noCompte")
                Dim lecompte As Compte = (From unCompte In lecontext.Compte Where unCompte.noCompte = noCompte Select unCompte).FirstOrDefault
                For Each membre In lecompte.Membre
                    For Each Paiement In membre.Paiement
                        Dim noGroupe As Integer = hFieldnoGroupe2.Value
                        If Paiement.Groupe.noGroupe = noGroupe Then
                            entityDataSourcePaiements.WhereParameters("peutVoir").DefaultValue = True
                        End If
                    Next
                Next
                If Not Session("userType") = 2 Then
                    dDListCompteP.Visible = False
                    dDListMembreP.Visible = False
                    btninscrirePrepose.Visible = False
                End If
            Else
                dDListCompteP.Visible = False
                dDListMembreP.Visible = False
                btninscrirePrepose.Visible = False
            End If
        End If
        If mViewCours.ActiveViewIndex = 3 Then
            'Remplissage du dropdownlist annee
            Dim i As Integer = 0
            dropDownListAnnee.Items.Add("")
            While i < 12
                dropDownListAnnee.Items.Add(Now.AddYears(i).Year)
                i += 1
            End While
        End If
    End Sub

    Protected Sub btnSinscrire_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSinscrire.Click
        Dim leNoGroupe As Integer = hFieldnoGroupe2.Value
        Dim leGroupe As Groupe = (From monGroupe In lecontext.Groupe Where monGroupe.noGroupe = leNoGroupe Select monGroupe).FirstOrDefault
        Dim leNoMembre As Integer = dDListMembres.SelectedValue
        hFieldnoMembre.Value = dDListMembres.SelectedValue
        Dim leMembre As Membre = (From monMembre In lecontext.Membre Where monMembre.noMembre = leNoMembre Select monMembre).FirstOrDefault
        Dim leNoCompte As Integer = leMembre.Compte.noCompte
        'Valider si le client s'est déja inscrit
        Dim dejaInscrit As Boolean = False
        For Each lePaiementBD As Paiement In lecontext.Paiement
            If lePaiementBD.Groupe.Cours.noCours = leGroupe.Cours.noCours And lePaiementBD.Membre.noMembre = leMembre.noMembre Then
                dejaInscrit = True
                lbMessage.Text = "Vous ne pouvez pas vous inscrire 2 fois au même cours."
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
        If peutSinscrire = False Then
            lbMessage.Text = "Vous ne possédez pas le prérequis pour ce cours."
        End If

        'Valider si le client est dans la tranche dage requise
        Dim ageCorrect As Boolean = True
        Dim ageMembre As Integer = (Date.Now - leMembre.DateNaissance).TotalDays / 365.25
        If Not leGroupe.AgeMinimum <= ageMembre Or Not leGroupe.Agemaximum >= ageMembre Then
            ageCorrect = False
            lbMessage.Text = "Vous n'êtes pas dans la tranche d'âge requis pour vous inscrire à ce cours."
        End If
        'Changement de view pour aller a la view paiement
        If Not dejaInscrit And peutSinscrire And ageCorrect Then
            mViewCours.ActiveViewIndex = 3

        End If

    End Sub

    Protected Sub lviewGroupes_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles lviewGroupes.ItemDataBound
        If CType(e.Item.DataItem, Groupe).DateLimiteInscription < Date.Today And Not Session("noCompte") Is Nothing And Not Session("userType") = "2" Then
            CType(e.Item.FindControl("btnSinscrire"), Button).Text = "Fermé"
            CType(e.Item.FindControl("btnSinscrire"), Button).Enabled = False
            CType(e.Item.FindControl("lnkInscriptionListeDAttente"), LinkButton).Visible = False
        ElseIf CType(e.Item.DataItem, Groupe).Paiement.Count >= CType(e.Item.DataItem, Groupe).nbMaxInscrits And Not Session("noCompte") Is Nothing And Not Session("userType") = "2" Then
            CType(e.Item.FindControl("btnSinscrire"), Button).Text = "Complet"
            CType(e.Item.FindControl("btnSinscrire"), Button).Enabled = False
        Else
            CType(e.Item.FindControl("lnkInscriptionListeDAttente"), LinkButton).Visible = False
        End If
    End Sub

    Protected Sub lnkInscriptionListeDAttente_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkInscriptionListeDAttente.Click
        Dim leNoGroupe As Integer = hFieldnoGroupe2.Value
        Dim leGroupe As Groupe = (From monGroupe In lecontext.Groupe Where monGroupe.noGroupe = leNoGroupe Select monGroupe).FirstOrDefault
        Dim leNoMembre As Integer = dDListMembres.SelectedValue
        Dim leMembre As Membre = (From monMembre In lecontext.Membre Where monMembre.noMembre = leNoMembre Select monMembre).FirstOrDefault

        'Valider si le client s'est déja inscrit
        Dim dejaInscrit As Boolean = False
        For Each lePaiementBD As Paiement In lecontext.Paiement
            If lePaiementBD.Groupe.Cours.noCours = leGroupe.Cours.noCours And lePaiementBD.Membre.noMembre = leMembre.noMembre Then
                dejaInscrit = True
                lbMessage.Text = "Vous ne pouvez pas vous inscrire 2 fois au même cours"
            End If
        Next
        'Valider si le client s'est déja inscrit sur la liste d'attente
        Dim dejaInscritAttente As Boolean = False
        For Each lInscriptionAttenteBD As ListeDAttente In lecontext.ListeDAttente
            If lInscriptionAttenteBD.Groupe.Cours.noCours = leGroupe.Cours.noCours And lInscriptionAttenteBD.Membre.noMembre = leMembre.noMembre Then
                dejaInscritAttente = True
                lbMessage.Text = "Vous ne pouvez pas vous inscrire 2 fois au même cours"
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
                    lbMessage.Text = ""
                End If
            Next
        End If

        'Valider si le client est dans la tranche dage requise
        Dim ageCorrect As Boolean = True
        Dim ageMembre As Integer = (Date.Now - leMembre.DateNaissance).TotalDays / 365.25
        If Not leGroupe.AgeMinimum <= ageMembre Or Not leGroupe.Agemaximum >= ageMembre Then
            ageCorrect = False
            lbMessage.Text = "Vous n'êtes pas dans la tranche d'âge requis pour vous inscrire à ce cours."
        End If

        If Not dejaInscrit And peutSinscrire And Not dejaInscritAttente And ageCorrect Then
            lbMessage.Text = leMembre.Prenom & " " & leMembre.Nom & " est inscrit sur la liste d'attente du Groupe " & leGroupe.noGroupe & " du cours de " & leGroupe.Cours.Nom & "."
            Dim laListeAttente As New ListeDAttente
            laListeAttente.Accepte = False
            laListeAttente.DateAjout = Date.Now
            laListeAttente.Groupe = leGroupe
            laListeAttente.Membre = leMembre
            lecontext.ListeDAttente.AddObject(laListeAttente)
            lecontext.SaveChanges()
        End If
    End Sub

    Protected Sub btnEnregistrerInscription_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEnregistrerInscription.Click
        Dim leNoGroupe As Integer = hFieldnoGroupe2.Value
        Dim leGroupe As Groupe = (From monGroupe In lecontext.Groupe Where monGroupe.noGroupe = leNoGroupe Select monGroupe).FirstOrDefault
        Dim leNoMembre As Integer = hFieldnoMembre.Value
        Dim leMembre As Membre = (From monMembre In lecontext.Membre Where monMembre.noMembre = leNoMembre Select monMembre).FirstOrDefault
        Dim lePaiement As New Paiement
        Dim leNoCompte As Integer = leMembre.Compte.noCompte
        Dim leCompte As Compte = leMembre.Compte
        Dim leCours As Cours = leGroupe.Cours

        lePaiement.Groupe = leGroupe
        lePaiement.Membre = leMembre
        lePaiement.ModePaiement = rbListeTypeCarte.SelectedValue

        'Vérification du prix en fonction des forfaits
        Dim laSession As Integer = leGroupe.Session.noSession
        Dim coutForfait As Double
        Dim nbInscriptionsEnfants As Integer = (From unPaiement In lecontext.Paiement Where unPaiement.Membre.Parent = False And unPaiement.Membre.Compte.noCompte = leNoCompte And unPaiement.Groupe.Session.noSession = laSession Select unPaiement).Count + 1
        If (From unForfait In lecontext.Forfait Where unForfait.nbInscrits <= nbInscriptionsEnfants Select unForfait).Count > 0 Then
            Dim leForfait As Forfait = New Forfait
            leForfait.Cout = (From unForfait In lecontext.Forfait Where unForfait.nbInscrits <= nbInscriptionsEnfants Select unForfait.Cout).Min
            coutForfait = leForfait.Cout
        Else
            coutForfait = 1
        End If
        If Me.IsValid Then
            Dim noPaypal = doTransaction("4583279825118372", rbListeTypeCarte.SelectedItem.Text, dropDownListMois.SelectedItem.Text & dropDownListAnnee.SelectedItem.Text, tbNumeroSecuriteCarte.Text, _
                             leGroupe.Cours.Prix * coutForfait, tbPrenomPaiement.Text, tbNomPaiement.Text, tbAdresse.Text, _
                                 tbVille.Text, dropDownListProvince.SelectedItem.Text, tbCodePostal.Text)
            If Not noPaypal = "" Then
                lePaiement.Prix = CType(lviewCours.Items(0).FindControl("lblPrix"), Label).Text * coutForfait
                lePaiement.noPaypal = noPaypal
                lecontext.Paiement.AddObject(lePaiement)
                lecontext.SaveChanges()
                envoyerMailPaiementInscription(leCompte.Email, leCours.Nom, leGroupe.Nom, lePaiement.Prix, lePaiement.ModePaiement, _
                                               tbVille.Text, dropDownListProvince.SelectedItem.Text, tbCodePostal.Text, tbAdresse.Text)
                Response.Redirect("~/paiement/paiementSucess.aspx")
            Else
                Dim validatorErrorPaiement As CustomValidator = New CustomValidator
                validatorErrorPaiement.ErrorMessage = "Les informations de paiement que vous avez entré ne sont pas valide."
                validatorErrorPaiement.IsValid = False
                Me.Validators.Add(validatorErrorPaiement)
            End If
        End If

    End Sub

    Protected Sub dDListCompteP_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dDListCompteP.DataBound
        hFieldNoCompte.Value = dDListCompteP.SelectedValue
    End Sub

    Protected Sub dDListCompteP_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles dDListCompteP.SelectedIndexChanged
        hFieldNoCompte.Value = dDListCompteP.SelectedValue
        entiDataSourceMembresP.DataBind()
    End Sub

    Protected Sub btninscrirePrepose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btninscrirePrepose.Click
        Dim leNoGroupe As Integer = hFieldnoGroupe2.Value
        Dim leGroupe As Groupe = (From monGroupe In lecontext.Groupe Where monGroupe.noGroupe = leNoGroupe Select monGroupe).FirstOrDefault
        Dim leNoMembre As Integer = dDListMembreP.SelectedValue
        hFieldnoMembre.Value = dDListMembreP.SelectedValue
        Dim leMembre As Membre = (From monMembre In lecontext.Membre Where monMembre.noMembre = leNoMembre Select monMembre).FirstOrDefault
        Dim leNoCompte As Integer = leMembre.Compte.noCompte
        'Valider si le client s'est déja inscrit
        Dim dejaInscrit As Boolean = False
        For Each lePaiementBD As Paiement In lecontext.Paiement
            If lePaiementBD.Groupe.Cours.noCours = leGroupe.Cours.noCours And lePaiementBD.Membre.noMembre = leMembre.noMembre Then
                dejaInscrit = True
                lbMessage.Text = "Le membre ne peut s'inscrire 2 fois au même cours."
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
        If peutSinscrire = False Then
            lbMessage.Text = "Le membre ne possède pas le prérequis pour ce cours."
        End If

        'Valider si le client est dans la tranche dage requise
        Dim ageCorrect As Boolean = True
        Dim ageMembre As Integer = (Date.Now - leMembre.DateNaissance).TotalDays / 365.25
        If Not leGroupe.AgeMinimum <= ageMembre Or Not leGroupe.Agemaximum >= ageMembre Then
            ageCorrect = False
            lbMessage.Text = "Le membre n'est pas dans la tranche d'âge requise pour s'inscrire à ce cours."
        End If

        If Not dejaInscrit And peutSinscrire And ageCorrect Then
            Dim lePaiement As New Paiement
            lePaiement.Groupe = leGroupe
            lePaiement.Membre = leMembre
            lePaiement.ModePaiement = "Sur place"
            lePaiement.noPaypal = "Aucun"

            Dim laSession As Integer = leGroupe.Session.noSession
            Dim coutForfait As Double
            Dim nbInscriptionsEnfants As Integer = (From unPaiement In lecontext.Paiement Where unPaiement.Membre.Parent = False And unPaiement.Membre.Compte.noCompte = leNoCompte And unPaiement.Groupe.Session.noSession = laSession Select unPaiement).Count + 1
            If (From unForfait In lecontext.Forfait Where unForfait.nbInscrits <= nbInscriptionsEnfants Select unForfait).Count > 0 Then
                Dim leForfait As Forfait = New Forfait
                leForfait.Cout = (From unForfait In lecontext.Forfait Where unForfait.nbInscrits <= nbInscriptionsEnfants Select unForfait.Cout).Min
                coutForfait = leForfait.Cout
            Else
                coutForfait = 1
            End If
            lePaiement.Prix = CType(lviewCours.Items(0).FindControl("lblPrix"), Label).Text * coutForfait
            lecontext.Paiement.AddObject(lePaiement)
            lecontext.SaveChanges()
            lbMessage.Text = "Le membre " & leMembre.Prenom & " " & leMembre.Nom & " a bien été inscrit au groupe."
        End If

    End Sub
#End Region
End Class
