<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="GererSessions.aspx.vb" Inherits="Admin_GererSessions" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

<asp:Content ID="ContentCours" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="contentRight">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="Server" /> 
        <asp:Label ID="lblTitreSessions" runat="server" Text="Gérer les sessions" SkinID="lbTitrePage"></asp:Label><br />
        <asp:ListView ID="lViewSessions" runat="server" DataSourceID="entiDataSourceSessions" DataKeyNames="noSession" InsertItemPosition="LastItem">
            <LayoutTemplate>
            <table id="tbListeAttente">
                <tr>
                    <th><asp:Label ID="lbTitreNoSession" runat="server" Text="Numéro"></asp:Label></th>
                    <th><asp:Label ID="lbTitreNom" runat="server" Text="Nom"></asp:Label></th>
                    <th><asp:Label ID="lbTitreDebutSession" runat="server" Text="Date de début"></asp:Label></th>
                </tr>
                <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
            </table>
            <asp:ValidationSummary ID="vSummaryInsert" runat="server" ValidationGroup="Insert" CssClass="validationSummary" Height="50px" />
            <asp:ValidationSummary ID="vSummaryEdit" runat="server" ValidationGroup="Edit" CssClass="validationSummary" Height="50px" />  
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td><asp:Label ID="lbNoSession" runat="server" Text='<%#Eval("noSession")%>'></asp:Label></td>
                    <td><asp:Label ID="lbNom" runat="server" Text='<%#Eval("NomSession")%>'></asp:Label></td>
                    <td><asp:Label ID="lbDebutSession" runat="server" Text='<%#Eval("DebutSession", "{0:dd/MM/yyyy}")%>'></asp:Label></td>
                    <td><asp:Button ID="btnModifier" runat="server" Text="Modifier" CommandName="Edit" SkinID="btnAjoutSupprimer" Width="78px" /></td>
                    <td><asp:Button ID="btnSupprimer" runat="server" Text="Supprimer" CommandName="Delete" SkinID="btnAjoutSupprimer" Width="78px"/></td>
                </tr>
            </ItemTemplate>
            <EditItemTemplate>
                <tr>
                    <td><asp:Label ID="lbNoSession" runat="server" Text='<%#Eval("noSession")%>'></asp:Label></td>
                    <td>
                        <asp:TextBox ID="tbNom" runat="server" Text='<%#Bind("NomSession")%>' SkinID="tbSkin" Width="80px" MaxLength="15"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNom" ForeColor="Red" runat="server" Display="Dynamic"
                            ErrorMessage="Le nom de la session doit être spécifié." ControlToValidate="tbNom" ValidationGroup="Edit">*
                        </asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <asp:CalendarExtender ID="calendarExtenderDebut" runat="server" TargetControlID="tbDebutSession" PopupButtonID="imgBtnDebut" 
                            CssClass="MyCalendar" PopupPosition="Right" Format="d-MM-yyyy" >
                        </asp:CalendarExtender>
                        <asp:TextBox ID="tbDebutSession" runat="server" Text='<%#Bind("DebutSession", "{0:dd/MM/yyyy}")%>' ToolTip="JJ-MM-AAAA" SkinID="tbSkin" Width="90px" MaxLength="10"></asp:TextBox>
                        <asp:ImageButton ID="imgBtnDebut" ImageUrl="~/App_Themes/Default/images/btnCalendrier.png" runat="server" CausesValidation="false" />
                        <asp:RequiredFieldValidator ForeColor="Red" ValidationGroup="Edit"
                            ID="rfvDebut" runat="server" ErrorMessage="La date de début doit être spécifiée." 
                            ControlToValidate="tbDebutSession" Display="Dynamic">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator runat="server" ID="cvDebut" Type="Date" ControlToValidate="tbDebutSession"
                            ErrorMessage="La date de début n'est pas du bon format (jj-mm-aaaa)" ForeColor="Red" ValidationGroup="Edit"
                            Operator="DataTypeCheck" Display="Dynamic">*</asp:CompareValidator>
                    </td>
                    <td><asp:Button ID="btnUpdate" runat="server" Text="Enregistrer" ValidationGroup="Edit" CommandName="Update" SkinID="btnAjoutSupprimer" Width="78px" /></td>
                    <td><asp:Button ID="btnCancel" runat="server" Text="Annuler" CausesValidation="false" CommandName="Cancel" SkinID="btnAjoutSupprimer" Width="78px"/></td>
                </tr>
            </EditItemTemplate>
            <InsertItemTemplate>
                <tr>
                    <td></td>
                    <td>
                        <asp:TextBox ID="tbNom" runat="server" Text='<%#Bind("NomSession")%>' SkinID="tbSkin" Width="80px" MaxLength="15"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNom" ForeColor="Red" runat="server" Display="Dynamic"
                            ErrorMessage="Le nom de la session doit être spécifié." ControlToValidate="tbNom" ValidationGroup="Insert">*
                        </asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <asp:CalendarExtender ID="calendarExtenderDebut" runat="server" TargetControlID="tbDebutSession" PopupButtonID="imgBtnDebut" 
                            CssClass="MyCalendar" PopupPosition="Right" Format="d-MM-yyyy" >
                        </asp:CalendarExtender>
                        <asp:TextBox ID="tbDebutSession" runat="server" Text='<%#Bind("DebutSession", "{0:dd/MM/yyyy}")%>' ToolTip="JJ-MM-AAAA" SkinID="tbSkin" Width="90px" MaxLength="10"></asp:TextBox>
                        <asp:ImageButton ID="imgBtnDebut" ImageUrl="~/App_Themes/Default/images/btnCalendrier.png" runat="server" CausesValidation="false" />
                        <asp:RequiredFieldValidator ForeColor="Red" ValidationGroup="Insert"
                            ID="rfvDebut" runat="server" ErrorMessage="La date de début doit être spécifiée." 
                            ControlToValidate="tbDebutSession" Display="Dynamic">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator runat="server" ID="cvDebut" Type="Date" ControlToValidate="tbDebutSession" ValidationGroup="Insert"
                            ErrorMessage="La date de début n'est pas du bon format (jj-mm-aaaa)" ForeColor="Red"
                            Operator="DataTypeCheck" Display="Dynamic">*</asp:CompareValidator>
                    </td>
                    <td><asp:Button ID="btnInsert" runat="server" Text="Ajouter" ValidationGroup="Insert" CommandName="Insert" SkinID="btnAjoutSupprimer" Width="78px" /></td>
                </tr>
            </InsertItemTemplate>
        </asp:ListView>
        <asp:DataPager ID="DataPagerGererSession" runat="server" PagedControlID="lViewSessions">
            <Fields>
                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                    ShowLastPageButton="True" FirstPageText="Premier" LastPageText="Dernier" 
                    NextPageText="Suivant" PreviousPageText="Précédent" ButtonCssClass="boutonMenuPager"/>
            </Fields>
        </asp:DataPager>
        <br /><asp:Label ID="lbMessage" runat="server" Text=""></asp:Label>
        <asp:EntityDataSource ID="entiDataSourceSessions" runat="server" 
            ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
            EnableFlattening="False" EntitySetName="Session" EnableDelete="true" EnableUpdate="true" EnableInsert="true">
        </asp:EntityDataSource>
    </div>
</asp:Content>