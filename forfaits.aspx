<%@ Page Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false" CodeFile="forfaits.aspx.vb" Inherits="forfaits" %>


<asp:Content ID="contentMenu" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <asp:Label ID="lblTitreForfaits" runat="server" Text="Forfaits disponibles" SkinID="lbTitrePage"></asp:Label><br /><br />

    <asp:ListView ID="lViewForfaits" runat="server" DataSourceID="entiDataSourceForfaits" DataKeyNames="nbInscrits">
        <LayoutTemplate>
            <table id="tbListeAttente">
                <tr>
                    <th><asp:Label ID="lbTitreNbInscrits" runat="server" Text="Nombre d'inscriptions"></asp:Label></th>
                    <th><asp:Label ID="lbTitreCout" runat="server" Text="Coût"></asp:Label></th>
                </tr>
                <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
            </table>
        </LayoutTemplate>
        <ItemTemplate>
            <tr>
                    <td><asp:Label ID="lbNbInscrits" runat="server" Text='<%#Eval("nbInscrits")%>'></asp:Label></td>
                    <td><asp:Label ID="lbCout" runat="server" Text='<%#Eval("Coût","{0:#%}")%>'></asp:Label></td>
                </tr>
        </ItemTemplate>
    </asp:ListView>
    <br /><br />
    <asp:Label ID="lbInformations" runat="server" Text="*Ces forfaits s'appliquent lorsque le total des inscriptions dans une même session des enfants d'un compte s'élèvent au nombre mentionné par le forfait."></asp:Label>
    <asp:EntityDataSource ID="entiDataSourceForfaits" runat="server" 
            ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
            EnableFlattening="False" EntitySetName="Forfait">
        </asp:EntityDataSource>
</asp:Content>
