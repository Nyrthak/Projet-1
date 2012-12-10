'Systeme: Permet de s'incrire à des activitées pour le site CSL
'Auteurs: Lawrence Dubé et Katherine Vandal
'Fonctionnalités:
'       -Modification d'un compte client par un client
'Intrants:
'       le numéro de téléphone
'       adresse
'       code postale
'       ville
'       province
'       pays
'       mot de passe
'       nouveau mot de passe
'       mot de passe de confirmation
'Extrants: Elle affiche une liste des catégorie déjà ajouté
'       le numéro de téléphone
'       adresse
'       code postale
'       ville
'       province
'       pays
'Dernière mise à jours: 6 novembre 2012


Imports Model
Partial Class client_modifClient
    Inherits page
    Private Shared lecontext As ModelContainer = Nothing

    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
    Handles entiDataSourceCompte.ContextCreating, entiDataSourceProvince.ContextCreating

        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub

    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
    Handles entiDataSourceProvince.ContextDisposing, entiDataSourceCompte.ContextDisposing
        e.Cancel = True
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
        lbMessage.Text = ""
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        verificationTypeUser(1)
    End Sub

    Protected Sub lViewCompte_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lViewCompte.ItemUpdated
        lbMessage.Text = "Votre compte à bien été modifié."
    End Sub

    Protected Sub lViewCompte_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles lViewCompte.PreRender
        CType(lViewCompte.Items(0).FindControl("dropDownListProvince"), DropDownList).Items.Insert(0, "")
    End Sub

    Protected Sub btnEnregistrer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEnregistrer.Click
        Dim noCompte As String = Session("noCompte")
        If Me.IsValid Then
            lViewCompte.UpdateItem(0, True)
            lViewCompte.EditIndex = 0
        End If
    End Sub

    Protected Sub btnModiMotDePasse_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnModiMotDePasse.Click
        multiViewModiCompte.ActiveViewIndex = 1
    End Sub

    Protected Sub btnEnregistrerPW_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEnregistrerPW.Click
        Dim salt = "manan"
        Dim noCompte As String = Session("noCompte")
        Dim compte As Compte = (From monCompte In lecontext.Compte Where monCompte.noCompte = noCompte).First
        If tbNouvMotDePasse.Text.Count < 6 Then
            Dim validatorMotDePasse As CustomValidator = New CustomValidator
            validatorMotDePasse.ErrorMessage = "Votre nouveau mot de passe doit contenir plus de 5 caractères"
            validatorMotDePasse.IsValid = False
            Me.Validators.Add(validatorMotDePasse)
        End If
        If compte.motDePasseCrypté = CreatePasswordHash(tbMotDePasse.Text, salt) Then
            Dim hash As String = CreatePasswordHash(tbNouvMotDePasse.Text, salt)
            compte.motDePasseCrypté = hash
            lbMessage.Text = "Votre mot de passe à bien été changé."
        Else
            lbMessage.Text = "Votre ancient mot de passe n'est pas valide."
        End If
        If Me.IsValid Then
            lecontext.SaveChanges()
        End If
    End Sub

    Protected Sub btnAnnuler_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAnnuler.Click
        multiViewModiCompte.ActiveViewIndex = 0
    End Sub

End Class
