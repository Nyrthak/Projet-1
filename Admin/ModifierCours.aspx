<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="ModifierCours.aspx.vb" Inherits="Admin_ModifierCours" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">    
    <asp:ListView ID="lViewCours" runat="server" DataSourceID="EntityDataSourceCours" DataKeyNames="noCours" EditIndex="0">   
        <LayoutTemplate> 
            <asp:Label ID="lblTitreModifierCours" runat="server" Text="Gérer les cours" SkinID="lbTitrePage"></asp:Label>
            <asp:ValidationSummary ID="ValidationSummaryModifierCours" runat="server" CssClass="validationSummary" Height="50px" />
            <table>
                <asp:PlaceHolder id="ItemPlaceHolder"  runat="server" />
            </table>
        </LayoutTemplate>
        <ItemTemplate></ItemTemplate>
        <EditItemTemplate>
            <tr>            
                <td><asp:Label ID="lblNomDuCours" runat="server" Text="Nom du cours" SkinID="lbChampsFormulaire"></asp:Label></td>
                <td><asp:Label ID="lblPrix" runat="server" Text="Prix" SkinID="lbChampsFormulaire"></asp:Label></td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtNomDuCours" runat="server" SkinID="TextBoxFormulaire" Text='<%#Bind("Nom")%>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNomDuCours" runat="server" ErrorMessage="Le nom du cours est requis." ControlToValidate="txtNomDuCours" Text="*" />
                </td>
                <td>
                    <asp:TextBox ID="txtPrix" runat="server" SkinID="TextBoxFormulaire" Text='<%#Bind("Prix")%>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPrix" runat="server" ErrorMessage="Le prix est requis." ControlToValidate="txtPrix" Text="*" />
                    <asp:CompareValidator ID="cvPrix" runat="server" ErrorMessage="Le prix doit être écrit sous le format 0,00" ControlToValidate="txtPrix" Type="Double" Text="*" Operator="DataTypeCheck" />
                </td> 
                <td></td>          
            </tr>
            <tr>
                <td><asp:Label ID="lblGroupeDAge" runat="server" Text="Groupe d'âge" SkinID="lbChampsFormulaire"></asp:Label></td>
                <td><asp:Label ID="lblSession" runat="server" Text="Session" SkinID="lbChampsFormulaire"></asp:Label></td>
                <td><asp:Label ID="lblCategorie" runat="server" Text="Catégorie" SkinID="lbChampsFormulaire"></asp:Label></td>
            </tr>
            <tr>
                <td><asp:DropDownList ID="dDListGroupeDAge" runat="server" 
                        SkinID="dDListFormulaire" DataSourceID="EntityDataSourceGroupeDAge" 
                        DataTextField="NomGroupeDAge" DataValueField="noGroupeDAge"  SelectedValue='<%#Bind("GroupeDAge.noGroupeDAge")%>'></asp:DropDownList></td>
                <td><asp:DropDownList ID="dDListSession" runat="server" SkinID="dDListFormulaire" 
                        DataSourceID="EntityDataSourceSession" DataTextField="NomSession" 
                        DataValueField="noSession"  SelectedValue='<%#Bind("Session.noSession")%>'></asp:DropDownList></td>
                <td><asp:DropDownList ID="dDListCategorie" runat="server" SkinID="dDListFormulaire" 
                        DataSourceID="EntityDataSourceCategorie" DataTextField="Nom" 
                        DataValueField="noCatégorie" SelectedValue='<%#Bind("Catégorie.noCatégorie")%>'></asp:DropDownList></td>
            </tr>
            <tr>
                <td><asp:Label ID="lblPrerequis" runat="server" Text="Prérequis" SkinID="lbChampsFormulaire"></asp:Label></td>
                <td colspan="2"><asp:Label ID="lblDescription" runat="server" Text="Description" SkinID="lbChampsFormulaire"></asp:Label></td>
            </tr>
            <tr>
                <td><asp:DropDownList ID="dDListPrerequis" runat="server" SkinID="dDListFormulaire" AppendDataBoundItems="true" 
                        DataSourceID="EntityDataSourcePrerequis" DataTextField="Nom" DataValueField="noCours" SelectedValue='<%#Bind("noCoursRequis")%>'>
                      <asp:ListItem Text="Aucun" Value="0"></asp:ListItem>
                    </asp:DropDownList></td>
                <td colspan="2"><asp:TextBox ID="txtDescription" runat="server" SkinID="TextBoxDescription" TextMode="MultiLine" Text='<%#Bind("Description")%>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnUpdateCours" runat="server" SkinID="btnConfirmation" Text="Enregistrer" CommandName="Update" PostBackUrl="~/Admin/GérerLesCours.aspx" />
                    <asp:Button ID="btnCancel" runat="server" Text="Annuler" SkinID="btnConfirmation" CommandName="Annuler" />
                </td>
            </tr>
        </EditItemTemplate>
    </asp:ListView>
        <asp:EntityDataSource ID="EntityDataSourceGroupeDAge" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EnableFlattening="False" EntitySetName="GroupeDAgeSet">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EntityDataSourceSession" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EnableFlattening="False" EntitySetName="SessionSet">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EntityDataSourceCategorie" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EnableFlattening="False" EntitySetName="CatégorieSet">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EntityDataSourcePrerequis" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="CoursSet" Select="it.[noCours], it.[Nom]">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EntityDataSourceCours" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EnableDelete="True" EnableUpdate="True" EntitySetName="CoursSet"
        Where="it.noCours = @noCours" Include="Catégorie, Session, GroupeDAge">
        <WhereParameters>
            <asp:QueryStringParameter Name="noCours" type="Int32" QueryStringField="noCours" />
        </WhereParameters>
    </asp:EntityDataSource>
</asp:Content>
