<%@ Page Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false" CodeFile="compteClient.aspx.vb" Inherits="CompteClient" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

<asp:Content ID="contentAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="contentRight">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="Server" />   
    <asp:MultiView ID="multiViewMembre" runat="server" ActiveViewIndex="0">
    <asp:View ID="viewMembres" runat="server">
        <asp:Label skinid="lbTitrePage" ID="lbListeMembre" runat="server" Text="Liste des membres de ce compte."></asp:Label><br /><br />
        <asp:ListView ID="listViewMembres" runat="server" DataSourceID="entiDataSourceMembre" DataKeyNames="noMembre" >
            <LayoutTemplate>
                <table>
                    <tr>
                        <td class="itemTemplate" style="width:250px" >
                            <asp:Label SkinID="lbTitreInfoMembre" ID="lbNomPrenom" runat="server" Text="Nom:"></asp:Label>
                        </td>
                        <td class="itemTemplate">
                            <asp:Label SkinID="lbTitreInfoMembre" id="lbDate" runat="server" Text="Date de naissance:"></asp:Label>
                        </td>
                        <td>

                        </td>
                    </tr>
                    <asp:PlaceHolder runat="server" ID="GroupPlaceHolder"></asp:PlaceHolder>
                </table>
            </LayoutTemplate>
            <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
            <ItemTemplate>
                <tr>
                    <td id="itemTemplate">
                        <asp:Label SkinID="lbInfoMembre" id="lbNomMembre" runat="server" Text='<%#Eval("Prenom") &" " & Eval("Nom") %>'></asp:Label>
                    </td>
                    <td style="width:200px;">
                        <asp:Label SkinID="lbInfoMembre" id="tbDateNaissance" runat="server" Text='<%#Eval("DateNaissance", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </td>
                </tr>
            </ItemTemplate>         
        </asp:ListView>
        <asp:Button SkinID="btnAjoutSupprimer" ID="btnAjouter" runat="server" Text="Ajouter" Width="80px"/><br />
        <asp:Label ID="lbErreur" runat="server" Text="" Font-Size="18px" ForeColor="Red"></asp:Label>
    </asp:View> 
    <asp:View ID="viewAjoutMembre" runat="server">    
    <asp:Label skinid="lbTitrePage" ID="lbTitreAjout" runat="server" Text="Ajouter un membre au compte."></asp:Label><br /><br />
    <asp:ListView ID="lViewAjoutMembre" runat="server" DataSourceID="entiDataSourceAjouterMembre" DataKeyNames="noMembre" EditIndex="0">
            <LayoutTemplate>
                <table>
                    <asp:PlaceHolder runat="server" ID="GroupPlaceHolder"></asp:PlaceHolder>
                </table>
            </LayoutTemplate>
            <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
            <ItemTemplate></ItemTemplate>
            <EditItemTemplate>
                <tr>
                        <td class="itemTemplate">
                            <asp:Label SkinID="lbTitreInfoMembre" ID="lbPrenom" runat="server" Text="Prénom:"></asp:Label>
                            <asp:RequiredFieldValidator SkinID="requisValidation" Display="Dynamic" ID="RequiredFieldValidator1" ControlToValidate="tbNomMembre" runat="server" 
                                ErrorMessage="Veuillez entrer un nom" ValidatlToValidate="tbPrenomMembre" ForeColor="Red">*</asp:RequiredFieldValidator>
                            <asp:TextBox SkinID="tbInscription" id="tbPrenomMembre" Width="150px" runat="server" Text='<%#Bind("Prenom") %>'></asp:TextBox>
                            <asp:CompareValidator ID="compareValidatorPrenom" runat="server" ValidationGroup="A" controlToValidate="tbPrenomMembre" ErrorMessage="Veuillez entrer un prénom différent de Entrez un prénom" 
                            ValueToCompare="Entrez un prénom" Display="Dynamic" Operator="NotEqual" ForeColor="Red">*</asp:CompareValidator>
                        </td>
                        <td class="itemTemplate">
                            <asp:Label SkinID="lbTitreInfoMembre" id="lbNom" runat="server" Text="Nom:"></asp:Label>
                            <asp:RequiredFieldValidator SkinID="requisValidation" Display="Dynamic" ID="requisValidationNom" ControlToValidate="tbNomMembre" runat="server" 
                             ValidatlToValidate="tbNomMembre" ErrorMessage="Veuillez entrer un nom" 
                              ForeColor="Red">*</asp:RequiredFieldValidator>
                            <asp:TextBox SkinID="tbInscription" id="tbNomMembre" Width="150px" runat="server" Text='<%#Bind("Nom") %>'></asp:TextBox>
                            <asp:CompareValidator ID="compareValidationNom" runat="server" ValidationGroup="A" controlToValidate="tbNomMembre" ErrorMessage="Veuillez entrer un nom différent de Entrez un nom" 
                            ValueToCompare="Entrez un nom" Display="Dynamic" Operator="NotEqual" ForeColor="Red">*</asp:CompareValidator>
                        </td>  
                    <tr>                                   
                        <td>
                            <asp:Label SkinID="lbTitreInfoMembre" id="lbTypeMembre" runat="server" Text="Type de membre:"></asp:Label>
                             <asp:RequiredFieldValidator SkinID="requisValidation" ID="requisTypeMembre" runat="server" 
                                ErrorMessage="Le type du membre doit être spécifié." ValidationGroup="A" ControlToValidate="rbListeTypeMembre" 
                                Display="Dynamic" >*</asp:RequiredFieldValidator>
                            <asp:RadioButtonList ID="rbListeTypeMembre" runat="server" CellSpacing="10" RepeatDirection="Horizontal" SelectedValue='<%# Bind("Parent") %>'>
                                <asp:ListItem Value="True">Parent</asp:ListItem>
                                <asp:ListItem Value="False">Enfant</asp:ListItem>
                            </asp:RadioButtonList>
                           
                            <asp:Label SkinID="lbChampsFormulaire" id="maxParent" runat="server" Text="Maximum de deux parents par compte."></asp:Label>
                        </td>
                        <td style="width:230px;">
                            <asp:CalendarExtender ID="calendarExtenderDateNaissance" runat="server" TargetControlID="tbDateNaissance" PopupButtonID="imgBtnCalendrier" 
                                    CssClass="MyCalendar" PopupPosition="Right" Format="d-MM-yyyy">
                            </asp:CalendarExtender>                           
                            <asp:Label SkinID="lbTitreInfoMembre" id="lbDate" runat="server" Text="Date de naissance:"></asp:Label>
                            <asp:textbox SkinID="tbinscription" Width="100px" id="tbDateNaissance" runat="server" Text='<%#Bind("DateNaissance" , "{0:dd-MM-yyyy}") %>' ToolTip="JJ-MM-AAAA"></asp:TextBox>
                            <asp:ImageButton ID="imgBtnCalendrier" ImageUrl="~/App_Themes/Default/images/btnCalendrier.png" runat="server" CausesValidation="false" />
                            <asp:CompareValidator runat="server" ID="test" Type="Date" ControlToValidate="tbDateNaissance" ErrorMessage="La date de naissance n'est pas du bon format (jj-mm-aaaa)" ForeColor="Red" Operator="DataTypeCheck" Display="Dynamic">*</asp:CompareValidator>
                            <asp:CustomValidator ID="customVDateNaissance" runat="server" ValidationGroup="A" ErrorMessage="L'âge d'un enfant doit etre plus petit que 18 ans." OnServerValidate="custom_vDateNaissance" ControlToValidate="tbDateNaissance" ForeColor="Red" Display="Dynamic">*</asp:CustomValidator>                 
                            <asp:RequiredFieldValidator SkinID="requisValidation" 
                                ID="requisValidationDateNaissance" runat="server" 
                                ErrorMessage="Votre date de naissance doit être spécifié." 
                                ControlToValidate="tbDateNaissance" Display="Dynamic" ValidationGroup="A">*</asp:RequiredFieldValidator>           
                        </td>
                     </tr>
                     <tr>
                        <td>
                            <asp:Button SkinID="btnConfirmation" ID="btnEnregistrer" runat="server" Text="Enregistrer" CommandName="Update" CommandArgument='<%#Eval("noMembre")%>' ValidationGroup="A" />
                            <asp:Button SkinID="btnConfirmation" ID="btnCancel" runat="server" Text="Annuler" CommandName="Cancel" ValidationGroup="B" />
                        </td>                  
                     </tr>                        
                </tr>
            </EditItemTemplate>                    
        </asp:ListView>
        <asp:HiddenField ID="hiddenFieldNoMembre" Visible="false" Value="" runat="server" />
        <div style="margin-left:20px">
            <asp:ValidationSummary SkinID="valiSummary" ID="validationSummaryMembre" runat="server" ValidationGroup="A" />
        </div>
    </asp:View>
    </asp:MultiView>
    <br />
        <asp:Label ID="lbMessage" runat="server" Text=""></asp:Label> 
</div>
<asp:EntityDataSource ID="entiDataSourceAjouterMembre" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Membre" Where="it.noMembre = @noMembre" Include="Compte" EnableUpdate="true" EnableFlattening="false">      
        <WhereParameters>
            <asp:ControlParameter Name="noMembre" Type="Int32" ControlID="hiddenFieldNoMembre" />
        </WhereParameters>
</asp:EntityDataSource>

<asp:EntityDataSource ID="entiDataSourceMembre" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer"  
        EntitySetName="Membre" Where="it.Compte.noCompte = @noCompte" Include="Compte" >
        <WhereParameters>
            <asp:SessionParameter Name="noCompte" Type="Int32" SessionField="noCompte" />
        </WhereParameters>
    </asp:EntityDataSource>

</asp:Content>
