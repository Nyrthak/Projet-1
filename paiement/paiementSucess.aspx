<%@ Page Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false" CodeFile="paiementSucess.aspx.vb" Inherits="paiement_paiementSucess" %>

<asp:Content ID="contentMenu" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <asp:Label SkinID="lbSousTitre" ID="lbPaiementSucess" runat="server" Text="Le paiement que vous venez de passer à fonctionner."></asp:Label><br />
    <asp:Label SkinID="lbSousTitre" ID="lbPaiemntSucess2" runat="server" Text="Merci de nous magasiner chez nous."></asp:Label><br />
</asp:Content>
