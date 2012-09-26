
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 09/25/2012 13:52:40
-- Generated from EDMX file: C:\Users\Katherine\Documents\A2012\Projet I\Projet-1\App_Code\Model.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [ProjetRegulier2012_05];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_CompteProvince]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CompteSet] DROP CONSTRAINT [FK_CompteProvince];
GO
IF OBJECT_ID(N'[dbo].[FK_CompteMembre]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MembreSet] DROP CONSTRAINT [FK_CompteMembre];
GO
IF OBJECT_ID(N'[dbo].[FK_MembrePaiement]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PaiementSet] DROP CONSTRAINT [FK_MembrePaiement];
GO
IF OBJECT_ID(N'[dbo].[FK_GroupePaiement]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PaiementSet] DROP CONSTRAINT [FK_GroupePaiement];
GO
IF OBJECT_ID(N'[dbo].[FK_CatégorieCours]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CoursSet] DROP CONSTRAINT [FK_CatégorieCours];
GO
IF OBJECT_ID(N'[dbo].[FK_SessionCours]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CoursSet] DROP CONSTRAINT [FK_SessionCours];
GO
IF OBJECT_ID(N'[dbo].[FK_ListeDAttenteMembre]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ListeDAttenteSet] DROP CONSTRAINT [FK_ListeDAttenteMembre];
GO
IF OBJECT_ID(N'[dbo].[FK_ListeDAttenteGroupe]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ListeDAttenteSet] DROP CONSTRAINT [FK_ListeDAttenteGroupe];
GO
IF OBJECT_ID(N'[dbo].[FK_GroupeDAgeCours]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CoursSet] DROP CONSTRAINT [FK_GroupeDAgeCours];
GO
IF OBJECT_ID(N'[dbo].[FK_JourHoraire]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[HoraireSet] DROP CONSTRAINT [FK_JourHoraire];
GO
IF OBJECT_ID(N'[dbo].[FK_AnimateurGroupe]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[GroupeSet] DROP CONSTRAINT [FK_AnimateurGroupe];
GO
IF OBJECT_ID(N'[dbo].[FK_HoraireGroupe]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[HoraireSet] DROP CONSTRAINT [FK_HoraireGroupe];
GO
IF OBJECT_ID(N'[dbo].[FK_AnimateurProvince]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[AnimateurSet] DROP CONSTRAINT [FK_AnimateurProvince];
GO
IF OBJECT_ID(N'[dbo].[FK_AnimateurSpécialitéAnimateur]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SpécialitéAnimateurSet] DROP CONSTRAINT [FK_AnimateurSpécialitéAnimateur];
GO
IF OBJECT_ID(N'[dbo].[FK_SpécialitéSpécialitéAnimateur]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SpécialitéAnimateurSet] DROP CONSTRAINT [FK_SpécialitéSpécialitéAnimateur];
GO
IF OBJECT_ID(N'[dbo].[FK_GroupeCours]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[GroupeSet] DROP CONSTRAINT [FK_GroupeCours];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[ProvinceSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProvinceSet];
GO
IF OBJECT_ID(N'[dbo].[CompteSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CompteSet];
GO
IF OBJECT_ID(N'[dbo].[MembreSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MembreSet];
GO
IF OBJECT_ID(N'[dbo].[PaiementSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PaiementSet];
GO
IF OBJECT_ID(N'[dbo].[CatégorieSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CatégorieSet];
GO
IF OBJECT_ID(N'[dbo].[CoursSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CoursSet];
GO
IF OBJECT_ID(N'[dbo].[GroupeSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[GroupeSet];
GO
IF OBJECT_ID(N'[dbo].[ListeDAttenteSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ListeDAttenteSet];
GO
IF OBJECT_ID(N'[dbo].[SessionSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SessionSet];
GO
IF OBJECT_ID(N'[dbo].[GroupeDAgeSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[GroupeDAgeSet];
GO
IF OBJECT_ID(N'[dbo].[JourSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[JourSet];
GO
IF OBJECT_ID(N'[dbo].[HoraireSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[HoraireSet];
GO
IF OBJECT_ID(N'[dbo].[AnimateurSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[AnimateurSet];
GO
IF OBJECT_ID(N'[dbo].[ForfaitSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ForfaitSet];
GO
IF OBJECT_ID(N'[dbo].[SpécialitéSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SpécialitéSet];
GO
IF OBJECT_ID(N'[dbo].[SpécialitéAnimateurSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SpécialitéAnimateurSet];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'ProvinceSet'
CREATE TABLE [dbo].[ProvinceSet] (
    [noProvince] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(25)  NOT NULL
);
GO

-- Creating table 'CompteSet'
CREATE TABLE [dbo].[CompteSet] (
    [noCompte] int IDENTITY(1,1) NOT NULL,
    [Type] int  NOT NULL,
    [Adresse] nvarchar(50)  NOT NULL,
    [Ville] nvarchar(30)  NOT NULL,
    [CodePostal] nvarchar(6)  NOT NULL,
    [Abonnement] bit  NULL,
    [ModePaiement] nvarchar(15)  NULL,
    [motDePasseCrypté] nvarchar(100)  NOT NULL,
    [Email] nvarchar(30)  NOT NULL,
    [noTelephone] nvarchar(12)  NOT NULL,
    [Pays] nvarchar(max)  NOT NULL,
    [Province_noProvince] int  NOT NULL
);
GO

-- Creating table 'MembreSet'
CREATE TABLE [dbo].[MembreSet] (
    [noMembre] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(25)  NOT NULL,
    [Prénom] nvarchar(25)  NOT NULL,
    [DateNaissance] datetime  NOT NULL,
    [Propriétaire] bit  NOT NULL,
    [Compte_noCompte] int  NOT NULL
);
GO

-- Creating table 'PaiementSet'
CREATE TABLE [dbo].[PaiementSet] (
    [ModePaiement] nvarchar(15)  NOT NULL,
    [Prix] float  NOT NULL,
    [noCours] int  NOT NULL,
    [noGroupe] int  NOT NULL,
    [noMembre] int  NOT NULL,
    [noPaypal] nvarchar(30)  NOT NULL,
    [Membre_noMembre] int  NOT NULL,
    [Groupe_noGroupe] int  NOT NULL
);
GO

-- Creating table 'CatégorieSet'
CREATE TABLE [dbo].[CatégorieSet] (
    [noCatégorie] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(15)  NOT NULL
);
GO

-- Creating table 'CoursSet'
CREATE TABLE [dbo].[CoursSet] (
    [noCours] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(25)  NOT NULL,
    [Prix] float  NOT NULL,
    [Description] nvarchar(250)  NOT NULL,
    [noCoursRequis] int  NOT NULL,
    [Catégorie_noCatégorie] int  NOT NULL,
    [Session_noSession] int  NOT NULL,
    [GroupeDAge_noGroupeDAge] int  NOT NULL
);
GO

-- Creating table 'GroupeSet'
CREATE TABLE [dbo].[GroupeSet] (
    [noGroupe] int IDENTITY(1,1) NOT NULL,
    [Local] nvarchar(10)  NOT NULL,
    [DateDébut] datetime  NOT NULL,
    [DateFin] datetime  NOT NULL,
    [DateLimiteInscription] datetime  NOT NULL,
    [Âge] int  NOT NULL,
    [Animateur_noAnimateur] int  NOT NULL,
    [Cours_noCours] int  NOT NULL
);
GO

-- Creating table 'ListeDAttenteSet'
CREATE TABLE [dbo].[ListeDAttenteSet] (
    [DateAjout] datetime  NOT NULL,
    [noCours] int  NOT NULL,
    [noGroupe] int  NOT NULL,
    [noMembre] int  NOT NULL,
    [Membre_noMembre] int  NOT NULL,
    [Groupe_noGroupe] int  NOT NULL
);
GO

-- Creating table 'SessionSet'
CREATE TABLE [dbo].[SessionSet] (
    [noSession] int IDENTITY(1,1) NOT NULL,
    [NomSession] nvarchar(25)  NOT NULL
);
GO

-- Creating table 'GroupeDAgeSet'
CREATE TABLE [dbo].[GroupeDAgeSet] (
    [noGroupeDAge] int IDENTITY(1,1) NOT NULL,
    [NomGroupeDAge] nvarchar(25)  NOT NULL
);
GO

-- Creating table 'JourSet'
CREATE TABLE [dbo].[JourSet] (
    [noJour] int IDENTITY(1,1) NOT NULL,
    [nomJour] nvarchar(10)  NOT NULL
);
GO

-- Creating table 'HoraireSet'
CREATE TABLE [dbo].[HoraireSet] (
    [HeureDébut] datetime  NOT NULL,
    [HeureFin] datetime  NOT NULL,
    [noGroupe] int  NOT NULL,
    [noJour] int  NOT NULL,
    [Jour_noJour] int  NOT NULL,
    [Groupe_noGroupe] int  NOT NULL
);
GO

-- Creating table 'AnimateurSet'
CREATE TABLE [dbo].[AnimateurSet] (
    [noAnimateur] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(25)  NOT NULL,
    [Prénom] nvarchar(25)  NOT NULL,
    [DateNaissance] datetime  NOT NULL,
    [Adresse] nvarchar(50)  NOT NULL,
    [Ville] nvarchar(30)  NOT NULL,
    [CodePostal] nvarchar(6)  NOT NULL,
    [noTéléphone] nvarchar(12)  NOT NULL,
    [Province_noProvince] int  NOT NULL
);
GO

-- Creating table 'ForfaitSet'
CREATE TABLE [dbo].[ForfaitSet] (
    [nbInscrits] int IDENTITY(1,1) NOT NULL,
    [Coût] float  NOT NULL
);
GO

-- Creating table 'SpécialitéSet'
CREATE TABLE [dbo].[SpécialitéSet] (
    [noSpécialité] int IDENTITY(1,1) NOT NULL,
    [nomSpécialité] nvarchar(25)  NOT NULL
);
GO

-- Creating table 'SpécialitéAnimateurSet'
CREATE TABLE [dbo].[SpécialitéAnimateurSet] (
    [noSpécialité] int IDENTITY(1,1) NOT NULL,
    [noAnimateur] int  NOT NULL,
    [Animateur_noAnimateur] int  NOT NULL,
    [Spécialité_noSpécialité] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [noProvince] in table 'ProvinceSet'
ALTER TABLE [dbo].[ProvinceSet]
ADD CONSTRAINT [PK_ProvinceSet]
    PRIMARY KEY CLUSTERED ([noProvince] ASC);
GO

-- Creating primary key on [noCompte] in table 'CompteSet'
ALTER TABLE [dbo].[CompteSet]
ADD CONSTRAINT [PK_CompteSet]
    PRIMARY KEY CLUSTERED ([noCompte] ASC);
GO

-- Creating primary key on [noMembre] in table 'MembreSet'
ALTER TABLE [dbo].[MembreSet]
ADD CONSTRAINT [PK_MembreSet]
    PRIMARY KEY CLUSTERED ([noMembre] ASC);
GO

-- Creating primary key on [noCours], [noGroupe], [noMembre] in table 'PaiementSet'
ALTER TABLE [dbo].[PaiementSet]
ADD CONSTRAINT [PK_PaiementSet]
    PRIMARY KEY CLUSTERED ([noCours], [noGroupe], [noMembre] ASC);
GO

-- Creating primary key on [noCatégorie] in table 'CatégorieSet'
ALTER TABLE [dbo].[CatégorieSet]
ADD CONSTRAINT [PK_CatégorieSet]
    PRIMARY KEY CLUSTERED ([noCatégorie] ASC);
GO

-- Creating primary key on [noCours] in table 'CoursSet'
ALTER TABLE [dbo].[CoursSet]
ADD CONSTRAINT [PK_CoursSet]
    PRIMARY KEY CLUSTERED ([noCours] ASC);
GO

-- Creating primary key on [noGroupe] in table 'GroupeSet'
ALTER TABLE [dbo].[GroupeSet]
ADD CONSTRAINT [PK_GroupeSet]
    PRIMARY KEY CLUSTERED ([noGroupe] ASC);
GO

-- Creating primary key on [noCours], [noGroupe], [noMembre] in table 'ListeDAttenteSet'
ALTER TABLE [dbo].[ListeDAttenteSet]
ADD CONSTRAINT [PK_ListeDAttenteSet]
    PRIMARY KEY CLUSTERED ([noCours], [noGroupe], [noMembre] ASC);
GO

-- Creating primary key on [noSession] in table 'SessionSet'
ALTER TABLE [dbo].[SessionSet]
ADD CONSTRAINT [PK_SessionSet]
    PRIMARY KEY CLUSTERED ([noSession] ASC);
GO

-- Creating primary key on [noGroupeDAge] in table 'GroupeDAgeSet'
ALTER TABLE [dbo].[GroupeDAgeSet]
ADD CONSTRAINT [PK_GroupeDAgeSet]
    PRIMARY KEY CLUSTERED ([noGroupeDAge] ASC);
GO

-- Creating primary key on [noJour] in table 'JourSet'
ALTER TABLE [dbo].[JourSet]
ADD CONSTRAINT [PK_JourSet]
    PRIMARY KEY CLUSTERED ([noJour] ASC);
GO

-- Creating primary key on [noGroupe], [noJour] in table 'HoraireSet'
ALTER TABLE [dbo].[HoraireSet]
ADD CONSTRAINT [PK_HoraireSet]
    PRIMARY KEY CLUSTERED ([noGroupe], [noJour] ASC);
GO

-- Creating primary key on [noAnimateur] in table 'AnimateurSet'
ALTER TABLE [dbo].[AnimateurSet]
ADD CONSTRAINT [PK_AnimateurSet]
    PRIMARY KEY CLUSTERED ([noAnimateur] ASC);
GO

-- Creating primary key on [nbInscrits] in table 'ForfaitSet'
ALTER TABLE [dbo].[ForfaitSet]
ADD CONSTRAINT [PK_ForfaitSet]
    PRIMARY KEY CLUSTERED ([nbInscrits] ASC);
GO

-- Creating primary key on [noSpécialité] in table 'SpécialitéSet'
ALTER TABLE [dbo].[SpécialitéSet]
ADD CONSTRAINT [PK_SpécialitéSet]
    PRIMARY KEY CLUSTERED ([noSpécialité] ASC);
GO

-- Creating primary key on [noSpécialité], [noAnimateur] in table 'SpécialitéAnimateurSet'
ALTER TABLE [dbo].[SpécialitéAnimateurSet]
ADD CONSTRAINT [PK_SpécialitéAnimateurSet]
    PRIMARY KEY CLUSTERED ([noSpécialité], [noAnimateur] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Province_noProvince] in table 'CompteSet'
ALTER TABLE [dbo].[CompteSet]
ADD CONSTRAINT [FK_CompteProvince]
    FOREIGN KEY ([Province_noProvince])
    REFERENCES [dbo].[ProvinceSet]
        ([noProvince])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CompteProvince'
CREATE INDEX [IX_FK_CompteProvince]
ON [dbo].[CompteSet]
    ([Province_noProvince]);
GO

-- Creating foreign key on [Compte_noCompte] in table 'MembreSet'
ALTER TABLE [dbo].[MembreSet]
ADD CONSTRAINT [FK_CompteMembre]
    FOREIGN KEY ([Compte_noCompte])
    REFERENCES [dbo].[CompteSet]
        ([noCompte])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CompteMembre'
CREATE INDEX [IX_FK_CompteMembre]
ON [dbo].[MembreSet]
    ([Compte_noCompte]);
GO

-- Creating foreign key on [Membre_noMembre] in table 'PaiementSet'
ALTER TABLE [dbo].[PaiementSet]
ADD CONSTRAINT [FK_MembrePaiement]
    FOREIGN KEY ([Membre_noMembre])
    REFERENCES [dbo].[MembreSet]
        ([noMembre])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_MembrePaiement'
CREATE INDEX [IX_FK_MembrePaiement]
ON [dbo].[PaiementSet]
    ([Membre_noMembre]);
GO

-- Creating foreign key on [Groupe_noGroupe] in table 'PaiementSet'
ALTER TABLE [dbo].[PaiementSet]
ADD CONSTRAINT [FK_GroupePaiement]
    FOREIGN KEY ([Groupe_noGroupe])
    REFERENCES [dbo].[GroupeSet]
        ([noGroupe])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_GroupePaiement'
CREATE INDEX [IX_FK_GroupePaiement]
ON [dbo].[PaiementSet]
    ([Groupe_noGroupe]);
GO

-- Creating foreign key on [Catégorie_noCatégorie] in table 'CoursSet'
ALTER TABLE [dbo].[CoursSet]
ADD CONSTRAINT [FK_CatégorieCours]
    FOREIGN KEY ([Catégorie_noCatégorie])
    REFERENCES [dbo].[CatégorieSet]
        ([noCatégorie])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CatégorieCours'
CREATE INDEX [IX_FK_CatégorieCours]
ON [dbo].[CoursSet]
    ([Catégorie_noCatégorie]);
GO

-- Creating foreign key on [Session_noSession] in table 'CoursSet'
ALTER TABLE [dbo].[CoursSet]
ADD CONSTRAINT [FK_SessionCours]
    FOREIGN KEY ([Session_noSession])
    REFERENCES [dbo].[SessionSet]
        ([noSession])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_SessionCours'
CREATE INDEX [IX_FK_SessionCours]
ON [dbo].[CoursSet]
    ([Session_noSession]);
GO

-- Creating foreign key on [Membre_noMembre] in table 'ListeDAttenteSet'
ALTER TABLE [dbo].[ListeDAttenteSet]
ADD CONSTRAINT [FK_ListeDAttenteMembre]
    FOREIGN KEY ([Membre_noMembre])
    REFERENCES [dbo].[MembreSet]
        ([noMembre])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ListeDAttenteMembre'
CREATE INDEX [IX_FK_ListeDAttenteMembre]
ON [dbo].[ListeDAttenteSet]
    ([Membre_noMembre]);
GO

-- Creating foreign key on [Groupe_noGroupe] in table 'ListeDAttenteSet'
ALTER TABLE [dbo].[ListeDAttenteSet]
ADD CONSTRAINT [FK_ListeDAttenteGroupe]
    FOREIGN KEY ([Groupe_noGroupe])
    REFERENCES [dbo].[GroupeSet]
        ([noGroupe])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ListeDAttenteGroupe'
CREATE INDEX [IX_FK_ListeDAttenteGroupe]
ON [dbo].[ListeDAttenteSet]
    ([Groupe_noGroupe]);
GO

-- Creating foreign key on [GroupeDAge_noGroupeDAge] in table 'CoursSet'
ALTER TABLE [dbo].[CoursSet]
ADD CONSTRAINT [FK_GroupeDAgeCours]
    FOREIGN KEY ([GroupeDAge_noGroupeDAge])
    REFERENCES [dbo].[GroupeDAgeSet]
        ([noGroupeDAge])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_GroupeDAgeCours'
CREATE INDEX [IX_FK_GroupeDAgeCours]
ON [dbo].[CoursSet]
    ([GroupeDAge_noGroupeDAge]);
GO

-- Creating foreign key on [Jour_noJour] in table 'HoraireSet'
ALTER TABLE [dbo].[HoraireSet]
ADD CONSTRAINT [FK_JourHoraire]
    FOREIGN KEY ([Jour_noJour])
    REFERENCES [dbo].[JourSet]
        ([noJour])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_JourHoraire'
CREATE INDEX [IX_FK_JourHoraire]
ON [dbo].[HoraireSet]
    ([Jour_noJour]);
GO

-- Creating foreign key on [Animateur_noAnimateur] in table 'GroupeSet'
ALTER TABLE [dbo].[GroupeSet]
ADD CONSTRAINT [FK_AnimateurGroupe]
    FOREIGN KEY ([Animateur_noAnimateur])
    REFERENCES [dbo].[AnimateurSet]
        ([noAnimateur])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_AnimateurGroupe'
CREATE INDEX [IX_FK_AnimateurGroupe]
ON [dbo].[GroupeSet]
    ([Animateur_noAnimateur]);
GO

-- Creating foreign key on [Groupe_noGroupe] in table 'HoraireSet'
ALTER TABLE [dbo].[HoraireSet]
ADD CONSTRAINT [FK_HoraireGroupe]
    FOREIGN KEY ([Groupe_noGroupe])
    REFERENCES [dbo].[GroupeSet]
        ([noGroupe])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_HoraireGroupe'
CREATE INDEX [IX_FK_HoraireGroupe]
ON [dbo].[HoraireSet]
    ([Groupe_noGroupe]);
GO

-- Creating foreign key on [Province_noProvince] in table 'AnimateurSet'
ALTER TABLE [dbo].[AnimateurSet]
ADD CONSTRAINT [FK_AnimateurProvince]
    FOREIGN KEY ([Province_noProvince])
    REFERENCES [dbo].[ProvinceSet]
        ([noProvince])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_AnimateurProvince'
CREATE INDEX [IX_FK_AnimateurProvince]
ON [dbo].[AnimateurSet]
    ([Province_noProvince]);
GO

-- Creating foreign key on [Animateur_noAnimateur] in table 'SpécialitéAnimateurSet'
ALTER TABLE [dbo].[SpécialitéAnimateurSet]
ADD CONSTRAINT [FK_AnimateurSpécialitéAnimateur]
    FOREIGN KEY ([Animateur_noAnimateur])
    REFERENCES [dbo].[AnimateurSet]
        ([noAnimateur])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_AnimateurSpécialitéAnimateur'
CREATE INDEX [IX_FK_AnimateurSpécialitéAnimateur]
ON [dbo].[SpécialitéAnimateurSet]
    ([Animateur_noAnimateur]);
GO

-- Creating foreign key on [Spécialité_noSpécialité] in table 'SpécialitéAnimateurSet'
ALTER TABLE [dbo].[SpécialitéAnimateurSet]
ADD CONSTRAINT [FK_SpécialitéSpécialitéAnimateur]
    FOREIGN KEY ([Spécialité_noSpécialité])
    REFERENCES [dbo].[SpécialitéSet]
        ([noSpécialité])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_SpécialitéSpécialitéAnimateur'
CREATE INDEX [IX_FK_SpécialitéSpécialitéAnimateur]
ON [dbo].[SpécialitéAnimateurSet]
    ([Spécialité_noSpécialité]);
GO

-- Creating foreign key on [Cours_noCours] in table 'GroupeSet'
ALTER TABLE [dbo].[GroupeSet]
ADD CONSTRAINT [FK_GroupeCours]
    FOREIGN KEY ([Cours_noCours])
    REFERENCES [dbo].[CoursSet]
        ([noCours])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_GroupeCours'
CREATE INDEX [IX_FK_GroupeCours]
ON [dbo].[GroupeSet]
    ([Cours_noCours]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------