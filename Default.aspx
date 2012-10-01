<%@ Page Title="" Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" Theme="Default" %>

<asp:Content ID="contentAccueil" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
<h1><asp:Label SkinID="lbTitrePage" ID="lbAccueil" runat="server" Text="Accueil" ></asp:Label></h1>
    <div id="texteAccueil">
        <asp:Label ID="lbTexte" runat="server" Width="450px"
        Text="Nous sommes une entreprise d'inscription à des sports, des cours et des activitées de loisirs."></asp:Label><br />
        </div>
    <div id="imageAccueil"><asp:Image ID="imgAccueil" runat="server"  Width="250px" Height="250px" /></div>
</asp:Content>

