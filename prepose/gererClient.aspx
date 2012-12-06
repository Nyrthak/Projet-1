<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="gererClient.aspx.vb" Inherits="prepose_gererClient" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

<asp:Content ID="contentMenuClient" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentMenuAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="Server" /> 
    <div id="contentRight">
        <asp:Button Skinid="btnRechercher" ID="btnRechercher" runat="server" Text="Ok" CssClass="rechercher" />
        <asp:TextBox ID="tbRechercher" runat="server" SkinID="TextBoxFormulaire" CssClass="rechercher"></asp:TextBox>
        <asp:Label ID="lbRechercher" runat="server" Text="Rechercher" CssClass="lbRechercher"></asp:Label><br /><br />
        <asp:ValidationSummary SkinID="valiSummary" ID="valiSummaryCompte" ValidationGroup="A" runat="server" />
        <asp:MultiView ID="mViewActionCompte" runat="server" ActiveViewIndex="0">      
            <asp:View runat="server" ID="viewListeCompte">
                <asp:Label SkinID="lbTitrePage" ID="lbTitrePage" runat="server" Text="Liste de comptes"></asp:Label>
                <asp:ListView ID="lviewListeCompte" runat="server" DataKeyNames="noCompte" DataSourceID="entiDataSourceCompte">
                    <LayoutTemplate>
                        <table>
                            <asp:PlaceHolder id="GroupPlaceHolder" runat="server" />
                        </table>
                    </LayoutTemplate>
                    <GroupTemplate>
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                    </GroupTemplate>
                    <ItemTemplate>
                        <tr>
                            <td style="width:250px">
                                <asp:Label SkinID="lbInscription" ID="lbNomCompte" runat="server" Text='<%#Eval("Email") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Button skinid="btnActionPossible" ID="btnSupprimerMembre" runat="server" Text="Gérer" CommandName="supprimerMembre" CommandArgument='<%#Eval("noCompte") %>'/>
                            </td>
                            <td>
                                <asp:Button skinid="btnActionPossible" ID="btInscription" runat="server" Text="Inscription" CommandName="inscription" CommandArgument='<%#Eval("noCompte") %>'/>
                            </td>
                            <td>
                                <asp:Button skinid="btnActionPossible" ID="btnModifier" runat="server" Text="Modifier compte" CommandName="modifier" CommandArgument='<%#Eval("noCompte") %>'/>
                            </td>
                            <td>
                                <asp:Button skinid="btnActionPossible" ID="btnPrerequis" runat="server" Text="Pérequis" CommandName="prerequis" CommandArgument='<%#Eval("noCompte") %>'/>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </asp:View>
            <asp:View runat="server" ID="viewInscription">
                <asp:Label SkinID="lbTitrePage" ID="lbListeInscription" runat="server" Text="Liste d'inscriptions par membres" Width="600px"></asp:Label>
                <asp:ListView ID="lViewMembre" runat="server" DataSourceID="entiDataSourceMembre" DataKeyNames="noMembre">
                    <LayoutTemplate>                                                   
                         <asp:PlaceHolder runat="server" id="GroupPlaceHolder"></asp:PlaceHolder>          
                    </LayoutTemplate>
                    <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
                    <ItemTemplate>
                       <div class="borderInscription">            
                        <asp:Label SkinID="lbInscription" ID="lbNomMembre" runat="server" Text='<%#Eval("Prénom") &" " & Eval("Nom") %>'></asp:Label>
               
                        <asp:HiddenField ID="hFielNoMembre" runat="server" Value='<%#Eval("noMembre") %>' />
                
                        <asp:ListView ID="lViewPaiement" runat="server" DataSourceID="entiDataSourcePaiement" DataKeyNames="noPaiement">
                            <LayoutTemplate>                       
                                    <table style="float:right">
                                        <asp:PlaceHolder runat="server" id="GroupPlaceHolder"></asp:PlaceHolder>
                                    </table>
                            </LayoutTemplate>
                            <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="longeurDeuxiemeColonneNOM">
                                        <asp:Label SkinID="lbInscription" ID="lbNomMembre" runat="server" Text='<%#Eval("Groupe.Cours.Nom") & " Groupe " & Eval("Groupe.noGroupe") %>'></asp:Label>                                    
                                    </td>
                                    <td>
                                        <asp:Button skinid="btnActionPossible" ID="btnDesinscrire" runat="server" 
                                        Text="Désinscrire" CommandName="Delete" CommandArgument='<%#Eval("noPaiement") %>'/>
                                    </td>                                
                               </tr>
                            </ItemTemplate>                  
                        </asp:ListView>
                    </div>              
                    <asp:EntityDataSource ID="entiDataSourcePaiement" runat="server" 
                        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
                        EntitySetName="Paiement" Where="it.Membre.noMembre = @noMembre" Include="Membre, Groupe.Cours" 
                        EnableDelete="True" OnDeleted="deletePaiement" OnDeleting="deletingPaiement" >
                     <WhereParameters>
                        <asp:ControlParameter Type="int32" Name="noMembre" ControlID="hFielNoMembre"/>
                     </WhereParameters>
                    </asp:EntityDataSource>
                   </ItemTemplate>
                </asp:ListView>
                <br /> 
                <asp:Button SkinID="btnActionPossible" ID="btnRetourInscription" runat="server" Text="Retour" />         
            </asp:View>       
            <asp:View runat="server" ID="viewModifierCompte">
                <asp:Label SkinID="lbTitrePage" ID="lbTitreModiCompte" runat="server" Text="Modification de compte"></asp:Label>
                <asp:MultiView ID="multiViewModiCompte" runat="server" ActiveViewIndex="0">
                <asp:View ID="viewModiCompte" runat="server">               
                    <asp:ListView ID="lViewCompte" runat="server" DataKeyNames="noCompte" DataSourceID="entiDataSourceCompte" EditIndex="0">
                    <LayoutTemplate>
                                <table>
                                    <asp:PlaceHolder runat="server" ID="GroupPlaceHolder"></asp:PlaceHolder>
                                </table>
                            </LayoutTemplate>
                    <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
                    <ItemTemplate></ItemTemplate>
                    <EditItemTemplate>
                             <tr>
                                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbCourriel" runat="server" Text="Adresse courriel*"></asp:Label>
                                    </td>
                                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="210px" ID="tbCourriel" runat="server" MaxLength="35" Text='<%# Bind("Email") %>' ></asp:TextBox>
                                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                                        ID="requisValidationCourriel" runat="server" 
                                        ErrorMessage="Votre courriel doit être spécifié." 
                                        ControlToValidate="tbCourriel" Display="Dynamic" ValidationGroup="A">*</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="reguExpressionEmail" runat="server" 
                                        ErrorMessage="L'email n'est pas du bon format." ControlToValidate="tbCourriel"  
                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="A" Display="Dynamic" ForeColor="Red">*</asp:RegularExpressionValidator> 
                                    </td>
                            </tr> 
                             <tr>
                                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbNumeroTelephone" runat="server" Text="Numéro de téléphone"></asp:Label>
                                    </td>
                                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="100px" ID="tbNumeroTelephone" Text='<%# Bind("noTelephone") %>' runat="server"  MaxLength="10" ></asp:TextBox>
                                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                                        ID="requisValidationNumeroTelephone" runat="server" 
                                        ErrorMessage="Votre numéro de téléphone doit être spécifié." 
                                        ControlToValidate="tbNumeroTelephone" Display="Dynamic" ValidationGroup="A">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="reguExpressionNumeroTele" runat="server" ErrorMessage="Le numéro de téléphone ne peut comporter que des chiffres (4502473882)." 
                                    ControlToValidate="tbNumeroTelephone" Display="Dynamic" ValidationExpression="^[0-9]{10}$" ForeColor="Red" ValidationGroup="A">*</asp:RegularExpressionValidator>
                                    </td>
                            </tr>
                            <tr>
                                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbAdresse" runat="server" Text="Adresse"></asp:Label>
                                    </td>
                                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="200px" ID="tbAdresse" Text='<%# Bind("Adresse") %>' runat="server" MaxLength="30" ></asp:TextBox>
                                <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationAdresse" 
                                        runat="server" ErrorMessage="Votre adresse doit être spécifié." 
                                        ControlToValidate="tbAdresse" Display="Dynamic" ValidationGroup="A">*</asp:RequiredFieldValidator>                      
                                    </td>
                            </tr>
                            <tr>
                                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbCodePostale" runat="server" Text="Code Postal"></asp:Label>
                                    </td>
                                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="60px" ID="tbCodePostal" Text='<%# Bind("CodePostal") %>' runat="server" MaxLength="6" ></asp:TextBox>
                                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                                        ID="requisValidationCodePostal" runat="server" 
                                        ErrorMessage="Votre code postal doit être spécifié." 
                                        ControlToValidate="tbCodePostal" Display="Dynamic" ValidationGroup="A">*</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="reguExpressionCodePostale" runat="server" 
                                            ErrorMessage="Le code postale n'est pas du bon format(X#X#X#)" 
                                            ControlToValidate="tbCodePostal" 
                                            ValidationExpression="^[ABCEGHJKLMNPRSTVXYabceghjklmnprstvxy]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvwxyz]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvwxyz]{1}\d{1}$" 
                                            ForeColor="Red" Display="Dynamic" ValidationGroup="A">*</asp:RegularExpressionValidator> 
                                    </td>
                            </tr>
                            <tr>
                                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbVille" runat="server" Text="Ville"></asp:Label>
                                    </td>
                                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="160px" ID="tbVille" Text='<%# Bind("Ville") %>' runat="server" MaxLength="20" ></asp:TextBox>
                                <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationVille" 
                                        runat="server" ErrorMessage="Votre ville doit être spécifié." 
                                        ControlToValidate="tbVille" Display="Dynamic" ValidationGroup="A">*</asp:RequiredFieldValidator>
                                </td>                        
                            </tr>
                            <tr>
                                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbProvince" runat="server" Text="Province"></asp:Label>
                                    </td>
                                <td class="longeurDeuxiemeColonne"><asp:DropDownList skinId="dropDownListProvince" id="dropDownListProvince" 
                                        runat="server" DataSourceID="entiDataSourceProvince" DataTextField="nom" 
                                        DataValueField="noProvince" SelectedValue='<%# Bind("Province_noProvince") %>'>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator skinid="requisValidation" ID="requisValidationProvince" runat="server" 
                                    ErrorMessage="La province doit être spécifié." ControlToValidate="dropDownListProvince" 
                                    Display="Dynamic" ValidationGroup="A">*</asp:RequiredFieldValidator>
                                    </td>
                            </tr>
                            <tr>
                                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbPays" runat="server" Text="Pays"></asp:Label>
                                    </td>
                                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="80px" ID="tbPays" Text='<%# Bind("Pays") %>' runat="server" MaxLength="25" ></asp:TextBox>
                                <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationPays" 
                                runat="server" ErrorMessage="Votre pays doit être spécifié." ControlToValidate="tbPays" 
                                Display="Dynamic" ValidationGroup="A">*</asp:RequiredFieldValidator>
                                    </td>
                            </tr>                      
                        </table> 
                    </EditItemTemplate>
                    </asp:ListView>
                    <asp:Button SkinID="btnEnregistrer" ID="btnEnregistrer" runat="server" Text="Enregistrer" ValidationGroup="A" CauseValidation="True"/>  
                    <asp:Button skinid="btnModiMotDePasse" id="btnModiMotDePasse" runat="server" Text="Modifier mot de passe" CausesValidation="false" />
                    <asp:Button SkinID="btnActionPossible" ID="btnRetourModifier" runat="server" Text="Retour" CausesValidation="false" />
                </asp:View>
                <asp:View Id="viewMotDePasse" runat="server">
                <asp:ValidationSummary SkinID="valiSummary" ID="valiSummaryMotDePasse" runat="server" />    
                      <table>                  
                            <tr>
                                <td class="longeurPremiereColonnePW">
                                    <asp:Label SkinID="lbInscription" ID="lbNouvMotDePasse" runat="server" Text="Nouveau mot de passe"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox SkinID="tbInscription" Width="160px" ID="tbNouvMotDePasse" runat="server" TextMode="Password" MaxLength="20"></asp:TextBox>                     
                                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                                        ID="requisValidationNouvMot" runat="server" 
                                        ErrorMessage="Votre nouveau mot de passe doit être spécifié." 
                                        ControlToValidate="tbNouvMotDePasse" Display="Dynamic">*</asp:RequiredFieldValidator>
                                </td>               
                            </tr>
                             <tr>
                                <td class="longeurPremiereColonnePW">
                                    <asp:Label SkinID="lbInscription" ID="lbConfirmationNouv" runat="server" Text="Confirmation du nouveau mot de passe"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox SkinID="tbInscription" Width="160px" ID="tbConfirmationNouv" runat="server" TextMode="Password" MaxLength="20"></asp:TextBox>                     
                                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                                        ID="requisValiConfNouv" runat="server" 
                                        ErrorMessage="Votre confirmation de mot de passe doit être spécifié." 
                                        ControlToValidate="tbConfirmationNouv" Display="Dynamic">*</asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="compareConfirmMotPasse" runat="server" 
                                    ErrorMessage="Votre mot de passe de confirmation doit être le même que votre mot de passe." 
                                    Display="Dynamic" ControlToCompare="tbNouvMotDePasse" ControlToValidate="tbConfirmationNouv" 
                                    Operator="Equal">*</asp:CompareValidator>
                                </td>               
                            </tr>
                    </table>
                    <asp:Button SkinID="btnEnregistrer" ID="btnEnregistrerPW" runat="server" Text="Enregistrer" CausesValidation="true"/>
                    <asp:Button SkinID="btnEnregistrer" ID="btnAnnuler" runat="server" Text="Annuler" CausesValidation="false" /><br />                    
                </asp:View>
    </asp:MultiView>  
            </asp:View>
            <asp:View runat="server" ID="viewPrerequis">
                <asp:Label SkinID="lbTitrePage" ID="lbTitrePagePrerequis" runat="server" Text="Liste de prérequis par membres" Width="600px"></asp:Label>
                <asp:ListView ID="lViewMembrePrerequis" runat="server" DataSourceID="entiDataSourceMembre" DataKeyNames="noMembre" >
                    <LayoutTemplate>                                                   
                         <asp:PlaceHolder runat="server" id="GroupPlaceHolder"></asp:PlaceHolder>          
                    </LayoutTemplate>
                    <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
                    <ItemTemplate>
                       <div class="borderInscription">            
                        <asp:Label SkinID="lbInscription" ID="lbNomMembre" runat="server" Text='<%#Eval("Prénom") &" " & Eval("Nom") %>'></asp:Label>
                        <asp:ListView ID="lViewPaiementPrerequis" runat="server" 
                            DataSourceID="entiDataSourcePaiement" DataKeyNames="noPaiement" 
                            InsertItemPosition="LastItem" >
                            <LayoutTemplate>                       
                                    <table style="float:right">
                                        <asp:PlaceHolder runat="server" id="GroupPlaceHolder"></asp:PlaceHolder>
                                    </table>
                            </LayoutTemplate>
                            <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="longeurDeuxiemeColonneNOM">
                                        <asp:Label SkinID="lbInscription" ID="lbNomMembre" runat="server" Text='<%#Eval("Groupe.Cours.Nom") & " Groupe " & Eval("Groupe.noGroupe") %>'></asp:Label>                                    
                                    </td>                                                                                          
                               </tr>
                            </ItemTemplate>
                            <InsertItemTemplate>
                                    <tr>
                                        <td class="longeurDeuxiemeColonneNOM">
                                            <asp:DropDownList SkinID="dropDownListProvince" ID="dDListPrerequis" runat="server" DataSourceID="entiDataSourcePrerequis" DataTextField="nomCours"
                                              DataValueField="noGroupe" SelectedValue='<%#Bind("Groupe_noGroupe") %>'>
                                            </asp:DropDownList> 
                                            <asp:RequiredFieldValidator skinid="requisValidation" ID="requisValidationGroupe" 
                                            runat="server" ErrorMessage="La province doit être spécifié." ControlToValidate="dDListPrerequis" 
                                            Display="Dynamic">*</asp:RequiredFieldValidator>                                  
                                        </td>
                                        <td>
                                            <asp:Button skinid="btnActionPossible" ID="btnAjout" runat="server" 
                                            Text="Ajouter" CommandName="Insert" CommandArgument='<%#Eval("noPaiement") %>'/>
                                             
                                        </td>
                                   </tr>                             
                           </InsertItemTemplate>                                                       
                        </asp:ListView>
                    </div>
                        <asp:HiddenField ID="hFielNoMembre" runat="server" Value='<%#Eval("noMembre") %>' />  
                        <asp:HiddenField ID="hFielNoPaypal" runat="server" Value="Prerequis" />
                        <asp:HiddenField ID="hFielModePaiement" runat="server" Value="Prerequis" /> 
                        <asp:HiddenField ID="hFielPrix" runat="server" Value="0" />                 
                    <asp:EntityDataSource ID="entiDataSourcePaiement" runat="server" 
                        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
                        EntitySetName="Paiement" Where="it.Membre.noMembre = @noMembre" 
                        Include="Membre, Groupe.Cours" EnableInsert="True" OnInserted="ajoutePaiement">
                     <WhereParameters>
                        <asp:ControlParameter Type="int32" Name="noMembre" ControlID="hFielNoMembre"/>
                     </WhereParameters>
                     <InsertParameters>
                        <asp:ControlParameter Type="String" ControlID="hFielNoPaypal" Name="noPaypal" />
                        <asp:ControlParameter Type="String" ControlID="hFielModePaiement" Name="ModePaiement" />
                        <asp:ControlParameter Type="Int32" ControlID="hFielPrix" Name="Prix" />
                        <asp:ControlParameter Type="Int32" ControlID="hFielNoMembre" Name="Membre_noMembre" />
                     </InsertParameters>
                    </asp:EntityDataSource>
                    <asp:EntityDataSource ID="entiDataSourcePrerequis" runat="server" 
                          ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
                          EntitySetName="Groupe" Where='it.Nom = "Prerequis"' Select="it.[noGroupe], it.Cours.Nom AS nomCours"  >
                    </asp:EntityDataSource>
                   </ItemTemplate>                         
                </asp:ListView>
                <br /> 
                <asp:Button SkinID="btnActionPossible" ID="btnRetourPrerequis" runat="server" Text="Retour" CausesValidation="false" /> 
            </asp:View>
            <asp:View ID="viewListeMembre" runat="server">
                <asp:Label SkinID="lbTitrePage" ID="lbModifierSupprimerMembre" runat="server" Text="Modifier ou supprimer des membres"></asp:Label>
                <asp:ListView ID="lViewGererMembres" runat="server" DataSourceID="entiDataSourceMembre" DataKeyNames="noMembre" EditIndex="-1" >
                <LayoutTemplate>
                    <table>
                        <tr>
                            <td style="width:300px; height:20px;" >
                                <asp:Label SkinID="lbTitreInfoMembre" ID="lbNomPrenom" runat="server" Text="Nom:"></asp:Label>
                            </td>
                            <td style="width:200px; height:20px;" >
                                <asp:Label SkinID="lbTitreInfoMembre" id="lbDate" runat="server" Text="Date de naissance:"></asp:Label>
                            </td>
                        </tr>
                        <asp:PlaceHolder runat="server" ID="GroupPlaceHolder"></asp:PlaceHolder>
                    </table>
                </LayoutTemplate>
                <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Label SkinID="lbInfoMembre" id="lbNomMembre" runat="server" Text='<%#Eval("Prénom") &" " & Eval("Nom") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label SkinID="lbInfoMembre" id="tbDateNaissance" runat="server" Text='<%#Eval("DateNaissance", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                        <td >
                            <asp:Button SkinID="btnAjoutSupprimer" ID="btnModifier" runat="server" Text="Modifier" CommandName="Edit" CommandArgument='<%#Eval("noMembre") %>' />
                        </td>
                        <td>
                            <asp:Button SkinID="btnAjoutSupprimer" ID="btnSupprimer" runat="server" Text="-" CommandName="Supprimer" CommandArgument='<%#Eval("noMembre") %>' />
                            <ajaxToolkit:ConfirmButtonExtender ID="confirmBtnExtSupprimer" runat="server" TargetControlID="btnSupprimer" ConfirmText="Voulez-vous vraiment supprimer ce membre?">
                            </ajaxToolkit:ConfirmButtonExtender>    
                        </td>
                    </tr>
                </ItemTemplate>
                <EditItemTemplate>
                    <tr>
                        <td>
                            <asp:TextBox skinid="tbInscription" Width="90px" ID="tbNom" runat="server" Text='<%#Bind("Nom") %>' CssClass="flowLeftTB" ></asp:TextBox>
                            <asp:RegularExpressionValidator SkinID="requisValiation" runat="server" ID="requisNom" 
                             ErrorMessage="Le nom du membre doit être spécifié." ValidationGroup="A"
                             ControlToValidate="tbNom" Display="Dynamic"></asp:RegularExpressionValidator>
                            <asp:TextBox SkinID="tbInscription" Width="100px" ID="tbPrenom" Text='<%#Bind("Prénom") %>' runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator SkinID="requisValiation" ID="requisPrenom" runat="server"
                             ErrorMessage="Le prenom du membre doit être spécifié." ValidationGroup="A"
                             ControlToValidate="tbNom" Display="Dynamic"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:TextBox SkinID="tbInscription" Width="90px" ID="tbDateNaissance" Text='<%#Bind("DateNaissance", "{0:dd/MM/yyyy}") %>' runat="server" MaxLength="10" ToolTip="JJ-MM-AAAA" ></asp:TextBox>
                            <asp:ImageButton ID="imgBtnCalendrier" ImageUrl="~/App_Themes/Default/images/btnCalendrier.png" runat="server" CausesValidation="false" />              
                             <asp:RequiredFieldValidator SkinID="requisValidation" 
                                    ID="requisValidationDateNaissance" runat="server" 
                                    ErrorMessage="Votre date de naissance doit être spécifiée." 
                                    ControlToValidate="tbDateNaissance" Display="Dynamic">*</asp:RequiredFieldValidator>
                             <asp:CompareValidator runat="server" ID="test" Type="Date" ControlToValidate="tbDateNaissance" 
                                    ErrorMessage="La date de naissance n'est pas du bon format (jj-mm-aaaa)" ForeColor="Red" Operator="DataTypeCheck" 
                                    Display="Dynamic">*</asp:CompareValidator>
                            <asp:CalendarExtender ID="calendarExtenderDateNaissance" runat="server" TargetControlID="tbDateNaissance" PopupButtonID="imgBtnCalendrier" 
                                    CssClass="MyCalendar" PopupPosition="Right" Format="d-MM-yyyy" ></asp:CalendarExtender>                 
                        </td>
                        <td>
                            <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisTypeMembre" runat="server" 
                                ErrorMessage="Le type du membre doit être spécifié." ValidationGroup="A" ControlToValidate="rbListeTypeMembre" 
                                Display="Dynamic" >*</asp:RequiredFieldValidator>
                            <asp:RadioButtonList ID="rbListeTypeMembre" runat="server"  CellSpacing="10" RepeatDirection="Vertical" RepeatLayout="Flow" SelectedValue='<%# Bind("Parent") %>'>
                                <asp:ListItem Value="True">Parent</asp:ListItem>
                                <asp:ListItem Value="False">Enfant</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        <td>
                            <asp:Button SkinID="btnAjoutSupprimer" ID="btnEnregistrerModification" runat="server" Text="Enregistrer" CommandName="Update" CommandArgument='<%#Eval("noMembre") %>' />                      
                        </td>
                    </tr>
                </EditItemTemplate>
                
        
            </asp:ListView>  
            <br /> 
                <asp:Button SkinID="btnActionPossible" ID="btnRetourGererMembre" runat="server" Text="Retour" CausesValidation="false" /> 
            </asp:View>
        </asp:MultiView><br />   
        <asp:Label  ID="lbMessage" runat="server" Text=""></asp:Label> 
        </div>
    
    <asp:HiddenField ID="hFieldNoCompte" runat="server" />
    
    <asp:EntityDataSource ID="entiDataSourceCompte" runat="server" 
            ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
            EnableFlattening="False" EntitySetName="Compte" Where='it.Email like "%"+@recherche+"%" OR (@recherche ="") AND it.Type = 1' EnableUpdate="true">
        <WhereParameters>
            <asp:ControlParameter ControlID="tbRechercher" ConvertEmptyStringToNull="false" Name="recherche" Type="String" />
        </WhereParameters>    
    </asp:EntityDataSource>
     <asp:EntityDataSource ID="entiDataSourceMembre" runat="server"
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Membre" Where='it.Compte.noCompte = @noCompte AND it.Nom <> "Entrez un nom"' Include="Compte" EnableFlattening="False" EnableUpdate="true">
        <WhereParameters>
            <asp:ControlParameter ControlID="hFieldNoCompte" Type="Int32" Name="noCompte" />
        </WhereParameters>
   </asp:EntityDataSource>
   <asp:EntityDataSource ID="entiDataSourceProvince" runat="server" 
        ConnectionString="name=ModelContainer" 
        DefaultContainerName="ModelContainer" EntitySetName="Province" 
        EnableFlattening="False">
    </asp:EntityDataSource>
   
</asp:Content>
