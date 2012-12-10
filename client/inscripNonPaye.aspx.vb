'Systeme: Permet de s'incrire à des activitées pour le site CSL
'Auteurs: Lawrence Dubé et Katherine Vandal
'Fonctionnalités:
'       -Payer les inscriptions non payés
'Intrants:
'       le nom
'       le prénom
'       adresse
'       numéro de carte de crédit
'       date d'expiration
'Extrants: Elle affiche une d'inscriptions non payé
'       -le numéro
'       -le nom
'Dernière mise à jours: 6 novembre 2012

Imports Model

Partial Class client_inscripNonPaye
    Inherits page

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
#Region "Controle d'erreur"

#End Region
#Region "EntityDataSource"
    Protected Sub entiDataSourcePaiementNonPaye_ContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) Handles entiDataSourcePaiementNonPaye.ContextCreating, entityDataSourceProvince.ContextCreating
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub
    Protected Sub entiDataSourcePaiementNonPaye_ContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) Handles entiDataSourcePaiementNonPaye.ContextDisposing, entityDataSourceProvince.ContextDisposing
        e.Cancel = True
    End Sub

#End Region
#Region "Controle"
    Protected Sub lViewPaiement_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewCommandEventArgs) Handles lViewPaiement.ItemCommand
        If e.CommandName = "Payer" Then
            hFielNoPaiement.Value = e.CommandArgument
            mViewInscription.ActiveViewIndex = 1
        End If
    End Sub
    Protected Sub btnEnregistrerInscription_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEnregistrerInscription.Click
        Dim leNoCompte As Integer = Session("noCompte")
        Dim leNoPaiement As Integer = hFielNoPaiement.Value
        Dim lePaiement As Paiement = (From unPaiement In lecontext.Paiement Where unPaiement.noPaiement = leNoPaiement Select unPaiement).First
        Dim lePrixPaiementBase As Double = lePaiement.Prix
        Dim leCompte As Compte = (From unCompte In lecontext.Compte Where unCompte.noCompte = leNoCompte Select unCompte).First

        lePaiement.ModePaiement = rbListeTypeCarte.SelectedItem.Text
        lePaiement.noPaypal = "3jfh3jdh"

        'Vérification du prix en fonction des forfaits
        Dim laSession As Integer = lePaiement.Groupe.Session.noSession
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
                             lePaiement.Groupe.Cours.Prix * coutForfait, tbPrenomPaiement.Text, tbNomPaiement.Text, tbAdresse.Text, _
                                 tbVille.Text, dropDownListProvince.SelectedItem.Text, tbCodePostal.Text)

            If Not noPaypal = "" Then
                lePaiement.Prix = lePrixPaiementBase * coutForfait
                lePaiement.noPaypal = noPaypal
                Try
                    lecontext.SaveChanges()
                Catch ex As Exception
                    lbMessage.Text = traiteErreur(ex, "mise à jour")
                End Try

                envoyerMailPaiementInscription(leCompte.Email, lePaiement.Groupe.Cours.Nom, lePaiement.Groupe.Nom, lePaiement.Prix, lePaiement.ModePaiement, _
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
    Protected Sub mViewInscription_ActiveViewChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles mViewInscription.ActiveViewChanged
        If mViewInscription.ActiveViewIndex = 1 Then
            'Remplissage du dropdownlist annee
            Dim i As Integer = 0
            dropDownListAnnee.Items.Add("")
            While i < 12
                dropDownListAnnee.Items.Add(Now.AddYears(i).Year)
                i += 1
            End While
        End If
    End Sub
#End Region
End Class
