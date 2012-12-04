<%@ Page Title="" Language="VB" MasterPageFile="~/masterPage.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" Theme="Default" %>

<asp:Content ID="contentMenu" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>
<asp:Content ID="contentMenuPrepose" ContentPlaceHolderID="contentMenuPrepose" runat="server"></asp:Content>

<asp:Content ID="contentAccueil" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="texteAccueil">
        <asp:Label SkinID="lbTitrePage" ID="lbAccueil" runat="server" Text="Accueil" ></asp:Label>
         <p>
            Bienvenue sur le site de CSL inc. CSL inc. est un centre de sports, loisir et activités culturelles de la région de granby haute-yamaska. 
            Nous offrons plus de 200 cours divers s'adressant à tous les âges, de nouveau né à l'âge d'or. La santé de la population de granby haute-yamaska nous tient à coeur. Chacun de nos cours vise à améliorer la santé physique ou mentale de nos clients.
        </p>
        <p>
            Votre sécurité et celle de vos enfants est notre priorité. Chacun de nos animateurs est formé selon le public avec lequel il va travailler, ceci allant
            d'enfants en bas âge, à des femmes enceintes, à des personnes âgées.
        </p>
        </div>
    <div id="imageAccueil"><asp:Image ID="imgAccueil" runat="server"  Width="252px" Height="168px" ImageUrl="~/App_Themes/Default/images/tennis.JPG" /></div>
</asp:Content>

