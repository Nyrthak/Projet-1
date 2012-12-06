<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="GérerLesCours.aspx.vb" Inherits="Admin_GérerLesCours" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ PreviousPageType VirtualPath="~/Admin/listesDAttente.aspx" %>

<asp:Content ID="ContentMenu" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="ContentCours" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="contentRight">
    <asp:MultiView ID="mViewCours" runat="server" ActiveViewIndex="0">
        <asp:View ID="viewGererCours" runat="server">
            <asp:Label ID="lblTitreGererCours" runat="server" Text="Gérer les cours" SkinID="lbTitrePage"></asp:Label><br />
            <asp:Label ID="lblListeDeCours" runat="server" Text="Liste de cours" SkinID="lbSousTitre"></asp:Label>
            <asp:Button ID="btnRechercher" runat="server" Text="OK" CssClass="rechercher" SkinID="btnRechercher" />
            <asp:TextBox ID="tbRechercher" runat="server" SkinID="TextBoxFormulaire" CssClass="rechercher"></asp:TextBox>
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
                        <td><asp:LinkButton ID="lblNbGroupe" runat="server" Text='<%#Eval("nbGroupes")%>' CommandName="VoirGroupes" CommandArgument='<%#Eval("noCours") %>'></asp:LinkButton></td>
                        <td><asp:Label ID="lblCategorie" runat="server" Text='<%#Eval("nomCategorie")%>'></asp:Label></td>
                        <td><asp:Button ID="btnModifier" runat="server" Text="Modifier" SkinID="btnAjoutSupprimer" Width="72px" CommandName="Modifier" CommandArgument='<%#Eval("noCours")%>'  /></td>
                        <td>
                            <asp:Button ID="btnDesactiver" runat="server" Text="Désactiver" SkinID="btnAjoutSupprimer" Width="76px" CommandName="Desactiver" CommandArgument='<%#Eval("noCours")%>' />
                        </td>
                        <td>
                        <asp:Button ID="btnSupprimer" runat="server" Text="Supprimer" SkinID="btnAjoutSupprimer" Width="74px" CommandName="Supprimer" CommandArgument='<%#Eval("noCours")%>' />
                            <ajaxToolkit:ConfirmButtonExtender ID="confirmBtnExtSupprimer" runat="server" TargetControlID="btnSupprimer" ConfirmText="Voulez-vous vraiment supprimer ce cours?">
                            </ajaxToolkit:ConfirmButtonExtender>  
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
            <br />
            <asp:Button ID="btnAjouterUnCours" runat="server" Text="Ajouter" SkinID="btnAjoutSupprimer" Width="72px"/>
            <br /><br />
            <asp:DataPager ID="DataPagerGereCours" runat="server" 
                PagedControlID="lViewCours">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                        ShowLastPageButton="True" FirstPageText="Premier" LastPageText="Dernier" 
                        NextPageText="Suivant" PreviousPageText="Précédent" ButtonCssClass="boutonMenuPager"/>
                </Fields>
            </asp:DataPager>
        </asp:View>
        <asp:View ID="viewModifierCours" runat="server">
            <asp:ListView ID="lViewModifierCours" runat="server" DataSourceID="entiDataSourceCours" DataKeyNames="noCours" EditIndex="0">   
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
                        <td style="width:155px;"><asp:Label ID="lblNomDuCours" runat="server" Text="Nom du cours" SkinID="lbChampsFormulaire"></asp:Label></td>
                        <td colspan="2"><asp:Label ID="lblPrix" runat="server" Text="Prix" SkinID="lbChampsFormulaire"></asp:Label><asp:HiddenField ID="hFieldNoCours" runat="server" Value='<%#Eval("noCours") %>' /></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="tbNomDuCours" runat="server" Width="130px" SkinID="tbSkin" Text='<%#Bind("Nom")%>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNomDuCours" runat="server" ErrorMessage="Le nom du cours est requis." ControlToValidate="tbNomDuCours" Text="*" />
                            <asp:CompareValidator ID="cValidatorNomDuCours" runat="server" controlToValidate="tbNomDuCours" ErrorMessage="Veuillez entrer un nom." 
                            ValueToCompare="Entrez un nom" Display="Dynamic" Operator="NotEqual" ForeColor="Red">*</asp:CompareValidator>
                        </td>
                        <td colspan="2">
                            <asp:TextBox ID="tbPrix" runat="server" SkinID="tbSkin" Width="100px" Text='<%#Bind("Prix")%>'></asp:TextBox>$
                            <asp:RequiredFieldValidator ID="rfvPrix" runat="server" ErrorMessage="Le prix est requis." ControlToValidate="tbPrix" Text="*" Display="Dynamic" />
                            <asp:CompareValidator ID="cvPrix" runat="server" ErrorMessage="Le prix doit être écrit sous le format 0,00" ControlToValidate="tbPrix" Type="Double" Text="*" Operator="DataTypeCheck" Display="Dynamic" />
                        </td>          
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblGroupeDAge" runat="server" Text="Groupe d'âge" SkinID="lbChampsFormulaire"></asp:Label></td>
                        <td></td>
                        <td><asp:Label ID="lblCategorie" runat="server" Text="Catégorie" SkinID="lbChampsFormulaire"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><asp:DropDownList ID="dDListGroupeDAge" runat="server" 
                                SkinID="dDListFormulaire" DataSourceID="entiDataSourceGroupeDAge" 
                                DataTextField="NomGroupeDAge" DataValueField="noGroupeDAge"  SelectedValue='<%#Bind("GroupeDAge_noGroupeDAge")%>'></asp:DropDownList></td>
                        <td></td>
                        <td><asp:DropDownList ID="dDListCategorie" runat="server" SkinID="dDListFormulaire" 
                                DataSourceID="entiDataSourceCategorie" DataTextField="Nom" 
                                DataValueField="noCategorie" SelectedValue='<%#Bind("Categorie_noCatégorie")%>'></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblPrerequis" runat="server" Text="Prérequis" SkinID="lbChampsFormulaire"></asp:Label></td>
                        <td colspan="2"><asp:Label ID="lblDescription" runat="server" Text="Description" SkinID="lbChampsFormulaire"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><asp:DropDownList ID="dDListPrerequis" runat="server" SkinID="dDListFormulaire" AppendDataBoundItems="true" 
                                DataSourceID="entiDataSourcePrerequis" DataTextField="Nom" DataValueField="noCours" SelectedValue='<%# Bind("lePrerequis_noCours") %>' >
                              <asp:ListItem Text="Aucun" Value=""></asp:ListItem>
                            </asp:DropDownList></td>
                        <td colspan="2"><asp:TextBox ID="tbDescription" runat="server" SkinID="TextBoxDescription" TextMode="MultiLine" Text='<%#Bind("Description")%>'></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <br />
                            <asp:Button ID="btnUpdateCours" runat="server" SkinID="btnConfirmation" Text="Enregistrer" CommandName="Update" />
                            <asp:Button ID="btnCancel" runat="server" Text="Annuler" SkinID="btnConfirmation" CommandName="Annuler" CausesValidation="false" />
                        </td>
                    </tr>
                </EditItemTemplate>
            </asp:ListView>
        </asp:View>
        <asp:View ID="viewGroupes" runat="server">
            <asp:Label ID="lblTitreModifierCours" runat="server" Text="Liste des groupes" SkinID="lbTitrePage"></asp:Label>
            <asp:Button ID="btnRechercherG" runat="server" Text="OK" CssClass="rechercher" SkinID="btnRechercher" />
            <asp:DropDownList ID="dDListRechercherG" runat="server" CssClass="rechercher" DataSourceID="entiDataSourceSession"
                DataTextField="NomSession" DataValueField="noSession" SkinID="dDListFormulaire">
                <asp:ListItem Text="Aucun" Value="42"></asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="lblRechercherG" runat="server" Text="Rechercher : " CssClass="lbRechercher"></asp:Label>
            <asp:ListView ID="lviewGroupes" runat="server" DataSourceID="entiDataSourceGroupes" DataKeyNames="noGroupe">
                <LayoutTemplate>
                    <table id="tbCours">
                        <tr>
                            <td><asp:Label ID="lblTitreNomGroupe" runat="server" SkinID="lbTitreInfoMembre" Text="Nom"></asp:Label></td>
                            <td><asp:Label ID="lblTitreAge" runat="server" SkinID="lbTitreInfoMembre" Text="Âge"></asp:Label></td>
                            <td><asp:Label ID="lblTitreSession" runat="server" SkinID="lbTitreInfoMembre" Text="Session"></asp:Label></td>
                        </tr>
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td><asp:LinkButton ID="lnkGroupe" runat="server" Text='<%# Eval("Nom") %>' CommandName="Selection" CommandArgument='<%#Eval("noGroupe")%>' /></td>
                        <td><asp:Label ID="lblAge" runat="server" Text='<%#Eval("AgeMinimum") & "-" & Eval("AgeMaximum") & " ans"%>' /></td>
                        <td><asp:Label ID="lblSession" runat="server" Text='<%#Eval("Session.NomSession")%>' /></td>
                        <td><asp:Button ID="btnDesactiver" runat="server" SkinID="btnConfirmation" Text="Désactiver" CommandName="Desactiver" CommandArgument='<%#Eval("noGroupe")%>' /></td>
                        <td>
                            <asp:Button ID="btnSupprimer" runat="server" SkinID="btnConfirmation" Text="Supprimer" CommandName="Delete" />
                            <ajaxToolkit:ConfirmButtonExtender ID="confirmBtnExtSupprimer" runat="server" TargetControlID="btnSupprimer" ConfirmText="Voulez-vous vraiment supprimer ce groupe?">
                            </ajaxToolkit:ConfirmButtonExtender>
                        </td>
                    </tr>
                    <asp:HiddenField ID="hFieldnoGroupe" runat="server" Value='<%#Eval("noGroupe")%>' />

                    <asp:ListView ID="lviewHoraire" runat="server" DataSourceID="entiDataSourceHoraire" DataKeyNames="noHoraire">
                         <LayoutTemplate>            
                                <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />              
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr>
                                <td colspan="2"></td>
                                <td  class="horaire"><asp:Label ID="lblHoraire" runat="server" Text='<%#Eval("Jour.nomJour") & " de " & Eval("HeureDebut", "{0:hh:mm}") & "h" & " à " & Eval("HeureFin", "{0:hh:mm}") & "h" %>' /></td>
                                <td colspan="2"></td>
                            </tr>
                        </ItemTemplate>
                    </asp:ListView>
                    <tr>
                        <td colspan="4"><br /> </td>
                    </tr>
                    <asp:EntityDataSource ID="entiDataSourceHoraire" runat="server" ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer"
                        EntitySetName="Horaire" EnableFlattening="false" Include="Groupe, Jour" Where="it.Groupe.noGroupe = @noGroupe">
                        <WhereParameters>
                            <asp:ControlParameter Name="noGroupe" Type="Int32" ControlID="hFieldnoGroupe" />
                        </WhereParameters>
                    </asp:EntityDataSource>
                </ItemTemplate>
            </asp:ListView>
            <asp:DataPager ID="DataPagerGroupes" runat="server" 
                PagedControlID="lViewGroupes">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                        ShowLastPageButton="True" FirstPageText="Premier" LastPageText="Dernier" 
                        NextPageText="Suivant" PreviousPageText="Précédent" ButtonCssClass="boutonMenuPager"/>
                </Fields>
            </asp:DataPager>
            <div class="btnCentre">
                <asp:Button ID="btnAjouterGroupe" runat="server" Text="Ajouter un groupe" CssClass="btnAjout" Width="140px" SkinID="btnAjoutSupprimer"/>
                <asp:Button ID="btnRetour2" runat="server" Text="Retour" Width="80px" SkinID="btnAjoutSupprimer" />
            </div>
        </asp:View>
        <asp:View ID="viewLeGroupe" runat="server">
            <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="Server" />          
            <asp:ListView ID="lviewLeGroupe" runat="server" DataSourceID="entiDataSourceLeGroupe" DataKeyNames="noGroupe">
                <LayoutTemplate>                    
                    <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                </LayoutTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblTitreAfficherGroupe" runat="server" Text='<%#Eval("Cours.Nom") & " " & Eval("Nom") %>' SkinID="lbTitrePage"></asp:Label>
                    <table id="tbCours">
                        <tr>
                            <td>
                                <asp:Label ID="lblTitreNom" runat="server" Text="Nom: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblTitre" runat="server" Text='<%#Eval("Nom") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblTitreLocal" runat="server" Text="Local: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblLocal" runat="server" Text='<%#Eval("Local") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTitreDebut" runat="server" Text="Date de début: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblDebut" runat="server" Text='<%#Eval("DateDebut", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblTitreAge" runat="server" Text="Âge: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblAge" runat="server" Text='<%#Eval("AgeMinimum") & "-" & Eval("AgeMaximum") & " ans"%>'></asp:Label>
                            </td
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTitreFin" runat="server" Text="Date de fin: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblFin" runat="server" Text='<%#Eval("DateFin", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblTitreAnimateur" runat="server" Text="Animateur: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblAnimateur" runat="server" Text='<%#Eval("Animateur.Prenom") & " " & Eval("Animateur.Nom")%>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTitreDateLimite" runat="server" Text="Date limite d'inscription: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblDateLimite" runat="server" Text='<%#Eval("DateLimiteInscription", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblTitreSession" runat="server" Text="Session: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="Label2" runat="server" Text='<%#Eval("Session.NomSession")%>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTitreNbMaxInscrits" runat="server" Text="Nombre de places : " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblNbMaxInscrits" runat="server" Text='<%#Eval("nbMaxInscrits")%>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnModifier" runat="server" Text="Modifier" Width="80px" CommandName="Edit" SkinID="btnAjoutSupprimer" />
                            </td>
                            
                        </tr>
                    </table>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CalendarExtender ID="calendarExtenderDebut" runat="server" TargetControlID="tbDebut" PopupButtonID="imgBtnDebut" 
                        CssClass="MyCalendar" PopupPosition="Right" Format="d-MM-yyyy" >
                    </asp:CalendarExtender>
                    <asp:CalendarExtender ID="calendarExtenderFin" runat="server" TargetControlID="tbFin" PopupButtonID="imgBtnFin" 
                        CssClass="MyCalendar" PopupPosition="Right" Format="d-MM-yyyy" >
                    </asp:CalendarExtender>
                    <asp:CalendarExtender ID="calendarExtenderDateLimite" runat="server" TargetControlID="tbDateLimite" PopupButtonID="imgBtnDateLimite" 
                        CssClass="MyCalendar" PopupPosition="Right" Format="d-MM-yyyy" >
                    </asp:CalendarExtender>
                    <asp:Label ID="lblTitreAfficherGroupe" runat="server" Text='<%# "Groupe " & Eval("noGroupe") %>' SkinID="lbTitrePage"></asp:Label>
                    <table id="tbCours">
                        <tr>
                            <td>
                                <asp:Label ID="lblTitreNom" runat="server" Text="Nom: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:TextBox ID="tbNom" runat="server" Text='<%#Bind("Nom") %>' SkinID="tbSkin" Width="60px" MaxLength="8"></asp:TextBox>
                                <asp:RequiredFieldValidator  ForeColor="Red"
                                    ID="rfvNom" runat="server" ErrorMessage="Le nom doit être spécifié." 
                                    ControlToValidate="tbLocal" Display="Dynamic">*</asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:Label ID="lblTitreLocal" runat="server" Text="Local: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:TextBox ID="tbLocal" runat="server" Text='<%#Bind("Local") %>' SkinID="tbSkin" Width="60px" MaxLength="8"></asp:TextBox>
                                <asp:RequiredFieldValidator  ForeColor="Red"
                                    ID="rfvLocal" runat="server" ErrorMessage="Le local doit être spécifié." 
                                    ControlToValidate="tbLocal" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="regexvLocal" runat="server" ErrorMessage="Le local ne peut contenir de caractères spéciaux."
                                    ValidationExpression="^[a-zA-Z0-9àâéèêôîïö/-]*$" ControlToValidate="tbLocal" ForeColor="Red" Display="Dynamic">*</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTitreDebut" runat="server" Text="Date de début: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:TextBox ID="tbDebut" runat="server" Text='<%#Bind("DateDebut", "{0:dd/MM/yyyy}") %>' SkinID="tbSkin" Width="90px" MaxLength="10"></asp:TextBox>
                                <asp:ImageButton ID="imgBtnDebut" ImageUrl="~/App_Themes/Default/images/btnCalendrier.png" runat="server" CausesValidation="false" />
                                <asp:RequiredFieldValidator ForeColor="Red"
                                    ID="rfvDebut" runat="server" ErrorMessage="La date de début doit être spécifiée." 
                                    ControlToValidate="tbDebut" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator runat="server" ID="cvDebut" Type="Date" ControlToValidate="tbDebut"
                                    ErrorMessage="La date de début n'est pas du bon format (jj-mm-aaaa)" ForeColor="Red"
                                    Operator="DataTypeCheck" Display="Dynamic">*</asp:CompareValidator>
                            </td>
                            <td>
                                <asp:Label ID="lblTitreAge" runat="server" Text="Âge: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:TextBox ID="tbAgeMin" runat="server" Text='<%#Bind("AgeMinimum") %>' SkinID="tbSkin" Width="20px" MaxLength="2"></asp:TextBox>
                                <asp:RequiredFieldValidator ForeColor="Red" 
                                    ID="rfvAge" runat="server" ErrorMessage="L'âge minimum doit être spécifié." 
                                    ControlToValidate="tbAgeMin" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator runat="server" ID="cvAgeMin" Type="Integer" ControlToValidate="tbAgeMin"
                                    ErrorMessage="L'âge minimum doit être un nombre." ForeColor="Red"
                                    Operator="DataTypeCheck" Display="Dynamic">*</asp:CompareValidator>
                                <asp:CompareValidator runat="server" ID="cvAgeMin2" Type="Integer" ControlToValidate="tbAgeMin"
                                    ErrorMessage="L'âge minimum doit être plus petit que l'âge maximum." ForeColor="Red" ControlToCompare="tbAgeMax"
                                    Operator="LessThanEqual" Display="Dynamic">*</asp:CompareValidator>
                                <asp:Label ID="lblAge" runat="server" Text="-"></asp:Label>
                                <asp:TextBox ID="tbAgeMax" runat="server" Text='<%#Bind("Agemaximum")%>' SkinID="tbSkin" Width="20px" MaxLength="2"></asp:TextBox>
                                <asp:RequiredFieldValidator ForeColor="Red" 
                                    ID="rfvAgeMax" runat="server" ErrorMessage="L'âge maximum doit être spécifié." 
                                    ControlToValidate="tbAgeMax" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator runat="server" ID="cvAgeMax" Type="Integer" ControlToValidate="tbAgeMax"
                                    ErrorMessage="L'âge maximum doit être un nombre." ForeColor="Red"
                                    Operator="DataTypeCheck" Display="Dynamic">*</asp:CompareValidator>
                                <asp:Label ID="lblAns" runat="server" Text="ans"></asp:Label>
                            </td
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTitreFin" runat="server" Text="Date de fin: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:TextBox ID="tbFin" runat="server" Text='<%#Bind("DateFin", "{0:dd/MM/yyyy}") %>' SkinID="tbSkin" Width="90px" MaxLength="10"></asp:TextBox>
                                <asp:ImageButton ID="imgBtnFin" ImageUrl="~/App_Themes/Default/images/btnCalendrier.png" runat="server" CausesValidation="false" />
                                <asp:RequiredFieldValidator ForeColor="Red"
                                    ID="rfvFin" runat="server" ErrorMessage="La date de fin doit être spécifiée." 
                                    ControlToValidate="tbDebut" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator runat="server" ID="cvFin" Type="Date" ControlToValidate="tbDebut"
                                    ErrorMessage="La date de fin n'est pas du bon format (jj-mm-aaaa)" ForeColor="Red"
                                    Operator="DataTypeCheck" Display="Dynamic">*</asp:CompareValidator>
                                <asp:CompareValidator runat="server" ID="cvFinCompareDebut" Type="Date" ControlToValidate="tbFin"
                                    ControlToCompare="tbDebut" ErrorMessage="La date de fin doit être après la date de début." ForeColor="Red"
                                    Operator="GreaterThan" Display="Dynamic">*</asp:CompareValidator>
                            </td>
                            <td>
                                <asp:Label ID="lblTitreAnimateur" runat="server" Text="Animateur: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:DropDownList ID="dDListAnimateur" runat="server" DataSourceID="entiDataSourceAnimateur" SkinID="dDListFormulaire"
                                    DataTextField="leNom" DataValueField="noAnimateur" SelectedValue='<%#Bind("Animateur_noAnimateur")%>'>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTitreDateLimite" runat="server" Text="Date limite d'inscription: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:TextBox ID="tbDateLimite" runat="server" Text='<%#Bind("DateLimiteInscription", "{0:dd/MM/yyyy}") %>' SkinID="tbSkin" Width="90px" MaxLength="10"></asp:TextBox>
                                <asp:ImageButton ID="imgBtnDateLimite" ImageUrl="~/App_Themes/Default/images/btnCalendrier.png" runat="server" CausesValidation="false" />
                                <asp:RequiredFieldValidator ForeColor="Red" 
                                    ID="rvDateLimite" runat="server" ErrorMessage="La date limite doit être spécifiée." 
                                    ControlToValidate="tbDateLimite" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator runat="server" ID="cvDateLimite" Type="Date" ControlToValidate="tbDateLimite"
                                    ErrorMessage="La date limite n'est pas du bon format (jj-mm-aaaa)" ForeColor="Red"
                                    Operator="DataTypeCheck" Display="Dynamic">*</asp:CompareValidator>
                                <asp:CompareValidator runat="server" ID="cvDateLimite2" Type="Date" ControlToValidate="tbDateLimite"
                                    ControlToCompare="tbDebut" ErrorMessage="La date limite doit être avant la date de début." ForeColor="Red"
                                    Operator="LessThanEqual" Display="Dynamic">*</asp:CompareValidator>
                            </td>
                            <td>
                                <asp:Label ID="lblSession" runat="server" Text="Session" SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:DropDownList ID="dDListSession" runat="server" SkinID="dDListFormulaire" 
                                    DataSourceID="entiDataSourceSession" DataTextField="NomSession" 
                                    DataValueField="noSession"  SelectedValue='<%#Bind("Session.noSession")%>'></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTitreNbMaxInscrits" runat="server" Text="Nombre de places : " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:TextBox ID="tbNbMaxInscrits" runat="server" Text='<%#Bind("nbMaxInscrits")%>' SkinID="tbSkin" MaxLength="4" Width="50px"></asp:TextBox>
                                <asp:RequiredFieldValidator ForeColor="Red" 
                                    ID="rfvNbMaxInscrits" runat="server" ErrorMessage="Le nombre de participants maximum doit être spécifié." 
                                    ControlToValidate="tbNbMaxInscrits" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator runat="server" ID="cvNbMaxInscrits" Type="Integer" ControlToValidate="tbNbMaxInscrits"
                                    ErrorMessage="Le nombre de participants maximum doit être un nombre." ForeColor="Red"
                                    Operator="DataTypeCheck" Display="Dynamic">*</asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnEnregistrer" runat="server" Text="Enregistrer" Width="80px" CommandName="Update" SkinID="btnAjoutSupprimer" />
                                <asp:Button ID="btnAnnuler" runat="server" Text="Annuler" Width="80px" CommandName="Cancel" SkinID="btnAjoutSupprimer" CausesValidation="false" />
                            </td>
                            
                        </tr>
                    </table>
                </EditItemTemplate>            
            </asp:ListView>
            <asp:ListView ID="lviewHoraire" runat="server" DataSourceID="entiDataSourceHoraire" DataKeyNames="noHoraire">
                         <LayoutTemplate>
                                <table>
                                    <tr>
                                        <td><asp:Label ID="lblTitreHoraire" runat="server" Text="Horaire" SkinID="lbChampsFormulaire" /></td>
                                    </tr>
                                    <asp:PlaceHolder id="ItemPlaceHolder" runat="server" /> 
                                </table>                          
                        </LayoutTemplate>
                        <ItemTemplate>                      
                            <tr>
                                <td class="horaire"><asp:Label ID="lblHoraire" runat="server" Text='<%#Eval("Jour.nomJour") & " de " & Eval("HeureDebut", "{0:HH:mm}") & "h" & " à " & Eval("HeureFin", "{0:HH:mm}") & "h" %>' /></td>
                                <td>
                                    <asp:Button ID="btnModifierHoraire" runat="server" Text="Modifier" CommandName="Edit" Width="80px" SkinID="btnAjoutSupprimer" />
                                    <asp:Button ID="btnSupprimerHoraire" runat="server" Text="Supprimer" CommandName="Delete" Width="80px" SkinID="btnAjoutSupprimer" />
                                    <ajaxToolkit:ConfirmButtonExtender ID="confirmBtnExtSupprimer" runat="server" TargetControlID="btnSupprimerHoraire" ConfirmText="Voulez-vous vraiment supprimer cet horaire?">
                                    </ajaxToolkit:ConfirmButtonExtender>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <tr>
                                <td class="horaire">
                                    <asp:DropDownList ID="dDListJour" runat="server" DataSourceID="entiDataSourceJour" SkinID="dDListFormulaire"
                                        DataTextField="nomJour" DataValueField="noJour" SelectedValue='<%#Bind("Jour_noJour")%>'>
                                    </asp:DropDownList>
                                    <asp:Label ID="lblDe" runat="server" Text=" de "></asp:Label>
                                    <asp:TextBox ID="tbHeureDebut" runat="server" Text='<%#Bind("HeureDebut", "{0:HH:mm}")%>' SkinID="tbSkin" Width="40px"></asp:TextBox>
                                    <asp:Label ID="lblA" runat="server" Text = "h à "></asp:Label>
                                    <asp:TextBox ID="tbHeureFin" runat="server" Text='<%#Bind("HeureFin", "{0:HH:mm}")%>' SkinID="tbSkin" Width="40px"></asp:TextBox>
                                    <asp:Label ID="lblH" runat="server" Text = "h"></asp:Label>
                                </td>
                                <td>
                                    <asp:Button ID="btnUpdateHoraire" runat="server" Text="Enregistrer" CommandName="Update" Width="80px" SkinID="btnAjoutSupprimer" />
                                    <asp:Button ID="btnAnnuler" runat="server" Text="Annuler" CommandName="Cancel" Width="80px" CommandArgument='<%#Eval("noHoraire")%>' SkinID="btnAjoutSupprimer" />
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="rfvHeureDebut" runat="server" ErrorMessage="L'heure de début est requis." ControlToValidate="tbHeureDebut" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="regexvHeureDebut" runat="server" ErrorMessage="L'heure de début n'est pas du bon format."
                                        ControlToValidate="tbHeureDebut" ValidationExpression="([01]?[0-9]|2[0-3]):[0-5][0-9]" ForeColor="Red" Display="Dynamic">*</asp:RegularExpressionValidator>
                                    <asp:CustomValidator ID="customVHeureDebut" runat="server" ErrorMessage="L'heure de début doit être plus petite que l'heure de fin."
                                        ControlToValidate="tbHeureDebut" Display="Dynamic" ForeColor="Red" OnServerValidate="customV_heureDebut">*</asp:CustomValidator>
                                    <asp:RequiredFieldValidator ID="rfvHeureFin" runat="server" ErrorMessage="L'heure de fin est requis." 
                                    ControlToValidate="tbHeureDebut" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="regexvHeureFin" runat="server" ErrorMessage="L'heure de fin n'est pas du bon format."
                                        ControlToValidate="tbHeureFin" ValidationExpression="([01]?[0-9]|2[0-3]):[0-5][0-9]" ForeColor="Red" Display="Dynamic">*</asp:RegularExpressionValidator>
                                </td>
                            </tr>
                        </EditItemTemplate>
                    </asp:ListView>
            <asp:Button ID="btnAjouterHoraire" runat="server" Text="Ajouter un horaire" Width="140px" SkinID="btnAjoutSupprimer"/><br />
            <asp:ListView ID="lViewMembres" runat="server" DataSourceID="entityDataSourcePaiements" DataKeyNames="noPaiement" GroupItemCount="3">
                <LayoutTemplate>
                    <asp:Label ID="lblTitreMembres" runat="server" Text= "Liste des membres " SkinID="lbSousTitre" />
                    <table>
                        <asp:PlaceHolder id="GroupPlaceHolder" runat="server" /> 
                    </table>                          
                </LayoutTemplate>
                <GroupTemplate>
                    <tr>
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                    </tr>
                </GroupTemplate>
                <ItemTemplate>
                        <td><asp:Label ID="lblNom" runat="server" Text='<%#Eval("Membre.Prenom") & " " & Eval("Membre.Nom") %>'></asp:Label></td>
                        <td width="50px"><asp:LinkButton ID="lnkSupprimer" runat="server" CommandName="Delete">X</asp:LinkButton></td>
                </ItemTemplate>
            </asp:ListView>  
            <div class="btnCentre">
                <asp:Button ID="btnRetour" runat="server" Text="Retour" Width="80px" SkinID="btnAjoutSupprimer" />
            </div>
            <asp:ValidationSummary SkinID="valiSummary" ID="valiSummaryInscription" runat="server" />
        </asp:View>
    </asp:MultiView>
    <br /><asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
    </div>
    <%-- View Gerer Cours --%>
    <asp:LinqDataSource ID="LinqDataSourceCours" runat="server"
                    ContextTypeName="Model.ModelContainer"
                    TableName="Cours" 
                    Select="new (noCours, Nom, Categorie.Nom As nomCategorie, Groupe.Count() AS nbGroupes)" 
                    OrderBy="Actif DESC, noCours"
                    Where='(@recherche = "") || Nom.Contains(@recherche) || Categorie.Nom.Contains(@recherche)' >
                    <WhereParameters>
                        <asp:ControlParameter Name="recherche" ControlID="tbRechercher" ConvertEmptyStringToNull="false" />
                    </WhereParameters>
            </asp:LinqDataSource>
    <%-- View modifier cours --%>
    <asp:HiddenField ID="hFieldNoCours" runat="server" />
    <asp:HiddenField ID="hFieldnoGroupe2" runat="server" />
    <asp:EntityDataSource ID="entiDataSourceCours" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer"
        EnableUpdate="True" EntitySetName="Cours" EnableFlattening="false"
        Where="it.[noCours] = @noCours" Include="[Categorie], GroupeDAge, lePrerequis">
        <WhereParameters>
            <asp:ControlParameter Name="noCours" Type="Int32" ControlID="hFieldNoCours" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entiDataSourceGroupeDAge" runat="server" 
    ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
    EnableFlattening="False" EntitySetName="GroupeDAge">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entiDataSourceCategorie" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EnableFlattening="False" EntitySetName="Catégorie">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entiDataSourcePrerequis" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" EnableFlattening="false" 
        EntitySetName="Cours" Select="it.[noCours], it.[Nom]" Where="it.[noCours] <> @noCours">
        <WhereParameters>
            <asp:ControlParameter ControlID="hFieldNoCours" Name="noCours" Type="Int32" />
        </WhereParameters>
    </asp:EntityDataSource>
    <%-- View les groupes --%>
    <asp:HiddenField ID="hFieldnoCours2" runat="server" />
    <asp:EntityDataSource ID="entiDataSourceGroupes" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Groupe" EnableFlattening="false" EnableDelete="true" Include="Cours, Session"
        Where='it.Cours.noCours = @leNoCours And (it.Session.noSession = @session or @session = -1)'>
        <WhereParameters>
            <asp:ControlParameter Name="leNoCours" Type="Int32" ControlID="hFieldnoCours2" />
            <asp:ControlParameter Name="session" Type="Int32" ControlID="dDListRechercherG" PropertyName="SelectedValue" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entiDataSourceSession" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EnableFlattening="False" EntitySetName="Session">
    </asp:EntityDataSource>
    <%-- View le groupe --%>
    <asp:EntityDataSource ID="entiDataSourceLeGroupe" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Groupe" EnableFlattening="false" Include="Cours, Animateur, Session"
        Where="it.noGroupe = @leNoGroupe" EnableUpdate="true">
        <WhereParameters>
            <asp:ControlParameter Name="leNoGroupe" Type="Int32" ControlID="hFieldnoGroupe2" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entiDataSourceHoraire" runat="server" ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer"
         EntitySetName="Horaire" EnableFlattening="false" EnableUpdate="true" EnableDelete="true" Include="Groupe, Jour" Where="it.Groupe.noGroupe = @noGroupe">
        <WhereParameters>
            <asp:ControlParameter Name="noGroupe" Type="Int32" ControlID="hFieldnoGroupe2" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entityDataSourcePaiements" runat="server"
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Paiement" EnableFlattening="false" EnableDelete="true" Include="Groupe, Membre, Groupe.Cours"
        Where="it.Groupe.noGroupe = @leNoGroupe">
        <WhereParameters>
            <asp:ControlParameter Name="leNoGroupe" Type="Int32" ControlID="hFieldnoGroupe2" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entiDataSourceAnimateur" runat="server" ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer"
         EntitySetName="Animateur" EnableFlattening="false" Select='(it.[Prenom] + " " + it.Nom) As leNom, it.noAnimateur'>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entiDataSourceJour" runat="server" ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer"
         EntitySetName="Jour" EnableFlattening="false">
    </asp:EntityDataSource>  
</asp:Content>
