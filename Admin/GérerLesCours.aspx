<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="GérerLesCours.aspx.vb" Inherits="Admin_GérerLesCours" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">

    <asp:EntityDataSource ID="EntityDataSourceCours" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="CoursSet" Include="Catégorie, Groupe" EnableDelete="True">
    </asp:EntityDataSource>
    <asp:Label ID="lblTitreGererCours" runat="server" Text="Gérer les cours" SkinID="lbTitrePage"></asp:Label><br />
    <asp:Label ID="lblListeDeCours" runat="server" Text="Liste de cours" SkinID="lbSousTitre"></asp:Label>
    <asp:TextBox ID="txtRechercher" runat="server" SkinID="TextBoxFormulaire" CssClass="txtRechercher"></asp:TextBox>
    <asp:Label ID="lblRechercher" runat="server" Text="Rechercher : " CssClass="lbRechercher"></asp:Label>   
        <asp:ListView ID="lViewCours" runat="server" DataSourceID="EntityDataSourceCours" DataKeyNames="noCours">
        <LayoutTemplate>
            <table>
            <tr>
                <td><asp:Label ID="lblTitreNomCours" runat="server" Text="Nom"></asp:Label></td>
                <td><asp:Label ID="lblTitreNbGroupes" runat="server" Text="Nb. de groupes"></asp:Label></td>
                <td><asp:Label ID="lblTitreCategorie" runat="server" Text="Catégorie"></asp:Label></td>
            </tr>
            <asp:PlaceHolder id="GroupPlaceHolder" runat="server" />
            </table>
            <br />
        </LayoutTemplate>
        <GroupTemplate>
            <asp:PlaceHolder id="ItemPlaceHolder"  runat="server" />
        </GroupTemplate>
        <ItemTemplate>
            <tr>
                <td><asp:Label ID="lblNomCours" runat="server" Text='<%#Eval("Nom")%>'></asp:Label></td>
                <td><asp:Label ID="lblNbGroupe" runat="server" Text='<%#Eval("Groupe.count")%>'></asp:Label></td>
                <td><asp:Label ID="lblCategorie" runat="server" Text='<%#Eval("Catégorie.Nom")%>'></asp:Label></td>
                <td><asp:Button ID="btnModifier" runat="server" Text="Modifier" SkinID="btnConfirmation" /></td>
                <td><asp:Button ID="btnSupprimer" runat="server" Text="Supprimer" SkinID="btnConfirmation" /></td>
            </tr>
        </ItemTemplate>
        </asp:ListView>
    <asp:Button ID="btnAjouterUnCours" runat="server" Text="Ajouter" SkinID="btnConfirmation" PostBackUrl="~/Admin/AjoutCours.aspx" />
</asp:Content>
