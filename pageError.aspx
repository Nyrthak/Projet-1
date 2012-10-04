<%@ Page Language="VB" AutoEventWireup="false" CodeFile="pageError.aspx.vb" Inherits="pageError" MasterPageFile="~/masterPage.master" %>


<asp:Content ID="contentMenu" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <asp:Label ID="lbTextError" SkinID="lbTitrePage" runat="server" Text="Désolé, vous n'avez pas les permissions nécessaires pour aller sur cette page."></asp:Label>
</asp:Content>
