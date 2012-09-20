<%@ Page Language="VB" AutoEventWireup="false" CodeFile="inscription.aspx.vb" Inherits="inscription" MasterPageFile="~/masterPage.master" Culture="auto" UICulture="auto" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>


<asp:Content ID="contentLogin" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">    
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="Server" />
    <asp:CalendarExtender ID="calendarExtenderDateNaissance" runat="server" TargetControlID="tbDateNaissance" PopupButtonID="imgBtnCalendrier" 
     CssClass="MyCalendar" PopupPosition="Right" Format="d/MM/yyyy" >
    </asp:CalendarExtender>
    
    <div id="content">             
        <asp:Label SkinID="lbTitrePage" ID="lbInscription" runat="server" Text="Inscription"></asp:Label>

        <asp:ValidationSummary SkinID="valiSummary" ID="valiSummaryInscription" runat="server" />
        <table class="tableau">
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbNom" runat="server" Text="Nom:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbNom" runat="server" ></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbPrenom" runat="server" Text="Prenom:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbPrenom" runat="server" ></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbCourriel" runat="server" Text="Adresse courriel*:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbCourriel" runat="server" ></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbDateNaissance" runat="server" Text="Date de naissance"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbDateNaissance" runat="server" ></asp:TextBox><asp:ImageButton
                        ID="imgBtnCalendrier" ImageUrl="~/App_Themes/Default/images/btnCalendrier.png" runat="server" />
                  
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbMotDePasse" runat="server" Text="Mot de passe:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbMotDePasse" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbConfirmationMotDePasse" runat="server" Text="Confirmation du mot de passe:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbConfirmationMotDePasse" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbAdresse" runat="server" Text="Adresse:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbAdresse" runat="server" ></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbCodePostale" runat="server" Text="Code Postale:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbCodePostale" runat="server" ></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbVille" runat="server" Text="Ville:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbVille" runat="server" ></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbProvince" runat="server" Text="Province:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbProvince" runat="server" ></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbPays" runat="server" Text="Pays:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbPays" runat="server" ></asp:TextBox>
                    </td>
            </tr>
        </table>
        <br />
        <asp:Label ID="lbFraisOuverture" runat="server" Text="Des frais de 50$ s'applique pour l'ouverture d'un compte." SkinID="lbTitrePage"></asp:Label><br />

        <asp:Label  SkinID="lbInscription" id="lbTypeDeCarte" runat="server" Text="Type de carte:"></asp:Label>
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
                <td><asp:TextBox SkinID="tbInscription" ID="tbNumeroCartePaiement" runat="server"></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbNumeroSecurite" runat="server" Text="Numéro de sécurité**:"></asp:Label>
                    </td>
                <td>
                   <asp:TextBox SkinID="tbInscription" ID="tbNumeroSecuriteCarte" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbDateExpirationCarte" runat="server" Text="Date d'expiration:"></asp:Label>
                    </td>
                <td>
                    <asp:TextBox SkinID="tbInscription" ID="tbDateExpirationCarte" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label skinid="lbInscription" ID="lbNomPaiement" runat="server" Text="Nom du détenteur:"></asp:Label>
                    </td>
                <td>
                    <asp:TextBox SkinID="tbInscription" ID="tbNomPaiement" runat="server"></asp:TextBox></td>
            </tr>
        </table>
        <asp:Label ID="lbNote1" runat="server" Text="*: Ce sera votre nom d'utilisateur lors de future connection. Il doit être valide pour que nous vous communiquions des informations."></asp:Label><br />
        <asp:Label ID="LbNote2" runat="server" Text="**: Ce numéro de 3 chiffres se situe au dos de votre carte."></asp:Label>
        <br />
        <asp:Button SkinID="btnEnregistrer" ID="btnEnregistrerInscription" runat="server" Text="S'inscrire et payer" />
        <%--Validation des textboxes précèdents--%>
        <asp:RegularExpressionValidator ID="reguExpressionEmail" runat="server" 
            ErrorMessage="L'email n'est pas du bon format." ControlToValidate="tbCourriel"  
            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" >&nbsp;</asp:RegularExpressionValidator>
        
        <asp:RegularExpressionValidator ID="reguExpressionCodePostale" runat="server" 
            ErrorMessage="Le code postale n'est pas du bon format(X#X#X#)" 
            ControlToValidate="tbCodePostale" 
            ValidationExpression="^[ABCEGHJKLMNPRSTVXYabceghjklmnprstvxy]{1}\d{1}[A-Za-z]{1}\d{1}[A-Za-z]{1}\d{1}$">&nbsp;</asp:RegularExpressionValidator>
          
    </div>
</asp:Content>

