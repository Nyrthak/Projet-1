<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="GererAnimateurs.aspx.vb" Inherits="Admin_GererAnimateurs" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<asp:Content ID="ContentCours" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <asp:Button SkinID="btnRechercher" ID="btnRechercher" runat="server" Text="Ok" CssClass="rechercher" />
    <asp:TextBox ID="txtRechercher" runat="server" SkinID="TextBoxFormulaire" CssClass="rechercher"></asp:TextBox>
    <asp:Label ID="lblRechercher" runat="server" Text="Rechercher" CssClass="lbRechercher"></asp:Label>
    <div id="contentRight">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="Server" />
        <asp:Label ID="lblTitreAnimateurs" runat="server" Text="Gérer les animateurs" SkinID="lbTitrePage"></asp:Label><br />
        <asp:MultiView ID="mViewAnimateurs" runat="server" ActiveViewIndex="0">
            <asp:View ID="viewAnimateurs" runat="server">
                <asp:ListView ID="lViewAnimateurs" runat="server" DataSourceID="entiDataSourceAnimateurs" DataKeyNames="noAnimateur" InsertItemPosition="LastItem">
            <LayoutTemplate>
                <asp:ValidationSummary ID="vSummaryInsert" runat="server" ValidationGroup="Insert" CssClass="validationSummary" />
                <asp:ValidationSummary ID="vSummaryEdit" runat="server" ValidationGroup="Edit" CssClass="validationSummary"/>
                <table id="tbAnimateurs">
                <tr>
                    <td><asp:Label ID="lbTitrePrenom" runat="server" Text="Prénom" SkinID="lbChampsFormulaire" Width="90px"></asp:Label></td>
                    <td><asp:Label ID="lbTitreNom" runat="server" Text="Nom" SkinID="lbChampsFormulaire"  Width="130px"></asp:Label></td>
                    <td><asp:Label ID="lbTitreDatenaissance" runat="server" Text="Date de naissance" SkinID="lbChampsFormulaire"  Width="160px"></asp:Label></td>
                    <td></td>
                </tr>                
                <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />    
            </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td><asp:LinkButton ID="lbPrenom" runat="server" Text='<%#Eval("Prenom")%>' CommandName="Select"></asp:LinkButton></td>
                    <td><asp:Label ID="lbNom" runat="server" Text='<%#Eval("Nom")%>'></asp:Label></td>
                    <td><asp:Label ID="lbDatenaissance" runat="server" Text='<%#Eval("DateNaissance", "{0:dd/MM/yyyy}")%>'></asp:Label></td>
                    <td><asp:Button ID="btnDelete" runat="server" Text="Supprimer" CommandName="Delete" SkinID="btnAjoutSupprimer" /></td>
                </tr>
            </ItemTemplate>
            <SelectedItemTemplate>
                <tr style="height:25px;"></tr>
                <tr>
                    <td class="tdTop tdGauche"><asp:Label ID="lbTitrePrenom" runat="server" Text="Prénom" SkinID="lbChampsFormulaire" Width="90px"></asp:Label></td>
                    <td class="tdTop"><asp:Label ID="lbTitreNom" runat="server" Text="Nom" SkinID="lbChampsFormulaire"  Width="130px"></asp:Label></td>
                    <td class="tdTop tdDroite" colspan="2"><asp:Label ID="lbTitreDatenaissance" runat="server" Text="Date de naissance" SkinID="lbChampsFormulaire"  Width="160px"></asp:Label></td>                    
                </tr>
                <tr>
                    <td class="tdGauche"><asp:Label ID="lbPrenom" runat="server" Text='<%#Eval("Prenom")%>' ></asp:Label></td>
                    <td><asp:Label ID="lbNom" runat="server" Text='<%#Eval("Nom")%>'></asp:Label></td>
                    <td colspan="2" class="tdDroite"><asp:Label ID="lbDatenaissance" runat="server" Text='<%#Eval("DateNaissance", "{0:dd/MM/yyyy}")%>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="tdGauche"><asp:Label ID="lbTitreNoTelephone" runat="server" Text="Téléphone" SkinID="lbChampsFormulaire"  Width="120px"></asp:Label></td>
                    <td><asp:Label ID="lbTitreCodePostal" runat="server" Text="CodePostal" SkinID="lbChampsFormulaire"></asp:Label></td>
                    <td><asp:Label ID="lbTitreVille" runat="server" Text="Ville" SkinID="lbChampsFormulaire"></asp:Label></td>
                    <td class="tdDroite"><asp:Label ID="lbTitreProvince" runat="server" Text="Province" SkinID="lbChampsFormulaire"></asp:Label></td>
                </tr>
                <tr>
                    <td class="tdGauche"><asp:Label ID="lbNoTelephone" runat="server" Text='<%#Eval("noTelephone")%>'></asp:Label></td>
                    <td><asp:Label ID="lbCodePostal" runat="server" Text='<%#Eval("CodePostal")%>'></asp:Label></td>
                    <td><asp:Label ID="lbVille" runat="server" Text='<%#Eval("Ville")%>'></asp:Label></td>
                    <td class="tdDroite"><asp:Label ID="lbProvince" runat="server" Text='<%#Eval("Province.Nom")%>'></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="4" class="tdGauche tdDroite"><asp:Label ID="lbTitreAdresse" runat="server" Text="Adresse" SkinID="lbChampsFormulaire"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="2" class="tdGauche"><asp:Label ID="lbAdresse" runat="server" Text='<%#Eval("Adresse")%>'></asp:Label></td>
                    <td style="text-align:right; padding-right:10px;"><asp:Button ID="btnSpecialite" runat="server" Text="Spécialités" CommandName="VoirSpecialites" CommandArgument='<%#Eval("noAnimateur")%>' SkinID="btnAjoutSupprimer" Width="80px" /></td>
                    <td class="tdDroite"><asp:Button ID="btnEdit" runat="server" Text="Modifier" CommandName="Edit" SkinID="btnAjoutSupprimer" Width="80px" /></td>
                </tr>
                <tr>
                    <td colspan="2" class="tdBas tdGauche"></td>
                    <td class="tdBas" style="text-align:right; padding-right:10px;"><asp:Button ID="btnCancel" runat="server" Text="Annuler" CommandName="AnnulerSelect" SkinID="btnAjoutSupprimer" Width="80px" /></td>
                    <td class="tdBas tdDroite"><asp:Button ID="btnDelete" runat="server" Text="Supprimer" CommandName="Delete" SkinID="btnAjoutSupprimer" Width="80px" /></td>
                </tr>
                <tr style="height:25px;"></tr>
            </SelectedItemTemplate>
            <EditItemTemplate>
                <tr style="height:25px;"></tr>
                <tr>
                    <td class="tdTop tdGauche"><asp:Label ID="lbTitrePrenom" runat="server" Text="Prénom" SkinID="lbChampsFormulaire" Width="100px"></asp:Label></td>
                    <td class="tdTop"><asp:Label ID="lbTitreNom" runat="server" Text="Nom" SkinID="lbChampsFormulaire"  Width="120px"></asp:Label></td>
                    <td colspan="2" class="tdTop tdDroite"><asp:Label ID="lbTitreDatenaissance" runat="server" Text="Date de naissance" SkinID="lbChampsFormulaire"  Width="160px"></asp:Label></td> 
                </tr>
                <tr>
                    <td class="tdGauche">
                        <asp:TextBox ID="tbPrenom" runat="server" Text='<%#Bind("Prenom")%>' SkinID="tbSkin" Width="80px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPrenom" ForeColor="Red" runat="server" Display="Dynamic"
                            ErrorMessage="Le prénom doit être spécifié." ControlToValidate="tbPrenom" ValidationGroup="Edit">*
                        </asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <asp:TextBox ID="tbNom" runat="server" Text='<%#Bind("Nom")%>' SkinID="tbSkin"  Width="80px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNom" ForeColor="Red" runat="server" ValidationGroup="Edit"
                            ControlToValidate="tbNom" Display="Dynamic" ErrorMessage="Le nom doit être spécifié." >*
                        </asp:RequiredFieldValidator>
                    </td>
                    <td colspan="2" class="tdDroite">
                        <asp:TextBox ID="tbDateNaissance" runat="server" Text='<%#Bind("DateNaissance", "{0:dd/MM/yyyy}")%>' SkinID="tbSkin"  Width="120px"></asp:TextBox>
                        <asp:ImageButton ID="imgBtnCalendrier" ImageUrl="~/App_Themes/Default/images/btnCalendrier.png" runat="server" CausesValidation="false" />
                        <asp:CalendarExtender ID="calendarExtenderDateNaissance" runat="server" TargetControlID="tbDateNaissance" 
                            PopupButtonID="imgBtnCalendrier" CssClass="MyCalendar" PopupPosition="Right" Format="d-MM-yyyy" >
                        </asp:CalendarExtender>
                        <asp:RequiredFieldValidator ID="rfvDateNaissance" ForeColor="Red" runat="server" Display="Dynamic"
                            ErrorMessage="La date de naissance doit être spécifiée." ControlToValidate="tbDateNaissance" ValidationGroup="Edit">*
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvDateNaissance" runat="server" Type="Date" ControlToValidate="tbDateNaissance"
                            ErrorMessage="La date de naissance n'est pas du bon format (jj-mm-aaaa)" ForeColor="Red" 
                            Operator="DataTypeCheck" Display="Dynamic" ValidationGroup="Edit">*
                        </asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="tdGauche"><asp:Label ID="lbTitreNoTelephone" runat="server" Text="Téléphone" SkinID="lbChampsFormulaire"  Width="120px"></asp:Label></td>
                    <td><asp:Label ID="lbTitreCodePostal" runat="server" Text="CodePostal" SkinID="lbChampsFormulaire"></asp:Label></td>
                    <td><asp:Label ID="lbTitreVille" runat="server" Text="Ville" SkinID="lbChampsFormulaire"></asp:Label></td>
                    <td class="tdDroite"><asp:Label ID="lbTitreProvince" runat="server" Text="Province" SkinID="lbChampsFormulaire"></asp:Label></td>
                </tr>
                <tr>
                    <td class="tdGauche">
                        <asp:TextBox ID="tbNoTelephone" runat="server" Text='<%#Bind("noTelephone")%>' SkinID="tbSkin"  Width="80px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNoTelephone" runat="server" ControlToValidate="tbNoTelephone" ValidationGroup="Edit"
                            ErrorMessage="Le numéro de téléphone doit être spécifié." Display="Dynamic" ForeColor="Red">*
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="reNoTelephone" runat="server" ControlToValidate="tbNoTelephone"
                            ErrorMessage="Le numéro de téléphone ne peut comporter que des chiffres (4502473882)." 
                            ValidationExpression="^[0-9]{10}$" ForeColor="Red" Display="Dynamic" ValidationGroup="Edit">*
                        </asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:TextBox ID="tbCodePostal" runat="server" Text='<%#Bind("CodePostal")%>' SkinID="tbSkin" Width="80px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvnCodePostal" runat="server" ErrorMessage="Le code postal doit être spécifié." 
                            ControlToValidate="tbCodePostal" Display="Dynamic" ForeColor="Red" ValidationGroup="Edit">*
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="reCodePostal" runat="server" ErrorMessage="Le code postal n'est pas du bon format(X#X#X#)" 
                            ControlToValidate="tbCodePostal" ForeColor="Red" Display="Dynamic" ValidationGroup="Edit"
                            ValidationExpression="^[ABCEGHJKLMNPRSTVXYabceghjklmnprstvxy]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvwxyz]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvwxyz]{1}\d{1}$" >*
                        </asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:TextBox ID="tbVille" runat="server" Text='<%#Bind("Ville")%>' SkinID="tbSkin" Width="80px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvVille" ForeColor="Red" runat="server" ValidationGroup="Edit"
                            ErrorMessage="La ville doit être spécifiée." ControlToValidate="tbVille" Display="Dynamic">*
                        </asp:RequiredFieldValidator>
                    </td>
                    <td class="tdDroite">
                        <asp:DropDownList ID="dDListProvince" runat="server" SkinID="dDListFormulaire" 
                            DataSourceID="entiDataSourceProvince" DataTextField="Nom" Width="80px" 
                            DataValueField="noProvince"  SelectedValue='<%#Bind("Province_noProvince")%>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="tdDroite tdGauche">
                        <asp:Label ID="lbTitreAdresse" runat="server" Text="Adresse" SkinID="lbChampsFormulaire"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="tdGauche tdBas">
                        <asp:TextBox ID="tbAdresse" runat="server" Text='<%#Bind("Adresse")%>' SkinID="tbSkin" Width="200px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="requisValidationAdresse" ForeColor="Red" runat="server" ValidationGroup="Edit"
                            ErrorMessage="L'adresse doit être spécifiée." ControlToValidate="tbAdresse" Display="Dynamic">*
                        </asp:RequiredFieldValidator>
                    </td>
                    <td colspan="2" class="tdDroite tdBas" style="text-align:right;">
                        <asp:Button ID="btnUpdate" runat="server" Text="Enregistrer" CommandName="Update" ValidationGroup="Edit" SkinID="btnAjoutSupprimer" />
                        <asp:Button ID="btnCancel" runat="server" Text="Annuler" CausesValidation="false" CommandName="Cancel" SkinID="btnAjoutSupprimer" />
                    </td>
                </tr>
                <tr style="height:25px;"></tr>
            </EditItemTemplate>
            <InsertItemTemplate>
                <tr style="height:25px;"></tr>
                <tr class="trInsert">
                    <td class="tdTop tdGauche"><asp:Label ID="lbTitrePrenom" runat="server" Text="Prénom" SkinID="lbChampsFormulaire" Width="100px"></asp:Label></td>
                    <td class="tdTop"><asp:Label ID="lbTitreNom" runat="server" Text="Nom" SkinID="lbChampsFormulaire"  Width="120px"></asp:Label></td>
                    <td colspan="2" class="tdTop tdDroite"><asp:Label ID="lbTitreDatenaissance" runat="server" Text="Date de naissance" SkinID="lbChampsFormulaire"  Width="160px"></asp:Label></td> 
                </tr>
                <tr class="trInsert">
                    <td class="tdGauche">
                        <asp:TextBox ID="tbPrenom" runat="server" Text='<%#Bind("Prenom")%>' SkinID="tbSkin" Width="80px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPrenom" ForeColor="Red" runat="server" Display="Dynamic"
                            ErrorMessage="Le prénom doit être spécifié." ControlToValidate="tbPrenom" ValidationGroup="Insert">*
                        </asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <asp:TextBox ID="tbNom" runat="server" Text='<%#Bind("Nom")%>' SkinID="tbSkin"  Width="80px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNom" ForeColor="Red" runat="server" ValidationGroup="Insert"
                            ControlToValidate="tbNom" Display="Dynamic" ErrorMessage="Le nom doit être spécifié." >*
                        </asp:RequiredFieldValidator>
                    </td>
                    <td colspan="2" class="tdDroite">
                        <asp:TextBox ID="tbDateNaissance" runat="server" Text='<%#Bind("DateNaissance", "{0:dd/MM/yyyy}")%>' SkinID="tbSkin"  Width="120px"></asp:TextBox>
                        <asp:ImageButton ID="imgBtnCalendrier" ImageUrl="~/App_Themes/Default/images/btnCalendrier.png" runat="server" CausesValidation="false" />
                        <asp:CalendarExtender ID="calendarExtenderDateNaissance" runat="server" TargetControlID="tbDateNaissance" 
                            PopupButtonID="imgBtnCalendrier" CssClass="MyCalendar" PopupPosition="Right" Format="d-MM-yyyy" >
                        </asp:CalendarExtender>
                        <asp:RequiredFieldValidator ID="rfvDateNaissance" ForeColor="Red" runat="server" Display="Dynamic"
                            ErrorMessage="La date de naissance doit être spécifiée." ControlToValidate="tbDateNaissance" ValidationGroup="Insert">*
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvDateNaissance" runat="server" Type="Date" ControlToValidate="tbDateNaissance"
                            ErrorMessage="La date de naissance n'est pas du bon format (jj-mm-aaaa)" ForeColor="Red" 
                            Operator="DataTypeCheck" Display="Dynamic" ValidationGroup="Insert">*
                        </asp:CompareValidator>
                    </td>
                </tr>
                <tr class="trInsert">
                    <td class="tdGauche"><asp:Label ID="lbTitreNoTelephone" runat="server" Text="Téléphone" SkinID="lbChampsFormulaire"  Width="120px"></asp:Label></td>
                    <td><asp:Label ID="lbTitreCodePostal" runat="server" Text="CodePostal" SkinID="lbChampsFormulaire"></asp:Label></td>
                    <td><asp:Label ID="lbTitreVille" runat="server" Text="Ville" SkinID="lbChampsFormulaire"></asp:Label></td>
                    <td class="tdDroite"><asp:Label ID="lbTitreProvince" runat="server" Text="Province" SkinID="lbChampsFormulaire"></asp:Label></td>
                </tr>
                <tr class="trInsert">
                    <td class="tdGauche">
                        <asp:TextBox ID="tbNoTelephone" runat="server" Text='<%#Bind("noTelephone")%>' SkinID="tbSkin"  Width="80px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNoTelephone" runat="server" ControlToValidate="tbNoTelephone" ValidationGroup="Insert"
                            ErrorMessage="Le numéro de téléphone doit être spécifié." Display="Dynamic" ForeColor="Red">*
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="reNoTelephone" runat="server" ControlToValidate="tbNoTelephone"
                            ErrorMessage="Le numéro de téléphone ne peut comporter que des chiffres (4502473882)." 
                            ValidationExpression="^[0-9]{10}$" ForeColor="Red" Display="Dynamic" ValidationGroup="Insert">*
                        </asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:TextBox ID="tbCodePostal" runat="server" Text='<%#Bind("CodePostal")%>' SkinID="tbSkin" Width="80px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvnCodePostal" runat="server" ErrorMessage="Le code postal doit être spécifié." 
                            ControlToValidate="tbCodePostal" Display="Dynamic" ForeColor="Red" ValidationGroup="Insert">*
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="reCodePostal" runat="server" ErrorMessage="Le code postal n'est pas du bon format(X#X#X#)" 
                            ControlToValidate="tbCodePostal" ForeColor="Red" Display="Dynamic" ValidationGroup="Insert"
                            ValidationExpression="^[ABCEGHJKLMNPRSTVXYabceghjklmnprstvxy]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvwxyz]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvwxyz]{1}\d{1}$" >*
                        </asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:TextBox ID="tbVille" runat="server" Text='<%#Bind("Ville")%>' SkinID="tbSkin" Width="80px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="requisValidationVille" ForeColor="Red" runat="server" ValidationGroup="Insert"
                            ErrorMessage="La ville doit être spécifiée." ControlToValidate="tbVille" Display="Dynamic">*
                        </asp:RequiredFieldValidator>
                    </td>
                    <td class="tdDroite">
                        <asp:DropDownList ID="dDListProvince" runat="server" SkinID="dDListFormulaire" 
                            DataSourceID="entiDataSourceProvince" DataTextField="Nom" Width="80px" 
                            DataValueField="noProvince" ValidationGroup="Insert" SelectedValue='<%#Bind("Province_noProvince")%>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr class="trInsert">
                    <td colspan="4" class="tdDroite tdGauche">
                        <asp:Label ID="lbTitreAdresse" runat="server" Text="Adresse" SkinID="lbChampsFormulaire"></asp:Label>
                    </td>
                </tr>
                <tr class="trInsert">
                    <td colspan="2" class="tdGauche tdBas">
                        <asp:TextBox ID="tbAdresse" runat="server" Text='<%#Bind("Adresse")%>' SkinID="tbSkin" Width="200px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="requisValidationAdresse" ForeColor="Red" runat="server" ValidationGroup="Insert"
                            ErrorMessage="L'adresse doit être spécifiée." ControlToValidate="tbAdresse" Display="Dynamic">*
                        </asp:RequiredFieldValidator>
                    </td>
                    <td colspan="2" class="tdDroite tdBas" style="text-align:right;">
                        <asp:Button ID="btnInsert" runat="server" Text="Ajouter" CommandName="Insert" ValidationGroup="Insert" SkinID="btnAjoutSupprimer" />
                    </td>
                </tr>
            </InsertItemTemplate>
        </asp:ListView>
                <asp:DataPager ID="DataPagerGererAnimateurs" runat="server" PagedControlID="lViewAnimateurs">
            <Fields>
                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                    ShowLastPageButton="True" FirstPageText="Premier" LastPageText="Dernier" 
                    NextPageText="Suivant" PreviousPageText="Précédent" ButtonCssClass="boutonMenuPager"/>
            </Fields>
        </asp:DataPager>
        </asp:View>
            <asp:View ID="viewSpecialites" runat="server">
            <asp:Label ID="lbSousTitreSpecialites" runat="server" Text="Spécialités de " SkinID="lbSousTitre"></asp:Label><br />
                <asp:ListView ID="lViewSpecialites" runat="server" DataSourceID="entiDataSourceSpecialites" DataKeyNames="Id" InsertItemPosition="LastItem">
                    <LayoutTemplate>
                    <table id="tbListeAttente">
                        <tr>
                            <th><asp:Label ID="lbTitreNoSpecialite" runat="server" Text="Numéro"></asp:Label></th>
                            <th><asp:Label ID="lbTitreNom" runat="server" Text="Nom"></asp:Label></th>
                        </tr>
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                    </table>
                    <asp:ValidationSummary ID="vSummaryInsert" runat="server" ValidationGroup="Insert" CssClass="validationSummary" Height="50px" />
                    <asp:ValidationSummary ID="vSummaryEdit" runat="server" ValidationGroup="Edit" CssClass="validationSummary" Height="50px" />  
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><asp:Label ID="lbNoSpecialite" runat="server" Text='<%#Eval("Specialite.noSpecialite")%>'></asp:Label></td>
                            <td><asp:Label ID="lbNom" runat="server" Text='<%#Eval("Specialite.nomSpecialite")%>'></asp:Label></td>
                            <td><asp:Button ID="btnSupprimer" runat="server" Text="Supprimer" CommandName="Delete" SkinID="btnAjoutSupprimer" Width="78px"/></td>
                        </tr>
                    </ItemTemplate>
                    <InsertItemTemplate>
                        <tr>
                            <td><asp:HiddenField ID="hFieldNoAnimateur" runat="server" Value='<%#Bind("Animateur_noAnimateur")%>'></asp:HiddenField></td>
                            <td>
                                <asp:DropDownList ID="dDListSpecialiteInsert" runat="server" 
                                SkinID="dDListFormulaire" DataSourceID="entiDataSourceSpecialite" 
                                DataTextField="nomSpecialite" DataValueField="noSpecialite"  SelectedValue='<%#Bind("Specialite_noSpecialite")%>'></asp:DropDownList>
                            </td>
                            <td><asp:Button ID="btnInsert" runat="server" Text="Ajouter" ValidationGroup="Insert" CommandName="Insert" SkinID="btnAjoutSupprimer" Width="78px" /></td>
                        </tr>
                    </InsertItemTemplate>
                </asp:ListView>
                <asp:DataPager ID="DataPagerGererAnimateur" runat="server" PagedControlID="lViewSpecialites">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                            ShowLastPageButton="True" FirstPageText="Premier" LastPageText="Dernier" 
                            NextPageText="Suivant" PreviousPageText="Précédent" ButtonCssClass="boutonMenuPager"/>
                    </Fields>
                </asp:DataPager>
        </asp:View>
        </asp:MultiView>
        <br /><asp:Label  ID="lbMessage" runat="server" Text=""></asp:Label>
    </div>
    <asp:HiddenField ID="hFieldNoAnimateur" runat="server" />
    <asp:EntityDataSource ID="entiDataSourceAnimateurs" runat="server" 
    ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" Where='(it.Nom + it.[Prenom] + it.Ville + it.[noTelephone] like "%"+@recherche+"%" OR (@recherche = ""))'
    EnableFlattening="False" EntitySetName="Animateur" EnableDelete="true" EnableUpdate="true" EnableInsert="true" Include="Province">
    <WhereParameters>
            <asp:ControlParameter Name="recherche" Type="String" ControlID="txtRechercher" ConvertEmptyStringToNull="false" />
    </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entiDataSourceProvince" runat="server" 
    ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
    EnableFlattening="False" EntitySetName="Province">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entiDataSourceSpecialite" runat="server" 
    ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
    EnableFlattening="False" EntitySetName="Spécialité">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entiDataSourceSpecialites" runat="server" 
    ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" EnableInsert="true" EnableDelete="true"
    EnableFlattening="False" EntitySetName="SpécialitéAnimateur" Where="it.Animateur_noAnimateur = @leNoAnimateur" Include="Specialite" >
        <WhereParameters>
            <asp:ControlParameter ConvertEmptyStringToNull="false" ControlID="hFieldNoAnimateur" Name="leNoAnimateur" Type="Int32" />
        </WhereParameters>
    </asp:EntityDataSource>
    </asp:Content>