<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="default.aspx.vb" Inherits="administration" %>
<asp:Content ID="ContentCours" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <asp:Label ID="lblTitrePageAdmin" runat="server" Text="Liste d'actions possibles" SkinID="lbTitrePage"></asp:Label>
    <table class="TableauAdmin">
        <tr>
            <td><asp:Button ID="btnAjoutCompteClient" runat="server" SkinID="btnAdmin" Text="Ajouter un compte client"  /></td>
            <td><asp:Button ID="btnAjoutComptePrépose" runat="server" SkinID="btnAdmin" Text="Ajouter un compte préposé" PostBackUrl="~/Admin/ajouterComptePrepose.aspx" /></td>
        </tr>
        <tr>
            <td><asp:Button ID="btnGererComptes" runat="server" SkinID="btnAdmin" Text="Gérer les comptes" /></td>
            <td><asp:Button ID="btnGererForfaits" runat="server" SkinID="btnAdmin" Text="Gérer les forfaits" /></td>
        </tr>
        <tr>
            <td><asp:Button ID="btnGererCours" runat="server" SkinID="btnAdmin" Text="Gérer les cours" PostBackUrl="~/Admin/GérerLesCours.aspx" /></td>
            <td><asp:Button ID="btnAfficherListeAttente" runat="server" SkinID="btnAdmin" Text="Afficher toutes les listes d'attente" /></td>
        </tr>
    </table>
</asp:Content>
