<%@ Page Language="VB" AutoEventWireup="false" CodeFile="inscription.aspx.vb" Inherits="inscription" MasterPageFile="~/masterPage.master" %>

<asp:Content ID="contentLogin" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="content">
        <asp:Label SkinID="lbTitrePage" ID="lbInscription" runat="server" Text="Inscription"></asp:Label>
        <table class="tableau">
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbNom" runat="server" Text="Nom:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbNom" runat="server" ></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbPrenom" runat="server" Text="Prenom:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbPrenom" runat="server" ></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbCourriel" runat="server" Text="Adresse courriel*:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbCourriel" runat="server" ></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbMotDePasse" runat="server" Text="Mot de passe:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbMotDePasse" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbConfirmationMotDePasse" runat="server" Text="Confirmation du mot de passe:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbConfirmationMotDePasse" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbCodePostale" runat="server" Text="Code Postale:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbCodePostale" runat="server" ></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbVille" runat="server" Text="Ville:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbVille" runat="server" ></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbProvince" runat="server" Text="Province:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbProvince" runat="server" ></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="longeurPremiereColonne"><asp:Label SkinID="lbInscription" ID="lbPays" runat="server" Text="Pays:"></asp:Label>
                    </td>
                <td class="longeurDeuxiemeColonne"><asp:TextBox SkinID="tbInscription" ID="tbPays" runat="server" ></asp:TextBox>
                    </td>
            </tr>
        </table>
        <asp:Button ID="btnEnregistrerInscription" runat="server" Text="Enregistrer" />

        <br /><br />
        
           
    </div>
</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</asp:Content>
