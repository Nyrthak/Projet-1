'Systeme: Permet de s'incrire à des activitées pour le site CSL
'Auteurs: Lawrence Dubé et Katherine Vandal
'Fonctionnalités:
'       -Gérer les comptes clients
'Intrants:
'       le nom
'       le prénom
'       adresse
'       numéro de carte de crédit
'       date d'expiration
'       prérequis
'Extrants: 
'       Liste de client
'           action possibles
'       Liste de membre
'           nom
'           prénom
'           date de naissance
'           parent ou enfant
'       Modifier compte
'           adresse courriel
'           numéro de téléphone
'           adresse
'           code postale
'           ville
'           province
'           pays
'       Liste d'inscription
'           nom
'           prénom
'           nom groupe
'           nom cours
'       prérequis
'           nom
'           prénom
'           liste de prérequis
'Dernière mise à jours: 6 novembre 2012


Imports Model
Partial Class prepose_gererClient
    Inherits page

    Private Shared lecontext As ModelContainer = Nothing
#Region "Page"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        verificationTypeUser(2)
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub
#End Region
#Region "EntityDataSource"
    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
    Handles entiDataSourceCompte.ContextCreating, entiDataSourceCompteModifier.ContextCreating, entiDataSourceMembre.ContextCreating, entiDataSourceProvince.ContextCreating

        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub
    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
    Handles entiDataSourceCompte.ContextDisposing, entiDataSourceCompteModifier.ContextDisposing, entiDataSourceMembre.ContextDisposing, entiDataSourceProvince.ContextDisposing
        e.Cancel = True
    End Sub
