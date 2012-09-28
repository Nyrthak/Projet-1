<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="GérerLesCours.aspx.vb" Inherits="Admin_GérerLesCours" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <asp:Label ID="lblTitreGererCours" runat="server" Text="Gérer les cours" SkinID="lbTitrePage"></asp:Label><br />
    <asp:Label ID="lblListeDeCours" runat="server" Text="Liste de cours" SkinID="lbSousTitre"></asp:Label>
    <asp:TextBox ID="txtRechercher" runat="server" SkinID="TextBoxFormulaire" CssClass="txtRechercher"></asp:TextBox>
    <asp:Label ID="lblRechercher" runat="server" Text="Rechercher : " CssClass="lbRechercher"></asp:Label> 
    <asp:ListView ID="lViewCours" runat="server" DataSourceID="LinqDataSourceCours" DataKeyNames="noCours">
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
                <td><asp:Label ID="lblNbGroupe" runat="server" Text='<%#Eval("nbGroupes")%>'></asp:Label></td>
                <td><asp:Label ID="lblCategorie" runat="server" Text='<%#Eval("nomCategorie")%>'></asp:Label></td>
                <td><asp:Button ID="btnModifier" runat="server" Text="Modifier" SkinID="btnConfirmation" PostBackUrl='<%# "~/Admin/ModifierCours.aspx?noCours=" & Eval("noCours")%>' /></td>
                <td><asp:Button ID="btnSupprimer" runat="server" Text="Supprimer" SkinID="btnConfirmation" CommandName="Delete" CommandArgument='<%#Eval("noCours")%>' /></td>
            </tr>
        </ItemTemplate>
    </asp:ListView>
    <br />
    <asp:Button ID="btnAjouterUnCours" runat="server" Text="Ajouter" SkinID="btnConfirmation"/>
    <br /><br />
    <asp:DataPager ID="DataPagerGereCours" runat="server" 
        PagedControlID="lViewCours">
        <Fields>
            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                ShowLastPageButton="True" FirstPageText="Premier" LastPageText="Dernier" 
                NextPageText="Suivant" PreviousPageText="Précédent" />
        </Fields>
    </asp:DataPager>
    <asp:LinqDataSource ID="LinqDataSourceCours" runat="server"
            ContextTypeName="Model.ModelContainer"
            TableName="CoursSet" 
            Select="new (noCours, Nom, Catégorie.Nom As nomCategorie, Groupe.Count() AS nbGroupes)" 
            EnableDelete="True" OrderBy="noCours"
            Where='(@recherche = "") || Nom.Contains(@recherche)' >
            <WhereParameters>
                <asp:ControlParameter Name="recherche" ControlID="txtRechercher" ConvertEmptyStringToNull="false" />
            </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
