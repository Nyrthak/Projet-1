'Cette page permet à l'administrateur de gérer les cours, les groupes et les horaires

Imports Model

Partial Class Admin_GérerLesCours
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
    Protected Sub entiDataSourceCours_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceChangedEventArgs) Handles entiDataSourceCours.Updated
        Dim leNoCours As Integer = hFieldNoCours.Value
    End Sub

    
    'View Gérer cours
    Protected Sub lViewCours_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lViewCours.ItemDeleted
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "supprimer")
        Else
            lblMessage.Text = ""
        End If
    End Sub
    'View Modifier cours
    Protected Sub lViewModifierCours_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewModifierCours.ItemUpdated
        Dim leNoCours As Integer = hFieldNoCours.Value
        Dim leCoursModifie As Cours = (From monCours In lecontext.Cours Where monCours.noCours = leNoCours Select monCours).First
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "mise-à-jour")
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
        Dim lesHoraires As New List(Of Horaire)(From unHoraire In lecontext.Horaire Where unHoraire.Groupe.noGroupe = noGroupe Select unHoraire)
        For Each unHoraire As Horaire In lesHoraires
            lecontext.Horaire.DeleteObject(unHoraire)
        Next
        lecontext.SaveChanges()
    End Sub
    Protected Sub lviewGroupes_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lviewGroupes.ItemDeleted
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "supprimer")
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
            lblMessage.Text = traiteErreur(e.Exception, "mise-à-jour")
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
            lecontext.SaveChanges()
            mViewCours.ActiveViewIndex = 2
            lviewGroupes.DataBind()
            e.Cancel = True
        End If
    End Sub
    Protected Sub lviewHoraire_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lviewHoraire.ItemCommand
        If e.CommandName = "Cancel" Then
            Dim noHoraire As Integer = e.CommandArgument
            Dim lHoraire As Horaire = (From unHoraire In lecontext.Horaire Where unHoraire.noHoraire = noHoraire Select unHoraire).First
            Dim midi As Date = Date.Parse("25-10-2012 00:00:00")
            If lHoraire.HeureDebut.TimeOfDay = midi.TimeOfDay And lHoraire.HeureFin.TimeOfDay = midi.TimeOfDay Then
                lecontext.Horaire.DeleteObject(lHoraire)
                lecontext.SaveChanges()
                lviewLeGroupe.DataBind()
            End If
        End If
    End Sub
    Protected Sub lviewHoraire_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lviewHoraire.ItemDeleted
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "supprimer")
        Else
            lblMessage.Text = "L'horaire a été supprimé."
        End If
    End Sub
    Protected Sub lviewHoraire_ItemEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewEditEventArgs) Handles lviewHoraire.ItemEditing
        lblMessage.Text = ""
    End Sub
    Protected Sub lviewHoraire_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lviewHoraire.ItemUpdated
        If e.Exception IsNot Nothing Then
            lblMessage.Text = traiteErreur(e.Exception, "mise-à-jour")
            e.KeepInEditMode = True
            e.ExceptionHandled = True
        Else
            lblMessage.Text = "L'Horaire a été modifié."
        End If
    End Sub

    Protected Function traiteErreur(ByVal ex As Exception, ByVal quoi As String) As String
        Dim message As String = ""

        If ex IsNot Nothing Then
            message = "Il y a eut un problème lors du " & quoi & "..."

            If ex.InnerException IsNot Nothing Then
                Dim inner As Exception = ex.InnerException

                If TypeOf inner Is System.Data.Common.DbException Then
                    message &= _
                       "Notre serveur de base de données a  actuellement des problèmes." & _
                       "Veuillez réessayer plus tard."
                ElseIf TypeOf inner _
                 Is System.Data.NoNullAllowedException Then
                    message &= _
                       "Un des champs dont la valeur est requise n'a pas été saisit."
                ElseIf TypeOf inner Is ArgumentException Then
                    Dim paramName As String = CType(inner, ArgumentException).ParamName
                    message &= _
                        String.Concat("La valeur de ", paramName, " est illégale.")
                ElseIf TypeOf inner Is ApplicationException Then
                    message &= inner.Message
                Else
                    message &= ex.ToString
                End If
            Else
                message &= ex.ToString
            End If
        End If

        ' LE LOGGÉ DANS UN FICHIER TEXTE SERAIT AUSSI UNE BONNE IDÉE. N' en afficher que la forme abrégée.
        Return message
    End Function

#End Region

