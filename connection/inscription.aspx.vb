'Cette class permet de s'inscrire sur notre site avec des validations sur les champs.
'Lawrence Dubé et Katherine Vandal

Imports System.Reflection
Imports System.Drawing
Imports Model
Imports System.Windows.Forms

Partial Class inscription
    Inherits page
    Private Shared lecontext As ModelContainer = Nothing
    Protected Sub page_load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Session("userOnline") = "" Then
            Page.Response.Redirect("~/Default.aspx")
        End If

        lecontext = New ModelContainer()

        'Remplissage du dropdownlist annee
        Dim i As Integer = 0
        dropDownListAnnee.Items.Add("")
        While i < 12
            dropDownListAnnee.Items.Add(Now.AddYears(i).Year)
            i += 1
        End While

    End Sub
    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
    Handles entityDataSourceProvince.ContextCreating

        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub
    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
    Handles entityDataSourceProvince.ContextDisposing
        e.Cancel = True
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub


    Protected Sub btnEnregistrerInscription_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEnregistrerInscription.Click
        Dim compteur As Integer = 0
        Dim salt As String = ""
        'Dim aCookie As New HttpCookie("online")
        For Each courriel As String In (From dl In lecontext.CompteSet Select dl.Email)
            If tbCourriel.Text = courriel Then
                Dim validatorEmail As CustomValidator = New CustomValidator
                validatorEmail.ErrorMessage = "Votre email est déja utilisé."
                validatorEmail.IsValid = False
                Me.Validators.Add(validatorEmail)
            Else
                salt = tbCourriel.Text.Substring(0, 3)
            End If
        Next
        If tbMotDePasse.Text.Count < 6 Then
            Dim validatorMotDePasse As CustomValidator = New CustomValidator
            validatorMotDePasse.ErrorMessage = "Votre mot de passe doit contenir plus de 5 caractères"
            validatorMotDePasse.IsValid = False
            Me.Validators.Add(validatorMotDePasse)
        End If
        'teste sur la carte de crédit

        If Me.IsValid Then
            Dim hash As String = CreatePasswordHash(tbMotDePasse.Text, salt)

            Dim compteAjoute As Compte = New Compte()
            Dim membreAjoute As Membre = New Membre()

            compteAjoute.Type = 1
            compteAjoute.Adresse = tbAdresse.Text
            compteAjoute.Ville = tbVille.Text
            compteAjoute.CodePostal = tbCodePostal.Text
            compteAjoute.Abonnement = False
            compteAjoute.ModePaiement = rbListeTypeCarte.SelectedValue
            compteAjoute.motDePasseCrypté = hash
            compteAjoute.Email = tbCourriel.Text
            compteAjoute.noTelephone = tbNumeroTelephone.Text
            compteAjoute.Province = (From dl In lecontext.ProvinceSet Where dl.noProvince = dropDownListProvince.SelectedValue Select dl).First
            compteAjoute.Pays = tbPays.Text

            membreAjoute.Nom = tbNom.Text
            membreAjoute.Prénom = tbPrenom.Text
            membreAjoute.DateNaissance = tbDateNaissance.Text
            membreAjoute.Propriétaire = True

            compteAjoute.Membre.Add(membreAjoute)
            lecontext.AddObject("CompteSet", compteAjoute)
            lecontext.SaveChanges()
            'aCookie("online") = "oui"
            'Response.Cookies.Add(aCookie)
            Page.Response.Redirect("~/connection/inscriptionReusi.aspx")
            
        End If
    End Sub


    Protected Sub dropDownListProvince_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dropDownListProvince.DataBound
        dropDownListProvince.Items.Insert(0, "")
    End Sub
End Class
