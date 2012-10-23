<%@ Page Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false" CodeFile="inscriptionClient.aspx.vb" Inherits="client_inscriptionClient" %>

<asp:Content ID="contentAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="contentMenu" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
        <asp:Repeater ID="repeater" DataSourceID="entityDataSourcePaiement" runat="server">
            <ItemTemplate>
                <asp:Label ID="lbPaiement" runat="server" Text='<%#Eval("noPaiement") %>'></asp:Label>
            </ItemTemplate>
        </asp:Repeater>


  <%--  <asp:EntityDataSource ID="entityDataSourceMembre" runat="server"
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="MembreSet" Where="it.noCompte = @noCompte" Include="Compte, Paiement" >
        <WhereParameters>
            <asp:SessionParameter Name="noCompte" Type="Int32" SessionField="noCompte" />
        </WhereParameters>
    </asp:EntityDataSource>--%>
    
    <asp:EntityDataSource ID="entityDataSourcePaiement" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Paiement" Where="" Include="Membre" >
      <%--  <WhereParameters>
            <asp:Parameter name="listMembre" Type="String" />
        </WhereParameters>--%>
    </asp:EntityDataSource>
</asp:Content>
