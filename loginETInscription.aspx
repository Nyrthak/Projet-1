<%@ Page Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false"  CodeFile="loginETInscription.aspx.vb" Inherits="loginETInscription" %>

<asp:Content ID="contentLogin" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="content">

        <div id="contentLeft">
        <h1><asp:Label runat="server" id="lbConnection" Text="Connection" SkinID="lbTitrePage"></asp:Label></h1>        
        <asp:Login ID="loginCtrl" runat="server" BackColor="#9FB8FF" Width="350px" Height="170px" 
                BorderColor="black" BorderStyle="Solid" BorderWidth="1px" 
                Font-Names="Verdana" Font-Size="16px" Font-Bold="True">
            <TitleTextStyle BackColor="#505C7F" Font-Bold="True" ForeColor="#FFFFFF" Font-Size="18px" />
            <TextBoxStyle Height="20px" Font-Size="16px" ForeColor="Black" />
            <LoginButtonStyle BackColor="#293F7F" ForeColor="White" Font-size="16px" Font-Bold="true" Width="100px" BorderColor="Black"    
             BorderStyle="Solid" BorderWidth="1px"/>
            <ValidatorTextStyle Forecolor="Red" />   
        </asp:Login>
        </div>

        <div id="contentRight">
            <h1><asp:Label runat="server" id="lbInscription" Text="S'inscrire" SkinID="lbTitrePage"></asp:Label></h1> 
            <asp:Label ID="lbNom" runat="server" Text="Nom:"></asp:Label><asp:TextBox ID="TextBox1"runat="server"></asp:TextBox>
        </div>
    </div>



</asp:Content>


