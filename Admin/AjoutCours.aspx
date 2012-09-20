<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="AjoutCours.aspx.vb" Inherits="Admin_AjoutCours" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    
    <asp:EntityDataSource ID="EntityDataSourceGroupeDAge" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EnableFlattening="False" EntitySetName="GroupeDAgeSet">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EntityDataSourceSession" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EnableFlattening="False" EntitySetName="SessionSet">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EntityDataSourceCategorie" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EnableFlattening="False" EntitySetName="CatégorieSet">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EntityDataSourcePrerequis" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="CoursSet" Select="it.[noCours], it.[Nom]">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EntityDataSourceCours" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EnableInsert="True" EntitySetName="CoursSet">
    </asp:EntityDataSource>

    <asp:Label ID="lblTitreAjoutCours" runat="server" Text="Ajouter un cours" SkinID="lbTitrePage"></asp:Label>
    <table>
        <tr>
            <td><asp:Label ID="lblNoCours" runat="server" Text="NoCours" SkinID="lbChampsFormulaire"></asp:Label></td>
            <td ><asp:Label ID="lblNomDuCours" runat="server" Text="Nom du cours" SkinID="lbChampsFormulaire"></asp:Label></td>
            <td><asp:Label ID="lblPrix" runat="server" Text="Prix" SkinID="lbChampsFormulaire"></asp:Label></td>
        </tr>
        <tr>
            <td><asp:TextBox ID="txtNoCours" runat="server" SkinID="TextBoxFormulaire"></asp:TextBox></td>
            <td><asp:TextBox ID="txtNomDuCours" runat="server" SkinID="TextBoxFormulaire"></asp:TextBox></td>
            <td><asp:TextBox ID="txtPrix" runat="server" SkinID="TextBoxFormulaire"></asp:TextBox></td>           
        </tr>
        <tr>
            <td><asp:Label ID="lblGroupeDAge" runat="server" Text="Groupe d'âge" SkinID="lbChampsFormulaire"></asp:Label></td>
            <td><asp:Label ID="lblSession" runat="server" Text="Session" SkinID="lbChampsFormulaire"></asp:Label></td>
            <td><asp:Label ID="lblCategorie" runat="server" Text="Catégorie" SkinID="lbChampsFormulaire"></asp:Label></td>
        </tr>
        <tr>
            <td><asp:DropDownList ID="dDListGroupeDAge" runat="server" 
                    SkinID="dDListFormulaire" DataSourceID="EntityDataSourceGroupeDAge" 
                    DataTextField="NomGroupeDAge" DataValueField="noGroupeDAge"></asp:DropDownList></td>
            <td><asp:DropDownList ID="dDListSession" runat="server" SkinID="dDListFormulaire" 
                    DataSourceID="EntityDataSourceSession" DataTextField="NomSession" 
                    DataValueField="noSession"></asp:DropDownList></td>
            <td><asp:DropDownList ID="dDListCategorie" runat="server" SkinID="dDListFormulaire" 
                    DataSourceID="EntityDataSourceCategorie" DataTextField="Nom" 
                    DataValueField="noCatégorie"></asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblPrerequis" runat="server" Text="Prérequis" SkinID="lbChampsFormulaire"></asp:Label></td>
            <td colspan="2"><asp:Label ID="lblDescription" runat="server" Text="Description" SkinID="lbChampsFormulaire"></asp:Label></td>
        </tr>
        <tr>
            <td><asp:DropDownList ID="dDListPrerequis" runat="server" SkinID="dDListFormulaire" 
                    DataSourceID="EntityDataSourcePrerequis" DataTextField="Nom" 
                    DataValueField="noCours"></asp:DropDownList></td>
            <td colspan="2"><asp:TextBox ID="txtDescription" runat="server" SkinID="TextBoxDescription" TextMode="MultiLine"></asp:TextBox></td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnAjoutCours" runat="server" SkinID="btnConfirmation" Text="Ajouter" /></td>
        </tr>
    </table>
</asp:Content>
