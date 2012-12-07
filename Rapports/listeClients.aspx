<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="listeClients.aspx.vb" Inherits="Admin_ListeClients" %>

<asp:Content ID="ContentCours" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="contentRight">
        <asp:Label ID="lblTitreCompte" runat="server" Text="Liste des comptes" SkinID="lbTitrePage"></asp:Label><br />
        <asp:Label ID="lbCriteres" runat="server" Text="Sélection des critères" SkinID="lbSousTitre"></asp:Label><br />
        <div style="float:left;" class="criteres">
            <asp:Label ID="lbChkCompte" runat="server" Text="Critères côté compte" Font-Bold="true"></asp:Label>
            <asp:CheckBoxList ID="chkBoxCompte" runat="server" RepeatColumns="2">
                <asp:ListItem Text="No de compte" Value="noCompte"></asp:ListItem>
                <asp:ListItem Text="E-mail" Value="Email"></asp:ListItem>
                <asp:ListItem Text="Type de compte" Value="Type"></asp:ListItem>
                <asp:ListItem Text="Mode de paiement" Value="ModePaiement"></asp:ListItem>
                <asp:ListItem Text="No de téléphone" Value="noTelephone"></asp:ListItem>
                <asp:ListItem Text="Adresse" Value="Adresse"></asp:ListItem>
                <asp:ListItem Text="Actif" Value="Actif"></asp:ListItem>
                <asp:ListItem Text="Code postal" Value="CodePostal"></asp:ListItem>
                <asp:ListItem Text="Ville" Value="Ville"></asp:ListItem>
                <asp:ListItem Text="Province" Value="Province.Nom"></asp:ListItem>
                <asp:ListItem Text="Pays" Value="Pays"></asp:ListItem>
            </asp:CheckBoxList>
        </div>
        <div style="margin-left:250px;" class="criteres">
            <asp:Label ID="lbChkMembre" runat="server" Text="Critères côté membre" Font-Bold="true"></asp:Label>
            <asp:CheckBoxList ID="chkBoxMembre" runat="server" RepeatColumns="2" CellSpacing="-1" RepeatLayout="Table" CellPadding="-1">
                <asp:ListItem Text="No de membre" Value="noMembre"></asp:ListItem>
                <asp:ListItem Text="Prénom" Value="Prenom"></asp:ListItem>
                <asp:ListItem Text="Nom" Value="Nom"></asp:ListItem>
                <asp:ListItem Text="Date de naissance" Value="DateNaissance"></asp:ListItem>
                <asp:ListItem Text="Propriétaire" Value="Proprietaire"></asp:ListItem>
                <asp:ListItem Text="Parent/Enfant" Value="Parent"></asp:ListItem>
            </asp:CheckBoxList>
        </div>
        <asp:Label ID="lbTrierCompte" runat="server" Text="Trier les comptes par: " Font-Bold="true" class="lbTrier"></asp:Label>
        <asp:DropDownList ID="ddListTriComptes" runat="server" SkinID="dDListFormulaire">
            <asp:ListItem Text="No de compte" Value="noCompte"></asp:ListItem>
            <asp:ListItem Text="Type de compte" Value="Type"></asp:ListItem>
            <asp:ListItem Text="Adresse" Value="Adresse"></asp:ListItem>
            <asp:ListItem Text="Actif" Value="Actif"></asp:ListItem>
            <asp:ListItem Text="Ville" Value="Ville"></asp:ListItem>
            <asp:ListItem Text="Code postal" Value="CodePostal"></asp:ListItem>
            <asp:ListItem Text="Mode de paiement" Value="ModePaiement"></asp:ListItem>
            <asp:ListItem Text="E-mail" Value="Email"></asp:ListItem>
            <asp:ListItem Text="No de téléphone" Value="noTelephone"></asp:ListItem>
            <asp:ListItem Text="Pays" Value="Pays"></asp:ListItem>
            <asp:ListItem Text="Province" Value="Province.Nom"></asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="lbTrierMembre" runat="server" Text="Trier les membres par: " Font-Bold="true" class="lbTrier"></asp:Label>
        <asp:DropDownList ID="ddListTriMembres" runat="server" SkinID="dDListFormulaire">
            <asp:ListItem Text="No de membre" Value="noMembre"></asp:ListItem>
            <asp:ListItem Text="Nom" Value="Nom"></asp:ListItem>
            <asp:ListItem Text="Prénom" Value="Prenom"></asp:ListItem>
            <asp:ListItem Text="Date de naissance" Value="DateNaissance"></asp:ListItem>
            <asp:ListItem Text="Propriétaire" Value="Proprietaire"></asp:ListItem>
            <asp:ListItem Text="Parent/Enfant" Value="Parent"></asp:ListItem>
        </asp:DropDownList><br /><br />
        <asp:LinkButton ID="lnkGenerer" runat="server" Text="Générer le rapport"></asp:LinkButton>
    </div>
</asp:Content>
