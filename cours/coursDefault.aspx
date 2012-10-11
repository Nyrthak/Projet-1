<%@ Page Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false" CodeFile="coursDefault.aspx.vb" Inherits="coursDefault" %>

<asp:Content ID="contentMenu" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">    
    <asp:Button ID="btnRechercher" runat="server" Text="Ok" CssClass="rechercher" />
    <asp:TextBox ID="txtRechercher" runat="server" SkinID="TextBoxFormulaire" CssClass="rechercher"></asp:TextBox>
    <asp:Label ID="lblRechercher" runat="server" Text="Rechercher" CssClass="lbRechercher"></asp:Label>
    <div id="menuFloat">
        <asp:ListView ID="lViewCatégorie" runat="server" DataSourceID="EntityDataSourceCatégorie" DataKeyNames="noCatégorie">
                <LayoutTemplate>
                    <ul>
                        <asp:PlaceHolder id="GroupPlaceHolder" runat="server" />
                    </ul>
                </LayoutTemplate>
                <GroupTemplate>
                    <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                </GroupTemplate>
                <ItemTemplate>
                    <li>
                        <asp:LinkButton ID="lblCatégorie" runat="server" Text='<%#Eval("Nom")%>' CommandName="ClickCatégorie" CommandArgument='<%#Eval("noCatégorie")%>'></asp:LinkButton>
                    </li>
                </ItemTemplate>
            </asp:ListView>
    </div>
    <div id="contentRight">
    <asp:MultiView ID="mViewCours" runat="server" ActiveViewIndex= "0">
        <asp:View ID="viewListeCours" runat="server">
            <asp:ListView ID="lViewListeCours" runat="server" DataSourceID="entityDataSourceListeCours" DataKeyNames="noCours" >
                <LayoutTemplate>
                    <asp:Label ID="lblTitreListeCours" runat="server" Text="Liste des cours" SkinID="lbTitrePage"></asp:Label>
                    <table class="listeCours">
                        <tr>
                            <td><asp:Label ID="lblTitreActivite" runat="server" SkinID="lbTitreInfoMembre" Text="Activité"></asp:Label></td>
                            <td><asp:Label ID="lblTitreGroupeDAge" runat="server" SkinID="lbTitreInfoMembre" Text="Groupe d'âge"></asp:Label></td>
                            <td><asp:Label ID="lblTitreSession" runat="server" SkinID="lbTitreInfoMembre" Text="Session"></asp:Label></td>
                        </tr>
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td><asp:LinkButton ID="lblActivite" runat="server" Text='<%#Eval("Nom")%>' CommandName="Selection" CommandArgument='<%#Eval("noCours")%>'></asp:LinkButton></td>
                        <td><asp:Label ID="lblGroupeDAge" runat="server" Text='<%#Eval("GroupeDAge.NomGroupeDAge")%>'></asp:Label></td>
                        <td><asp:Label ID="lblSession" runat="server" Text='<%#Eval("Session.NomSession")%>'></asp:Label></td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
            <asp:DataPager ID="dpListeCours" runat="server" PagedControlID="lViewListeCours">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                        ShowLastPageButton="True" FirstPageText="Premier" LastPageText="Dernier" 
                        NextPageText="Suivant" PreviousPageText="Précédent" ButtonCssClass="boutonMenuCategorie" />
                </Fields>
            </asp:DataPager>
        </asp:View>
        <asp:View ID="viewCours" runat="server">
            <asp:HiddenField ID="hFieldnoCours" runat="server" />
            <asp:ListView ID="lviewCours" runat="server" DataSourceID="entityDataSourceCours" DataKeyNames="noCours">
                <LayoutTemplate> 
                    <asp:Label ID="lblTitreModifierCours" runat="server" Text="Afficher un cours" SkinID="lbTitrePage"></asp:Label>
                    <table id="tbCours">
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>            
                        <td><asp:Label ID="lblSTitreNomDuCours" runat="server" Text="Nom : " SkinID="lbChampsFormulaire"></asp:Label><asp:Label ID="lblNomDuCours" runat="server" Text='<%#Eval("Nom")%>'></asp:Label></td>
                        <td><asp:Label ID="lblSTitrePrix" runat="server" Text="Prix : " SkinID="lbChampsFormulaire"></asp:Label><asp:Label ID="lblPrix" runat="server" Text='<%#Eval("Prix")%>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblSTitreGroupeDAge" runat="server" Text="Groupe d'âge : " SkinID="lbChampsFormulaire"></asp:Label><asp:Label ID="lblGroupeDAge" runat="server" Text='<%#Eval("GroupeDAge.NomGroupeDAge")%>'></asp:Label></td>
                        <td><asp:Label ID="lblSTitreSession" runat="server" Text="Session : " SkinID="lbChampsFormulaire"></asp:Label><asp:Label ID="lblSession" runat="server" Text='<%#Eval("Session.NomSession")%>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblSTitreCategorie" runat="server" Text="Catégorie : " SkinID="lbChampsFormulaire"></asp:Label><asp:Label ID="lblCategorie" runat="server" Text='<%#Eval("Catégorie.Nom")%>'></asp:Label></td>
                        <td><asp:Label ID="lblSTitrePrerequis" runat="server" Text="Prérequis : " SkinID="lbChampsFormulaire"></asp:Label><asp:Label ID="lblPrerequis" runat="server" Text='<%#Eval("Prerequis.lePrerequis.Nom")%>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="2"><asp:Label ID="lblSTitreDescription" runat="server" Text="Description : " SkinID="lbChampsFormulaire"></asp:Label><asp:Label ID="lblDescription" runat="server" Text='<%#Eval("Description")%>'></asp:Label></td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
            <asp:ListView ID="lviewGroupes" runat="server" DataSourceID="entityDataSourceGroupes" DataKeyNames="noGroupe">
                <LayoutTemplate>
                    <asp:Label ID="lblTitreModifierCours" runat="server" Text="Afficher un cours" SkinID="lbSousTitre"></asp:Label>
                    <table id="tbCours">
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td><asp:Label ID="lblJour" runat="server" Text='<%#Eval("Jour.nomJour")%>' /></td>
                        <td><asp:Label ID="lblHeureDebut" runat="server" Text='<%#Eval("HeureDébut")%>' /></td>
                        <td><asp:Label ID="lblHeureFin" runat="server" Text='<%#Eval("HeureFin")%>' /></td>
                        <td><asp:Label ID="lblLocal" runat="server" Text='<%#Eval("Groupe.Local")%>' /></td>
                        <td><asp:Label ID="lblDateDebut" runat="server" Text='<%#Eval("Groupe.DateDébut", "{0:dd/MM/yyyy}")%>' /></td>
                        <td><asp:Label ID="lblDateFin" runat="server" Text='<%#Eval("Groupe.DateFin", "{0:dd/MM/yyyy}")%>' /></td>
                        <td><asp:Label ID="lblDateLimiteInscription" runat="server" Text='<%#Eval("Groupe.DateLimiteInscription")%>' /></td>
                        <td><asp:Label ID="lblAge" runat="server" Text='<%#Eval("Groupe.Âge")%>' /></td>
                        <td><asp:Label ID="lblAnimateur" runat="server" Text='<%#Eval("Groupe.Animateur.Nom")%>' /></td>
                        <td></td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </asp:View>
    </asp:MultiView>
    </div>
    <asp:HiddenField ID="hFieldNoCategorie" runat="server" Value="0" />
    <asp:EntityDataSource ID="entityDataSourceListeCours" runat="server" 
    ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
    EntitySetName="CoursSet" EnableFlattening="false" Include="GroupeDAge, Session, Catégorie"
        Where='(it.Nom + it.[Catégorie].Nom + it.[GroupeDAge].NomGroupeDAge like "%"+@recherche+"%" OR (@recherche = "")) AND (it.[Catégorie].[noCatégorie] = @categorie OR @categorie = 0)'>                
        <WhereParameters>
            <asp:ControlParameter Name="recherche" Type="String" ControlID="txtRechercher" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter Name="categorie" Type="Int32" ControlID="hFieldNoCategorie" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EntityDataSourceCatégorie" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="CatégorieSet" EnableFlattening="false">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entityDataSourceCours" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="CoursSet" EnableFlattening="false" Include="GroupeDAge, Session, Catégorie, Prerequis.lePrerequis"
        Where="it.[noCours] = @leNoCours">               
        <WhereParameters>
            <asp:ControlParameter Name="leNoCours" Type="Int32" ControlID="hFieldnoCours" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entityDataSourceGroupes" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="HoraireSet" EnableFlattening="false" Include="Groupe.Cours, Jour, Groupe.Animateur, Groupe"
        Where="it.Groupe.Cours.noCours = @leNoCours">
        <WhereParameters>
            <asp:ControlParameter Name="leNoCours" Type="Int32" ControlID="hFieldnoCours" />
        </WhereParameters>
    </asp:EntityDataSource>
</asp:Content>

