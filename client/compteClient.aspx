<%@ Page Language="VB" MasterPageFile="~/masterPageClient.master" AutoEventWireup="false" CodeFile="compteClient.aspx.vb" Inherits="monCompteClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <asp:MultiView ID="multiViewMembre" runat="server" ActiveViewIndex="0">
    <asp:View ID="viewMembres" runat="server">
        <asp:Label skinid="lbTitrePage" ID="lbListeMembre" runat="server" Text="Liste des membres de ce compte."></asp:Label><br /><br />
        <asp:ListView ID="listViewMembres" runat="server" DataSourceID="entiDataSourceMembre" DataKeyNames="noMembre" >
            <LayoutTemplate>
                <table>
                    <tr>
                        <td>
                            <asp:Label SkinID="lbTitreInfoMembre" ID="lbNomPrenom" runat="server" Text="Nom:"></asp:Label>
                        </td>
                        <td >
                            <asp:Label SkinID="lbTitreInfoMembre" id="lbDate" runat="server" Text="Date de naissance:"></asp:Label>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <asp:PlaceHolder runat="server" ID="GroupPlaceHolder"></asp:PlaceHolder>
                </table>
            </LayoutTemplate>
            <GroupTemplate>
                <asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder>
            </GroupTemplate>
            <ItemTemplate>
                <tr>
                    <td id="itemTemplate">
                        <asp:Label SkinID="lbInfoMembre" id="lbNomMembre" runat="server" Text='<%#Eval("Prénom") &" " & Eval("Nom") %>'></asp:Label>
                    </td>
                    <td style="width:200px;">
                        <asp:Label SkinID="lbInfoMembre" id="lbDateNaissance" runat="server" Text='<%#Eval("DateNaissance", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </td>
                     <td>
                            <asp:Button SkinID="btnAjoutSupprimer" ID="btnSupprimer" runat="server" Text="Supprimer"    CommandName="Delete" />               
                    </td>  
                </tr>
            </ItemTemplate>         
        </asp:ListView>
        <asp:Button SkinID="btnAjoutSupprimer" ID="btnAjouter" runat="server" Text="Ajouter" Width="80px" CommandName="Ajout"/>
        <asp:Label ID="lbErreur" runat="server" Text="" Font-Size="18px" ForeColor="Red"></asp:Label>
    </asp:View>
    
    <asp:View ID="viewAjoutMembre" runat="server">
    <asp:Label skinid="lbTitrePage" ID="lbTitreAjout" runat="server" Text="Ajouter un membre au compte."></asp:Label><br /><br />
    <asp:ListView ID="listViewAjout" runat="server" DataSourceID="entiDataSourceMembre" DataKeyNames="noMembre" EditIndex="0">
            <LayoutTemplate>
                <table>
                    <asp:PlaceHolder runat="server" ID="GroupPlaceHolder"></asp:PlaceHolder>
                </table>
            </LayoutTemplate>
            <GroupTemplate>
                <asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder>
            </GroupTemplate>
            <ItemTemplate></ItemTemplate>
            <EditItemTemplate>
                <tr>
                    <td id="itemTemplate">
                        <asp:Label SkinID="lbTitreInfoMembre" ID="lbNom" runat="server" Text="Nom:"></asp:Label>
                        <asp:TextBox SkinID="tbInscription" id="lbNomMembre" runat="server" Text='<%#Bind("Prénom") &" " & Eval("Nom") %>'></asp:TextBox>
                    </td>
                    <td style="width:200px;">
                        <asp:Label SkinID="lbTitreInfoMembre" id="lbPrenom" runat="server" Text="Prénom:"></asp:Label>
                        <asp:textbox SkinID="tbinscription" id="tbPrenomMembre" runat="server" Text='<%#Bind("Prénom") %>'></asp:textBox>
                    </td>  
                    <tr>                      
                    <td style="width:200px;">
                        <asp:textbox SkinID="tbinscription" id="lbDateNaissance" runat="server" Text='<%#Bind("DateNaissance") %>'></asp:textBox><br />
                        <asp:Label SkinID="lbTitreInfoMembre" id="lbDate" runat="server" Text="Date de naissance:"></asp:Label>
                        
                    </td>
                     </tr>    
                </tr>
            </EditItemTemplate>         
        </asp:ListView>
       <asp:Button SkinID="btnConfirmation" ID="btnAjout" runat="server" Text="Enregistrer" Width="40px" CommandName="Update"/>
    </asp:View>
    </asp:MultiView>
<asp:EntityDataSource ID="entiDataSourceCompte" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="CompteSet">
</asp:EntityDataSource>
    <asp:EntityDataSource ID="entiDataSourceMembre" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="MembreSet" Where="it.Compte.noCompte = @noCompte" Include="Compte" EnableDelete="true">
        <WhereParameters>
        <asp:SessionParameter Name="noCompte" Type="Int32" SessionField="noCompte" /></WhereParameters>
    </asp:EntityDataSource>
</asp:Content>


