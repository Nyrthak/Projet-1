'Systeme: Permet de s'incrire à des activitées pour le site CSL
'Auteurs: Lawrence Dubé et Katherine Vandal
'Fonctionnalités:
'       -Affichage de la liste d'inscription
'Intrants:
'       Aucun
'Extrants: 
'       -Nom
'       -Prénom
'       -nom du cours
'       -nom du groupe
'Dernière mise à jours: 6 novembre 2012
Imports Model
Partial Class client_inscriptionClient
    Inherits pageMaster
    Private Shared lecontext As ModelContainer = Nothing

#Region "Page"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        verificationTypeUser(1)
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub
#End Region
#Region "EntityDataSource"
    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
    Handles entiDataSourceMembre.ContextCreating

        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub
    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
    Handles entiDataSourceMembre.ContextDisposing
        e.Cancel = True
    End Sub

#End Region
#Region "Controle d'erreur"
    Protected Sub entiDataSourceMembre_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceSelectedEventArgs) Handles entiDataSourceMembre.Selected
        If e.Exception IsNot Nothing Then
            lbMessage.Text = traiteErreur(e.Exception, "sélection d'un membre")
        End If
    End Sub
#End Region


End Class
