<%@ Page Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false" CodeFile="compteClient.aspx.vb" Inherits="monCompteClient" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

<asp:Content ID="contentAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>

<asp:Content ID="contentClient" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="contentRight">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="Server" />   
    <asp:MultiView ID="multiViewMembre" runat="server" ActiveViewIndex="0">
    <asp:View ID="viewMembres" runat="server">
        <asp:Label skinid="lbTitrePage" ID="lbListeMembre" runat="server" Text="Liste des membres de ce compte."></asp:Label><br /><br />
        <asp:ListView ID="listViewMembres" runat="server" DataSourceID="entiDataSourceMembre" DataKeyNames="noMembre" >
            <LayoutTemplate>
                <table>
                    <tr>
                        <td class="itemTemplate">
                            <asp:Label SkinID="lbTitreInfoMembre" ID="lbNomPrenom" runat="server" Text="Nom:"></asp:Label>
                        </td>
                        <td class="itemTemplate" >
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
                        <asp:Label SkinID="lbInfoMembre" id="lbNomMembre" runat="server" Text='<%#Eval("Prénom") &" " & Eval("Nom") %>'></asp:Label>
                    </td>
                    <td style="width:200px;">
                        <asp:Label SkinID="lbInfoMembre" id="tbDateNaissance" runat="server" Text='<%#Eval("DateNaissance", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </td>
                     <td>
                        <asp:Button SkinID="btnAjoutSupprimer" ID="btnSupprimer" runat="server" Text="Supprimer" CommandArgument='<%#Eval("noMembre") %>' CommandName="supprime"/>               
                    </td>  
                </tr>
            </ItemTemplate>         
        </asp:ListView>
        <asp:Button SkinID="btnAjoutSupprimer" ID="btnAjouter" runat="server" Text="Ajouter" Width="80px"/><br />
        <asp:Label ID="lbErreur" runat="server" Text="" Font-Size="18px" ForeColor="Red"></asp:Label>
    </asp:View>
    
    <asp:View ID="viewAjoutMembre" runat="server">    
    <asp:Label skinid="lbTitrePage" ID="lbTitreAjout" runat="server" Text="Ajouter un membre au compte."></asp:Label><br /><br />
    <asp:ListView ID="listViewAjoutMembre" runat="server" DataSourceID="entiDataSourceAjouterMembre" DataKeyNames="noMembre" EditIndex="0">
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
                            <asp:TextBox SkinID="tbInscription" id="tbPrenomMembre" runat="server" Text='<%#Bind("Prénom") %>'></asp:TextBox>
                            <asp:CompareValidator ID="compareValidatorPrenom" runat="server" ValidationGroup="A" controlToValidate="tbPrenomMembre" ErrorMessage="Veuillez entrer un prénom différent de Entrez un prénom" 
                            ValueToCompare="Entrez un prénom" Display="Dynamic" Operator="NotEqual" ForeColor="Red">*</asp:CompareValidator>
                        </td>
                        <td class="itemTemplate">
                            <asp:Label SkinID="lbTitreInfoMembre" id="lbNom" runat="server" Text="Nom:"></asp:Label>
                            <asp:RequiredFieldValidator SkinID="requisValidation" Display="Dynamic" ID="requisValidationNom" ControlToValidate="tbNomMembre" runat="server" 
                             ValidatlToValidate="tbNomMembre" ErrorMessage="Veuillez entrer un nom" 
                              ForeColor="Red">*</asp:RequiredFieldValidator>
                            <asp:TextBox SkinID="tbInscription" id="tbNomMembre" runat="server" Text='<%#Bind("Nom") %>'></asp:TextBox>
                            <asp:CompareValidator ID="compareValidationNom" runat="server" ValidationGroup="A" controlToValidate="tbNomMembre" ErrorMessage="Veuillez entrer un nom différent de Entrez un nom" 
                            ValueToCompare="Entrez un nom" Display="Dynamic" Operator="NotEqual" ForeColor="Red">*</asp:CompareValidator>
                        </td>  
                    <tr>                      
                        <td style="width:200px;">
                            <asp:CalendarExtender ID="calendarExtenderDateNaissance" runat="server" TargetControlID="tbDateNaissance" PopupButtonID="imgBtnCalendrier" 
                                    CssClass="MyCalendar" PopupPosition="Right" Format="d/MM/yyyy">
                            </asp:CalendarExtender>                           
                            <asp:Label SkinID="lbTitreInfoMembre" id="lbDate" runat="server" Text="Date de naissance:"></asp:Label>
                            <asp:textbox SkinID="tbinscription" id="tbDateNaissance" runat="server" Text='<%#Bind("DateNaissance" , "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                            <asp:RegularExpressionValidator ID="reguExpressionDateNaissance" runat="server" ErrorMessage="Votre date de naissance n'est pas du bon format (jj/mm/yyyy)" ControlToValidate="tbDateNaissance" 
                                ValidationExpression="(0[0-9]|[012][0-9]|[3][01])[/]([0-9]|[0][123456789]|[1][012])[/][0-9][0-9][0-9][0-9]$" forecolor="Red" Display="Dynamic" ValidationGroup="A">*</asp:RegularExpressionValidator>
                            <asp:ImageButton ID="imgBtnCalendrier" ImageUrl="~/App_Themes/Default/images/btnCalendrier.png" runat="server" CausesValidation="false" />                          
                            <asp:RequiredFieldValidator SkinID="requisValidation" 
                                ID="requisValidationDateNaissance" runat="server" 
                                ErrorMessage="Votre date de naissance doit être spécifié." 
                                ControlToValidate="tbDateNaissance" Display="Dynamic" ValidationGroup="A">*</asp:RequiredFieldValidator>
                        </td>
                     </tr>
                     <tr>
                        <td>
                            <asp:Button SkinID="btnConfirmation" ID="btnEnregistrer" runat="server" Text="Enregistrer" CommandName="Update" ValidationGroup="A" />
                            <asp:Button SkinID="btnConfirmation" ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel" ValidationGroup="B" />
                        </td>                  
                     </tr>                        
                </tr>
            </EditItemTemplate>                    
        </asp:ListView>
        <asp:HiddenField ID="hiddenFieldNoMembre" Visible="false" Value="" runat="server" />
                            <asp:ValidationSummary SkinID="valiSummary" ID="validationSummaryMembre" runat="server" ValidationGroup="A" />

    </asp:View>
    </asp:MultiView>
</div>
<asp:EntityDataSource ID="entiDataSourceCompte" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="CompteSet">
</asp:EntityDataSource>

<asp:EntityDataSource ID="entiDataSourceAjouterMembre" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="MembreSet" Where="it.noMembre = @noMembre" Include="Compte" EnableUpdate="true">      
        <WhereParameters>
            <asp:ControlParameter Name="noMembre" Type="Int32" ControlID="hiddenFieldNoMembre" />
        </WhereParameters>
</asp:EntityDataSource>

<asp:EntityDataSource ID="entiDataSourceMembre" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="MembreSet" Where="it.Compte.noCompte = @noCompte" Include="Compte" >
        <WhereParameters>
            <asp:SessionParameter Name="noCompte" Type="Int32" SessionField="noCompte" />
        </WhereParameters>
    </asp:EntityDataSource>

</asp:Content>


