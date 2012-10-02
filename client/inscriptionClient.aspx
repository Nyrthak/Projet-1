<%@ Page Language="VB" MasterPageFile="~/masterPageClient.master" AutoEventWireup="false" CodeFile="inscriptionClient.aspx.vb" Inherits="client_inscriptionClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
        <asp:Repeater ID="repeater" DataSourceID="entityDataSourceMembre" runat="server">
            <ItemTemplate>
                <asp:Label ID="lbPaiement" runat="server" Text=""></asp:Label>
            </ItemTemplate>
        </asp:Repeater>


    <asp:EntityDataSource ID="entityDataSourceMembre" runat="server"
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="MembreSet" Where="it.Compte.noCompte = @noCompte" Include="Compte, Paiement" >
        <WhereParameters>
            <asp:SessionParameter Name="noCompte" Type="Int32" SessionField="noCompte" />
        </WhereParameters>
    </asp:EntityDataSource>
    
    <asp:EntityDataSource ID="entityDataSourcePaiement" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="PaiementSet" Where="noMembre = ">
        <WhereParameters>
            
        </WhereParameters>
    </asp:EntityDataSource>
</asp:Content>
