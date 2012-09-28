<%@ Page Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false" CodeFile="coursDefault.aspx.vb" Inherits="coursDefault" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <asp:Label ID="lblTitreAfficheCours" runat="server" Text="Cours" SkinID="lbTitrePage"></asp:Label>
    <asp:TextBox ID="txtRechercher" runat="server" SkinID="TextBoxFormulaire" CssClass="txtRechercher"></asp:TextBox>
    <asp:Label ID="lblRechercher" runat="server" Text="Rechercher : " CssClass="lbRechercher"></asp:Label>
    <asp:ListView ID="ListViewCatégorie" runat="server" DataSourceID="EntityDataSourceCatégorie" DataKeyNames="noCatégorie">
        <LayoutTemplate>
            <ul class="listeSansPoints">
                <asp:PlaceHolder id="GroupPlaceHolder" runat="server" />
            </ul>
        </LayoutTemplate>
        <GroupTemplate>
            <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
        </GroupTemplate>
        <ItemTemplate>
            <li>
                <asp:LinkButton ID="lblCatégorie" runat="server" Text='<%#"Cours de " & Eval("Nom")%>' PostBackUrl='<%#"~/cours.aspx?noCatégorie=" & Eval("noCatégorie") %>'></asp:LinkButton>
            </li>
        </ItemTemplate>
    </asp:ListView>
    <asp:EntityDataSource ID="EntityDataSourceCatégorie" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="CatégorieSet" EnableFlattening="false">
    </asp:EntityDataSource>
</asp:Content>

