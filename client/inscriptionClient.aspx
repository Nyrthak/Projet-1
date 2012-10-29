<%@ Page Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false" CodeFile="inscriptionClient.aspx.vb" Inherits="client_inscriptionClient" %>

<asp:Content ID="contentAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="contentMenu" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="contentRight">
        <asp:Label SkinID="lbTitrePage" ID="lbTitrePage" runat="server" Text="Liste des inscriptions"></asp:Label><br />
        <asp:ListView ID="lViewMembre" runat="server" DataSourceID="entiDataSourceMembre" DataKeyNames="noMembre">
            <LayoutTemplate>                                                   
                        <asp:PlaceHolder runat="server" id="GroupPlaceHolder"></asp:PlaceHolder>          
            </LayoutTemplate>
            <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
            <ItemTemplate>
               <div class="borderInscription">            
                <asp:Label SkinID="lbInscription" ID="lbNomMembre" runat="server" Text='<%#Eval("Prénom") &" " & Eval("Nom") %>'></asp:Label>
               
                <asp:HiddenField ID="hFielNoMembre" runat="server" Value='<%#Eval("noMembre") %>' />
                
                <asp:ListView ID="lViewPaiement" runat="server" DataSourceID="entiDataSourcePaiement" DataKeyNames="noPaiement">
                        <LayoutTemplate>                       
                                <table style="float:right">
                                    <asp:PlaceHolder runat="server" id="GroupPlaceHolder"></asp:PlaceHolder>
                                </table>
                        </LayoutTemplate>
                        <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
                        <ItemTemplate>
                            <tr>
                                <td class="longeurDeuxiemeColonneNOM">
                                    <asp:Label SkinID="lbInscription" ID="lbNomMembre" runat="server" Text='<%#Eval("Groupe.Cours.Nom") & " Groupe " & Eval("Groupe.noGroupe") %>'></asp:Label>                                    
                                </td>                                
                           </tr>
                        </ItemTemplate>
                </asp:ListView>
                 </div>    
           
            <asp:EntityDataSource ID="entiDataSourcePaiement" runat="server" 
                ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
                EntitySetName="Paiement" Where="it.Membre.noMembre = @noMembre" Include="Membre, Groupe.Cours" >
             <WhereParameters>
                <asp:ControlParameter Type="int32" Name="noMembre" ControlID="hFielNoMembre"/>
             </WhereParameters>
            </asp:EntityDataSource>
        </ItemTemplate>
        </asp:ListView>
</div>
  <asp:EntityDataSource ID="entiDataSourceMembre" runat="server"
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Membre" Where="it.Compte.noCompte = @noCompte" Include="Compte" >
        <WhereParameters>
            <asp:SessionParameter Name="noCompte" Type="Int32" SessionField="noCompte" />
        </WhereParameters>
   </asp:EntityDataSource>
    
    
</asp:Content>
