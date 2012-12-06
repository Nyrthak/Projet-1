<%@ Page Language="VB" AutoEventWireup="false" CodeFile="imprimListeCours.aspx.vb" Inherits="Rapports_imprimListeCours" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body id="imprimable">
    <form id="form1" runat="server">
    <div>
        <asp:EntityDataSource ID="entiDataSourceCours" runat="server" 
            ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
            EnableFlattening="False" EntitySetName="Cours" Include="Categorie, GroupeDAge, lePrerequis">
        </asp:EntityDataSource>
        <img src="../App_Themes/Default/images/logo.jpg" alt="Logo CSL." class="imgCSL" /><br />
        <asp:Label ID="lbCSL" runat="server" Text="CSL inc." CssClass="lbCSL"></asp:Label><br />
        <asp:Label ID="lbTitre" runat="server" CssClass="lbCentrer" Text="Liste des comptes clients en date du " SkinID="lbTitrePage"></asp:Label><br /><br />
        <asp:ListView ID="lViewCours" runat="server" DataSourceID="entiDataSourceCours" DataKeyNames="noCours">
            <LayoutTemplate>
                <table class="tableRapportClients">
                    <tr>
                        <td id="tdTitreNoCours" runat="server"><asp:Label ID="lbTitreNoCours" runat="server" Text="#" SkinID="lbTitreTableau" Width="20px"></asp:Label></td>
                        <td id="tdTitreNomCours" runat="server"><asp:Label ID="lbTitreNomCours" runat="server" Text="Nom du cours" SkinID="lbTitreTableau" Width="120px"></asp:Label></td>
                        <td id="tdTitrePrix" runat="server"><asp:Label ID="lbTitrePrix" runat="server" Text="Prix" SkinID="lbTitreTableau" Width="40px"></asp:Label></td>
                        <td id="tdTitreActifCours" runat="server"><asp:Label ID="lbTitreActifCours" runat="server" Text="Actif" SkinID="lbTitreTableau" Width="50px"></asp:Label></td>
                        <td id="tdTitreCategorie" runat="server"><asp:Label ID="lbTitreCategorie" runat="server" Text="Catégorie" SkinID="lbTitreTableau" Width="80px"></asp:Label></td>
                        <td id="tdTitreGroupeDAge" runat="server"><asp:Label ID="lbTitreGroupeDAge" runat="server" Text="Groupe d'âge" SkinID="lbTitreTableau" Width="70px"></asp:Label></td>
                        <td id="tdTitrePrerequis" runat="server"><asp:Label ID="lbPrerequis" runat="server" Text="Prérequis" SkinID="lbTitreTableau" Width="80px"></asp:Label></td>
                        <td id="tdTitreDescription" runat="server"><asp:Label ID="lbTitreDescription" runat="server" Text="Description" SkinID="lbTitreTableau" Width="90px"></asp:Label></td>

                        <td id="tdTitreNoGroupe" runat="server"><asp:Label ID="lbTitreNoGroupe" runat="server" Text="#" SkinID="lbTitreTableau" Width="20px"></asp:Label></td>
                        <td id="tdTitreNomGroupe" runat="server"><asp:Label ID="lbTitreNomGroupe" runat="server" Text="Nom du groupe" SkinID="lbTitreTableau" Width="70px"></asp:Label></td>
                        <td id="tdTitreActifGroupe" runat="server"><asp:Label ID="lbTitreActifGroupe" runat="server" Text="Actif" SkinID="lbTitreTableau" Width="50px"></asp:Label></td>
                        <td id="tdTitreNbMaxInscrits" runat="server"><asp:Label ID="lbTitreNbMaxInscrits" runat="server" Text="Nb. maximum d'inscrits" SkinID="lbTitreTableau" Width="100px"></asp:Label></td>
                        <td id="tdTitreAge" runat="server"><asp:Label ID="lbTitreAge" runat="server" Text="Age" SkinID="lbTitreTableau" Width="40px"></asp:Label></td>
                        <td id="tdTitreSession" runat="server"><asp:Label ID="lbTitreSession" runat="server" Text="Session" SkinID="lbTitreTableau" Width="65px"></asp:Label></td>
                        <td id="tdTitreDateLimInscription" runat="server"><asp:Label ID="lbTitreDateLimInscription" runat="server" Text="Date limite d'incription" SkinID="lbTitreTableau" Width="100px"></asp:Label></td>
                        <td id="tdTitreDateDebut" runat="server"><asp:Label ID="lbTitreDateDebut" runat="server" Text="Date de début" SkinID="lbTitreTableau" Width="85px"></asp:Label></td>
                        <td id="tdTitreDateFin" runat="server"><asp:Label ID="lbTitreDateFin" runat="server" Text="Date de fin" SkinID="lbTitreTableau" Width="85px"></asp:Label></td>
                        <td id="tdTitreLocal" runat="server"><asp:Label ID="lbTitreLocal" runat="server" Text="Local" SkinID="lbTitreTableau" Width="70px"></asp:Label></td>
                        <td id="tdTitreAnimateur" runat="server"><asp:Label ID="lbTitreAnimateur" runat="server" Text="Animateur" SkinID="lbTitreTableau" Width="80px"></asp:Label></td>
                    </tr>
                    <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td id="tdNoCours" runat="server"><asp:Label ID="lbNoCours" runat="server" Text='<%#Eval("noCours")%>'></asp:Label></td>
                    <td id="tdNomCours" runat="server"><asp:Label ID="lbNom" runat="server" Text='<%#Eval("Nom")%>'></asp:Label></td>
                    <td id="tdPrix" runat="server"><asp:Label ID="lbPrix" runat="server" Text='<%#Eval("Prix")%>'></asp:Label></td>
                    <td id="tdActifCours" runat="server"><asp:Label ID="lbActif" runat="server" Text='<%#IIF(Eval("Actif"), "Oui", "Non")%>'></asp:Label></td>
                    <td id="tdCategorie" runat="server"><asp:Label ID="lbCategorie" runat="server" Text='<%#Eval("Categorie.Nom")%>'></asp:Label></td>
                    <td id="tdGroupeDAge" runat="server"><asp:Label ID="lbGroupeDAge" runat="server" Text='<%#Eval("GroupeDAge.NomGroupeDAge")%>'></asp:Label></td>
                    <td id="tdPrerequis" runat="server"><asp:Label ID="lbPrerequis" runat="server" Text='<%#IIF(Eval("lePrerequis.noCours") isnot Nothing, Eval("lePrerequis.Nom"), "Aucun")%>'></asp:Label></td>
                    <td id="tdDescription" runat="server"><asp:Label ID="lbDescription" runat="server" Text='<%#Eval("Description")%>'></asp:Label></td>
                    <td colspan="11">
                        <asp:HiddenField ID="hFieldNoCours" runat="server" Value='<%#Eval("noCours")%>' />
                        <asp:ListView ID="lViewGroupes" runat="server" DataSourceID="entiDataSourceGroupes" DataKeyNames="noGroupe">
                            <LayoutTemplate>
                                <table class="tableRapportClients">
                                    <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td id="tdNoGroupe" runat="server"><asp:Label ID="lbNoGroupe" runat="server" Text='<%#Eval("noGroupe")%>' Width="21px"></asp:Label></td>
                                    <td id="tdNomGroupe" runat="server"><asp:Label ID="lbNom" runat="server" Text='<%#Eval("Nom")%>' Width="71px"></asp:Label></td>
                                    <td id="tdActifGroupe" runat="server"><asp:Label ID="lbActif" runat="server" Text='<%#Eval("Actif")%>' Width="51px"></asp:Label></td>
                                    <td id="tdNbMaxInscrits" runat="server"><asp:Label ID="lbNbMaxInscrits" runat="server" Text='<%#Eval("nbMaxInscrits")%>' Width="101px"></asp:Label></td>
                                    <td id="tdAge" runat="server"><asp:Label ID="lbAge" runat="server" Text='<%#Eval("AgeMinimum") & "-" & Eval("AgeMaximum")%>' Width="41px"></asp:Label></td>
                                    <td id="tdSession" runat="server"><asp:Label ID="lbSession" runat="server" Text='<%#Eval("Session.NomSession")%>' Width="66px"></asp:Label></td>
                                    <td id="tdDateLimInscription" runat="server"><asp:Label ID="lbDateLimInscription" runat="server" Text='<%#Eval("DateLimiteInscription", "{0:dd/MM/yyyy}")%>' Width="101px"></asp:Label></td>
                                    <td id="tdDateDebut" runat="server"><asp:Label ID="lbDateDebut" runat="server" Text='<%#Eval("DateDebut", "{0:dd/MM/yyyy}")%>' Width="86px"></asp:Label></td>
                                    <td id="tdDateFin" runat="server"><asp:Label ID="lbDateFin" runat="server" Text='<%#Eval("DateFin", "{0:dd/MM/yyyy}")%>' Width="86px"></asp:Label></td>
                                    <td id="tdLocal" runat="server"><asp:Label ID="lbLocal" runat="server" Text='<%#Eval("Local")%>' Width="71px"></asp:Label></td>
                                    <td id="tdAnimateur" runat="server"><asp:Label ID="lbAnimateur" runat="server" Text='<%#Eval("Animateur.Nom")%>' Width="81px"></asp:Label></td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>
                    </td>
                </tr>
                <asp:EntityDataSource ID="entiDataSourceGroupes" runat="server" Include="Cours, Animateur, Session"
                    ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
                    EnableFlattening="False" EntitySetName="Groupe" Where="it.Cours.noCours = @noCours">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="hFieldNoCours" ConvertEmptyStringToNull="false" Type="Int32" Name="noCours" />
                    </WhereParameters>
                </asp:EntityDataSource>
            </ItemTemplate>
        </asp:ListView>
    </div>
    </form>
</body>
</html>