#Region "Contrôles"
    Protected Sub btnAjouterUnCours_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAjouterUnCours.Click
        Dim leCoursAjouté As Cours = New Cours()
        leCoursAjouté.Nom = "Entrez un nom"
        leCoursAjouté.Prix = 0
        leCoursAjouté.Description = ""
        leCoursAjouté.Actif = True
        leCoursAjouté.Catégorie = (From dl In lecontext.Catégorie
                                         Where dl.noCatégorie = 1
                                         Select dl).First
        leCoursAjouté.GroupeDAge = (From dl In lecontext.GroupeDAge
                                         Where dl.noGroupeDAge = 1
                                         Select dl).First
        leCoursAjouté.Session = (From dl In lecontext.Session
                                         Where dl.noSession = 1
                                         Select dl).First
        leCoursAjouté.lePrerequis = Nothing
        lecontext.AddObject("Cours", leCoursAjouté)
        lecontext.SaveChanges()
        hFieldNoCours.Value = leCoursAjouté.noCours
        lViewModifierCours.EditIndex = 0
        mViewCours.ActiveViewIndex = 1
    End Sub

    Protected Sub btnAjouterGroupe_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAjouterGroupe.Click
        Dim leGroupeAjoute As Groupe = New Groupe()
        Dim leNoCours As Integer = hFieldnoCours2.Value
        leGroupeAjoute.Local = "Local"
        leGroupeAjoute.DateDebut = Date.Now
        leGroupeAjoute.DateFin = Date.Now
        leGroupeAjoute.DateLimiteInscription = Date.Now
        leGroupeAjoute.AgeMinimum = 0
        leGroupeAjoute.Agemaximum = 99
        leGroupeAjoute.Actif = True
        leGroupeAjoute.Animateur = (From dl In lecontext.Animateur Select dl).FirstOrDefault
        leGroupeAjoute.Cours = (From dl In lecontext.Cours Where dl.noCours = leNoCours Select dl).First
        lecontext.AddObject("Groupe", leGroupeAjoute)
        lecontext.SaveChanges()
        hFieldnoGroupe2.Value = leGroupeAjoute.noGroupe
        lviewLeGroupe.EditIndex = 0
        mViewCours.ActiveViewIndex = 3

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
        lecontext.SaveChanges()
        lviewHoraire.DataBind()
        lviewHoraire.EditIndex = (From dl In lecontext.Horaire Where dl.Groupe.noGroupe = leNoGroupe).Count - 1
    End Sub

    Protected Sub lViewCours_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles lViewCours.ItemDataBound
        Dim noCours As Integer = e.Item.DataItem.noCours
        Dim leCours As Cours = (From unCours In lecontext.Cours Where unCours.noCours = noCours Select unCours).FirstOrDefault
        If Not leCours.Actif Then
            CType(e.Item.FindControl("lblNomCours"), Label).ForeColor = Drawing.Color.Gray
            CType(e.Item.FindControl("lblNbGroupe"), LinkButton).ForeColor = Drawing.Color.Gray
            CType(e.Item.FindControl("lblCategorie"), Label).ForeColor = Drawing.Color.Gray
            CType(e.Item.FindControl("btnModifier"), Button).Enabled = False
            CType(e.Item.FindControl("btnSupprimer"), Button).Enabled = False
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
        If e.CommandName = "Delete" Then
            Dim peutDeleter As Boolean = False
            For Each leCours In lecontext.Cours
                If leCours.noCours = leNoCours Then
                    peutDeleter = True
                End If
            Next
            If peutDeleter Then
                Dim leCoursADeleter As Cours = (From monCours In lecontext.Cours Where monCours.noCours = leNoCours Select monCours).First
                lecontext.Cours.DeleteObject(leCoursADeleter)
                lecontext.SaveChanges()
                lblMessage.Text = "Le cours a bien été supprimé"
                Response.Redirect("~/Admin/GérerLesCours.aspx")
            Else
                lblMessage.Text = "Le Cours n'existe pas dans la base de données"
            End If
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
                    lecontext.Cours.DeleteObject(leCoursADeleter)
                    lecontext.SaveChanges()
                    mViewCours.ActiveViewIndex = 0
                    lblMessage.Text = "L'ajout a été annulé"
                End If
                lblMessage.Text = "La modification a été annulée"
            Else
                lblMessage.Text = "Le Cours n'existe pas dans la base de données"
            End If
        End If
        mViewCours.ActiveViewIndex = 0
    End Sub

    Protected Sub lviewGroupes_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lviewGroupes.ItemCommand
        If e.CommandName = "Selection" Then
            hFieldnoGroupe2.Value = e.CommandArgument
            lviewLeGroupe.DataBind()
            mViewCours.ActiveViewIndex = 3
        End If
    End Sub
#End Region
End Class