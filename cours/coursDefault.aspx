<%@ Page Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false" CodeFile="coursDefault.aspx.vb" Inherits="coursDefault" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">    
    <asp:Button ID="btnRechercher" runat="server" Text="Ok" CssClass="rechercher" />
    <asp:TextBox ID="txtRechercher" runat="server" SkinID="TextBoxFormulaire" CssClass="rechercher"></asp:TextBox>
    <asp:Label ID="lblRechercher" runat="server" Text="Rechercher" CssClass="lbRechercher"></asp:Label>
    <asp:MultiView ID="mViewCours" runat="server" ActiveViewIndex= "0">
        <asp:View ID="viewCategorie" runat="server">
            <asp:Label ID="lblTitreAfficheCours" runat="server" Text="Cours" SkinID="lbTitrePage"></asp:Label> 
            <asp:ListView ID="lViewCatégorie" runat="server" DataSourceID="EntityDataSourceCatégorie" DataKeyNames="noCatégorie">
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
                        <asp:LinkButton ID="lblCatégorie" runat="server" Text='<%#"Cours de " & Eval("Nom")%>' CommandName="ClickCatégorie" CommandArgument='<%#Eval("noCatégorie")%>'></asp:LinkButton>
                    </li>
                </ItemTemplate>
            </asp:ListView>
            <asp:HiddenField ID="hFieldNoCategorie" runat="server" />
            <asp:EntityDataSource ID="EntityDataSourceCatégorie" runat="server" 
                ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
                EntitySetName="CatégorieSet" EnableFlattening="false">
            </asp:EntityDataSource>
        </asp:View>
        <asp:View ID="viewListeCours" runat="server">
            <asp:ListView ID="lViewListeCours" runat="server" DataSourceID="entityDataSourceListeCours" DataKeyNames="noCours" >
                <LayoutTemplate>
                    <asp:Label ID="lblTitreListeCours" runat="server" Text="Liste des cours" SkinID="lbTitrePage"></asp:Label>
                    <table>
                        <tr>
                            <td><asp:Label ID="lblTitreActivite" runat="server" Text="Activité"></asp:Label></td>
                            <td><asp:Label ID="lblTitreGroupeDAge" runat="server" Text="Groupe d'âge"></asp:Label></td>
                            <td><asp:Label ID="lblTitreSession" runat="server" Text="Session"></asp:Label></td>
                        </tr>
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td><asp:Label ID="lblActivite" runat="server" Text='<%#Eval("Nom")%>'></asp:Label></td>
                        <td><asp:Label ID="lblGroupeDAge" runat="server" Text='<%#Eval("GroupeDAge.NomGroupeDAge")%>'></asp:Label></td>
                        <td><asp:Label ID="lblSession" runat="server" Text='<%#Eval("Session.NomSession")%>'></asp:Label></td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
            <asp:EntityDataSource ID="entityDataSourceListeCours" runat="server" 
                ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
                EntitySetName="CoursSet" EnableFlattening="false" Include="GroupeDAge, Session, Catégorie"
                 Where='((@recherche = "") AND it.[Catégorie].[noCatégorie] = @categorie) OR (it.Nom + it.[Catégorie].Nom + it.[GroupeDAge].NomGroupeDAge like "%"+@recherche+"%" AND it.[Catégorie].[noCatégorie] = @categorie)'>
                 
                <WhereParameters>
                    <asp:ControlParameter Name="recherche" Type="String" ControlID="txtRechercher" ConvertEmptyStringToNull="false" />
                    <asp:ControlParameter Name="categorie" Type="Int32" ControlID="hFieldNoCategorie" />
                </WhereParameters>
            </asp:EntityDataSource>
        </asp:View>
    </asp:MultiView>
    
</asp:Content>

