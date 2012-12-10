'Systeme: Permet de s'incrire à des activitées pour le site CSL
'Auteurs: Lawrence Dubé et Katherine Vandal
'Fonctionnalités:
'       -Ajout/modification/suppression des objects suivants:
'           Cours
'           Groupe
'           Horaire
'Intrants:
'       -Pour l'ajout/modification/suppression d'un cours
'           Nom
'           Prix
'           Groupe d'âge
'           Prérequis
'           Catégorie
'           Description
'       -Pour l'ajout/modification/suppression d'un groupe
'           Nom
'           Date de début
'           Date de fin
'           Date limite d'inscrption
'           Nombre de places
'           Local
'           Âge
'           Animateur
'           Session
'       -Pour l'ajout/modification/suppression d'un horaire
'           Journée
'           Heure de début
'           Heure de fin
'Extrants: 
'       -Pour l'ajout/modification/suppression d'un cours
'           Nom
'           Nombre de groupe
'           Catégorie
'       -Pour l'ajout/modification/suppression d'un groupe
'           Nom
'           Date de début
'           Date de fin
'           Date limite d'inscrption
'           Nombre de places
'           Local
'           Âge
'           Animateur
'           Session
'           Liste de membre
'       -Pour l'ajout/modification/suppression d'un horaire
'           Journée
'           Heure de début
'           Heure de fin
'Dernière mise à jours: 6 novembre 2012

Imports Model
Partial Class Admin_GérerLesCours
    Inherits pageMaster
#Region "Page"

    Private Shared lecontext As ModelContainer = Nothing
    Protected Sub page_load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()

        If Not PreviousPage Is Nothing Then
            mViewCours.ActiveViewIndex = 3
            hFieldnoGroupe2.Value = PreviousPage.noGroupe
        End If
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        verificationTypeUser(3)
    End Sub
#End Region

#Region "EntityDataSource"
    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
        Handles entiDataSourceCategorie.ContextCreating, entiDataSourceGroupeDAge.ContextCreating, entiDataSourcePrerequis.ContextCreating, entiDataSourceSession.ContextCreating, entiDataSourceCours.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles entiDataSourceCategorie.ContextDisposing, entiDataSourceGroupeDAge.ContextDisposing, entiDataSourcePrerequis.ContextDisposing, entiDataSourceSession.ContextDisposing, entiDataSourceCours.ContextDisposing
        e.Cancel = True
    End Sub

#End Region

