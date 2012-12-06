Imports Model
Partial Class Admin_listesDattente
    Inherits page

#Region "Page"

    Private Shared lecontext As ModelContainer = Nothing
    Protected Sub page_load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

    Public ReadOnly Property noGroupe() As String
        Get
            Return hFieldNoGroupe.Value
        End Get
    End Property

#End Region

#Region "EntityDataSource"
    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
        Handles entiDataSourceLaListeDAttente.ContextCreating
        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
       Handles entiDataSourceLaListeDAttente.ContextDisposing
        e.Cancel = True
    End Sub

#End Region

#Region "Contrôle d'erreur"
    Protected Sub lviewLaListeDattente_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lviewLaListeDattente.ItemDeleted
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "suppression")
        Else
            lbMessage.Text = "L'inscription a été supprimée."
        End If
    End Sub
#End Region

#Region "Contrôles"
    Protected Sub mViewListeDAttente_ActiveViewChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles mViewListeDAttente.ActiveViewChanged
        If mViewListeDAttente.ActiveViewIndex = 1 Then
            Dim leGroupe As Groupe = (From unGroupe In lecontext.Groupe Where unGroupe.noGroupe = hFieldNoGroupe.Value Select unGroupe).FirstOrDefault
            lblDetailListe.Text = leGroupe.Cours.Nom & " - Groupe " & leGroupe.noGroupe
        End If
    End Sub

    Protected Sub lviewListesDattente_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lviewListesDattente.ItemCommand
        If e.CommandName = "SelectionListe" Then
            hFieldNoGroupe.Value = e.CommandArgument
            mViewListeDAttente.ActiveViewIndex = 1
        End If
    End Sub

    Protected Sub btnCreerGroupe_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCreerGroupe.Click
        Dim leGroupeAjoute As Groupe = New Groupe()
        Dim leNoGroupeDepart As Integer = hFieldNoGroupe.Value
        Dim leGroupeDepart As Groupe = (From unGroupe In lecontext.Groupe Where unGroupe.noGroupe = leNoGroupeDepart Select unGroupe).FirstOrDefault
        'Création du groupe
        leGroupeAjoute.Local = leGroupeDepart.Local
        leGroupeAjoute.DateDebut = leGroupeDepart.DateDebut
        leGroupeAjoute.DateFin = leGroupeDepart.DateFin
        leGroupeAjoute.DateLimiteInscription = leGroupeDepart.DateLimiteInscription
        leGroupeAjoute.AgeMinimum = leGroupeDepart.AgeMinimum
        leGroupeAjoute.Agemaximum = leGroupeDepart.Agemaximum
        leGroupeAjoute.Actif = False
        leGroupeAjoute.Session = leGroupeDepart.Session
        leGroupeAjoute.Nom = "Groupe"
        leGroupeAjoute.Animateur = (From dl In lecontext.Animateur Where dl.noAnimateur = leGroupeDepart.Animateur.noAnimateur Select dl).FirstOrDefault
        leGroupeAjoute.Cours = (From dl In lecontext.Cours Where dl.noCours = leGroupeDepart.Cours.noCours Select dl).First
        lecontext.AddObject("Groupe", leGroupeAjoute)
        lecontext.SaveChanges()

        Dim lesInscriptions As New List(Of ListeDAttente)(From uneInscription In lecontext.ListeDAttente Where uneInscription.Accepte = True Select uneInscription)
        For Each inscription In lesInscriptions
            Dim lePaiement As Paiement = New Paiement()
            lePaiement.ModePaiement = "Non payé"
            lePaiement.noPaypal = "Non payé"
            lePaiement.Membre = inscription.Membre
            lePaiement.Groupe = leGroupeAjoute
            lePaiement.Prix = leGroupeAjoute.Cours.Prix
            lecontext.ListeDAttente.DeleteObject(inscription)
            lecontext.SaveChanges()
            envoyerMailPayerInscription(lePaiement.Membre.Compte.Email, lePaiement.Groupe.Cours.Nom, lePaiement.Groupe.Nom, lePaiement.Membre.Nom)
        Next


        Server.Transfer("~/Admin/GérerLesCours.aspx")
    End Sub

    Protected Sub btnEnregistrer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEnregistrer.Click
        For Each itemTemplate In lviewLaListeDattente.Items
            Dim leNoListeDattente As Integer = CType(lviewLaListeDattente.Items(itemTemplate.DataItemIndex).FindControl("hFieldNoListeAttente"), HiddenField).Value
            Dim laListeDAttente As ListeDAttente = (From uneListeDAttente In lecontext.ListeDAttente Where uneListeDAttente.noListeDAttente = leNoListeDattente Select uneListeDAttente).FirstOrDefault
            laListeDAttente.Accepte = CType(lviewLaListeDattente.Items(itemTemplate.DataItemIndex).FindControl("chkAccepte"), CheckBox).Checked
        Next
        lecontext.SaveChanges()
        lviewLaListeDattente.DataBind()

    End Sub

    Protected Sub btnRetour_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRetour.Click
        mViewListeDAttente.ActiveViewIndex = 0
    End Sub
#End Region
End Class
