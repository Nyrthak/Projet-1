<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="ajouterComptePrepose.aspx.vb" Inherits="Admin_ajouterComptePrepose" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>


<asp:Content ID="contentMenuClient" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="ContentCours" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
<asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="Server" />
    <asp:CalendarExtender ID="calendarExtenderDateNaissance" runat="server" TargetControlID="tbDateNaissance" PopupButtonID="imgBtnCalendrier" 
     CssClass="MyCalendar" PopupPosition="Right" Format="d-MM-yyyy" >
    </asp:CalendarExtender> 
<asp:ValidationSummary SkinID="valiSummary" ID="valiSummaryInscription" runat="server" />
    <table class="tableau">
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbNom" runat="server" Text="Nom:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="160px" ID="tbNom" runat="server" MaxLength="20"></asp:TextBox>               
                    <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationNom" 
                        runat="server" ErrorMessage="Le nom doit être spécifié." 
                        ControlToValidate="tbNom" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbPrenom" runat="server" Text="Prenom:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="160px" ID="tbPrenom" runat="server" MaxLength="20" ></asp:TextBox>                     
                    <asp:RequiredFieldValidator skinid="requisValidation" 
                        ID="requisValidationPrenom" runat="server" 
                        ErrorMessage="Le prenom doit être spécifié." ControlToValidate="tbPrenom" 
                        Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbCourriel" runat="server" Text="Adresse courriel*:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="210px" ID="tbCourriel" runat="server" MaxLength="35" ></asp:TextBox>
                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                        ID="requisValidationCourriel" runat="server" 
                        ErrorMessage="Le courriel doit être spécifié." 
                        ControlToValidate="tbCourriel" Display="Dynamic">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="reguExpressionEmail" runat="server" 
                        ErrorMessage="L'email n'est pas du bon format." ControlToValidate="tbCourriel"  
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" ForeColor="Red">*</asp:RegularExpressionValidator> 
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbDateNaissance" runat="server" Text="Date de naissance"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="90px" ID="tbDateNaissance" runat="server" MaxLength="10" ReadOnly="false" ></asp:TextBox>
                <asp:ImageButton ID="imgBtnCalendrier" ImageUrl="~/App_Themes/Default/images/btnCalendrier.png" runat="server" CausesValidation="false" />              
                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                        ID="requisValidationDateNaissance" runat="server" 
                        ErrorMessage="La date de naissance doit être spécifié." 
                        ControlToValidate="tbDateNaissance" Display="Dynamic">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator runat="server" ID="test" Type="Date" ControlToValidate="tbDateNaissance" ErrorMessage="La date de naissance n'est pas du bon format (jj-mm-aaaa)" ForeColor="Red" Operator="DataTypeCheck">*</asp:CompareValidator>
                        <asp:RangeValidator ID="rangeValidatorDateNaissance" runat="server" ErrorMessage="La date de naissance doit précèder la date d'aujourd'hui." 
                        ControlToValidate="tbDateNaissance" Display="Dynamic" ForeColor="Red">*</asp:RangeValidator>
                            
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbMotDePasse" runat="server" Text="Mot de passe:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="160px" ID="tbMotDePasse" runat="server" TextMode="Password" MaxLength="20"></asp:TextBox>                     
                     <asp:RequiredFieldValidator SkinID="requisValidation" 
                        ID="requisValidationMotDePasse" runat="server" 
                        ErrorMessage="Le mot de passe doit être spécifié." 
                        ControlToValidate="tbMotDePasse" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbConfirmationMotDePasse" runat="server" Text="Confirmation du mot de passe:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="160px" ID="tbConfirmationMotDePasse" runat="server" TextMode="Password" MaxLength="20"></asp:TextBox>
                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                        ID="requisValidationConfirmationMotDePasse" runat="server" 
                        ErrorMessage="La confirmation de mot de passe doit être spécifié." 
                        ControlToValidate="tbConfirmationMotDePasse" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="compareConfirmMotPasse" runat="server" ErrorMessage="Le mot de passe de confirmation doit être le même que votre mot de passe." Display="Dynamic" ControlToCompare="tbMotDePasse" ControlToValidate="tbConfirmationMotDePasse">*</asp:CompareValidator>
                        </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbNumeroTelephone" runat="server" Text="Numéro de téléphone:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="100px" ID="tbNumeroTelephone" runat="server"  MaxLength="10" ></asp:TextBox>
                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                        ID="requisValidationNumeroTelephone" runat="server" 
                        ErrorMessage="Le numéro de téléphone doit être spécifié." 
                        ControlToValidate="tbNumeroTelephone" Display="Dynamic">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="reguExpressionNumeroTele" runat="server" ErrorMessage="Le numéro de téléphone ne peut comporter que des chiffres (4502473882)." 
                    ControlToValidate="tbNumeroTelephone" Display="Dynamic" ValidationExpression="^[0-9]{10}$" ForeColor="Red">*</asp:RegularExpressionValidator>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbAdresse" runat="server" Text="Adresse:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="200px" ID="tbAdresse" runat="server" MaxLength="30" ></asp:TextBox>
                <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationAdresse" 
                        runat="server" ErrorMessage="L'adresse doit être spécifié." 
                        ControlToValidate="tbAdresse" Display="Dynamic">*</asp:RequiredFieldValidator>                      
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbCodePostale" runat="server" Text="Code Postal:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="60px" ID="tbCodePostal" runat="server" MaxLength="6" ></asp:TextBox>
                    <asp:RequiredFieldValidator SkinID="requisValidation" 
                        ID="requisValidationCodePostal" runat="server" 
                        ErrorMessage="Le code postal doit être spécifié." 
                        ControlToValidate="tbCodePostal" Display="Dynamic">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="reguExpressionCodePostale" runat="server" 
                            ErrorMessage="Le code postale n'est pas du bon format(X#X#X#)" 
                            ControlToValidate="tbCodePostal" 
                            ValidationExpression="^[ABCEGHJKLMNPRSTVXYabceghjklmnprstvxy]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvwxyz]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvwxyz]{1}\d{1}$" 
                            ForeColor="Red" Display="Dynamic">*</asp:RegularExpressionValidator> 
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbVille" runat="server" Text="Ville:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="160px" ID="tbVille" runat="server" MaxLength="20" ></asp:TextBox>
                <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationVille" 
                        runat="server" ErrorMessage="La ville doit être spécifié." 
                        ControlToValidate="tbVille" Display="Dynamic">*</asp:RequiredFieldValidator>
                </td>                        
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbProvince" runat="server" Text="Province:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:DropDownList skinId="dropDownListProvince" id="dropDownListProvince" 
                        runat="server" DataSourceID="entityDataSourceProvince" DataTextField="nom" 
                        DataValueField="noProvince" >
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator skinid="requisValidation" ID="requisValidationProvince" runat="server" ErrorMessage="La province doit être spécifié." ControlToValidate="dropDownListProvince" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbPays" runat="server" Text="Pays:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="80px" ID="tbPays" runat="server" MaxLength="25" ></asp:TextBox>
                <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationPays" runat="server" ErrorMessage="Le pays doit être spécifié." ControlToValidate="tbPays" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
            </tr>
        </table>  
        <asp:Button SkinID="btnEnregistrer" ID="btnEnregistrerInscription" runat="server" Text="S'inscrire" /><br />
         <asp:Label ID="lbNote1" runat="server" Text="*: Ce sera votre nom d'utilisateur lors de future connection. Il doit être valide pour que nous vous communiquions des informations."></asp:Label><br />
        <asp:EntityDataSource ID="entityDataSourceProvince" runat="server" 
        ConnectionString="name=ModelContainer" 
        DefaultContainerName="ModelContainer" EntitySetName="ProvinceSet" 
        EnableFlattening="False">
    </asp:EntityDataSource>
</asp:Content>
