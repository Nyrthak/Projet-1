
Imports Model
Partial Class client_inscriptionClient
    Inherits page
    Private Shared lecontext As ModelContainer = Nothing

    Protected Sub dsContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextCreatingEventArgs) _
    Handles entityDataSourcePaiement.ContextCreating

        'RÉCUPÈRE LE CONTEXTE DE FACON À N'EN AVOIR QU'UN
        If Not lecontext Is Nothing Then
            e.Context = lecontext
        End If
    End Sub


    Protected Sub dsContextDisposing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.EntityDataSourceContextDisposingEventArgs) _
    Handles entityDataSourcePaiement.ContextDisposing
        e.Cancel = True
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

    Protected Sub entityDataSourcePaiement_DataBinding(ByVal sender As Object, ByVal e As System.EventArgs) Handles entityDataSourcePaiement.DataBinding
        
    End Sub

    'Protected Sub entityDataSourcePaiement_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles entityDataSourcePaiement.Load
    '    Dim noCompte As Integer = Session("noCompte")
    '    Dim membreList = (From monMembre In lecontext.MembreSet Where monMembre.Compte.noCompte = noCompte)
    '    Dim membreListString As String = ""
    '    Dim listMembre As New Parameter
    '    Dim noMembre As Integer
    '    For Each membre In membreList
    '        membreListString += (membre.noMembre & " ")
    '    Next
    '    listMembre.DefaultValue = membreListString
    '    entityDataSourcePaiement.WhereParameters.Add(listMembre)

    '    entityDataSourcePaiement.Where() = "It.membre.noMembre Like membreListString"
    'End Sub

    Protected Sub repeater_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles repeater.ItemDataBound
        e.Item.Visible = True
    End Sub
End Class
