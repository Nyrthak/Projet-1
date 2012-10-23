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
        Handles EntityDataSourceCategorie.ContextCreating, EntityDataSourceGroupeDAge.ContextCreating, EntityDataSourcePrerequis.ContextCreating, EntityDataSourceSession.ContextCreating, EntityDataSourceCours.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles EntityDataSourceCategorie.ContextDisposing, EntityDataSourceGroupeDAge.ContextDisposing, EntityDataSourcePrerequis.ContextDisposing, EntityDataSourceSession.ContextDisposing, EntityDataSourceCours.ContextDisposing
        e.Cancel = True
    End Sub

#End Region

#Region "Contrôle d'erreur"
    'Protected Sub EntityDataSourceCours_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceChangedEventArgs) Handles EntityDataSourceCours.Updated
    '    Dim noPrerequis = CType(lViewModifierCours.Items(0).FindControl("dDListPrerequis"), DropDownList).SelectedValue
    '    If Not noPrerequis = "" Then
    '        Dim leNoCours As Integer = hFieldNoCours.Value
    '        Dim leCoursPrerequis As Cours = (From monCours In lecontext.Cours Where monCours.noCours = noPrerequis Select monCours).First
    '        Dim leCoursAModifier As Cours = (From monCours In lecontext.Cours Where monCours.noCours = leNoCours Select monCours).First
    '        If leCoursAModifier.Prerequis Is Nothing Then
    '            Dim leLienPrerequis As Prerequis = New Prerequis
    '            leLienPrerequis.Cours = leCoursAModifier
    '            leLienPrerequis.lePrerequis = leCoursPrerequis
    '            lecontext.Prerequis.AddObject(leLienPrerequis)
    '        End If
    '        leCoursAModifier.Prerequis.lePrerequis = leCoursPrerequis
    '        lecontext.SaveChanges()

    '    Else
    '        Dim leNoCours As Integer = hFieldNoCours.Value
    '        Dim leCoursAModifier As Cours = (From monCours In lecontext.Cours Where monCours.noCours = leNoCours Select monCours).First
    '        If Not leCoursAModifier.Prerequis Is Nothing Then
    '            leCoursAModifier.Prerequis = Nothing
    '            Dim leLienPrerequis As Prerequis = (From monPrerequis In lecontext.Prerequis Where monPrerequis.Cours.noCours = leNoCours Select monPrerequis).First
    '            lecontext.Prerequis.DeleteObject(leLienPrerequis)
    '            lecontext.SaveChanges()
    '        End If
    '    End If
    'End Sub
#End Region

#Region "Contrôles"
    Protected Sub btnAjouterUnCours_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAjouterUnCours.Click
        Dim leCoursAjouté As Cours = New Cours()
        leCoursAjouté.Nom = "Entrez un nom"
        leCoursAjouté.Prix = 0
        leCoursAjouté.Description = ""
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

    Protected Sub btnRetour_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRetour.Click
        lviewGroupes.DataBind()
        mViewCours.ActiveViewIndex = 2
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
        If mViewCours.ActiveViewIndex = 1 Then
            lblMessage.Text = ""
        End If
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
                'If Not leCoursADeleter.Prerequis Is Nothing Then
                '    leCoursADeleter.Prerequis = Nothing
                '    Dim leLienPrerequis As Prerequis = (From monPrerequis In lecontext.Prerequis Where monPrerequis.Cours.noCours = leNoCours Select monPrerequis).First
                '    lecontext.Prerequis.DeleteObject(leLienPrerequis)
                'End If
                lecontext.Cours.DeleteObject(leCoursADeleter)
                lecontext.SaveChanges()
                'lblMessage.Text = "Le cours a bien été supprimé"
                Response.Redirect("~/Admin/GérerLesCours.aspx")
            Else
                lblMessage.Text = "Le Cours n'existe pas dans la base de données"
            End If
        ElseIf e.CommandName = "Modifier" Then
            hFieldNoCours.Value = e.CommandArgument
            lViewModifierCours.EditIndex = 0
            mViewCours.ActiveViewIndex = 1
            lViewModifierCours.DataBind()
            lblMessage.Text = ""
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

    Protected Sub lViewModifierCours_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewModifierCours.ItemUpdated
        mViewCours.ActiveViewIndex = 0
        lViewCours.DataBind()
        Dim leNoCours As Integer = hFieldNoCours.Value
        Dim leCoursModifie As Cours = (From monCours In lecontext.Cours Where monCours.noCours = leNoCours Select monCours).First
        lblMessage.Text = "Le cours """ & leCoursModifie.Nom & """ a été modifié"
    End Sub

    Protected Sub lviewGroupes_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lviewGroupes.ItemCommand
        If e.CommandName = "Selection" Then
            hFieldnoGroupe2.Value = e.CommandArgument
            lviewLeGroupe.DataBind()
            mViewCours.ActiveViewIndex = 3
        End If
    End Sub
#End Region

    Protected Sub lviewGroupes_ItemDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeleteEventArgs) Handles lviewGroupes.ItemDeleting
        'Dim leNoGroupe As Integer = e.Keys.Item(0)
        'Dim leGroupe As Groupe = (From monGroupe In lecontext.Groupe Where monGroupe.noGroupe = leNoGroupe).First
        'leGroupe.Animateur = Nothing

        'Dim lesHoraires As Horaire() = (From lHoraire In lecontext.Horaire Where lHoraire.Groupe.noGroupe = leNoGroupe Select lHoraire).ToArray
        'For Each unHoraire As Horaire In lesHoraires
        '    lecontext.Horaire.DeleteObject(unHoraire)
        'Next

        'lecontext.Groupe.DeleteObject(leGroupe)
        'lecontext.SaveChanges()
        'e.Cancel = True
        'lviewGroupes.DataBind()


    End Sub

    Protected Sub lViewModifierCours_ItemUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdateEventArgs) Handles lViewModifierCours.ItemUpdating

    End Sub
End Class