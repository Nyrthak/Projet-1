<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="modifComptePrep.aspx.vb" Inherits="prepose_modifComptePrep" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

<asp:Content ID="contentMenuClient" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentMenuAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>

<asp:Content ID="contentMain" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
<div id="contentRight">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="Server" />             
    <asp:Label  SkinID="lbTitrePage" ID="lbTitrePage" runat="server" Text="Modification de mon compte."></asp:Label>
    
    <asp:MultiView ID="multiViewModiCompte" runat="server" ActiveViewIndex="0">
        <asp:View ID="viewModiCompte" runat="server">
        <asp:ValidationSummary SkinID="valiSummary" ID="valiSummaryCompte" runat="server" />            
            <asp:ListView ID="lViewCompte" runat="server" DataKeyNames="noCompte" DataSourceID="entiDataSourceCompte" EditIndex="0">
            <LayoutTemplate>
                        <table>
                            <asp:PlaceHolder runat="server" ID="GroupPlaceHolder"></asp:PlaceHolder>
                        </table>
                    </LayoutTemplate>
            <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
            <ItemTemplate></ItemTemplate>
            <EditItemTemplate>
                       <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbCourriel" runat="server" Text="Adresse courriel"></asp:Label>
                            </td>
                        <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="210px" ID="tbCourriel" Text='<%# Bind("Email") %>' runat="server" MaxLength="35" ></asp:TextBox>
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
                        <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbNumeroTelephone" runat="server" Text="Numéro de téléphone"></asp:Label>
                            </td>
                        <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="100px" ID="tbNumeroTelephone" Text='<%# Bind("noTelephone") %>' runat="server"  MaxLength="10" ></asp:TextBox>
                            <asp:RequiredFieldValidator SkinID="requisValidation" 
                                ID="requisValidationNumeroTelephone" runat="server" 
                                ErrorMessage="Votre numéro de téléphone doit être spécifié." 
                                ControlToValidate="tbNumeroTelephone" Display="Dynamic">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="reguExpressionNumeroTele" runat="server" ErrorMessage="Le numéro de téléphone ne peut comporter que des chiffres (4502473882)." 
                            ControlToValidate="tbNumeroTelephone" Display="Dynamic" ValidationExpression="^[0-9]{10}$" ForeColor="Red">*</asp:RegularExpressionValidator>
                            </td>
                    </tr>
                    <tr>
                        <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbAdresse" runat="server" Text="Adresse"></asp:Label>
                            </td>
                        <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="200px" ID="tbAdresse" Text='<%# Bind("Adresse") %>' runat="server" MaxLength="30" ></asp:TextBox>
                        <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationAdresse" 
                                runat="server" ErrorMessage="Votre adresse doit être spécifié." 
                                ControlToValidate="tbAdresse" Display="Dynamic">*</asp:RequiredFieldValidator>                      
                            </td>
                    </tr>
                    <tr>
                        <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbCodePostale" runat="server" Text="Code Postal"></asp:Label>
                            </td>
                        <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="60px" ID="tbCodePostal" Text='<%# Bind("CodePostal") %>' runat="server" MaxLength="6" ></asp:TextBox>
                            <asp:RequiredFieldValidator SkinID="requisValidation" 
                                ID="requisValidationCodePostal" runat="server" 
                                ErrorMessage="Votre code postal doit être spécifié." 
                                ControlToValidate="tbCodePostal" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="reguExpressionCodePostale" runat="server" 
                                    ErrorMessage="Le code postale n'est pas du bon format(X#X#X#)" 
                                    ControlToValidate="tbCodePostal" 
                                    ValidationExpression="^[ABCEGHJKLMNPRSTVXYabceghjklmnprstvxy]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvwxyz]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvwxyz]{1}\d{1}$" 
                                    ForeColor="Red" Display="Dynamic">*</asp:RegularExpressionValidator> 
                            </td>
                    </tr>
                    <tr>
                        <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbVille" runat="server" Text="Ville"></asp:Label>
                            </td>
                        <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="160px" ID="tbVille" Text='<%# Bind("Ville") %>' runat="server" MaxLength="20" ></asp:TextBox>
                        <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationVille" 
                                runat="server" ErrorMessage="Votre ville doit être spécifié." 
                                ControlToValidate="tbVille" Display="Dynamic">*</asp:RequiredFieldValidator>
                        </td>                        
                    </tr>
                    <tr>
                        <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbProvince" runat="server" Text="Province"></asp:Label>
                            </td>
                        <td class="longeurDeuxiemeColonne"><asp:DropDownList skinId="dropDownListProvince" id="dropDownListProvince" 
                                runat="server" DataSourceID="entiDataSourceProvince" DataTextField="nom" 
                                DataValueField="noProvince" SelectedValue='<%# Bind("Province_noProvince") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator skinid="requisValidation" ID="requisValidationProvince" runat="server" ErrorMessage="La province doit être spécifié." ControlToValidate="dropDownListProvince" Display="Dynamic">*</asp:RequiredFieldValidator>
                            </td>
                    </tr>
                    <tr>
                        <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbPays" runat="server" Text="Pays"></asp:Label>
                            </td>
                        <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" Width="80px" ID="tbPays" Text='<%# Bind("Pays") %>' runat="server" MaxLength="25" ></asp:TextBox>
                        <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisValidationPays" runat="server" ErrorMessage="Votre pays doit être spécifié." ControlToValidate="tbPays" Display="Dynamic">*</asp:RequiredFieldValidator>
                            </td>
                    </tr>                        
                </table> 
            </EditItemTemplate>
            </asp:ListView>
            <asp:Button SkinID="btnEnregistrer" ID="btnEnregistrer" runat="server" Text="Enregistrer" causeValidation="true"/>  
            <asp:Button skinid="btnModiMotDePasse" id="btnModiMotDePasse" runat="server" Text="Modifier mot de passe" CausesValidation="false" /><br />
        </asp:View>
        <asp:View Id="viewMotDePasse" runat="server">
        <asp:ValidationSummary SkinID="valiSummary" ID="valiSummaryMotDePasse" runat="server" />    
              <table>                  
                    <tr>
                        <td class="longeurPremiereColonnePW">
                            <asp:Label SkinID="lbInscription" ID="lbAncientMotDePasse" runat="server" Text="Ancient mot de passe"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox SkinID="tbInscription" Width="160px" ID="tbMotDePasse" runat="server" TextMode="Password" MaxLength="20"></asp:TextBox>                     
                            <asp:RequiredFieldValidator SkinID="requisValidation" 
                                ID="requisValidationMotDePasse" runat="server" 
                                ErrorMessage="Votre mot de passe doit être spécifié." 
                                ControlToValidate="tbMotDePasse" Display="Dynamic">*</asp:RequiredFieldValidator>
                        </td>               
                    </tr>
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
                                <asp:CompareValidator ID="compareNouvMotDePasse" runat="server" 
                                 ErrorMessage="Votre nouveau mot de passe doit être différent de l'ancient." 
                                 Display="Dynamic" ControlToCompare="tbMotDePasse" ControlToValidate="tbNouvMotDePasse" 
                                 Operator="NotEqual">*</asp:CompareValidator>
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
     <asp:Label  ID="lbMessage" runat="server" Text=""></asp:Label>  
</div>
     <asp:EntityDataSource ID="entiDataSourceProvince" runat="server" 
        ConnectionString="name=ModelContainer" 
        DefaultContainerName="ModelContainer" EntitySetName="Province" 
        EnableFlattening="False">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entiDataSourceCompte" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Compte" EnableFlattening="false" EnableUpdate="True" Where="it.noCompte = @noCompte" Include="Province">
        <WhereParameters>
        <asp:SessionParameter Name="noCompte" SessionField="noCompte" Type="Int32"/>    
        </WhereParameters>
    </asp:EntityDataSource>
</asp:Content>
