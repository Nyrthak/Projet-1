<%@ Page Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false" CodeFile="coursDefault.aspx.vb" Inherits="coursDefault" %>

<asp:Content ID="contentMenu" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">    
    <asp:Button ID="btnRechercher" runat="server" Text="Ok" CssClass="rechercher" />
    <asp:TextBox ID="txtRechercher" runat="server" SkinID="TextBoxFormulaire" CssClass="rechercher"></asp:TextBox>
    <asp:Label ID="lblRechercher" runat="server" Text="Rechercher" CssClass="lbRechercher"></asp:Label>
    <div class="menuFloat">
        <asp:ListView ID="lViewCatégorie" runat="server" DataSourceID="entityDataSourceCatégorie" DataKeyNames="noCatégorie">
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
        <asp:ValidationSummary SkinID="valiSummary" ID="valiPaiment" runat="server" />
    <asp:MultiView ID="mViewCours" runat="server" ActiveViewIndex= "0">
        <asp:View ID="viewListeCours" runat="server">
            <asp:ListView ID="lViewListeCours" runat="server" DataSourceID="entityDataSourceListeCours" DataKeyNames="noCours" >
                <LayoutTemplate>
                    <asp:Label ID="lblTitreListeCours" runat="server" Text="Liste des cours" SkinID="lbTitrePage"></asp:Label>
                    <table class="listeCours">
                        <tr>
                            <td><asp:Label ID="lblTitreActivite" runat="server" SkinID="lbTitreInfoMembre" Text="Activité"></asp:Label></td>
                            <td><asp:Label ID="lblTitreGroupeDAge" runat="server" SkinID="lbTitreInfoMembre" Text="Groupe d'âge"></asp:Label></td>
                            <td><asp:Label ID="lblTitrePrix" runat="server" SkinID="lbTitreInfoMembre" Text="Prix"></asp:Label></td>
                        </tr>
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td><asp:LinkButton ID="lblActivite" runat="server" Text='<%#Eval("Nom")%>' CommandName="Selection" CommandArgument='<%#Eval("noCours")%>'></asp:LinkButton></td>
                        <td><asp:Label ID="lblGroupeDAge" runat="server" Text='<%#Eval("GroupeDAge.NomGroupeDAge")%>'></asp:Label></td>
                        <td><asp:Label ID="lblPrix" runat="server" Text='<%#Eval("Prix") & "$"%>'></asp:Label></td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
            <asp:DataPager ID="dpListeCours" runat="server" PagedControlID="lViewListeCours">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                        ShowLastPageButton="True" FirstPageText="Premier" LastPageText="Dernier" 
                        NextPageText="Suivant" PreviousPageText="Précédent" ButtonCssClass="boutonMenuPager" />
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
                        <td><asp:Label ID="lblSTitrePrix" runat="server" Text="Prix : " SkinID="lbChampsFormulaire"></asp:Label><asp:Label ID="lblPrix" runat="server" Text='<%#Eval("Prix") & "$"%>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblSTitreGroupeDAge" runat="server" Text="Groupe d'âge : " SkinID="lbChampsFormulaire"></asp:Label><asp:Label ID="lblGroupeDAge" runat="server" Text='<%#Eval("GroupeDAge.NomGroupeDAge")%>'></asp:Label></td>
                        <td><asp:Label ID="lblSTitrePrerequis" runat="server" Text="Prérequis : " SkinID="lbChampsFormulaire"></asp:Label><asp:Label ID="lblPrerequis" runat="server" Text='<%#Eval("lePrerequis.Nom")%>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblSTitreCategorie" runat="server" Text="Catégorie : " SkinID="lbChampsFormulaire"></asp:Label><asp:Label ID="lblCategorie" runat="server" Text='<%#Eval("Catégorie.Nom")%>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="2"><asp:Label ID="lblSTitreDescription" runat="server" Text="Description : " SkinID="lbChampsFormulaire"></asp:Label><asp:Label ID="lblDescription" runat="server" Text='<%#Eval("Description")%>'></asp:Label></td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
            <asp:ListView ID="lviewGroupes" runat="server" DataSourceID="entityDataSourceGroupes" DataKeyNames="noGroupe">
                <LayoutTemplate>
                    <asp:Label ID="lblTitreModifierCours" runat="server" Text="Liste des groupes" SkinID="lbSousTitre"></asp:Label>
                    <table id="tbCours">
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td><asp:LinkButton ID="lnkGroupe" runat="server" Text='<%#Eval("Nom") %>' CommandName="Selection" CommandArgument='<%#Eval("noGroupe")%>' /></td>
                        <td><asp:Label ID="lblAge" runat="server" Text='<%#Eval("AgeMinimum") & "-" & Eval("AgeMaximum") & " ans"%>' /></td>
                        <td><asp:Label ID="lblSession" runat="server" Text='<%#Eval("Session.NomSession")%>'></asp:Label></td>
                        <td>
                            <asp:DropDownList ID="dDListMembres" runat="server" DataSourceID="entityDataSourceMembre"
                                DataTextField="Prénom" DataValueField="noMembre">
                            </asp:DropDownList>
                        </td>
                        <td><asp:Button ID="btnSinscrire" runat="server" Text="S'inscrire" SkinID="btnAjoutSupprimer" Width="80px" CommandName="Inscription" CommandArgument='<%#Eval("noGroupe")%>' /></td>
                        <td><asp:LinkButton ID="lnkInscriptionListeDAttente" runat="server" Text="S'inscrire à la liste d'attente" Width="100px" SkinID="btnAjoutSupprimer" CommandName="InscriptionAttente" CommandArgument='<%#Eval("noGroupe")%>' /></td>
                    </tr>
                    <asp:HiddenField ID="hFieldnoGroupe" runat="server" Value='<%#Eval("noGroupe")%>' />

                    <asp:ListView ID="lviewHoraire" runat="server" DataSourceID="entityDataSourceHoraire" DataKeyNames="noHoraire">
                         <LayoutTemplate>            
                                <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />              
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr>
                                <td></td>
                                <td  class="horaire"><asp:Label ID="lblHoraire" runat="server" Text='<%#Eval("Jour.nomJour") & " de " & Eval("HeureDebut", "{0:hh:mm}") & "h" & " à " & Eval("HeureFin", "{0:hh:mm}") & "h" %>' /></td>
                                <td colspan="2"></td>
                            </tr>
                        </ItemTemplate>
                    </asp:ListView>
                    <tr>
                        <td colspan="4"><br /> </td>
                    </tr>
                    <asp:EntityDataSource ID="entityDataSourceHoraire" runat="server" ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer"
                        EntitySetName="Horaire" EnableFlattening="false" Include="Groupe, Jour" Where="it.Groupe.noGroupe = @noGroupe">
                        <WhereParameters>
                            <asp:ControlParameter Name="noGroupe" Type="Int32" ControlID="hFieldnoGroupe" />
                        </WhereParameters>
                    </asp:EntityDataSource>
                </ItemTemplate>
            </asp:ListView>
        </asp:View>
        <asp:View ID="viewGroupe" runat="server">
            <asp:ListView ID="lviewLeGroupe" runat="server" DataSourceID="entityDataSourceLeGroupe" DataKeyNames="noGroupe">
                <LayoutTemplate>                    
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                </LayoutTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblTitreAfficherGroupe" runat="server" Text='<%#Eval("Nom") %>' SkinID="lbTitrePage"></asp:Label>
                    <table id="tbCours">
                        <tr>
                            <td>
                                <asp:Label ID="lblTitreDebut" runat="server" Text="Date de début: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblDebut" runat="server" Text='<%#Eval("DateDebut", "{0:dd/MM/yy}") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblTitreLocal" runat="server" Text="Local: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblLocal" runat="server" Text='<%#Eval("Local") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTitreFin" runat="server" Text="Date de fin: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblFin" runat="server" Text='<%#Eval("DateFin", "{0:dd/MM/yy}") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblTitreAge" runat="server" Text="Âge: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblAge" runat="server" Text='<%#Eval("AgeMinimum") & "-" & Eval("AgeMaximum") & " ans"%>'></asp:Label>
                            </td
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTitreDateLimite" runat="server" Text="Date limite d'inscription: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblDateLimite" runat="server" Text='<%#Eval("DateLimiteInscription", "{0:dd/MM/yy}") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblTitreAnimateur" runat="server" Text="Animateur: " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblAnimateur" runat="server" Text='<%#Eval("Animateur.Nom")%>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSTitreSession" runat="server" Text="Session : " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblSession" runat="server" Text='<%#Eval("Session.NomSession")%>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblTitreNbMaxInscrits" runat="server" Text="Nombre de places : " SkinID="lbChampsFormulaire"></asp:Label>
                                <asp:Label ID="lblNbMaxInscrits" runat="server" Text='<%#Eval("nbMaxInscrits")%>'></asp:Label>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:ListView>
            <asp:ListView ID="lviewHoraire" runat="server" DataSourceID="entityDataSourceHoraire" DataKeyNames="noHoraire">
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
                                <td  class="horaire"><asp:Label ID="lblHoraire" runat="server" Text='<%#Eval("Jour.nomJour") & " de " & Eval("HeureDebut", "{0:hh:mm}") & "h" & " à " & Eval("HeureFin", "{0:hh:mm}") & "h" %>' /></td>
                            </tr>
                        </ItemTemplate>
                    </asp:ListView>
            <asp:ListView ID="lViewMembres" runat="server" DataSourceID="entityDataSourcePaiements" DataKeyNames="noPaiement" GroupItemCount="3">
                <LayoutTemplate>
                    <asp:Label ID="lblTitreMembres" runat="server" Text= "Liste des membres " SkinID="lbSousTitre" />
                    <table width="400px">
                        <asp:PlaceHolder id="GroupPlaceHolder" runat="server" /> 
                    </table>                          
                </LayoutTemplate>
                <GroupTemplate>
                    <tr>
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                    </tr>
                </GroupTemplate>
                <ItemTemplate>
                        <td>
                            <asp:Label ID="lblNom" runat="server" Text='<%#Eval("Membre.Prénom") & " " & Eval("Membre.Nom") %>'></asp:Label>
                        </td>
                </ItemTemplate>
            </asp:ListView>
            <div class="btnCentre">
                <asp:DropDownList ID="dDListMembres" runat="server" DataSourceID="entityDataSourceMembre"
                        DataTextField="Prénom" DataValueField="noMembre" SkinID="dDListFormulaire">
                </asp:DropDownList>
                <asp:Button ID="btnSinscrire" runat="server" Text="S'inscrire" SkinID="btnAjoutSupprimer" Width="80px" />
                <asp:LinkButton ID="lnkInscriptionListeDAttente" runat="server" Text="S'inscrire à la liste d'attente" Width="100px" 
                    SkinID="btnAjoutSupprimer"/>
                <asp:DropDownList ID="dDListCompteP" runat="server" DataSourceID="entiDataSourceComptesP" DataTextField="Email" DataValueField="noCompte" AutoPostBack="true" SkinID="dDListFormulaire"/>
                <asp:DropDownList ID="dDListMembreP" runat="server" DataSourceID="entiDataSourceMembresP" DataTextField="leNom" DataValueField="noMembre" SkinID="dDListFormulaire"/>
                <asp:Button ID="btninscrirePrepose" runat="server" Text="Inscrire le membre" SkinID="btnAjoutSupprimer" Width="130px" />
            </div>
            <div class="btnCentre">
                <asp:Button ID="btnRetour" runat="server" Text="Retour" Width="80px" SkinID="btnAjoutSupprimer" />
            </div>
                    
        </asp:View>
        <asp:View ID="viewPaiement" runat="server">
            <asp:Label  SkinID="lbTitrePage" id="lbTitrePaiement" runat="server" Text="Paiement de votre inscription"></asp:Label><br />
            <asp:Label  SkinID="lbInscription" id="lbTypeCarte" runat="server" Text="Type de carte"></asp:Label>
            <asp:RequiredFieldValidator SkinID="requisValidation" ID="rfvRequisModePaiement" runat="server" ErrorMessage="Le mode de paiement doit être spécifié." ControlToValidate="rbListeTypeCarte" Display="Dynamic" >*</asp:RequiredFieldValidator>
            <asp:RadioButtonList ID="rbListeTypeCarte" runat="server" CellSpacing="10" 
            RepeatDirection="Horizontal">
            <asp:ListItem>MasterCard</asp:ListItem>
            <asp:ListItem>Visa</asp:ListItem>
            <asp:ListItem>American Express</asp:ListItem>
            <asp:ListItem>Discover</asp:ListItem>
            </asp:RadioButtonList>         
            <table class="style1">
                <tr>
                    <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbNoCarte" runat="server" Text="Numéro de la carte"></asp:Label>
                    </td>
                    <td><asp:TextBox SkinID="tbInscription" ID="tbNumeroCartePaiement" MaxLength="16" Text="" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                            ID="rfvNoCarte" runat="server" 
                            ErrorMessage="Votre numéro de carte doit être spécifié." 
                            ControlToValidate="tbNumeroCartePaiement" Display="Dynamic">*</asp:RequiredFieldValidator>                    
                    <asp:CompareValidator ID="cvNoCarte" runat="server" ControlToValidate="tbNumeroCartePaiement" 
                        Operator="LessThanEqual" ErrorMessage="Le numéro de la carte de crédit n'est pas du bon format(seulement des chiffres)" ValueToCompare="99999999999999">*</asp:CompareValidator>
                        </td>
                </tr>
                <tr>
                    <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbNoSecurite" runat="server" Text="Numéro de sécurité**"></asp:Label>
                        </td>
                    <td>
                       <asp:TextBox SkinID="tbInscription" Width="30px" ID="tbNumeroSecuriteCarte" runat="server" MaxLength="3" ></asp:TextBox>
                       <asp:RequiredFieldValidator SkinID="requisValidation" ID="rfvNoSecurite" runat="server" ErrorMessage="Votre numéro de sécurité doit être spécifié." ControlToValidate="tbNumeroSecuriteCarte" Display="Dynamic">*</asp:RequiredFieldValidator>
                       </td>                      
                </tr>
                <tr>
                    <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbDateExpiration" runat="server" Text="Date d'expiration"></asp:Label>
                        </td>
                    <td>
                        <asp:DropDownList skinid="dropDownListDateExpiration" Width="50px" ID="dropDownListMois"  runat="server" >
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem>4</asp:ListItem>
                            <asp:ListItem>5</asp:ListItem>
                            <asp:ListItem>6</asp:ListItem>
                            <asp:ListItem>7</asp:ListItem>
                            <asp:ListItem>8</asp:ListItem>
                            <asp:ListItem>9</asp:ListItem>
                            <asp:ListItem>10</asp:ListItem>
                            <asp:ListItem>11</asp:ListItem>
                            <asp:ListItem>12</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator SkinID="requisValidation" ID="rfvMoisExpiration" runat="server" 
                            ErrorMessage="Le mois de la date d'expiration de votre carte de crédit doit être spécifié." ControlToValidate="dropDownListMois" Display="Dynamic">*</asp:RequiredFieldValidator>
                        <asp:DropDownList skinid="dropDownListDateExpiration" Width="70px" ID="dropDownListAnnee" runat="server">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator SkinID="requisValidation" ID="rfvAnneExpiration" runat="server" 
                            ErrorMessage="L'année de la date d'expiration de votre carte de crédit doit être spécifié." ControlToValidate="dropDownListAnnee" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbNomDetenteur" runat="server" Text="Nom du détenteur"></asp:Label>
                        </td>
                    <td>
                        <asp:TextBox SkinID="tbInscription" Width="210px" ID="tbNomPaiement" runat="server" MaxLength="40"></asp:TextBox>
                            <asp:RequiredFieldValidator SkinID="requisValidation" ID="RequiredFieldValidator6" runat="server" ErrorMessage="Le nom du détenteur doit être spécifié." 
                            ControlToValidate="tbNomPaiement" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbPrenom" runat="server" Text="Prénom du détenteur"></asp:Label>
                        </td>
                    <td>
                        <asp:TextBox SkinID="tbInscription" Width="210px" ID="tbPrenomPaiement" runat="server" MaxLength="40"></asp:TextBox>
                            <asp:RequiredFieldValidator SkinID="requisValidation" ID="rfvPrenom" runat="server" ErrorMessage="Le prénom du détenteur doit être spécifié." 
                            ControlToValidate="tbPrenomPaiement" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbAdresse" runat="server" Text="Adresse"></asp:Label>
                        </td>
                    <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="200px" ID="tbAdresse" runat="server" MaxLength="30" ></asp:TextBox>
                    <asp:RequiredFieldValidator SkinID="requisValidation" ID="rfvAdresse" 
                            runat="server" ErrorMessage="Votre adresse doit être spécifiée." 
                            ControlToValidate="tbAdresse" Display="Dynamic">*</asp:RequiredFieldValidator>                      
                        </td>
                </tr>
                <tr>
                    <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbCodePostal" runat="server" Text="Code Postal"></asp:Label>
                        </td>
                    <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="60px" ID="tbCodePostal" runat="server" MaxLength="6" ToolTip="X#X#X#" ></asp:TextBox>
                        <asp:RequiredFieldValidator SkinID="requisValidation" 
                            ID="rfvCodePostal" runat="server" 
                            ErrorMessage="Votre code postal doit être spécifié." 
                            ControlToValidate="tbCodePostal" Display="Dynamic">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="regexCodePostal" runat="server" 
                                ErrorMessage="Le code postal n'est pas du bon format(X#X#X#)" 
                                ControlToValidate="tbCodePostal" 
                                ValidationExpression="^[ABCEGHJKLMNPRSTVXYabceghjklmnprstvxy]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvwxyz]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvwxyz]{1}\d{1}$" 
                                ForeColor="Red" Display="Dynamic">*</asp:RegularExpressionValidator> 
                        </td>
                </tr>
                <tr>
                    <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbVille" runat="server" Text="Ville"></asp:Label>
                        </td>
                    <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="160px" ID="tbVille" runat="server" MaxLength="20" ></asp:TextBox>
                    <asp:RequiredFieldValidator SkinID="requisValidation" ID="rfvVille" 
                            runat="server" ErrorMessage="Votre ville doit être spécifié." 
                            ControlToValidate="tbVille" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>                        
                </tr>
                <tr>
                    <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbProvince" runat="server" Text="Province"></asp:Label>
                        </td>
                    <td class="longeurDeuxiemeColonne"><asp:DropDownList skinId="dropDownListProvince" id="dropDownListProvince" 
                            runat="server" DataSourceID="entityDataSourceProvince" DataTextField="nom" 
                            DataValueField="noProvince" >
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator skinid="requisValidation" ID="rfvProvince" runat="server" ErrorMessage="La province doit être spécifié." ControlToValidate="dropDownListProvince" Display="Dynamic">*</asp:RequiredFieldValidator>
                        </td>
                </tr>
                <tr>
                    <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbPays" runat="server" Text="Pays"></asp:Label>
                        </td>
                    <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="80px" ID="tbPays" runat="server" MaxLength="25" ></asp:TextBox>
                    <asp:RequiredFieldValidator SkinID="requisValidation" ID="rfvPays" runat="server" ErrorMessage="Votre pays doit être spécifié." ControlToValidate="tbPays" Display="Dynamic">*</asp:RequiredFieldValidator>
                        </td>
                </tr>
            </table>
            <asp:Button SkinID="btnEnregistrer" ID="btnEnregistrerInscription" runat="server" Text="S'inscrire et payer" /><br />
            <asp:Label ID="lbNo3Chiffres" runat="server" Text="**: Ce numéro de 3 chiffres se situe au dos de votre carte."></asp:Label>
        </asp:View>
    </asp:MultiView><br />
        <asp:Label skinid="lbSousTitre" ID="lbMessage" runat="server" Text=""></asp:Label>
    </div>
    <asp:HiddenField ID="hFieldNoCompte" runat="server" />
    <asp:HiddenField ID="hFieldnoGroupe2" runat="server" />
    <asp:HiddenField ID="hFieldnoMembre" runat="server" />
    <asp:HiddenField ID="hFieldNoCategorie" runat="server" Value="0" />
    <asp:EntityDataSource ID="entityDataSourceListeCours" runat="server" 
    ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
    EntitySetName="Cours" EnableFlattening="false" Include="GroupeDAge, Catégorie"
        Where='(it.Nom + it.[Catégorie].Nom + it.[GroupeDAge].NomGroupeDAge like "%"+@recherche+"%" OR (@recherche = "")) AND (it.[Catégorie].[noCatégorie] = @categorie OR @categorie = 0) AND it.Actif'>                
        <WhereParameters>
            <asp:ControlParameter Name="recherche" Type="String" ControlID="txtRechercher" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter Name="categorie" Type="Int32" ControlID="hFieldNoCategorie" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entityDataSourceCatégorie" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Catégorie" EnableFlattening="false">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entityDataSourceCours" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Cours" EnableFlattening="false" Include="GroupeDAge, Catégorie, lePrerequis"
        Where="it.[noCours] = @leNoCours">               
        <WhereParameters>
            <asp:ControlParameter Name="leNoCours" Type="Int32" ControlID="hFieldnoCours" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entityDataSourceGroupes" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Groupe" EnableFlattening="false" Include="Cours, Session"
        Where='it.Cours.noCours = @leNoCours AND it.Actif AND it.Session.NomSession <> "Prerequis" AND it.Session.DebutSession > @Ya6mois  '>
        <WhereParameters>
            <asp:ControlParameter Name="leNoCours" Type="Int32" ControlID="hFieldnoCours" />
            <asp:Parameter Name="Ya6Mois" Type="DateTime" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entityDataSourceLeGroupe" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Groupe" EnableFlattening="false" Include="Cours, Animateur, Session"
        Where="it.noGroupe = @leNoGroupe">
        <WhereParameters>
            <asp:ControlParameter Name="leNoGroupe" Type="Int32" ControlID="hFieldnoGroupe2" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entityDataSourceMembre" runat="server"
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Membre" EnableFlattening="false" Include="Compte"
        Where="it.Compte.noCompte = @leNoCompte">
        <WhereParameters>
            <asp:SessionParameter Name="leNoCompte" Type="Int32" SessionField="noCompte" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entityDataSourceHoraire" runat="server" ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer"
         EntitySetName="Horaire" EnableFlattening="false" Include="Groupe, Jour" Where="it.Groupe.noGroupe = @noGroupe">
        <WhereParameters>
            <asp:ControlParameter Name="noGroupe" Type="Int32" ControlID="hFieldnoGroupe2" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entityDataSourcePaiements" runat="server"
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Paiement" EnableFlattening="false" Include="Groupe, Membre, Groupe.Cours"
        Where="it.Groupe.noGroupe = @leNoGroupe AND @peutVoir">
        <WhereParameters>
            <asp:ControlParameter Name="leNoGroupe" Type="Int32" ControlID="hFieldnoGroupe2" />
            <asp:Parameter Name="peutVoir" Type="Boolean" DefaultValue="False" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entityDataSourceProvince" runat="server" 
        ConnectionString="name=ModelContainer" 
        DefaultContainerName="ModelContainer" EntitySetName="Province" 
        EnableFlattening="False">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entiDataSourceComptesP" runat="server"
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Compte" EnableFlattening="false">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entiDataSourceMembresP" runat="server"
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Membre" EnableFlattening="false" Select='(it.[Prénom] + " " + it.Nom) As leNom, it.noMembre, it.Compte.noCompte'
        Where="it.Compte.noCompte = @leNoCompte">
        <WhereParameters>
            <asp:ControlParameter Name="leNoCompte" Type="Int32" ControlID="hFieldnoCompte" />
        </WhereParameters>
    </asp:EntityDataSource>
</asp:Content>
