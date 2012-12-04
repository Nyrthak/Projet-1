<%@ Page Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false" CodeFile="informationsGenerales.aspx.vb" Inherits="informationsGenerales" %>

<asp:Content ID="contentMenu" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="texteAccueil">
        <asp:Label ID="lbMission" runat="server" Text="Pour nous rejoindre" SkinID="lbSousTitre"></asp:Label>
        <table>
            <tr>
                <td style="width:150px;"><strong>Téléphone:</strong></td>
                <td>450-111-2222</td>
            </tr>
            <tr>
                <td><strong>Sans frais:</strong></td>
                <td>1 866 435-0298</td>
            </tr>
            <tr>
                <td><strong>Couriel:</strong></td>
                <td>support@csl.inc</td>
            </tr>
            <tr>
                <td><strong>Adresse:</strong></td>
                <td>48 rue Principale</td>
            </tr>
            <tr>
                <td></td>
                <td>Granby(Québec) J2K 6L4</td>
            </tr>
            <tr>
                <td></td>
                <td>Canada</td>
            </tr>
        </table>
        <asp:Label ID="lbPiscine" runat="server" Text="Piscine" SkinID="lbSousTitre"></asp:Label>
        <table>
            <tr>
                <td style="width:150px;"><strong>Téléphone:</strong></td>
                <td>450-111-2222 poste 536</td>
            </tr>
            <tr>
                <td><strong>Heures d'ouverture:</strong></td>
                <td>Dimanche au Mercredi: 5h30 à 22h30</td>
            </tr>
            <tr>
                <td></td>
                <td>Jeudi au Samedi: 5h30 à 23h30</td>
            </tr>
        </table>
        <asp:Label ID="lbTennis" runat="server" Text="Terrain de Tennis" SkinID="lbSousTitre"></asp:Label>
        <table>
            <tr>
                <td style="width:150px;"><strong>Téléphone:</strong></td>
                <td>450-111-2222 poste 834</td>
            </tr>
            <tr>
                <td><strong>Heures d'ouverture:</strong></td>
                <td>Dimanche au Mercredi: 6h30 à 21h00</td>
            </tr>
            <tr>
                <td></td>
                <td>Jeudi au Samedi: 6h30 à 23h30</td>
            </tr>
        </table>
    </div>
    <div id="imageAccueil"><asp:Image ID="imgAccueil" runat="server"  Width="250px" Height="168px" ImageUrl="~/App_Themes/Default/images/telephone.png" /></div>
</asp:Content>