<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/masterPage.master" CodeFile="gererClient.aspx.vb" Inherits="prepose_gererClient" %>

<asp:Content ID="contentMenuClient" ContentPlaceHolderID="contentMenuClient" runat="server"></asp:Content>
<asp:Content ID="contentMenuAdmin" ContentPlaceHolderID="contentMenuAdmin" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="contentPlaceMasterPage" runat="server">
    <div id="contentRight">
        <asp:Button Skinid="btnRechercher" ID="btnRechercher" runat="server" Text="Ok" CssClass="rechercher" />
        <asp:TextBox ID="tbRechercher" runat="server" SkinID="TextBoxFormulaire" CssClass="rechercher"></asp:TextBox>
        <asp:Label ID="lbRechercher" runat="server" Text="Rechercher" CssClass="lbRechercher"></asp:Label><br />
        <asp:MultiView ID="mViewActionCompte" runat="server" ActiveViewIndex="0">      
           <asp:View runat="server" ID="viewListeCompte">
                <asp:Label SkinID="lbTitrePage" ID="lbTitrePage" runat="server" Text="Liste de comptes"></asp:Label>
                <asp:ListView ID="lviewCompte" runat="server" DataKeyNames="noCompte" DataSourceID="entiDataSourceCompte">
                    <LayoutTemplate>
                        <table>
                            <asp:PlaceHolder id="GroupPlaceHolder" runat="server" />
                        </table>
                    </LayoutTemplate>
                    <GroupTemplate>
                        <asp:PlaceHolder id="ItemPlaceHolder" runat="server" />
                    </GroupTemplate>
                    <ItemTemplate>
                        <tr>
                            <td style="width:250px">
                                <asp:Label SkinID="lbInscription" ID="lbNomCompte" runat="server" Text='<%#Eval("Email") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Button skinid="btnActionPossible" ID="btInscription" runat="server" Text="Inscription" CommandName="inscription" CommandArgument='<%#Eval("noCompte") %>'/>
                            </td>
                            <td>
                                <asp:Button skinid="btnActionPossible" ID="btnModifier" runat="server" Text="Modifier compte" CommandName="modifier" CommandArgument='<%#Eval("noCompte") %>'/>
                            </td>
                            <td>
                                <asp:Button skinid="btnActionPossible" ID="btnPrerequis" runat="server" Text="Pérequis" CommandName="prerequis" CommandArgument='<%#Eval("noCompte") %>'/>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </asp:View>
           <asp:View runat="server" ID="viewInscription">
                <asp:Label SkinID="lbTitrePage" ID="lbListeInscription" runat="server" Text="Liste d'inscriptions par membres" Width="600px"></asp:Label>
                <asp:ListView ID="lViewMembre" runat="server" DataSourceID="entiDataSourceMembre" DataKeyNames="noMembre">
                    <LayoutTemplate>                                                   
                         <asp:PlaceHolder runat="server" id="GroupPlaceHolder"></asp:PlaceHolder>          
                    </LayoutTemplate>
                    <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
                    <ItemTemplate>
                       <div class="borderInscription">            
                        <asp:Label SkinID="lbInscription" ID="lbNomMembre" runat="server" Text='<%#Eval("Prénom") &" " & Eval("Nom") %>'></asp:Label>
               
                        <asp:HiddenField ID="hFielNoMembre" runat="server" Value='<%#Eval("noMembre") %>' />
                
                        <asp:ListView ID="lViewPaiement" runat="server" DataSourceID="entiDataSourcePaiement" DataKeyNames="noPaiement">
                            <LayoutTemplate>                       
                                    <table style="float:right">
                                        <asp:PlaceHolder runat="server" id="GroupPlaceHolder"></asp:PlaceHolder>
                                    </table>
                            </LayoutTemplate>
                            <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="longeurDeuxiemeColonneNOM">
                                        <asp:Label SkinID="lbInscription" ID="lbNomMembre" runat="server" Text='<%#Eval("Groupe.Cours.Nom") & " Groupe " & Eval("Groupe.noGroupe") %>'></asp:Label>                                    
                                    </td>
                                    <td>
                                        <asp:Button skinid="btnActionPossible" ID="btnDesinscrire" runat="server" 
                                        Text="Désinscrire" CommandName="Delete" CommandArgument='<%#Eval("noPaiement") %>'/>
                                    </td>                                
                               </tr>
                            </ItemTemplate>                  
                        </asp:ListView>
                    </div>              
                    <asp:EntityDataSource ID="entiDataSourcePaiement" runat="server" 
                        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
                        EntitySetName="Paiement" Where="it.Membre.noMembre = @noMembre" Include="Membre, Groupe.Cours" 
                        EnableDelete="True" OnDeleted="deletePaiement" OnDeleting="deletingPaiement" >
                     <WhereParameters>
                        <asp:ControlParameter Type="int32" Name="noMembre" ControlID="hFielNoMembre"/>
                     </WhereParameters>
                    </asp:EntityDataSource>
                   </ItemTemplate>
                </asp:ListView>
                <br /> 
                <asp:Button SkinID="btnActionPossible" ID="btnRetourInscription" runat="server" Text="Retour" />         
            </asp:View>
          
            <asp:View runat="server" ID="viewModifierCompte">
                 <br /> 
                <asp:Button SkinID="btnActionPossible" ID="btnRetourModifier" runat="server" Text="Retour" /> 
            </asp:View>
            <asp:View runat="server" ID="viewPrerequis">
                <asp:Label SkinID="lbTitrePage" ID="lbTitrePagePrerequis" runat="server" Text="Liste de prérequis par membres" Width="600px"></asp:Label>
                <asp:ListView ID="lViewMembrePrerequis" runat="server" DataSourceID="entiDataSourceMembre" DataKeyNames="noMembre" >
                    <LayoutTemplate>                                                   
                         <asp:PlaceHolder runat="server" id="GroupPlaceHolder"></asp:PlaceHolder>          
                    </LayoutTemplate>
                    <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
                    <ItemTemplate>
                       <div class="borderInscription">            
                        <asp:Label SkinID="lbInscription" ID="lbNomMembre" runat="server" Text='<%#Eval("Prénom") &" " & Eval("Nom") %>'></asp:Label>
                        <asp:ListView ID="lViewPaiementPrerequis" runat="server" 
                            DataSourceID="entiDataSourcePaiement" DataKeyNames="noPaiement" 
                            InsertItemPosition="LastItem" >
                            <LayoutTemplate>                       
                                    <table style="float:right">
                                        <asp:PlaceHolder runat="server" id="GroupPlaceHolder"></asp:PlaceHolder>
                                    </table>
                            </LayoutTemplate>
                            <GroupTemplate><asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder></GroupTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="longeurDeuxiemeColonneNOM">
                                        <asp:Label SkinID="lbInscription" ID="lbNomMembre" runat="server" Text='<%#Eval("Groupe.Cours.Nom") & " Groupe " & Eval("Groupe.noGroupe") %>'></asp:Label>                                    
                                    </td>                                                                                          
                               </tr>
                            </ItemTemplate>
                            <InsertItemTemplate>
                                    <tr>
                                        <td>
                                            <asp:DropDownList SkinID="dropDownListProvince" ID="dDListPrerequis" runat="server" DataSourceID="entiDataSourcePrerequis" DataTextField="nomCours"
                                              DataValueField="noGroupe" SelectedValue='<%#Bind("Groupe_noGroupe") %>'>
                                            </asp:DropDownList> 
                                            <asp:RequiredFieldValidator skinid="requisValidation" ID="requisValidationGroupe" 
                                            runat="server" ErrorMessage="La province doit être spécifié." ControlToValidate="dDListPrerequis" 
                                            Display="Dynamic">*</asp:RequiredFieldValidator>                                  
                                        </td>
                                        <td>
                                            <asp:Button skinid="btnActionPossible" ID="btnAjout" runat="server" 
                                            Text="Ajouter" CommandName="Insert" CommandArgument='<%#Eval("noPaiement") %>'/>
                                             
                                        </td>
                                   </tr>                             
                           </InsertItemTemplate>                                                       
                        </asp:ListView>
                    </div>
                        <asp:HiddenField ID="hFielNoMembre" runat="server" Value='<%#Eval("noMembre") %>' />  
                        <asp:HiddenField ID="hFielNoPaypal" runat="server" Value="Prerequis" />
                        <asp:HiddenField ID="hFielModePaiement" runat="server" Value="Prerequis" /> 
                        <asp:HiddenField ID="hFielPrix" runat="server" Value="0" />                 
                    <asp:EntityDataSource ID="entiDataSourcePaiement" runat="server" 
                        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
                        EntitySetName="Paiement" Where="it.Membre.noMembre = @noMembre" 
                        Include="Membre, Groupe.Cours" EnableInsert="True" OnInserted="ajoutePaiement">
                     <WhereParameters>
                        <asp:ControlParameter Type="int32" Name="noMembre" ControlID="hFielNoMembre"/>
                     </WhereParameters>
                     <InsertParameters>
                        <asp:ControlParameter Type="String" ControlID="hFielNoPaypal" Name="noPaypal" />
                        <asp:ControlParameter Type="String" ControlID="hFielModePaiement" Name="ModePaiement" />
                        <asp:ControlParameter Type="Int32" ControlID="hFielPrix" Name="Prix" />
                        <asp:ControlParameter Type="Int32" ControlID="hFielNoMembre" Name="Membre_noMembre" />
                     </InsertParameters>
                    </asp:EntityDataSource>
                    <asp:EntityDataSource ID="entiDataSourcePrerequis" runat="server" 
                          ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
                          EntitySetName="Groupe" Where='it.Nom = "Prerequis"' Select="it.[noGroupe], it.Cours.Nom AS nomCours"  >
                    </asp:EntityDataSource>
                   </ItemTemplate>                         
                </asp:ListView>
                <br /> 
                <asp:Button SkinID="btnActionPossible" ID="btnRetourPrerequis" runat="server" Text="Retour" /> 
            </asp:View>
        </asp:MultiView>    
        </div>
    <asp:HiddenField ID="hFieldNoCompte" runat="server" />
    
    <asp:EntityDataSource ID="entiDataSourceCompte" runat="server" 
            ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
            EnableFlattening="False" EntitySetName="Compte" Where='it.Email = @recherche OR (@recherche ="") AND it.Type = 1'>
        <WhereParameters>
            <asp:ControlParameter ControlID="tbRechercher" ConvertEmptyStringToNull="false" Name="recherche" Type="String" />
        </WhereParameters>    
    </asp:EntityDataSource>
     <asp:EntityDataSource ID="entiDataSourceMembre" runat="server"
        ConnectionString="name=ModelContainer" DefaultContainerName="ModelContainer" 
        EntitySetName="Membre" Where="it.Compte.noCompte = @noCompte" Include="Compte" >
        <WhereParameters>
            <asp:ControlParameter ControlID="hFieldNoCompte" Type="Int32" Name="noCompte" />
        </WhereParameters>
   </asp:EntityDataSource>
   
   
</asp:Content>