#Region "Contrôle d'erreur"

    Protected Sub entiDataSourceCours_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceCours.Selected
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub
    Protected Sub entiDataSourceCours_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceChangedEventArgs) Handles entiDataSourceCours.Updated
        Dim leNoCours As Integer = hFieldNoCours.Value
    End Sub
    'View Gérer cours
    Protected Sub lViewCours_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lViewCours.ItemDeleted
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "suppression")
        Else
            lblMessage.Text = ""
        End If
    End Sub
    'View Modifier cours
    Protected Sub lViewModifierCours_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewModifierCours.ItemUpdated
        Dim leNoCours As Integer = hFieldNoCours.Value
        Dim leCoursModifie As Cours = (From monCours In lecontext.Cours Where monCours.noCours = leNoCours Select monCours).First
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "mise à jour")
            e.KeepInEditMode = True
            e.ExceptionHandled = True
        Else
            mViewCours.ActiveViewIndex = 0
            lViewCours.DataBind()
            lblMessage.Text = "Le cours """ & leCoursModifie.Nom & """ a été modifié"
        End If
    End Sub
    'View Groupes
    Protected Sub lviewGroupes_ItemDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeleteEventArgs) Handles lviewGroupes.ItemDeleting
        Dim noGroupe As Integer = e.Keys(0)
        If (From unPaiement In lecontext.Paiement Where unPaiement.Groupe.noGroupe = noGroupe Select unPaiement).Count > 0 Then
            lblMessage.Text = "Vous ne pouvez supprimer le groupe " & noGroupe & ", car il contient une(des) inscription(s)."
            e.Cancel = True
        ElseIf (From uneListeAttente In lecontext.ListeDAttente Where uneListeAttente.Groupe.noGroupe = noGroupe Select uneListeAttente).Count > 0 Then
            lblMessage.Text = "Vous ne pouvez supprimer le groupe " & noGroupe & ", car il possède une liste d'attente."
            e.Cancel = True
        Else
            Dim leGroupeADeleter As Groupe = (From unGroupe In lecontext.Groupe Where unGroupe.noGroupe = noGroupe Select unGroupe).FirstOrDefault
            Dim lesHoraires As New List(Of Horaire)(From unHoraire In lecontext.Horaire Where unHoraire.Groupe.noGroupe = noGroupe Select unHoraire)
            For Each unHoraire As Horaire In lesHoraires
                lecontext.Horaire.DeleteObject(unHoraire)
            Next
            lecontext.Groupe.DeleteObject(leGroupeADeleter)
            Try
                lecontext.SaveChanges()
                lviewGroupes.DataBind()
                e.Cancel = True
            Catch ex As Exception
                lblMessage.Text = traiteErreur(ex, "suppression")
            End Try
            
        End If
    End Sub
    Protected Sub lviewGroupes_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lviewGroupes.ItemDeleted
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "suppression")
        Else
            lblMessage.Text = "Le groupe " & e.Keys(0) & " a été supprimé."
        End If
    End Sub
    'View le groupe
    Protected Sub lviewLeGroupe_ItemEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewEditEventArgs) Handles lviewLeGroupe.ItemEditing
        lblMessage.Text = ""
    End Sub
    Protected Sub lviewLeGroupe_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lviewLeGroupe.ItemUpdated
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "mise à jour")
            e.KeepInEditMode = True
            e.ExceptionHandled = True
        Else
            lblMessage.Text = "Le Groupe a été modifié."
        End If
    End Sub
    Protected Sub lviewLeGroupe_ItemCanceling(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCancelEventArgs) Handles lviewLeGroupe.ItemCanceling
        Dim noGroupe As Integer = hFieldnoGroupe2.Value
        Dim leGroupe As Groupe = (From unGroupe In lecontext.Groupe Where unGroupe.noGroupe = noGroupe Select unGroupe).First
        Dim uneDate As Date = Date.Parse("25-10-2012")
        If leGroupe.DateDebut.Date = uneDate And leGroupe.DateFin.Date = uneDate And leGroupe.DateLimiteInscription.Date = uneDate Then
            lecontext.Groupe.DeleteObject(leGroupe)
            Try
                lecontext.SaveChanges()
                mViewCours.ActiveViewIndex = 2
                lviewGroupes.DataBind()
                e.Cancel = True
            Catch ex As Exception
                lblMessage.Text = traiteErreur(ex, "suppression")
            End Try

        End If
    End Sub
    Protected Sub lviewHoraire_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lviewHoraire.ItemCommand
        If e.CommandName = "Cancel" Then
            Dim noHoraire As Integer = e.CommandArgument
            Dim lHoraire As Horaire = (From unHoraire In lecontext.Horaire Where unHoraire.noHoraire = noHoraire Select unHoraire).First
            Dim midi As Date = Date.Parse("25-10-2012 00:00:00")
            If lHoraire.HeureDebut.TimeOfDay = midi.TimeOfDay And lHoraire.HeureFin.TimeOfDay = midi.TimeOfDay Then
                lecontext.Horaire.DeleteObject(lHoraire)
                Try
                    lecontext.SaveChanges()
                    lviewLeGroupe.DataBind()
                Catch ex As Exception
                    lblMessage.Text = traiteErreur(ex, "suppression")
                End Try

            End If
        End If
    End Sub
    Protected Sub lviewHoraire_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lviewHoraire.ItemDeleted
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "suppression")
        Else
            lblMessage.Text = "L'horaire a été supprimé."
        End If
    End Sub
    Protected Sub lviewHoraire_ItemEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewEditEventArgs) Handles lviewHoraire.ItemEditing
        lblMessage.Text = ""
    End Sub
    Protected Sub lviewHoraire_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lviewHoraire.ItemUpdated
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "mise à jour")
            e.KeepInEditMode = True
            e.ExceptionHandled = True
        Else
            lblMessage.Text = "L'Horaire a été modifié."
        End If
    End Sub
    Protected Sub entiDataSourceAnimateur_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceAnimateur.Selected
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub

    Protected Sub entiDataSourceCategorie_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceCategorie.Selected
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub

    Protected Sub entiDataSourceGroupeDAge_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceGroupeDAge.Selected
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub

    Protected Sub entiDataSourceGroupes_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceGroupes.Selected
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub

    Protected Sub entiDataSourceHoraire_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceHoraire.Selected
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub

    Protected Sub entiDataSourceJour_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceJour.Selected
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub

    Protected Sub entiDataSourceLeGroupe_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceLeGroupe.Selected
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub

    Protected Sub entiDataSourcePrerequis_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourcePrerequis.Selected
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub

    Protected Sub entiDataSourceSession_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceSession.Selected
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub

    Protected Sub entityDataSourcePaiements_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entityDataSourcePaiements.Selected
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "sélection")
        End If
    End Sub

#End Region

#Region "Contrôles"
    Protected Sub btnAjouterUnCours_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAjouterUnCours.Click
        Dim messageErreur As String = ""
        Dim leCoursAjouté As Cours = New Cours()
        Dim leGroupeAjoute As Groupe = New Groupe()
        If (From dl In lecontext.Session Select dl).Count > 0 Then
            leGroupeAjoute.Session = (From dl In lecontext.Session Select dl).FirstOrDefault
        Else
            messageErreur += "Veuillez ajouter au moins une session dans la base de données avant d'ajouter un cours.</br>"
        End If
        If (From dl In lecontext.Catégorie Select dl).Count > 0 Then
            leCoursAjouté.Categorie = (From dl In lecontext.Catégorie Select dl).FirstOrDefault
        Else
            messageErreur += "Veuillez ajouter au moins une catégorie dans la base de données avant d'ajouter un cours.</br>"
        End If

        If (From dl In lecontext.GroupeDAge Select dl).Count > 0 Then
            leCoursAjouté.GroupeDAge = (From dl In lecontext.GroupeDAge Select dl).FirstOrDefault
        Else
            messageErreur += "Veuillez ajouter au moins un groupe d'âge dans la base de données avant d'ajouter un cours.</br>"
        End If

        If (From dl In lecontext.Animateur Select dl).Count > 0 Then
            leGroupeAjoute.Animateur = (From dl In lecontext.Animateur Select dl).FirstOrDefault
        Else
            messageErreur += "Veuillez ajouter au moins un animateur dans la base de données avant d'ajouter un cours.</br>"
        End If

        If messageErreur = "" Then
            leCoursAjouté.Nom = "Entrez un nom"
            leCoursAjouté.Prix = 0
            leCoursAjouté.Description = ""
            leCoursAjouté.Actif = False
            leCoursAjouté.lePrerequis = Nothing

            leGroupeAjoute.Nom = "Préréquis"
            leGroupeAjoute.Local = "Prerequis"
            leGroupeAjoute.DateDebut = Date.Now
            leGroupeAjoute.DateFin = Date.Now
            leGroupeAjoute.DateLimiteInscription = Date.Now
            leGroupeAjoute.AgeMinimum = 0
            leGroupeAjoute.Agemaximum = 99
            leGroupeAjoute.Actif = False
            leGroupeAjoute.nbMaxInscrits = 999
            Dim laSessionPrerequis As Session
            If (From uneSession In lecontext.Session Where uneSession.NomSession = "Préréquis" Select uneSession).Count = 0 Then
                laSessionPrerequis = New Session
                laSessionPrerequis.NomSession = "Préréquis"
                laSessionPrerequis.DebutSession = Date.Now.AddYears(-5)
                lecontext.Session.AddObject(laSessionPrerequis)
            Else
                laSessionPrerequis = (From uneSession In lecontext.Session Where uneSession.NomSession = "Préréquis" Select uneSession).FirstOrDefault
            End If
            leGroupeAjoute.Session = laSessionPrerequis
            leCoursAjouté.Groupe.Add(leGroupeAjoute)
            lecontext.AddObject("Cours", leCoursAjouté)
            Try
                lecontext.SaveChanges()
                hFieldNoCours.Value = leCoursAjouté.noCours
                lViewModifierCours.EditIndex = 0
                mViewCours.ActiveViewIndex = 1
            Catch ex As Exception
                lblMessage.Text = traiteErreur(ex, "ajout")
            End Try

        Else
            lblMessage.Text = messageErreur
        End If
    End Sub

    Protected Sub btnAjouterGroupe_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAjouterGroupe.Click
        Dim messageErreur As String = ""
        Dim leGroupeAjoute As Groupe = New Groupe()
        Dim leNoCours As Integer = hFieldnoCours2.Value
        Dim leCours As Cours = (From dl In lecontext.Cours Where dl.noCours = leNoCours Select dl).First
        If (From dl In lecontext.Session Select dl).Count > 0 Then
            leGroupeAjoute.Session = (From dl In lecontext.Session Select dl).FirstOrDefault
        Else
            messageErreur += "Veuillez ajouter au moins une session dans la base de données avant d'ajouter un groupe.</br>"
        End If
        If messageErreur = "" Then
            leGroupeAjoute.Local = "Local"
            leGroupeAjoute.Nom = "Groupe"
            leGroupeAjoute.DateDebut = Date.Now
            leGroupeAjoute.DateFin = Date.Now
            leGroupeAjoute.DateLimiteInscription = Date.Now
            leGroupeAjoute.AgeMinimum = 0
            leGroupeAjoute.Agemaximum = 99
            leGroupeAjoute.Actif = False
            leGroupeAjoute.Animateur = (From dl In lecontext.Animateur Select dl).FirstOrDefault
            leGroupeAjoute.Cours = leCours
            leGroupeAjoute.nbMaxInscrits = 0
            lecontext.AddObject("Groupe", leGroupeAjoute)
            Try
                lecontext.SaveChanges()
                hFieldnoGroupe2.Value = leGroupeAjoute.noGroupe
                lviewLeGroupe.EditIndex = 0
                mViewCours.ActiveViewIndex = 3
            Catch ex As Exception
                lblMessage.Text = traiteErreur(ex, "ajout")
            End Try

        Else
            lblMessage.Text = messageErreur
        End If
    End Sub

    Protected Sub btnAjouterHoraire_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAjouterHoraire.Click
        Dim lHoraireAjoute As Horaire = New Horaire()
        Dim leNoCours As Integer = hFieldnoCours2.Value
        Dim leNoGroupe As Integer = hFieldnoGroupe2.Value
        lHoraireAjoute.HeureDebut = "2012-12-12 00:00"
        lHoraireAjoute.HeureFin = "2012-12-12 00:00"
        lHoraireAjoute.Jour = (From dl In lecontext.Jour Select dl).First
        lHoraireAjoute.Groupe = (From dl In lecontext.Groupe Where dl.noGroupe = leNoGroupe).First
        lecontext.AddObject("Horaire", lHoraireAjoute)
        Try
            lecontext.SaveChanges()
            lviewHoraire.DataBind()
            lviewHoraire.EditIndex = (From dl In lecontext.Horaire Where dl.Groupe.noGroupe = leNoGroupe).Count - 1
        Catch ex As Exception
            lblMessage.Text = traiteErreur(ex, "ajout")
        End Try

    End Sub

    Protected Sub lViewCours_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles lViewCours.ItemDataBound
        Dim noCours As Integer = e.Item.DataItem.noCours
        Dim leCours As Cours = (From unCours In lecontext.Cours Where unCours.noCours = noCours Select unCours).FirstOrDefault
        If Not leCours.Actif Then
            CType(e.Item.FindControl("lblNomCours"), Label).ForeColor = Drawing.Color.Gray
            CType(e.Item.FindControl("lblNbGroupe"), LinkButton).ForeColor = Drawing.Color.Gray
            CType(e.Item.FindControl("lblCategorie"), Label).ForeColor = Drawing.Color.Gray
            CType(e.Item.FindControl("btnDesactiver"), Button).Text = "Activer"
        End If
    End Sub

    Protected Sub btnRetour_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRetour.Click
        lviewGroupes.DataBind()
        mViewCours.ActiveViewIndex = 2
    End Sub

    Protected Sub btnRetour2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRetour2.Click
        mViewCours.ActiveViewIndex = 0
        lViewCours.DataBind()
    End Sub

    Sub customV_heureDebut(ByVal sender As Object, ByVal e As ServerValidateEventArgs)
        Dim heureFinString As String() = (CType(lviewHoraire.EditItem.FindControl("tbHeureFin"), TextBox).Text.Split(":"))
        Dim heureDebutString As String() = (e.Value.Split(":"))
        Dim heureFin As New List(Of Integer)(heureFinString.Length)
        Dim heureDebut As New List(Of Integer)(heureDebutString.Length)
        Dim lHeure As Integer
        For Each heure As String In heureFinString
            If Integer.TryParse(heure, lHeure) Then
                heureFin.Add(lHeure)
            End If
        Next
        For Each heure As String In heureDebutString
            If Integer.TryParse(heure, lHeure) Then
                heureDebut.Add(lHeure)
            End If
        Next

        If heureDebut(0) < heureFin(0) Then
            e.IsValid = True
        ElseIf heureDebut(0) = heureFin(0) Then
            If heureDebut(1) < heureFin(1) Then
                e.IsValid = True
            Else
                e.IsValid = False
            End If
        Else
            e.IsValid = False
        End If
    End Sub

    Protected Sub mViewCours_ActiveViewChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles mViewCours.ActiveViewChanged
        lblMessage.Text = ""
    End Sub

    Protected Sub lViewCours_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewCours.ItemCommand
        Dim leNoCours As String = e.CommandArgument
        If e.CommandName = "Supprimer" Then
            Dim peutDeleter As Boolean = False
            For Each leCours In lecontext.Cours
                If leCours.noCours = leNoCours Then
                    peutDeleter = True
                End If
            Next
            If peutDeleter Then
                Dim leCoursADeleter As Cours = (From monCours In lecontext.Cours Where monCours.noCours = leNoCours Select monCours).First
                If (From unPaiement In lecontext.Paiement Where unPaiement.Groupe.Cours.noCours = leNoCours Select unPaiement).Count > 0 Then
                    lblMessage.Text = "Le cours " & leCoursADeleter.Nom & " ne peut être supprimé, car il contient une ou plusieurs inscriptions."
                ElseIf leCoursADeleter.estLePrerequisDe.Count > 0 Then
                    lblMessage.Text = "Le cours " & leCoursADeleter.Nom & " ne peut être supprimé, car il est le prérequis d'un ou plusieurs cours."
                ElseIf (From uneListeAttente In lecontext.ListeDAttente Where uneListeAttente.Groupe.Cours.noCours = leNoCours Select uneListeAttente).Count > 0 Then
                    lblMessage.Text = "Le cours " & leCoursADeleter.Nom & " ne peut être supprimé, car il possède une liste d'attente."
                Else
                    Dim lesGroupes As New List(Of Groupe)(From unGroupe In lecontext.Groupe Where unGroupe.Cours.noCours = leNoCours Select unGroupe)
                    For Each unGroupe As Groupe In lesGroupes
                        lecontext.Groupe.DeleteObject(unGroupe)
                    Next
                    lecontext.Cours.DeleteObject(leCoursADeleter)
                    Try
                        lecontext.SaveChanges()
                        lblMessage.Text = "Le cours a bien été supprimé."
                        Response.Redirect("~/Admin/GérerLesCours.aspx")
                    Catch ex As Exception
                        lblMessage.Text = traiteErreur(ex, "suppression")
                    End Try

                End If
            Else
                lblMessage.Text = "Le Cours n'existe pas dans la base de données."
            End If
        ElseIf e.CommandName = "Desactiver" Then
            Dim leNoCours2 As String = e.CommandArgument
            Dim leCoursADesactiver As Cours = (From monCours In lecontext.Cours Where monCours.noCours = leNoCours2 Select monCours).First
            If leCoursADesactiver.Actif Then
                leCoursADesactiver.Actif = False
                For Each leGroupe In leCoursADesactiver.Groupe
                    leGroupe.Actif = False
                Next
                Try
                    lecontext.SaveChanges()
                    lblMessage.Text = "Le Cours " & leCoursADesactiver.Nom & " et ses groupes ont été désactivés."
                Catch ex As Exception
                    lblMessage.Text = traiteErreur(ex, "modification")
                End Try
            Else
                leCoursADesactiver.Actif = True
                For Each leGroupe In leCoursADesactiver.Groupe
                    leGroupe.Actif = True
                Next
                Try
                    lecontext.SaveChanges()
                    lblMessage.Text = "Le Cours " & leCoursADesactiver.Nom & " et ses groupes ont été activés."
                Catch ex As Exception
                    lblMessage.Text = traiteErreur(ex, "modification")
                End Try
            End If
            lViewCours.DataBind()
            lviewGroupes.DataBind()
        ElseIf e.CommandName = "Modifier" Then
            hFieldNoCours.Value = e.CommandArgument
            lViewModifierCours.EditIndex = 0
            mViewCours.ActiveViewIndex = 1
            lViewModifierCours.DataBind()
        ElseIf e.CommandName = "VoirGroupes" Then
            hFieldnoCours2.Value = e.CommandArgument
            mViewCours.ActiveViewIndex = 2
        End If

    End Sub

    Protected Sub lViewModifierCours_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewModifierCours.ItemCommand
        If e.CommandName = "Annuler" Then
            Dim peutDeleter As Boolean = False
            For Each leCours In lecontext.Cours
                If leCours.noCours = hFieldNoCours.Value Then
                    peutDeleter = True
                End If
            Next
            If peutDeleter Then
                Dim leNoCours As String = hFieldNoCours.Value
                Dim leCoursADeleter As Cours = (From monCours In lecontext.Cours Where monCours.noCours = leNoCours Select monCours).First
                If leCoursADeleter.Nom = "Entrez un nom" Then
                    Dim lesGroupes As New List(Of Groupe)(From unGroupe In lecontext.Groupe Where unGroupe.Cours.noCours = leNoCours Select unGroupe)
                    For Each unGroupe As Groupe In lesGroupes
                        lecontext.Groupe.DeleteObject(unGroupe)
                    Next
                    lecontext.Cours.DeleteObject(leCoursADeleter)
                    Try
                        lecontext.SaveChanges()
                        mViewCours.ActiveViewIndex = 0
                        lblMessage.Text = "L'ajout a été annulé"
                    Catch ex As Exception
                        lblMessage.Text = traiteErreur(ex, "suppression")
                    End Try
                Else
                    mViewCours.ActiveViewIndex = 0
                    lblMessage.Text = "La modification a été annulée"
                End If
            Else
                mViewCours.ActiveViewIndex = 0
                lblMessage.Text = "Le Cours n'existe pas dans la base de données"
            End If
            End If
    End Sub

    Protected Sub lviewGroupes_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lviewGroupes.ItemCommand
        If e.CommandName = "Selection" Then
            hFieldnoGroupe2.Value = e.CommandArgument
            lviewLeGroupe.DataBind()
            mViewCours.ActiveViewIndex = 3
        ElseIf e.CommandName = "Desactiver" Then
            Dim noGroupe As Integer = e.CommandArgument
            Dim leGroupe As Groupe = (From unGroupe In lecontext.Groupe Where unGroupe.noGroupe = noGroupe Select unGroupe).FirstOrDefault
            If leGroupe.Actif Then
                leGroupe.Actif = False
                lblMessage.Text = "Le groupe " & leGroupe.noGroupe & " a été désactivé."
            Else
                leGroupe.Actif = True
                lblMessage.Text = "Le groupe " & leGroupe.noGroupe & " a été activé."
            End If
            Try
                lecontext.SaveChanges()
                lviewGroupes.DataBind()
            Catch ex As Exception
                lblMessage.Text = traiteErreur(ex, "modification")
            End Try
        End If
    End Sub

    Protected Sub lviewGroupes_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles lviewGroupes.ItemDataBound
        Dim noGroupe As Integer = e.Item.DataItem.noGroupe
        Dim leGroupe As Groupe = (From unGroupe In lecontext.Groupe Where unGroupe.noGroupe = noGroupe Select unGroupe).FirstOrDefault
        If Not leGroupe.Actif Then
            CType(e.Item.FindControl("lnkGroupe"), LinkButton).ForeColor = Drawing.Color.Gray
            CType(e.Item.FindControl("lblAge"), Label).ForeColor = Drawing.Color.Gray
            CType(e.Item.FindControl("btnDesactiver"), Button).Text = "Activer"

            For Each lHoraire In CType(e.Item.FindControl("lViewHoraire"), ListView).Items
                CType(lHoraire.FindControl("lblHoraire"), Label).ForeColor = Drawing.Color.Gray
            Next
        End If
    End Sub
#End Region
End Class