<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="listeCours.aspx.vb" Inherits="Admin_ListeCours" %>

<asp:Content ID="ContentCours" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="contentRight">
        <asp:Label ID="lblTitreCours" runat="server" Text="Liste des cours" SkinID="lbTitrePage"></asp:Label><br />
        <asp:Label ID="lbCriteres" runat="server" Text="Sélection des critères" SkinID="lbSousTitre"></asp:Label><br />
        <div style="float:left;" class="criteres">
            <asp:Label ID="lbChkCours" runat="server" Text="Critères côté cours" Font-Bold="true"></asp:Label>
            <asp:CheckBoxList ID="chkBoxCours" runat="server" RepeatColumns="2">
                <asp:ListItem Text="No de cours" Value="noCours"></asp:ListItem>
                <asp:ListItem Text="Nom" Value="NomCours"></asp:ListItem>
                <asp:ListItem Text="Prix" Value="Prix"></asp:ListItem>
                <asp:ListItem Text="Actif" Value="ActifCours"></asp:ListItem>
                <asp:ListItem Text="Catégorie" Value="Categorie"></asp:ListItem>
                <asp:ListItem Text="Groupe d'âge" Value="GroupeDAge"></asp:ListItem>
                <asp:ListItem Text="Prérequis" Value="Prerequis"></asp:ListItem>
                <asp:ListItem Text="Description" Value="Description"></asp:ListItem>
            </asp:CheckBoxList>
        </div>
        <div style="margin-left:250px;" class="criteres">
            <asp:Label ID="lbChkGroupe" runat="server" Text="Critères côté groupe" Font-Bold="true"></asp:Label>
            <asp:CheckBoxList ID="chkBoxGroupe" runat="server" RepeatColumns="2" CellSpacing="-1" RepeatLayout="Table" CellPadding="-1">
                <asp:ListItem Text="No de groupe" Value="noGroupe"></asp:ListItem>
                <asp:ListItem Text="Nom" Value="NomGroupe"></asp:ListItem>
                <asp:ListItem Text="Actif" Value="ActifGroupe"></asp:ListItem>
                <asp:ListItem Text="Nb. maximum d'inscrits" Value="NbMaxInscrits"></asp:ListItem>
                <asp:ListItem Text="Age" Value="Age"></asp:ListItem>
                <asp:ListItem Text="Session" Value="Session"></asp:ListItem>
                <asp:ListItem Text="Date limite d'inscription" Value="DateLimInscription"></asp:ListItem>
                <asp:ListItem Text="Date de début" Value="DateDebut"></asp:ListItem>    
                <asp:ListItem Text="Date de fin" Value="DateFin"></asp:ListItem>
                <asp:ListItem Text="Local" Value="Local"></asp:ListItem>
                <asp:ListItem Text="Animateur" Value="Animateur"></asp:ListItem>
            </asp:CheckBoxList>
        </div>
        <asp:Label ID="lbTrierCours" runat="server" Text="Trier les cours par: " Font-Bold="true" class="lbTrier"></asp:Label>
        <asp:DropDownList ID="ddListTriCours" runat="server" SkinID="dDListFormulaire">
            <asp:ListItem Text="No de cours" Value="noCours"></asp:ListItem>
            <asp:ListItem Text="Nom" Value="Nom"></asp:ListItem>
            <asp:ListItem Text="Prix" Value="Prix"></asp:ListItem>
            <asp:ListItem Text="Actif" Value="Actif"></asp:ListItem>
            <asp:ListItem Text="Catégorie" Value="Categorie.Nom"></asp:ListItem>
            <asp:ListItem Text="Groupe d'âge" Value="GroupeDAge.NomGroupeDAge"></asp:ListItem>
            <asp:ListItem Text="Prérequis" Value="lePrerequis.noCours"></asp:ListItem>
            <asp:ListItem Text="Description" Value="Description"></asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="lbTrierGroupe" runat="server" Text="Trier les groupes par: " Font-Bold="true" class="lbTrier"></asp:Label>
        <asp:DropDownList ID="ddListTriGroupe" runat="server" SkinID="dDListFormulaire">
            <asp:ListItem Text="No de groupe" Value="noGroupe"></asp:ListItem>
            <asp:ListItem Text="Nom" Value="Nom"></asp:ListItem>
            <asp:ListItem Text="Actif" Value="Actif"></asp:ListItem>
            <asp:ListItem Text="Nb. maximum d'inscrits" Value="NbMaxInscrits"></asp:ListItem>
            <asp:ListItem Text="Age minimum" Value="AgeMinimum"></asp:ListItem>
            <asp:ListItem Text="Age maximum" Value="AgeMaximum"></asp:ListItem>
            <asp:ListItem Text="Session" Value="Session.noSession"></asp:ListItem>
            <asp:ListItem Text="Date limite d'inscription" Value="DateLimiteInscription"></asp:ListItem>
            <asp:ListItem Text="Date de début" Value="DateDebut"></asp:ListItem>    
            <asp:ListItem Text="Date de fin" Value="DateFin"></asp:ListItem>
            <asp:ListItem Text="Local" Value="Local"></asp:ListItem>
            <asp:ListItem Text="Animateur" Value="Animateur.Nom"></asp:ListItem>
        </asp:DropDownList><br /><br />
        <asp:LinkButton ID="lnkGenerer" runat="server" Text="Générer le rapport"></asp:LinkButton>
    </div>
</asp:Content>
