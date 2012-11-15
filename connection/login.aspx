<%@ Page Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false"  CodeFile="login.aspx.vb" Inherits="login" %>


<asp:Content ID="contentMenu" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="contentLogin" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
        <h1><asp:Label runat="server" id="lbConnection" Text="Connection" SkinID="lbTitrePage"></asp:Label></h1>        
        <asp:Login ID="loginCtrl" runat="server" BackColor="#9FB8FF" Width="350px" Height="170px" 
                BorderColor="black" BorderStyle="Solid" BorderWidth="1px" 
                Font-Names="Verdana" Font-Size="16px" Font-Bold="True" DisplayRememberMe="false">
            <TitleTextStyle BackColor="#505C7F" Font-Bold="True" ForeColor="#FFFFFF" Font-Size="18px" />
            <TextBoxStyle Height="20px" Font-Size="16px" ForeColor="Black" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
            <LoginButtonStyle BackColor="#293F7F" ForeColor="White" Font-size="16px" Font-Bold="true" Width="100px" BorderColor="Black"    
             BorderStyle="Solid" BorderWidth="1px"/>
            <ValidatorTextStyle Forecolor="Red" />  
                   
        </asp:Login>
   </asp:Content>


