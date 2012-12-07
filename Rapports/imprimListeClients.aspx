<%@ Page Language="VB" AutoEventWireup="false" CodeFile="imprimListeClients.aspx.vb" Inherits="Rapports_imprimListeClients" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body id="imprimable">
    <form id="form1" runat="server">
    <div>
        <asp:EntityDataSource ID="entiDataSourceComptes" runat="server" 
            ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
            EnableFlattening="False" EntitySetName="Compte" Include="Province">
        </asp:EntityDataSource>
        <img src="../App_Themes/Default/images/logo.jpg" alt="Logo CSL." class="imgCSL" /><br />
        <asp:Label ID="lbCSL" runat="server" Text="CSL inc." CssClass="lbCSL"></asp:Label><br />
        <asp:Label ID="lbTitre" runat="server" CssClass="lbCentrer" Text="Liste des comptes clients en date du " SkinID="lbTitrePage"></asp:Label><br /><br />
        <asp:ListView ID="lViewComptes" runat="server" DataSourceID="entiDataSourceComptes" DataKeyNames="noCompte">
            <LayoutTemplate>
                <table class="tableRapportClients">
                    <tr>
                        <td id="tdTitreNoCompte" runat="server"><asp:Label ID="lbTitreNoCompte" runat="server" Text="#" SkinID="lbTitreTableau" Width="30px"></asp:Label></td>
                        <td id="tdTitreEmail" runat="server"><asp:Label ID="lbTitreEmail" runat="server" Text="E-mail" SkinID="lbTitreTableau" Width="130px"></asp:Label></td>
                        <td id="tdTitreTypeCompte" runat="server"><asp:Label ID="lbTitreTypeCompte" runat="server" Text="Type de compte" SkinID="lbTitreTableau" Width="70px"></asp:Label></td>
                        <td id="tdTitreModePaiement" runat="server"><asp:Label ID="lbTitreModePaiement" runat="server" Text="Mode de paiement" SkinID="lbTitreTableau" Width="80px"></asp:Label></td>
                        <td id="tdTitreTelephone" runat="server"><asp:Label ID="lbTitreTelephone" runat="server" Text="Téléphone" SkinID="lbTitreTableau" Width="90px"></asp:Label></td>
                        <td id="tdTitreAdresse" runat="server"><asp:Label ID="lbTitreAdresse" runat="server" Text="Adresse" SkinID="lbTitreTableau" Width="150px"></asp:Label></td>
                        <td id="tdTitreActif" runat="server"><asp:Label ID="lbTitreActif" runat="server" Text="Actif" SkinID="lbTitreTableau" Width="70px"></asp:Label></td>
                        <td id="tdTitreCodePostal" runat="server"><asp:Label ID="lbTitreCodePostal" runat="server" Text="Code postal" SkinID="lbTitreTableau" Width="90px"></asp:Label></td>
                        <td id="tdTitreVille" runat="server"><asp:Label ID="lbTitreVille" runat="server" Text="Ville" SkinID="lbTitreTableau" Width="70px"></asp:Label></td>
                        <td id="tdTitreProvince" runat="server"><asp:Label ID="lbTitreProvince" runat="server" Text="Province" SkinID="lbTitreTableau" Width="70px"></asp:Label></td>
                        <td id="tdTitrePays" runat="server"><asp:Label ID="lbTitrePays" runat="server" Text="Pays" SkinID="lbTitreTableau" Width="60px"></asp:Label></td>

                        <td id="tdTitreNoMembre" runat="server"><asp:Label ID="lbTitreNoMembre" runat="server" Text="#" SkinID="lbTitreTableau" Width="30px"></asp:Label></td>
                        <td id="tdTitrePrenom" runat="server"><asp:Label ID="lbTitrePrenom" runat="server" Text="Prénom" SkinID="lbTitreTableau" Width="80px"></asp:Label></td>
                        <td id="tdTitreNom" runat="server"><asp:Label ID="lbTitreNom" runat="server" Text="Nom" SkinID="lbTitreTableau" Width="80px"></asp:Label></td>
                        <td id="tdTitreDateNaissance" runat="server"><asp:Label ID="lbTitreDateNaissance" runat="server" Text="Date de naissance" SkinID="lbTitreTableau" Width="100px"></asp:Label></td>
                        <td id="tdTitreProprio" runat="server"><asp:Label ID="lbTitreProprio" runat="server" Text="Propriétaire" SkinID="lbTitreTableau" Width="90px"></asp:Label></td>
                        <td id="tdTitreTypeMembre" runat="server"><asp:Label ID="lbTitreTypeMembre" runat="server" Text="Type" SkinID="lbTitreTableau" Width="50px"></asp:Label></td>
                    </tr>
                    <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td id="tdNoCompte" runat="server"><asp:Label ID="lbNoCompte" runat="server" Text='<%#Eval("noCompte")%>'></asp:Label></td>
                    <td id="tdEmail" runat="server"><asp:Label ID="lbEmail" runat="server" Text='<%#Eval("Email")%>'></asp:Label></td>
                    <td id="tdTypeCompte" runat="server"><asp:Label ID="lbTypeCompte" runat="server" Text='<%#Eval("Type")%>'></asp:Label></td>
                    <td id="tdModePaiement" runat="server"><asp:Label ID="lbModePaiement" runat="server" Text='<%#Eval("ModePaiement")%>'></asp:Label></td>
                    <td id="tdTelephone" runat="server"><asp:Label ID="lbTelephone" runat="server" Text='<%#Eval("noTelephone")%>'></asp:Label></td>
                    <td id="tdAdresse" runat="server"><asp:Label ID="lbAdresse" runat="server" Text='<%#Eval("Adresse")%>'></asp:Label></td>
                    <td id="tdActif" runat="server"><asp:Label ID="lbActif" runat="server" Text='<%#IIF(Eval("Actif"), "Oui", "Non")%>'></asp:Label></td>
                    <td id="tdCodePostal" runat="server"><asp:Label ID="lbCodePostal" runat="server" Text='<%#Eval("CodePostal")%>'></asp:Label></td>
                    <td id="tdVille" runat="server"><asp:Label ID="lbVille" runat="server" Text='<%#Eval("Ville")%>'></asp:Label></td>
                    <td id="tdProvince" runat="server"><asp:Label ID="lbProvince" runat="server" Text='<%#Eval("Province.Nom")%>'></asp:Label></td>
                    <td id="tdPays" runat="server"><asp:Label ID="lbPays" runat="server" Text='<%#Eval("Pays")%>'></asp:Label></td>
                    <td colspan="6">
                        <asp:HiddenField ID="hFieldNoCompte" runat="server" Value='<%#Eval("noCompte")%>' />
                        <asp:ListView ID="lViewMembres" runat="server" DataSourceID="entiDataSourceMembres" DataKeyNames="noMembre">
                            <LayoutTemplate>
                                <table class="tableRapportClients">
                                    <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td id="tdNoMembre" runat="server"><asp:Label ID="lbNoMembre" runat="server" Text='<%#Eval("noMembre")%>' Width="31px"></asp:Label></td>
                                    <td id="tdPrenom" runat="server"><asp:Label ID="lbPrenom" runat="server" Text='<%#Eval("Prenom")%>' Width="81px"></asp:Label></td>
                                    <td id="tdNom" runat="server"><asp:Label ID="lbNom" runat="server" Text='<%#Eval("Nom")%>' Width="81px"></asp:Label></td>
                                    <td id="tdDateNaissance" runat="server"><asp:Label ID="lbDateNaissance" runat="server" Text='<%#Eval("DateNaissance", "{0:dd-MM-yyyy}")%>' Width="101px"></asp:Label></td>
                                    <td id="tdProprio" runat="server"><asp:Label ID="lbProprio" runat="server" Text='<%#IIF(Eval("Proprietaire"), "Oui", "Non")%>' Width="91px"></asp:Label></td>
                                    <td id="tdTypeMembre" runat="server"><asp:Label ID="lbParent" runat="server" Text='<%#IIF(Eval("Parent"), "Parent", "Enfant")%>' Width="51px"></asp:Label></td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>
                    </td>
                </tr>
                <asp:EntityDataSource ID="entiDataSourceMembres" runat="server" Include="Compte"
                    ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
                    EnableFlattening="False" EntitySetName="Membre" Where="it.Compte.noCompte = @noCompte">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="hFieldNoCompte" ConvertEmptyStringToNull="false" Type="Int32" Name="noCompte" />
                    </WhereParameters>
                </asp:EntityDataSource>
            </ItemTemplate>
        </asp:ListView>
    </div>
    </form>
</body>
</html>
