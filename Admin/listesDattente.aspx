<%@ Page Language="VB" AutoEventWireup="false"  MasterPageFile="~/masterPage.master" CodeFile="listesDattente.aspx.vb" Inherits="Admin_listesDattente" %>
<asp:Content ID="ContentCours" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="contentRight">
        <asp:MultiView ID="mViewListeDAttente" runat="server" ActiveViewIndex="0">
            <asp:View ID="viewListesDattente" runat="server">
                <asp:Label ID="lblTitreListeDAttente" runat="server" Text="Listes d'attente" SkinID="lbTitrePage"></asp:Label><br />
                <asp:ListView ID="lviewListesDattente" runat="server" DataSourceID="linqDataSourceListesDattente" DataKeyNames="noGroupe">
                    <LayoutTemplate>
                        <table id="tbListeAttente">
                            <tr>
                                <th><asp:Label ID="lbTitreCategorie" runat="server" Text="Catégorie"></asp:Label></th>
                                <th><asp:Label ID="lbTitreNomCours" runat="server" Text="Cours"></asp:Label></th>
                                <th><asp:Label ID="lbTitreNomGroupe" runat="server" Text="Groupe"></asp:Label></th>
                                <th><asp:Label ID="lbTitreNbClients" runat="server" Text="Nombre d'inscrits"></asp:Label></th>
                            </tr>
                            <asp:PlaceHolder id="GroupPlaceHolder" runat="server" />
                        </table>
                    </LayoutTemplate>
                    <GroupTemplate>
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                    </GroupTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><asp:Label ID="lbCategorie" runat="server" Text='<%#Eval("nomCategorie")%>'></asp:Label></td>
                            <td><asp:Label ID="lbNomCours" runat="server" Text='<%#Eval("nomCours")%>'></asp:Label></td>
                            <td><asp:LinkButton ID="lnkNomGroupe" runat="server" Text='<%#"Groupe " & Eval("noGroupe")%>' CommandName="SelectionListe" CommandArgument='<%#Eval("noGroupe")%>'></asp:LinkButton></td>
                            <td><asp:Label ID="lbNbClients" runat="server" Text='<%#Eval("nbClients")%>'></asp:Label></td>              
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
                <asp:DataPager ID="DataPagerListeDAttente" runat="server" PagedControlID="lviewListesDattente">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                                    ShowLastPageButton="True" FirstPageText="Premier" LastPageText="Dernier" 
                                    NextPageText="Suivant" PreviousPageText="Précédent" ButtonCssClass="boutonMenuPager"/>
                            </Fields>
                </asp:DataPager>
            </asp:View>
            <asp:View ID="viewUneListeDAttente" runat="server">     
                <asp:Label ID="lblDetailListe" runat="server" Text="" SkinID="lbTitrePage"></asp:Label><br />           
                <asp:ListView ID="lviewLaListeDattente" runat="server" DataSourceID="entiDataSourceLaListeDAttente" DataKeyNames="noListeDAttente">
                    <LayoutTemplate>
                        <table id="tbListeAttente">
                            <tr>
                                <th><asp:Label ID="lbTitreDateAjout" runat="server" Text="Date d'inscription"></asp:Label></th>
                                <th><asp:Label ID="lbTitreNomMembre" runat="server" Text="Nom du membre"></asp:Label></th>
                                <th><asp:Label ID="lbTitreDateNaissance" runat="server" Text="Date de naissance"></asp:Label></th>
                            </tr>
                            <asp:PlaceHolder id="GroupPlaceHolder" runat="server" />
                        </table>
                    </LayoutTemplate>
                    <GroupTemplate>
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                    </GroupTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:HiddenField ID="hFieldNoListeAttente" runat="server" Value='<%#Eval("noListeDAttente")%>'/>
                                <asp:Label ID="lbDateAjout" runat="server" Text='<%#Eval("DateAjout", "{0:dd/MM/yyyy}")%>'></asp:Label>
                            </td>
                            <td><asp:Label ID="lbNomMembre" runat="server" Text='<%#Eval("Membre.Prénom") & " " & Eval("Membre.Nom")%>'></asp:Label></td>
                            <td><asp:Label ID="lbDatenaissance" runat="server" Text='<%#Eval("Membre.DateNaissance", "{0:dd/MM/yyyy}")%>'></asp:Label></td>              
                            <td style="width:40px; text-align:center;"><asp:CheckBox ID="chkAccepte" runat="server" Checked='<%#Bind("Accepte")%>' /></td>
                            <td><asp:Button ID="btnSupprimer" runat="server" Text="Supprimer" CommandName="Delete" SkinID="btnAjoutSupprimer" Width="78px"/></td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
                <div class="btnCentre">
                    <asp:Button ID="btnEnregistrer" runat="server" Text="Enregistrer" Width="100px" SkinID="btnAjoutSupprimer" />
                    <asp:Button ID="btnCreerGroupe" runat="server" Text="Créer un groupe" Width="120px" SkinID="btnAjoutSupprimer" />
                    <asp:Button ID="btnRetour" runat="server" Text="Retour" Width="80px" SkinID="btnAjoutSupprimer" />
                </div>
            </asp:View>
        </asp:MultiView>
        <br /><asp:Label ID="lbMessage" runat="server" Text=""></asp:Label>
    </div>
    <asp:HiddenField ID="hFieldNoGroupe" runat="server" />
    <asp:LinqDataSource ID="linqDataSourceListesDattente" runat="server"
                    ContextTypeName="Model.ModelContainer"
                    TableName="Groupe" 
                    Select="new (noGroupe, Cours.noCours As noCours, Cours.Nom As nomCours, Cours.Catégorie.noCatégorie As noCategorie, Cours.Catégorie.Nom As nomCategorie, ListeDAttente.Count() AS nbClients)"
                    Where="ListeDAttente.Count() > 0" OrderBy="noGroupe"> 
    </asp:LinqDataSource>
    <asp:EntityDataSource ID="entiDataSourceLaListeDAttente" runat="server" ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer"
         EntitySetName="ListeDAttente" EnableFlattening="false" EnableUpdate="true" EnableDelete="true" Include="Groupe, Groupe.Cours, Membre" Where="it.Groupe.noGroupe = @noGroupe">
        <WhereParameters>
            <asp:ControlParameter Name="noGroupe" Type="Int32" ControlID="hFieldNoGroupe" />
        </WhereParameters>
    </asp:EntityDataSource>   
</asp:Content>
