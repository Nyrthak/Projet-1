<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="GererForfaits.aspx.vb" Inherits="Admin_GererForfaits" %>

<asp:Content ID="ContentCours" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="contentRight">
        <asp:Label ID="lblTitreForfaits" runat="server" Text="Gérer les forfaits" SkinID="lbTitrePage"></asp:Label><br />
        <asp:ListView ID="lViewForfaits" runat="server" DataSourceID="entiDataSourceForfaits" DataKeyNames="nbInscrits" InsertItemPosition="LastItem">
            <LayoutTemplate>
            <table id="tbListeAttente">
                <tr>
                    <th><asp:Label ID="lbTitreNbInscrits" runat="server" Text="Nombre d'inscrits"></asp:Label></th>
                    <th><asp:Label ID="lbCout" runat="server" Text="Coût"></asp:Label></th>
                </tr>
                <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
            </table>
            <asp:ValidationSummary ID="vSummaryInsert" runat="server" ValidationGroup="Insert" CssClass="validationSummary" Height="50px" />
            <asp:ValidationSummary ID="vSummaryEdit" runat="server" ValidationGroup="Edit" CssClass="validationSummary" Height="50px" />  
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td><asp:Label ID="lbNbInscrits" runat="server" Text='<%#Eval("nbInscrits")%>'></asp:Label></td>
                    <td><asp:Label ID="lbCout" runat="server" Text='<%#Eval("Cout","{0:#%}")%>'></asp:Label></td>
                    <td><asp:Button ID="btnModifier" runat="server" Text="Modifier" CommandName="Edit" SkinID="btnAjoutSupprimer" Width="78px" /></td>
                    <td><asp:Button ID="btnSupprimer" runat="server" Text="Supprimer" CommandName="Delete" SkinID="btnAjoutSupprimer"/></td>
                </tr>
            </ItemTemplate>
            <EditItemTemplate>
                <tr>
                    <td><asp:Label ID="lbNbInscrits" runat="server" Text='<%#Bind("nbInscrits")%>'></asp:Label></td>
                    <td>
                        <asp:TextBox ID="tbCout" runat="server" Text='<%#Bind("Cout")%>' SkinID="tbSkin" Width="80px"></asp:TextBox>
                        <asp:CompareValidator ID="cvCout" runat="server" ErrorMessage="Le cout doit être écrit sous le format 0,00" ControlToValidate="tbCout" Type="Double" Text="*" Operator="DataTypeCheck" ForeColor="Red" Display="Dynamic" ValidationGroup="Edit" />
                        <asp:RequiredFieldValidator ForeColor="Red" ValidationGroup="Edit"
                                    ID="rfvCout" runat="server" ErrorMessage="Le coût doit être spécifié." 
                                    ControlToValidate="tbCout" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
                    <td><asp:Button ID="btnUpdate" runat="server" Text="Enregistrer" CommandName="Update" ValidationGroup="Edit" SkinID="btnAjoutSupprimer"/></td>
                    <td><asp:Button ID="btnAnnuler" runat="server" Text="Annuler" CommandName="Cancel" SkinID="btnAjoutSupprimer" Width="75px" /></td>
                </tr>
            </EditItemTemplate>
            <InsertItemTemplate>
                <tr style="padding-top:20px;">
                    <td>
                        <asp:TextBox ID="tbNbInscrits" runat="server" Text='<%#Bind("nbInscrits")%>'  SkinID="tbSkin" Width="30px" MaxLength="2"></asp:TextBox>
                        <asp:CustomValidator ID="customVNbInscrits" runat="server" ValidationGroup="Insert" ErrorMessage="Vous ne pouvez renseigner plusieurs fois le même forfait."
                            ControlToValidate="tbNbInscrits" Display="Dynamic" ForeColor="Red" OnServerValidate="customV_NbInscrits">*</asp:CustomValidator>
                        <asp:RequiredFieldValidator ForeColor="Red" ValidationGroup="Insert"
                                    ID="rfvNbInscrits" runat="server" ErrorMessage="Le nombre d'inscrits doit être spécifié." 
                                    ControlToValidate="tbNbInscrits" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <asp:TextBox ID="tbCout" runat="server" Text='<%#Bind("Cout")%>' SkinID="tbSkin" Width="80px"></asp:TextBox>
                        <asp:CompareValidator ID="cvCout" runat="server" ValidationGroup="Insert" ErrorMessage="Le cout doit être écrit sous le format 0,00" ControlToValidate="tbCout" Type="Double" Text="*" Operator="DataTypeCheck"  ForeColor="Red" Display="Dynamic" />
                        <asp:RequiredFieldValidator ForeColor="Red" ValidationGroup="Insert"
                                    ID="rfvCout" runat="server" ErrorMessage="Le coût doit être spécifié." 
                                    ControlToValidate="tbCout" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </td>
                    <td><asp:Button ID="btnInsert" runat="server" Text="Ajouter" CommandName="Insert" ValidationGroup="Insert" SkinID="btnAjoutSupprimer" Width="78px" /></td>
                </tr>
            </InsertItemTemplate>
        </asp:ListView>
        <asp:DataPager ID="DataPagerGererForfaits" runat="server" PagedControlID="lViewForfaits">
            <Fields>
                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                    ShowLastPageButton="True" FirstPageText="Premier" LastPageText="Dernier" 
                    NextPageText="Suivant" PreviousPageText="Précédent" ButtonCssClass="boutonMenuPager"/>
            </Fields>
        </asp:DataPager>
        <br /><asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
    </div>
    <asp:EntityDataSource ID="entiDataSourceForfaits" runat="server" 
    ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
    EnableFlattening="False" EntitySetName="Forfait" EnableDelete="true" EnableUpdate="true" EnableInsert="true">
    </asp:EntityDataSource>
</asp:Content>