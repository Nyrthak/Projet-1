<%@ Page Language="VB" AutoEventWireup="false" CodeFile="pageError.aspx.vb" Inherits="pageError" MasterPageFile="~/masterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="content">
    <asp:Label ID="lbTextError" SkinID="lbTitrePage" runat="server" Text="Désolé, vous n'avez pas les permissions nécessaires pour aller sur cette page."></asp:Label>
</div>
</asp:Content>
