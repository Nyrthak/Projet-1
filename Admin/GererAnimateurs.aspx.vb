'Systeme: Permet de s'incrire à des activitées pour le site CSL
'Auteurs: Lawrence Dubé et Katherine Vandal
'Fonctionnalités:
'       -Ajout/suppression d'un animateur par un admin
'Intrants:
'       le nom
'       le prénom
'       le courriel
'       la date de naissance
'       le mot de passe
'       le mot de passe de confirmation
'       le numéro de téléphone
'       l'adresse
'       le code postale
'       la ville
'       la province
'Extrants: Elle affiche une liste d'animateur:
'       le nom
'       le prénom
'       la date de naissance
'Dernière mise à jours: 6 novembre 2012
Imports Model
Partial Class Admin_GererAnimateurs
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
       Handles entiDataSourceAnimateurs.ContextCreating, entiDataSourceProvince.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles entiDataSourceAnimateurs.ContextDisposing, entiDataSourceProvince.ContextDisposing
        e.Cancel = True
    End Sub
#End Region

#Region "Contrôle d'erreur"

    Protected Sub lViewAnimateurs_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lViewAnimateurs.ItemDeleted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "suppression")
        Else
            lbMessage.Text = "L'animateur a été supprimé."
        End If
    End Sub
    Protected Sub lViewAnimateurs_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewInsertedEventArgs) Handles lViewAnimateurs.ItemInserted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "insertion")
        Else
            lbMessage.Text = "L'animateur " & e.Values(0) & " " & e.Values(1) & " a été ajouté."
        End If
    End Sub
    Protected Sub lViewAnimateurs_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewInsertEventArgs) Handles lViewAnimateurs.ItemInserting
        If e.Values(6) = Nothing Then
            Dim validateProvince As CustomValidator = New CustomValidator()
            validateProvince.ErrorMessage = "Veuillez ajouter au moins une province dans la base de données avant d'ajouter un animateur."
            validateProvince.ValidationGroup = "Insert"
            validateProvince.IsValid = False
            Page.Validators.Add(validateProvince)
            e.Cancel = True
        End If
    End Sub
    Protected Sub lViewAnimateurs_ItemEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewEditEventArgs) Handles lViewAnimateurs.ItemEditing
        lbMessage.Text = ""
    End Sub
    Protected Sub lViewAnimateurs_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewAnimateurs.ItemUpdated
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "mise à jour")
            e.KeepInEditMode = True
            e.ExceptionHandled = True
        Else
            lbMessage.Text = "L'animateur " & e.NewValues(0) & " " & e.NewValues(1) & " a été modifié."
        End If
    End Sub
    Protected Sub lViewAnimateurs_ItemDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeleteEventArgs) Handles lViewAnimateurs.ItemDeleting
        Dim noAnimateur As Integer = e.Keys(0)
        If (From unGroupe In lecontext.Groupe Where unGroupe.Animateur.noAnimateur = noAnimateur Select unGroupe).Count > 0 Then
            Dim lAnimateur As Animateur = (From unAnimateur In lecontext.Animateur Where unAnimateur.noAnimateur = noAnimateur Select unAnimateur).FirstOrDefault
            lbMessage.Text = "Vous ne pouvez supprimer l'animateur " & lAnimateur.Prénom & " " & lAnimateur.Nom & ", car il est relié à au moins un groupe."
            e.Cancel = True
        End If
    End Sub

    Protected Sub lViewSpecialites_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewInsertEventArgs) Handles lViewSpecialites.ItemInserting
        e.Values(0) = hFieldNoAnimateur.Value
        If e.Values(1) = Nothing Then
            Dim validateSpecialite As CustomValidator = New CustomValidator()
            validateSpecialite.ErrorMessage = "Veuillez ajouter au moins une spécialité dans la base de données avant d'en ajouter une à l'animateur."
            validateSpecialite.ValidationGroup = "Insert"
            validateSpecialite.IsValid = False
            Page.Validators.Add(validateSpecialite)
            e.Cancel = True
        End If
        Dim leNoAnimateur As Integer = hFieldNoAnimateur.Value
        Dim leNoSpecialite As Integer = e.Values(1)
        For Each laSpecAnimateur As SpécialitéAnimateur In lecontext.SpécialitéAnimateur
            If laSpecAnimateur.Animateur.noAnimateur = leNoAnimateur And laSpecAnimateur.Spécialité.noSpécialité = leNoSpecialite Then
                lbMessage.Text = "Vous ne pouvez pas vous ajouter 2 fois la même spécialité."
                e.Cancel = True
            End If
        Next
    End Sub
    Protected Sub lViewSpecialites_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lViewSpecialites.ItemDeleted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "suppression")
        Else
            lbMessage.Text = "La spécialité a été retirée."
        End If
    End Sub
    Protected Sub lViewSpecialites_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewInsertedEventArgs) Handles lViewSpecialites.ItemInserted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "insertion")
        Else
            lbMessage.Text = "La spécialité " & e.Values(1) & " a été ajoutée."
        End If
    End Sub
    Protected Sub entiDataSourceProvince_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceProvince.Selected
        If e.Exception IsNot Nothing Then
            traiteErreur(e.Exception, "sélection")
        End If
    End Sub
#End Region

#Region "Contrôles"
    Protected Sub lViewAnimateurs_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewAnimateurs.ItemCommand
        If e.CommandName = "AnnulerSelect" Then
            lbMessage.Text = ""
            lViewAnimateurs.SelectedIndex = -1
        ElseIf e.CommandName = "VoirSpecialites" Then
            Dim noAnimateur As Integer = e.CommandArgument
            hFieldNoAnimateur.Value = noAnimateur
            Dim lAnimateur As Animateur = (From unAnimateur In lecontext.Animateur Where unAnimateur.noAnimateur = noAnimateur Select unAnimateur).FirstOrDefault
            lbSousTitreSpecialites.Text &= lAnimateur.Prénom & " " & lAnimateur.Nom
            mViewAnimateurs.ActiveViewIndex = 1
        End If
    End Sub

    Protected Sub lViewAnimateurs_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lViewAnimateurs.SelectedIndexChanged
        lbMessage.Text = ""
    End Sub
#End Region


End Class