#End Region
#Region "Controle d'erreur"
    Protected Sub lViewGererMembres_ItemUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdateEventArgs) Handles lViewGererMembres.ItemUpdating
        Dim noCompteCourant As String = hFieldNoCompte.Value
        Dim noMembreCourant As Integer = e.Keys(0)
        If e.NewValues(3) = "True" Then
            Dim nombreParent As Integer = (From unMembre As Membre In lecontext.Membre Where (unMembre.Compte.noCompte = noCompteCourant And
                                                                                              unMembre.Parent = True And Not unMembre.noMembre = noMembreCourant) Select unMembre).Count
            If nombreParent >= 2 Then
                Dim validatorNombreParent As CustomValidator = New CustomValidator
                validatorNombreParent.ValidationGroup = "A"
                validatorNombreParent.ErrorMessage = "Il ne peut pas y avoir plus de deux parents."
                validatorNombreParent.IsValid = False
                Me.Validators.Add(validatorNombreParent)
                e.Cancel = True
            End If
        End If
    End Sub
    Protected Sub entiDataSourceMembre_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceChangedEventArgs) Handles entiDataSourceMembre.Deleted
        Response.Redirect("~/prepose/gererClient.aspx")
    End Sub
    Protected Sub lViewGererMembres_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewGererMembres.ItemUpdated
        lbMessage.Text = "Vous avez modifier le membre " & e.NewValues(1) & " " & e.NewValues(0) & "."
    End Sub
    Protected Sub entiDataSourceCompte_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceCompte.Selected
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub

    Protected Sub entiDataSourceCompteModifier_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceCompteModifier.Selected
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub

    Protected Sub entiDataSourceMembre_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceMembre.Selected
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub

    Protected Sub entiDataSourceMembre_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceChangedEventArgs) Handles entiDataSourceMembre.Updated
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "mise à jour")
        Else
            lbMessage.Text = "La modification d'un membre à bien fonctionnée."
        End If
    End Sub

    Protected Sub entiDataSourceProvince_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceProvince.Selected
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub
#End Region
#Region "Controle"
    Protected Sub lviewListeCompte_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lviewListeCompte.ItemCommand
        If e.CommandName = "inscription" Then
            lviewCompte.DataBind()
            hFieldNoCompte.Value = e.CommandArgument
            mViewActionCompte.ActiveViewIndex = 1
        End If
        If e.CommandName = "modifier" Then
            hFieldNoCompte.Value = e.CommandArgument
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
        If e.CommandName = "supprimerMembre" Then
            hFieldNoCompte.Value = e.CommandArgument
            mViewActionCompte.ActiveViewIndex = 4
        End If
        If e.CommandName = "desactiver" Then
            hFieldNoCompte.Value = e.CommandArgument
            Dim noCompte As Integer = e.CommandArgument
            Dim leCompte As Compte = (From unCompte As Compte In lecontext.Compte Where unCompte.noCompte = noCompte Select unCompte).FirstOrDefault
            If leCompte IsNot Nothing Then
                If leCompte.Actif = True Then
                    leCompte.Actif = False
                    lecontext.SaveChanges()
                    lviewListeCompte.DataBind()
                Else
                    leCompte.Actif = True
                    lecontext.SaveChanges()
                    lviewListeCompte.DataBind()
                End If
            End If

        End If
    End Sub
    Protected Sub btnRetour_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRetourInscription.Click, btnRetourPrerequis.Click, _
        btnRetourModifier.Click, btnRetourGererMembre.Click
        lbMessage.Text = ""
        mViewActionCompte.ActiveViewIndex = 0
    End Sub
    Protected Sub btnAnnuler_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAnnuler.Click
        multiViewModiCompte.ActiveViewIndex = 0
        lbMessage.Text = ""
    End Sub
    Protected Sub btnEnregistrer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEnregistrer.Click
        Dim noCompteCourant As String = hFieldNoCompte.Value
        For Each courriel As String In (From unCompte In lecontext.Compte Where unCompte.noCompte <> noCompteCourant Select unCompte.Email)
            If CType(lViewCompte.Items(0).FindControl("tbCourriel"), TextBox).Text = courriel Then
                Dim validatorEmail As CustomValidator = New CustomValidator
                validatorEmail.ErrorMessage = "L'email est déja utilisé."
                validatorEmail.IsValid = False
                validatorEmail.ValidationGroup = "A"
                Me.Validators.Add(validatorEmail)
            End If
        Next
        If Me.IsValid Then
            lViewCompte.UpdateItem(0, True)
            lViewCompte.EditIndex = 0
            lbMessage.Text = "Votre compte a bien été modifié."
            lviewListeCompte.DataBind()
        End If
    End Sub
    Protected Sub btnModiMotDePasse_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnModiMotDePasse.Click
        multiViewModiCompte.ActiveViewIndex = 1
    End Sub
    Protected Sub btnEnregistrerPW_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEnregistrerPW.Click
        Dim salt = "manan"
        Dim noCompte As String = hFieldNoCompte.Value
        Dim compte As Compte = (From monCompte In lecontext.Compte Where monCompte.noCompte = noCompte).First
        If tbNouvMotDePasse.Text.Count < 6 Then
            Dim validatorMotDePasse As CustomValidator = New CustomValidator
            validatorMotDePasse.ErrorMessage = "Le nouveau mot de passe doit contenir plus de 5 caractères"
            validatorMotDePasse.IsValid = False
            Me.Validators.Add(validatorMotDePasse)
        End If

        If compte.motDePasseCrypté = CreatePasswordHash(tbNouvMotDePasse.Text, salt) Then
            Dim validatorNouveauPasse As CustomValidator = New CustomValidator
            validatorNouveauPasse.ErrorMessage = "Le nouveau mot de passe doit être différent de l'ancient"
            validatorNouveauPasse.IsValid = False
            Me.Validators.Add(validatorNouveauPasse)
        End If
        If Me.IsValid Then
            Dim hash As String = CreatePasswordHash(tbNouvMotDePasse.Text, salt)
            compte.motDePasseCrypté = hash
            lbMessage.Text = "Le mot de passe à bien été changé."
            lecontext.SaveChanges()
        End If
    End Sub
    Protected Sub deletePaiement(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceChangedEventArgs)
        Response.Redirect("~/prepose/gererClient.aspx")
    End Sub
    Protected Sub ajoutePaiement()
        lViewCompte.DataBind()
        Response.Redirect("~/prepose/gererClient.aspx")
    End Sub
    Protected Sub deletingPaiement(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceChangingEventArgs)
        Dim leNoPaiement As Integer = CType(e.Entity, Paiement).noPaiement
        Dim lePaiement As Paiement = (From unPaiement In lecontext.Paiement Where unPaiement.noPaiement = leNoPaiement Select unPaiement).FirstOrDefault
        Dim leGroupe As Groupe = (From unGroupe In lecontext.Groupe Where unGroupe.noGroupe = lePaiement.Groupe.noGroupe Select unGroupe).FirstOrDefault
        If leGroupe.ListeDAttente.Count > 0 Then
            Dim lAttente As ListeDAttente = (From uneAttente In leGroupe.ListeDAttente Select uneAttente Order By uneAttente.DateAjout).FirstOrDefault
            Dim paiementAjout As Paiement = New Paiement
            paiementAjout.Groupe = leGroupe
            paiementAjout.Membre = lAttente.Membre
            paiementAjout.ModePaiement = "Non Payé"
            paiementAjout.noPaypal = "Non Payé"
            paiementAjout.Prix = leGroupe.Cours.Prix
            lecontext.Paiement.AddObject(paiementAjout)
            lecontext.ListeDAttente.DeleteObject(lAttente)
            lecontext.SaveChanges()
            envoyerMailPayerInscription(lePaiement.Membre.Compte.Email, lePaiement.Groupe.Cours.Nom, lePaiement.Groupe.Nom, lePaiement.Membre.Nom)

        End If
    End Sub
    Protected Sub lViewGererMembres_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewGererMembres.ItemCommand
        If e.CommandName = "Supprimer" Then
            Dim noMembreASupprimer As Integer = e.CommandArgument
            Dim present As Boolean = False
            Dim lesMembres As New List(Of Membre)(From unMembre In lecontext.Membre Select unMembre)
            For Each membreADeleter In lesMembres
                If membreADeleter.noMembre = noMembreASupprimer Then
                    present = True
                    If Not membreADeleter.Paiement.Count > 0 Then
                        If membreADeleter.Proprietaire = False Then
                            lecontext.Membre.DeleteObject(membreADeleter)
                            lecontext.SaveChanges()
                            lViewGererMembres.DataBind()
                            lbMessage.Text = "Vous avez bien supprimer le membre " & membreADeleter.Prenom & " " & membreADeleter.Nom
                        Else
                            Dim validatorPropriétaire As CustomValidator = New CustomValidator
                            validatorPropriétaire.ErrorMessage = "Vous ne pouvez pas supprimer le propriétaire d'un compte."
                            validatorPropriétaire.IsValid = False
                            validatorPropriétaire.ValidationGroup = "A"
                            Me.Validators.Add(validatorPropriétaire)
                        End If
                    Else
                        lbMessage.Text = "Vous avez bien supprimer le membre " & membreADeleter.Prenom & " " & membreADeleter.Nom & "."
                    End If
                End If
            Next
        End If

    End Sub
    Protected Sub lviewListeCompte_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles lviewListeCompte.ItemDataBound
        Dim noCompte As Integer = e.Item.DataItem.noCompte
        Dim leCompte As Compte = (From unCompte In lecontext.Compte Where unCompte.noCompte = noCompte Select unCompte).First
        If Not leCompte.Actif = True Then
            CType(e.Item.FindControl("lbNomCompte"), Label).ForeColor = Drawing.Color.Gray
            CType(e.Item.FindControl("btnDesactiver"), Button).Text = "+"
        End If
    End Sub
#End Region
End Class
