<%@ Page Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false" CodeFile="inscripNonPaye.aspx.vb" Inherits="client_inscripNonPaye" %>

<asp:Content ID="contentAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="contentRight">
        <asp:MultiView ID="mViewInscription" ActiveViewIndex="0"  runat="server">
            <asp:View runat="server" ID="viewInscriptions">
                <asp:Label SkinID="lbTitrePage" ID="lbNonPayé" runat="server" Text="Inscription non payé"></asp:Label>
                <asp:ListView ID="lViewPaiement" runat="server" DataSourceID="entiDataSourcePaiementNonPaye" DataKeyNames="noPaiement">
                <LayoutTemplate>
                            <table>
                                <tr>
                                    <td class="itemTemplate">
                                        <asp:Label SkinID="lbTitreInfoMembre" ID="lbNonCours" runat="server" Text="Nom du cours"></asp:Label>
                                    </td>
                                </tr>
                                <asp:PlaceHolder runat="server" ID="GroupPlaceHolder"></asp:PlaceHolder>
                            </table>
                        </LayoutTemplate>
                        <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
                        <ItemTemplate>
                            <tr>
                               <td class="itemTemplate">
                                   <asp:Label SkinID="lbTitreInfoMembre" ID="lbNonCours" runat="server" Text='<%#Eval("Groupe.Cours.Nom") %>'></asp:Label>
                               </td>
                               <td>
                                   <asp:Button SkinID="btnEnregistrer" ID="btnPayer" runat="server" CommandArgument='<%#Eval("noPaiement") %>' CommandName="Payer" Text="Payer" />
                               </td>
                            </tr>
                        </ItemTemplate>
                </asp:ListView>
            </asp:View>
            <asp:View runat="server" ID="viewPaiement">
                <asp:Label  SkinID="lbTitrePage" id="lbPaiement" runat="server" Text="Paiement de votre inscription"></asp:Label><br />
                <asp:Label  SkinID="lbInscription" id="lbTypeDeCarte" runat="server" Text="Type de carte"></asp:Label>
                <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationModePaiement" runat="server" ErrorMessage="Le mode de paiement doit être spécifié." ControlToValidate="rbListeTypeCarte" Display="Dynamic" >*</asp:RequiredFieldValidator>
                <asp:RadioButtonList ID="rbListeTypeCarte" runat="server" CellSpacing="10" 
                    RepeatDirection="Horizontal">
                <asp:ListItem>MasterCard</asp:ListItem>
                <asp:ListItem>Visa</asp:ListItem>
                <asp:ListItem>American Express</asp:ListItem>
                <asp:ListItem>Discover</asp:ListItem>
                </asp:RadioButtonList>         
                <table class="style1">
                    <tr>
                        <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbNumeroCartePaiement" runat="server" Text="Numéro de la carte"></asp:Label>
                        </td>
                        <td><asp:TextBox SkinID="tbInscription" ID="tbNumeroCartePaiement" MaxLength="16" Text="" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator SkinID="requisValidation" 
                                ID="requisValidationNumeroCartePaiement" runat="server" 
                                ErrorMessage="Votre numéro de carte doit être spécifié." 
                                ControlToValidate="tbNumeroCartePaiement" Display="Dynamic">*</asp:RequiredFieldValidator>                    
                        <asp:CompareValidator ID="compareNumeroCarte" runat="server" ControlToValidate="tbNumeroCartePaiement" 
                            Operator="LessThanEqual" ErrorMessage="Le numéro de la carte de crédit n'est pas du bon format(seulement des chiffres)" ValueToCompare="99999999999999">*</asp:CompareValidator>
                            </td>
                    </tr>
                    <tr>
                        <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbNumeroSecurite" runat="server" Text="Numéro de sécurité**"></asp:Label>
                            </td>
                        <td>
                           <asp:TextBox SkinID="tbInscription" Width="30px" ID="tbNumeroSecuriteCarte" runat="server" MaxLength="3" ></asp:TextBox>
                           <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationNumeroSecurite" runat="server" ErrorMessage="Votre numéro de sécurité doit être spécifié." ControlToValidate="tbNumeroSecuriteCarte" Display="Dynamic">*</asp:RequiredFieldValidator>
                           </td>                      
                    </tr>
                    <tr>
                        <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbDateExpirationCarte" runat="server" Text="Date d'expiration"></asp:Label>
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
                            <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationDateExpirationMois" runat="server" 
                                ErrorMessage="Le mois de la date d'expiration de votre carte de crédit doit être spécifié." ControlToValidate="dropDownListMois" Display="Dynamic">*</asp:RequiredFieldValidator>
                            <asp:DropDownList skinid="dropDownListDateExpiration" Width="70px" ID="dropDownListAnnee" runat="server">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationDateExpirationAnnee" runat="server" 
                                ErrorMessage="L'année de la date d'expiration de votre carte de crédit doit être spécifié." ControlToValidate="dropDownListAnnee" Display="Dynamic">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbNomPaiement" runat="server" Text="Nom du détenteur"></asp:Label>
                            </td>
                        <td>
                            <asp:TextBox SkinID="tbInscription" Width="210px" ID="tbNomPaiement" runat="server" MaxLength="40"></asp:TextBox>
                                <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationNomDetenteur" runat="server" ErrorMessage="Le nom du détenteur doit être spécifié." 
                                ControlToValidate="tbNomPaiement" Display="Dynamic">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbPrenomPaiement" runat="server" Text="Prénom du détenteur"></asp:Label>
                            </td>
                        <td>
                            <asp:TextBox SkinID="tbInscription" Width="210px" ID="tbPrenomPaiement" runat="server" MaxLength="40"></asp:TextBox>
                                <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisVlidationPrenomDetendeur" runat="server" ErrorMessage="Le prénom du détenteur doit être spécifié." 
                                ControlToValidate="tbPrenomPaiement" Display="Dynamic">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbAdresse" runat="server" Text="Adresse"></asp:Label>
                            </td>
                        <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="200px" ID="tbAdresse" runat="server" MaxLength="30" ></asp:TextBox>
                        <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationAdresse" 
                                runat="server" ErrorMessage="Votre adresse doit être spécifiée." 
                                ControlToValidate="tbAdresse" Display="Dynamic">*</asp:RequiredFieldValidator>                      
                            </td>
                    </tr>
                    <tr>
                        <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbCodePostale" runat="server" Text="Code Postal"></asp:Label>
                            </td>
                        <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="60px" ID="tbCodePostal" runat="server" MaxLength="6" ToolTip="X#X#X#" ></asp:TextBox>
                            <asp:RequiredFieldValidator SkinID="requisValidation" 
                                ID="requisValidationCodePostal" runat="server" 
                                ErrorMessage="Votre code postal doit être spécifié." 
                                ControlToValidate="tbCodePostal" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="reguExpressionCodePostal" runat="server" 
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
                        <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationVille" 
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
                            <asp:RequiredFieldValidator skinid="requisValidation" ID="requisValidationProvince" runat="server" ErrorMessage="La province doit être spécifié." ControlToValidate="dropDownListProvince" Display="Dynamic">*</asp:RequiredFieldValidator>
                            </td>
                    </tr>
                    <tr>
                        <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbPays" runat="server" Text="Pays"></asp:Label>
                            </td>
                        <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="80px" ID="tbPays" runat="server" MaxLength="25" ></asp:TextBox>
                        <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationPays" runat="server" ErrorMessage="Votre pays doit être spécifié." ControlToValidate="tbPays" Display="Dynamic">*</asp:RequiredFieldValidator>
                            </td>
                    </tr>
                </table>
                <asp:Button SkinID="btnEnregistrer" ID="btnEnregistrerInscription" runat="server" Text="S'inscrire et payer" /><br />
                <asp:Label ID="LbNote2" runat="server" Text="**: Ce numéro de 3 chiffres se situe au dos de votre carte."></asp:Label>
            </asp:View>
        </asp:MultiView>
    </div>
    <asp:HiddenField ID="hFielNoPaiement" runat="server" />
    <asp:EntityDataSource ID="entiDataSourcePaiementNonPaye" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Paiement" Include="Membre.Compte, Groupe.Cours" Where='it.Membre.Compte.noCompte = @noCompte AND it.ModePaiement = "Non Payé"'>
        <WhereParameters>
            <asp:SessionParameter Name="noCompte" Type="Int32" SessionField="noCompte" />
        </WhereParameters>
    </asp:EntityDataSource>

    <asp:EntityDataSource ID="entityDataSourceProvince" runat="server" 
        ConnectionString="name=ModelContainer" 
        DefaultContainerName="ModelContainer" EntitySetName="Province" 
        EnableFlattening="False">
    </asp:EntityDataSource>
</asp:Content>
