<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="GérerLesCours.aspx.vb" Inherits="Admin_GérerLesCours" %>
<asp:Content ID="ContentMenu" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>

<asp:Content ID="ContentCours" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <asp:MultiView ID="mViewCours" runat="server" ActiveViewIndex="0">
        <asp:View ID="viewGererCours" runat="server">
            <asp:Label ID="lblTitreGererCours" runat="server" Text="Gérer les cours" SkinID="lbTitrePage"></asp:Label><br />
            <asp:Label ID="lblListeDeCours" runat="server" Text="Liste de cours" SkinID="lbSousTitre"></asp:Label>
            <asp:Button ID="btnRechercher" runat="server" Text="Ok" CssClass="rechercher" />
            <asp:TextBox ID="txtRechercher" runat="server" SkinID="TextBoxFormulaire" CssClass="rechercher"></asp:TextBox>
            <asp:Label ID="lblRechercher" runat="server" Text="Rechercher : " CssClass="lbRechercher"></asp:Label> 
            <asp:ListView ID="lViewCours" runat="server" DataSourceID="LinqDataSourceCours" DataKeyNames="noCours">
                <LayoutTemplate>
                    <table id="tableauListeCours">
                        <tr>
                            <td><asp:Label ID="lblTitreNomCours" runat="server" SkinID="lbTitreInfoMembre" Text="Nom"></asp:Label></td>
                            <td><asp:Label ID="lblTitreNbGroupes" runat="server" SkinID="lbTitreInfoMembre" Text="Nb. de groupes"></asp:Label></td>
                            <td><asp:Label ID="lblTitreCategorie" runat="server" SkinID="lbTitreInfoMembre" Text="Catégorie"></asp:Label></td>
                        </tr>
                        <asp:PlaceHolder id="GroupPlaceHolder" runat="server" />
                    </table>
                    <br />
                </LayoutTemplate>
                <GroupTemplate>
                    <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                </GroupTemplate>
                <ItemTemplate>
                    <tr>
                        <td><asp:Label ID="lblNomCours" runat="server" Text='<%#Eval("Nom")%>'></asp:Label></td>
                        <td><asp:Label ID="lblNbGroupe" runat="server" Text='<%#Eval("nbGroupes")%>'></asp:Label></td>
                        <td><asp:Label ID="lblCategorie" runat="server" Text='<%#Eval("nomCategorie")%>'></asp:Label></td>
                        <td><asp:Button ID="btnModifier" runat="server" Text="Modifier" SkinID="btnConfirmation" CommandName="Modifier" CommandArgument='<%#Eval("noCours")%>'  /></td>
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
                        NextPageText="Suivant" PreviousPageText="Précédent" ButtonCssClass="boutonMenuCategorie"/>
                </Fields>
            </asp:DataPager>
            <asp:LinqDataSource ID="LinqDataSourceCours" runat="server"
                    ContextTypeName="Model.ModelContainer"
                    TableName="CoursSet" 
                    Select="new (noCours, Nom, Catégorie.Nom As nomCategorie, Groupe.Count() AS nbGroupes)" 
                    EnableDelete="True" OrderBy="noCours"
                    Where='(@recherche = "") || Nom.Contains(@recherche) || Catégorie.Nom.Contains(@recherche)' >
                    <WhereParameters>
                        <asp:ControlParameter Name="recherche" ControlID="txtRechercher" ConvertEmptyStringToNull="false" />
                    </WhereParameters>
            </asp:LinqDataSource>
        </asp:View>
        <asp:View ID="viewModifierCours" runat="server">
            <asp:ListView ID="lViewModifierCours" runat="server" DataSourceID="EntityDataSourceCours" DataKeyNames="noCours" EditIndex="0">   
                <LayoutTemplate> 
                    <asp:Label ID="lblTitreModifierCours" runat="server" Text="Gérer les cours" SkinID="lbTitrePage"></asp:Label>
                    <asp:ValidationSummary ID="ValidationSummaryModifierCours" runat="server" CssClass="validationSummary" Height="50px" />
                    <table>
                        <asp:PlaceHolder id="ItemPlaceHolder"  runat="server" />
                    </table>
                </LayoutTemplate>
                <ItemTemplate></ItemTemplate>
                <EditItemTemplate>
                    <tr>            
                        <td><asp:Label ID="lblNomDuCours" runat="server" Text="Nom du cours" SkinID="lbChampsFormulaire"></asp:Label></td>
                        <td><asp:Label ID="lblPrix" runat="server" Text="Prix" SkinID="lbChampsFormulaire"></asp:Label></td>
                        <td><asp:HiddenField ID="hFieldNoCours" runat="server" Value='<%#Eval("noCours") %>' /></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtNomDuCours" runat="server" SkinID="TextBoxFormulaire" Text='<%#Bind("Nom")%>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNomDuCours" runat="server" ErrorMessage="Le nom du cours est requis." ControlToValidate="txtNomDuCours" Text="*" />
                            <asp:CompareValidator ID="cValidatorNomDuCours" runat="server" controlToValidate="txtNomDuCours" ErrorMessage="Veuillez entrer un nom." 
                            ValueToCompare="Entrez un nom" Display="Dynamic" Operator="NotEqual" ForeColor="Red">*</asp:CompareValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPrix" runat="server" SkinID="TextBoxFormulaire" Text='<%#Bind("Prix")%>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPrix" runat="server" ErrorMessage="Le prix est requis." ControlToValidate="txtPrix" Text="*" />
                            <asp:CompareValidator ID="cvPrix" runat="server" ErrorMessage="Le prix doit être écrit sous le format 0,00" ControlToValidate="txtPrix" Type="Double" Text="*" Operator="DataTypeCheck" />
                        </td> 
                        <td></td>          
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblGroupeDAge" runat="server" Text="Groupe d'âge" SkinID="lbChampsFormulaire"></asp:Label></td>
                        <td><asp:Label ID="lblSession" runat="server" Text="Session" SkinID="lbChampsFormulaire"></asp:Label></td>
                        <td><asp:Label ID="lblCategorie" runat="server" Text="Catégorie" SkinID="lbChampsFormulaire"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><asp:DropDownList ID="dDListGroupeDAge" runat="server" 
                                SkinID="dDListFormulaire" DataSourceID="EntityDataSourceGroupeDAge" 
                                DataTextField="NomGroupeDAge" DataValueField="noGroupeDAge"  SelectedValue='<%#Bind("GroupeDAge.noGroupeDAge")%>'></asp:DropDownList></td>
                        <td><asp:DropDownList ID="dDListSession" runat="server" SkinID="dDListFormulaire" 
                                DataSourceID="EntityDataSourceSession" DataTextField="NomSession" 
                                DataValueField="noSession"  SelectedValue='<%#Bind("Session.noSession")%>'></asp:DropDownList></td>
                        <td><asp:DropDownList ID="dDListCategorie" runat="server" SkinID="dDListFormulaire" 
                                DataSourceID="EntityDataSourceCategorie" DataTextField="Nom" 
                                DataValueField="noCatégorie" SelectedValue='<%#Bind("Catégorie.noCatégorie")%>'></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblPrerequis" runat="server" Text="Prérequis" SkinID="lbChampsFormulaire"></asp:Label></td>
                        <td colspan="2"><asp:Label ID="lblDescription" runat="server" Text="Description" SkinID="lbChampsFormulaire"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><asp:DropDownList ID="dDListPrerequis" runat="server" SkinID="dDListFormulaire" AppendDataBoundItems="true" 
                                DataSourceID="EntityDataSourcePrerequis" DataTextField="Nom" DataValueField="noCours" SelectedValue='<%# Eval("Prerequis.lePrerequis.noCours") %>' >
                              <asp:ListItem Text="Aucun" Value=""></asp:ListItem>
                            </asp:DropDownList></td>
                        <td colspan="2"><asp:TextBox ID="txtDescription" runat="server" SkinID="TextBoxDescription" TextMode="MultiLine" Text='<%#Bind("Description")%>'></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btnUpdateCours" runat="server" SkinID="btnConfirmation" Text="Enregistrer" CommandName="Update" />
                            <asp:Button ID="btnCancel" runat="server" Text="Annuler" SkinID="btnConfirmation" CommandName="Annuler" CausesValidation="false" />
                        </td>
                    </tr>
                </EditItemTemplate>
            </asp:ListView>
            <asp:HiddenField ID="hFieldNoCours" runat="server" />
            <asp:EntityDataSource ID="EntityDataSourceGroupeDAge" runat="server" 
            ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
            EnableFlattening="False" EntitySetName="GroupeDAgeSet">
            </asp:EntityDataSource>
            <asp:EntityDataSource ID="EntityDataSourceSession" runat="server" 
                ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
                EnableFlattening="False" EntitySetName="SessionSet">
            </asp:EntityDataSource>
            <asp:EntityDataSource ID="EntityDataSourceCategorie" runat="server" 
                ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
                EnableFlattening="False" EntitySetName="CatégorieSet">
            </asp:EntityDataSource>
            <asp:EntityDataSource ID="EntityDataSourcePrerequis" runat="server" 
                ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" EnableFlattening="false" 
                EntitySetName="CoursSet" Select="it.[noCours], it.[Nom]" Where="it.[noCours] <> @noCours">
                <WhereParameters>
                    <asp:ControlParameter ControlID="hFieldNoCours" Name="noCours" Type="Int32" />
                </WhereParameters>
            </asp:EntityDataSource>
            <asp:EntityDataSource ID="EntityDataSourceCours" runat="server" 
                ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer"
                EnableUpdate="True" EntitySetName="CoursSet" EnableFlattening="false"
                Where="it.[noCours] = @noCours" Include="[Catégorie], Session, GroupeDAge, Prerequis.lePrerequis">
                <WhereParameters>
                    <asp:ControlParameter Name="noCours" Type="Int32" ControlID="hFieldNoCours" />
                </WhereParameters>
            </asp:EntityDataSource>
        </asp:View>
    </asp:MultiView>
    <br /><asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
</asp:Content>
