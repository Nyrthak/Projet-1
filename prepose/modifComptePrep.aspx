<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="modifComptePrep.aspx.vb" Inherits="prepose_modifComptePrep" %>

<asp:Content ID="contentMenuClient" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentMenuAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>

<asp:Content ID="contentMain" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
<div id="contentRight">
</div>
    <asp:ListView ID="listViewInfoCompte" runat="server" DataKeyNames="noCompte" DataSourceID="entityDataSourceCompte" EditIndex="0">
    <LayoutTemplate>
                <table>
                    <asp:PlaceHolder runat="server" ID="GroupPlaceHolder"></asp:PlaceHolder>
                </table>
            </LayoutTemplate>
    <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
    <ItemTemplate></ItemTemplate>
    <EditItemTemplate>
        <tr>
            <td class="longeurPremiereColonne">
                <asp:Label ID="lbNom" runat="server" Text="Nom"></asp:Label></td>
            <td></td>
        </tr>
    
    
    </EditItemTemplate>
    </asp:ListView>


     <asp:EntityDataSource ID="entityDataSourceProvince" runat="server" 
        ConnectionString="name=ModelContainer" 
        DefaultContainerName="ModelContainer" EntitySetName="ProvinceSet" 
        EnableFlattening="False">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="entityDataSourceCompte" runat="server" 
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="CompteSet" EnableFlattening="false" EnableUpdate="true" Where="it.noCompte = @noCompte">
        <WhereParameters>
        <asp:SessionParameter Name="noCompte" SessionField="noCompte" Type="Int32"/>    
        </WhereParameters>
    </asp:EntityDataSource>
</asp:Content>
