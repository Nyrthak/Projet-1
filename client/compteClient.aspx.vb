Imports Model

Partial Class CompteClient
    Inherits page
    Private Shared lecontext As ModelContainer = Nothing

    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
    Handles entiDataSourceCompte.ContextCreating, entiDataSourceMembre.ContextCreating, entiDataSourceAjouterMembre.ContextCreating

        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
    Handles entiDataSourceCompte.ContextDisposing, entiDataSourceMembre.ContextDisposing, entiDataSourceAjouterMembre.ContextDisposing
        e.Cancel = True
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lbErreur.Text = ""
        lecontext = New ModelContainer()
       
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        verificationTypeUser(1)      
    End Sub

    Protected Sub listViewMembres_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles listViewMembres.ItemCommand
        If e.CommandName = "supprime" Then
            Dim noMembre As Integer = e.CommandArgument
            Dim present As Boolean = False
            For Each membreDeleter As Membre In lecontext.MembreSet
                If membreDeleter.noMembre = noMembre Then
                    present = True
                End If
            Next
            If present = True Then
                'Supprime le membre qui dont le nom est "Entrez un nom"
                Dim leMembreADeleter As Membre = (From monMembre In lecontext.MembreSet Where monMembre.noMembre = noMembre Select monMembre).First
                If leMembreADeleter.Propriétaire = False Then
                    lecontext.MembreSet.DeleteObject(leMembreADeleter)
                    lecontext.SaveChanges()
                    Response.Redirect("~/client/compteClient.aspx")
                Else
                    lbErreur.Text = "Vous ne pouvez pas supprimer le propriétaire du compte."
                End If
            End If
        End If
    End Sub

    Protected Sub btnAjouter_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAjouter.Click
        Dim ajouterMembre As Membre = New Membre()
        Dim noCompte As Integer = Session("noCompte")

        ajouterMembre.Nom = "Entrez un nom"
        ajouterMembre.Prénom = "Entrez un prénom"
        ajouterMembre.DateNaissance = Date.Now
        ajouterMembre.Propriétaire = False
        ajouterMembre.Compte = (From dl In lecontext.CompteSet Where dl.noCompte = noCompte Select dl).First

        lecontext.AddObject("MembreSet", ajouterMembre)
        lecontext.SaveChanges()
        multiViewMembre.ActiveViewIndex = 1
        listViewAjoutMembre.EditIndex = 0
        hiddenFieldNoMembre.Value = ajouterMembre.noMembre
    End Sub


    Protected Sub listViewAjoutMembre_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles listViewAjoutMembre.ItemCommand
        If e.CommandName = "Cancel" Then
            'Teste si le membre a déleter est bien dans la base de donnée.
            Dim noMembre As String = hiddenFieldNoMembre.Value
            Dim present As Boolean = False
            For Each membreDeleter As Membre In lecontext.MembreSet
                If membreDeleter.noMembre = noMembre Then
                    present = True
                Else
                    present = False
                End If
            Next
            If present = True Then
                'Supprime le membre qui dont le nom est "Entrez un nom"
                Dim leMembreADeleter As Membre = (From monMembre In lecontext.MembreSet Where monMembre.noMembre = noMembre Select monMembre).First
                If leMembreADeleter.Nom = "Entrez un nom" Then
                    lecontext.MembreSet.DeleteObject(leMembreADeleter)
                    lecontext.SaveChanges()
                End If
            End If
            multiViewMembre.ActiveViewIndex = 0
        End If
    End Sub

    Protected Sub listViewAjoutMembre_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles listViewAjoutMembre.ItemUpdated
        multiViewMembre.ActiveViewIndex = 0
        listViewMembres.DataBind()
    End Sub

    Protected Sub listViewAjoutMembre_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles listViewAjoutMembre.PreRender
        CType(listViewAjoutMembre.Items(0).FindControl("rangeValidatorDateNaissance"), RangeValidator).MaximumValue = Now.Date.ToShortDateString
        CType(listViewAjoutMembre.Items(0).FindControl("rangeValidatorDateNaissance"), RangeValidator).MinimumValue = Now.AddYears(-150).ToShortDateString
    End Sub

    Protected Sub viewMembres_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles viewMembres.Load
        'Supprime les membre qui dont le nom est "Entrez un nom"
        If Not multiViewMembre.ActiveViewIndex = 1 Then
            For Each membre As Membre In (From monMembre In lecontext.MembreSet Select monMembre)
                If membre.Nom = "Entrez un nom" Then
                    lecontext.MembreSet.DeleteObject(membre)
                End If
            Next
            lecontext.SaveChanges()
        End If
    End Sub
End Class
