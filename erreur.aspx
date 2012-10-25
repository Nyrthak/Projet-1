<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="erreur.aspx.vb" Inherits="Erreur" %>

<asp:Content ID="contentMenu" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="contentAccueil" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
<h1><asp:Label SkinID="lbTitrePage" ID="lbAccueil" runat="server" Text="Accueil" ></asp:Label></h1>
    <div id="texteErreur">
        <asp:Label ID="lbTexte" runat="server" Width="450px"
        Text="Une erreure non gérée s'est produite. Nous sommes désolés de l'inconvénient. Si cela se reproduit, veuillez nous contacter."></asp:Label><br />
        </div>
    <div id="imageAccueil"><asp:Image ID="imgAccueil" runat="server"  Width="250px" Height="250px" /></div>
</asp:Content>
