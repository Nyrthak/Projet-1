﻿'Systeme: Permet de s'incrire à des activitées pour le site CSL
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
    Inherits page
    Private Shared lecontext As ModelContainer = Nothing

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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lecontext = New ModelContainer()
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        verificationTypeUser(1)
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        lecontext = Nothing
    End Sub

End Class
