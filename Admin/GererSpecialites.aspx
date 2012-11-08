<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="GererSpecialites.aspx.vb" Inherits="Admin_GererSpecialites" %>

<asp:Content ID="ContentCours" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="contentRight">
        <asp:Label ID="lblTitreCategorie" runat="server" Text="Gérer les Catégories" SkinID="lbTitrePage"></asp:Label><br />
        <asp:ListView ID="lViewCategorie" runat="server" DataSourceID="entiDataSourceCategorie" DataKeyNames="noCatégorie" InsertItemPosition="LastItem">
            <LayoutTemplate>
            <table id="tbListeAttente">
                <tr>
                    <th><asp:Label ID="lbTitreNoCategorie" runat="server" Text="Numéro"></asp:Label></th>
                    <th><asp:Label ID="lbTitreNom" runat="server" Text="Nom"></asp:Label></th>
                </tr>
                <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
            </table>
            <asp:ValidationSummary ID="vSummaryInsert" runat="server" ValidationGroup="Insert" CssClass="validationSummary" Height="50px" />
            <asp:ValidationSummary ID="vSummaryEdit" runat="server" ValidationGroup="Edit" CssClass="validationSummary" Height="50px" />  
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td><asp:Label ID="lbNoCategorie" runat="server" Text='<%#Eval("noCatégorie")%>'></asp:Label></td>
                    <td><asp:Label ID="lbNom" runat="server" Text='<%#Eval("Nom")%>'></asp:Label></td>
                    <td><asp:Button ID="btnModifier" runat="server" Text="Modifier" CommandName="Edit" SkinID="btnAjoutSupprimer" Width="78px" /></td>
                    <td><asp:Button ID="btnSupprimer" runat="server" Text="Supprimer" CommandName="Delete" SkinID="btnAjoutSupprimer" Width="78px"/></td>
                </tr>
            </ItemTemplate>
            <EditItemTemplate>
                <tr>
                    <td><asp:Label ID="lbNoCategorie" runat="server" Text='<%#Eval("noCatégorie")%>'></asp:Label></td>
                    <td><asp:TextBox ID="tbNom" runat="server" Text='<%#Bind("Nom")%>' SkinID="tbSkin" Width="80px" MaxLength="15"></asp:TextBox></td>
                    <td><asp:Button ID="btnUpdate" runat="server" Text="Enregistrer" CommandName="Update" SkinID="btnAjoutSupprimer" Width="78px" /></td>
                    <td><asp:Button ID="btnCancel" runat="server" Text="Annuler" CommandName="Cancel" SkinID="btnAjoutSupprimer" Width="78px"/></td>
                </tr>
            </EditItemTemplate>
            <InsertItemTemplate>
                <tr>
                    <td></td>
                    <td><asp:TextBox ID="tbNom" runat="server" Text='<%#Bind("Nom")%>' SkinID="tbSkin" Width="80px" MaxLength="15"></asp:TextBox></td>
                    <td><asp:Button ID="btnInsert" runat="server" Text="Ajouter" CommandName="Insert" SkinID="btnAjoutSupprimer" Width="78px" /></td>
                </tr>
            </InsertItemTemplate>
        </asp:ListView>
        <asp:DataPager ID="DataPagerGererCategorie" runat="server" PagedControlID="lViewCategorie">
            <Fields>
                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                    ShowLastPageButton="True" FirstPageText="Premier" LastPageText="Dernier" 
                    NextPageText="Suivant" PreviousPageText="Précédent" ButtonCssClass="boutonMenuPager"/>
            </Fields>
        </asp:DataPager>
        <br /><asp:Label ID="lbMessage" runat="server" Text=""></asp:Label>
        <asp:EntityDataSource ID="entiDataSourcecategorie" runat="server" 
            ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
            EnableFlattening="False" EntitySetName="Catégorie" EnableDelete="true" EnableUpdate="true" EnableInsert="true">
        </asp:EntityDataSource>
    </div>
</asp:Content>