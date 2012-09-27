<%@ Page Language="VB" AutoEventWireup="false" CodeFile="inscription.aspx.vb" Inherits="inscription" MasterPageFile="~/masterPage.master" Culture="auto" UICulture="auto" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>


<asp:Content ID="contentLogin" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">    
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="Server" />
    <asp:CalendarExtender ID="calendarExtenderDateNaissance" runat="server" TargetControlID="tbDateNaissance" PopupButtonID="imgBtnCalendrier" 
     CssClass="MyCalendar" PopupPosition="Right" Format="d/MM/yyyy" >
    </asp:CalendarExtender>
    <asp:EntityDataSource ID="entityDataSourceProvince" runat="server" 
        ConnectionString="name=ModelContainer" 
        DefaultContainerName="ModelContainer" EntitySetName="ProvinceSet" 
        EnableFlattening="False">
    </asp:EntityDataSource>
    <div id="content">             
        <asp:Label SkinID="lbTitrePage" ID="lbInscription" runat="server" Text="Inscription"></asp:Label>

        <asp:ValidationSummary SkinID="valiSummary" ID="valiSummaryInscription" runat="server" />
        <table class="tableau">
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbNom" runat="server" Text="Nom:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbNom" runat="server" MaxLength="25"></asp:TextBox>               
                    <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationNom" 
                        runat="server" ErrorMessage="Votre nom doit être spécifié." 
                        ControlToValidate="tbNom" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbPrenom" runat="server" Text="Prenom:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbPrenom" runat="server" MaxLength="25" ></asp:TextBox>                     
                    <asp:RequiredFieldValidator skinid="requisValidation" 
                        ID="requisValidationPrenom" runat="server" 
                        ErrorMessage="Votre prenom doit être spécifié." ControlToValidate="tbPrenom" 
                        Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbCourriel" runat="server" Text="Adresse courriel*:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbCourriel" runat="server" MaxLength="35" ></asp:TextBox>
                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                        ID="requisValidationCourriel" runat="server" 
                        ErrorMessage="Votre courriel doit être spécifié." 
                        ControlToValidate="tbCourriel" Display="Dynamic">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="reguExpressionEmail" runat="server" 
                        ErrorMessage="L'email n'est pas du bon format." ControlToValidate="tbCourriel"  
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" ForeColor="Red">*</asp:RegularExpressionValidator> 
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbDateNaissance" runat="server" Text="Date de naissance"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbDateNaissance" runat="server" MaxLength="10" ReadOnly="false" ></asp:TextBox>
                <asp:ImageButton ID="imgBtnCalendrier" ImageUrl="~/App_Themes/Default/images/btnCalendrier.png" runat="server" CausesValidation="false" />              
                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                        ID="requisValidationDateNaissance" runat="server" 
                        ErrorMessage="Votre date de naissance doit être spécifié." 
                        ControlToValidate="tbDateNaissance" Display="Dynamic">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="reguExpressionDateNaissance" runat="server" ErrorMessage="Votre date de naissance n'est pas du bon format (jj/mm/yyyy)" ControlToValidate="tbDateNaissance" 
                        ValidationExpression="^([0-9]|[0][123456789]|[1][012])[/]([012][0-9]|[3][01])[/][0-9][0-9][0-9][0-9]$" forecolor="Red" Display="Dynamic">*</asp:RegularExpressionValidator>        
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbMotDePasse" runat="server" Text="Mot de passe:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbMotDePasse" runat="server" TextMode="Password" MaxLength="30"></asp:TextBox>                     
                     <asp:RequiredFieldValidator SkinID="requisValidation" 
                        ID="requisValidationMotDePasse" runat="server" 
                        ErrorMessage="Votre mot de passe doit être spécifié." 
                        ControlToValidate="tbMotDePasse" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbConfirmationMotDePasse" runat="server" Text="Confirmation du mot de passe:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbConfirmationMotDePasse" runat="server" TextMode="Password" MaxLength="30"></asp:TextBox>
                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                        ID="requisValidationConfirmationMotDePasse" runat="server" 
                        ErrorMessage="Votre confirmation de mot de passe doit être spécifié." 
                        ControlToValidate="tbConfirmationMotDePasse" Display="Dynamic">*</asp:RequiredFieldValidator>
                        </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbNumeroTelephone" runat="server" Text="Numéro de téléphone:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbNumeroTelephone" runat="server" MaxLength="10" ></asp:TextBox>
                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                        ID="requisValidationNumeroTelephone" runat="server" 
                        ErrorMessage="Votre numéro de téléphone doit être spécifié." 
                        ControlToValidate="tbNumeroTelephone" Display="Dynamic">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="reguExpressionNumeroTele" runat="server" ErrorMessage="Le numéro de téléphone ne peut comporter que des chiffres (4502473882)." 
                    ControlToValidate="tbNumeroTelephone" Display="Dynamic" ValidationExpression="^[0-9]{10}$" ForeColor="Red">*</asp:RegularExpressionValidator>

                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbAdresse" runat="server" Text="Adresse:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbAdresse" runat="server" MaxLength="50" ></asp:TextBox>
                <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationAdresse" 
                        runat="server" ErrorMessage="Votre adresse doit être spécifié." 
                        ControlToValidate="tbAdresse" Display="Dynamic">*</asp:RequiredFieldValidator>                      
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbCodePostale" runat="server" Text="Code Postal:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbCodePostal" runat="server" MaxLength="6" ></asp:TextBox>
                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                        ID="requisValidationCodePostal" runat="server" 
                        ErrorMessage="Votre code postal doit être spécifié." 
                        ControlToValidate="tbCodePostal" Display="Dynamic">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="reguExpressionCodePostale" runat="server" 
                            ErrorMessage="Le code postale n'est pas du bon format(X#X#X#)" 
                            ControlToValidate="tbCodePostal" 
                            ValidationExpression="^[ABCEGHJKLMNPRSTVXYabceghjklmnprstvxy]{1}\d{1}[A-Za-z]{1}\d{1}[A-Za-z]{1}\d{1}$" ForeColor="Red" Display="Dynamic">*</asp:RegularExpressionValidator> 
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbVille" runat="server" Text="Ville:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbVille" runat="server" MaxLength="30" ></asp:TextBox>
                <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationVille" 
                        runat="server" ErrorMessage="Votre ville doit être spécifié." 
                        ControlToValidate="tbVille" Display="Dynamic">*</asp:RequiredFieldValidator>
                </td>                        
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbProvince" runat="server" Text="Province:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:DropDownList skinId="dropDownListProvince" id="dropDownListProvince" 
                        runat="server" DataSourceID="entityDataSourceProvince" DataTextField="nom" 
                        DataValueField="noProvince" Width="200px" >
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator skinid="requisValidation" ID="requisValidationProvince" runat="server" ErrorMessage="La province doit être spécifié." ControlToValidate="dropDownListProvince" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbPays" runat="server" Text="Pays:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbPays" runat="server" MaxLength="25" ></asp:TextBox>
                <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationPays" runat="server" ErrorMessage="Votre pays doit être spécifié." ControlToValidate="tbPays" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
            </tr>
        </table>
        <br />
        <asp:Label ID="lbFraisOuverture" runat="server" Text="Des frais de 50$ s'applique pour l'ouverture d'un compte." SkinID="lbTitrePage"></asp:Label><br />
        <asp:Label ID="lbInformationsFrais" runat="server" Text="Les frais ne seront pas crédités avant que votre inscription soit approuvée." Font-Size="12px"></asp:Label><br />
 
        <asp:Label  SkinID="lbInscription" id="lbTypeDeCarte" runat="server" Text="Type de carte:"></asp:Label>
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
                <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbNumeroCartePaiement" runat="server" Text="Numéro de la carte:"></asp:Label>
                </td>
                <td><asp:TextBox SkinID="tbInscription" ID="tbNumeroCartePaiement" Text="" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator SkinID="requisValidation" 
                        ID="requisValidationNumeroCartePaiement" runat="server" 
                        ErrorMessage="Votre numéro de carte doit être spécifié." 
                        ControlToValidate="tbNumeroCartePaiement" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbNumeroSecurite" runat="server" Text="Numéro de sécurité**:"></asp:Label>
                    </td>
                <td>
                   <asp:TextBox SkinID="tbInscription" ID="tbNumeroSecuriteCarte" runat="server" MaxLength="3"></asp:TextBox>
                   <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationNumeroSecurite" runat="server" ErrorMessage="Votre numéro de sécurité doit être spécifié." ControlToValidate="tbNumeroSecuriteCarte" Display="Dynamic">*</asp:RequiredFieldValidator>
                   </td>                      
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbDateExpirationCarte" runat="server" Text="Date d'expiration:"></asp:Label>
                    </td>
                <td>
                    <asp:DropDownList skinid="dropDownListDateExpiration" ID="dropDownListMois"  runat="server" >
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
                    <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationDateExpirationMois" runat="server" ErrorMessage="Le mois de la date d'expiration de votre carte de crédit doit être spécifié." ControlToValidate="dropDownListMois" Display="Dynamic">*</asp:RequiredFieldValidator>
                    <asp:DropDownList skinid="dropDownListDateExpiration" ID="dropDownListAnnee" runat="server">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationDateExpirationAnnee" runat="server" ErrorMessage="L'année de la date d'expiration de votre carte de crédit doit être spécifié." ControlToValidate="dropDownListAnnee" Display="Dynamic">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbNomPaiement" runat="server" Text="Nom du détenteur:"></asp:Label>
                    </td>
                <td>
                    <asp:TextBox SkinID="tbInscription" ID="tbNomPaiement" runat="server" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationNomDétenteur" runat="server" ErrorMessage="Le nom du détenteur doit être spécifié." ControlToValidate="tbNomPaiement" Display="Dynamic">*</asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
        <asp:Label ID="lbNote1" runat="server" Text="*: Ce sera votre nom d'utilisateur lors de future connection. Il doit être valide pour que nous vous communiquions des informations."></asp:Label><br />
        <asp:Label ID="LbNote2" runat="server" Text="**: Ce numéro de 3 chiffres se situe au dos de votre carte."></asp:Label>
        <br />
        <asp:Button SkinID="btnEnregistrer" ID="btnEnregistrerInscription" runat="server" Text="S'inscrire et payer" />
    </div>
</asp:Content>

