
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 11/01/2012 10:19:52
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

IF OBJECT_ID(N'[dbo].[FK_AnimateurGroupe]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Groupe] DROP CONSTRAINT [FK_AnimateurGroupe];
GO
IF OBJECT_ID(N'[dbo].[FK_AnimateurProvince]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Animateur] DROP CONSTRAINT [FK_AnimateurProvince];
GO
IF OBJECT_ID(N'[dbo].[FK_AnimateurSpécialitéAnimateur]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SpécialitéAnimateur] DROP CONSTRAINT [FK_AnimateurSpécialitéAnimateur];
GO
IF OBJECT_ID(N'[dbo].[FK_CatégorieCours]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Cours] DROP CONSTRAINT [FK_CatégorieCours];
GO
IF OBJECT_ID(N'[dbo].[FK_CompteMembre]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Membre] DROP CONSTRAINT [FK_CompteMembre];
GO
IF OBJECT_ID(N'[dbo].[FK_CompteProvince]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Compte] DROP CONSTRAINT [FK_CompteProvince];
GO
IF OBJECT_ID(N'[dbo].[FK_CoursCours]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Cours] DROP CONSTRAINT [FK_CoursCours];
GO
IF OBJECT_ID(N'[dbo].[FK_GroupeCours]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Groupe] DROP CONSTRAINT [FK_GroupeCours];
GO
IF OBJECT_ID(N'[dbo].[FK_GroupeDAgeCours]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Cours] DROP CONSTRAINT [FK_GroupeDAgeCours];
GO
IF OBJECT_ID(N'[dbo].[FK_SessionCours]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Cours] DROP CONSTRAINT [FK_SessionCours];
GO
IF OBJECT_ID(N'[dbo].[FK_GroupePaiement]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Paiement] DROP CONSTRAINT [FK_GroupePaiement];
GO
IF OBJECT_ID(N'[dbo].[FK_HoraireGroupe]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Horaire] DROP CONSTRAINT [FK_HoraireGroupe];
GO
IF OBJECT_ID(N'[dbo].[FK_ListeDAttenteGroupe]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ListeDAttente] DROP CONSTRAINT [FK_ListeDAttenteGroupe];
GO
IF OBJECT_ID(N'[dbo].[FK_JourHoraire]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Horaire] DROP CONSTRAINT [FK_JourHoraire];
GO
IF OBJECT_ID(N'[dbo].[FK_ListeDAttenteMembre]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ListeDAttente] DROP CONSTRAINT [FK_ListeDAttenteMembre];
GO
IF OBJECT_ID(N'[dbo].[FK_MembrePaiement]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Paiement] DROP CONSTRAINT [FK_MembrePaiement];
GO
IF OBJECT_ID(N'[dbo].[FK_SpécialitéSpécialitéAnimateur]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SpécialitéAnimateur] DROP CONSTRAINT [FK_SpécialitéSpécialitéAnimateur];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Animateur]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Animateur];
GO
IF OBJECT_ID(N'[dbo].[Catégorie]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Catégorie];
GO
IF OBJECT_ID(N'[dbo].[Compte]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Compte];
GO
IF OBJECT_ID(N'[dbo].[Cours]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Cours];
GO
IF OBJECT_ID(N'[dbo].[Forfait]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Forfait];
GO
IF OBJECT_ID(N'[dbo].[Groupe]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Groupe];
GO
IF OBJECT_ID(N'[dbo].[GroupeDAge]', 'U') IS NOT NULL
    DROP TABLE [dbo].[GroupeDAge];
GO
IF OBJECT_ID(N'[dbo].[Horaire]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Horaire];
GO
IF OBJECT_ID(N'[dbo].[Jour]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Jour];
GO
IF OBJECT_ID(N'[dbo].[ListeDAttente]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ListeDAttente];
GO
IF OBJECT_ID(N'[dbo].[Membre]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Membre];
GO
IF OBJECT_ID(N'[dbo].[Paiement]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Paiement];
GO
IF OBJECT_ID(N'[dbo].[Province]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Province];
GO
IF OBJECT_ID(N'[dbo].[Session]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Session];
GO
IF OBJECT_ID(N'[dbo].[Spécialité]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Spécialité];
GO
IF OBJECT_ID(N'[dbo].[SpécialitéAnimateur]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SpécialitéAnimateur];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Animateur'
CREATE TABLE [dbo].[Animateur] (
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

-- Creating table 'Catégorie'
CREATE TABLE [dbo].[Catégorie] (
    [noCatégorie] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(15)  NOT NULL
);
GO

-- Creating table 'Compte'
CREATE TABLE [dbo].[Compte] (
    [noCompte] int IDENTITY(1,1) NOT NULL,
    [Type] int  NOT NULL,
    [Adresse] nvarchar(50)  NOT NULL,
    [Ville] nvarchar(30)  NOT NULL,
    [CodePostal] nvarchar(6)  NOT NULL,
    [ModePaiement] nvarchar(20)  NULL,
    [motDePasseCrypté] nvarchar(100)  NOT NULL,
    [Email] nvarchar(30)  NOT NULL,
    [noTelephone] nvarchar(12)  NOT NULL,
    [Pays] nvarchar(20)  NOT NULL,
    [Province_noProvince] int  NOT NULL
);
GO

-- Creating table 'Cours'
CREATE TABLE [dbo].[Cours] (
    [noCours] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(25)  NOT NULL,
    [Prix] float  NOT NULL,
    [Description] nvarchar(250)  NULL,
    [Catégorie_noCatégorie] int  NOT NULL,
    [Session_noSession] int  NOT NULL,
    [GroupeDAge_noGroupeDAge] int  NOT NULL,
    [lePrerequis_noCours] int  NULL,
    [Actif] bit  NOT NULL
);
GO

-- Creating table 'Forfait'
CREATE TABLE [dbo].[Forfait] (
    [nbInscrits] int  NOT NULL,
    [Coût] float  NOT NULL
);
GO

-- Creating table 'Groupe'
CREATE TABLE [dbo].[Groupe] (
    [noGroupe] int IDENTITY(1,1) NOT NULL,
    [Local] nvarchar(10)  NOT NULL,
    [DateDebut] datetime  NOT NULL,
    [DateFin] datetime  NOT NULL,
    [DateLimiteInscription] datetime  NOT NULL,
    [AgeMinimum] int  NOT NULL,
    [Agemaximum] nvarchar(max)  NOT NULL,
    [Animateur_noAnimateur] int  NOT NULL,
    [Cours_noCours] int  NOT NULL,
    [Actif] bit  NOT NULL,
    [Nom] nvarchar(10)  NOT NULL
);
GO

-- Creating table 'GroupeDAge'
CREATE TABLE [dbo].[GroupeDAge] (
    [noGroupeDAge] int IDENTITY(1,1) NOT NULL,
    [NomGroupeDAge] nvarchar(25)  NOT NULL
);
GO

-- Creating table 'Horaire'
CREATE TABLE [dbo].[Horaire] (
    [HeureDebut] datetime  NOT NULL,
    [HeureFin] datetime  NOT NULL,
    [noHoraire] int IDENTITY(1,1) NOT NULL,
    [Jour_noJour] int  NOT NULL,
    [Groupe_noGroupe] int  NOT NULL
);
GO

-- Creating table 'Jour'
CREATE TABLE [dbo].[Jour] (
    [noJour] int IDENTITY(1,1) NOT NULL,
    [nomJour] nvarchar(10)  NOT NULL
);
GO

-- Creating table 'ListeDAttente'
CREATE TABLE [dbo].[ListeDAttente] (
    [DateAjout] datetime  NOT NULL,
    [noListeDAttente] int IDENTITY(1,1) NOT NULL,
    [Membre_noMembre] int  NOT NULL,
    [Groupe_noGroupe] int  NOT NULL,
    [Accepte] bit  NOT NULL
);
GO

-- Creating table 'Membre'
CREATE TABLE [dbo].[Membre] (
    [noMembre] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(25)  NOT NULL,
    [Prénom] nvarchar(25)  NOT NULL,
    [DateNaissance] datetime  NOT NULL,
    [Propriétaire] bit  NOT NULL,
    [Compte_noCompte] int  NOT NULL
);
GO

-- Creating table 'Paiement'
CREATE TABLE [dbo].[Paiement] (
    [ModePaiement] nvarchar(15)  NULL,
    [Prix] float  NOT NULL,
    [noPaypal] nvarchar(30)  NOT NULL,
    [noPaiement] int IDENTITY(1,1) NOT NULL,
    [Membre_noMembre] int  NOT NULL,
    [Groupe_noGroupe] int  NOT NULL
);
GO

-- Creating table 'Province'
CREATE TABLE [dbo].[Province] (
    [noProvince] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(25)  NOT NULL
);
GO

-- Creating table 'Session'
CREATE TABLE [dbo].[Session] (
    [noSession] int IDENTITY(1,1) NOT NULL,
    [NomSession] nvarchar(25)  NOT NULL
);
GO

-- Creating table 'Spécialité'
CREATE TABLE [dbo].[Spécialité] (
    [noSpécialité] int IDENTITY(1,1) NOT NULL,
    [nomSpécialité] nvarchar(25)  NOT NULL
);
GO

-- Creating table 'SpécialitéAnimateur'
CREATE TABLE [dbo].[SpécialitéAnimateur] (
    [Id] int  NOT NULL,
    [Animateur_noAnimateur] int  NOT NULL,
    [Spécialité_noSpécialité] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [noAnimateur] in table 'Animateur'
ALTER TABLE [dbo].[Animateur]
ADD CONSTRAINT [PK_Animateur]
    PRIMARY KEY CLUSTERED ([noAnimateur] ASC);
GO

-- Creating primary key on [noCatégorie] in table 'Catégorie'
ALTER TABLE [dbo].[Catégorie]
ADD CONSTRAINT [PK_Catégorie]
    PRIMARY KEY CLUSTERED ([noCatégorie] ASC);
GO

-- Creating primary key on [noCompte] in table 'Compte'
ALTER TABLE [dbo].[Compte]
ADD CONSTRAINT [PK_Compte]
    PRIMARY KEY CLUSTERED ([noCompte] ASC);
GO

-- Creating primary key on [noCours] in table 'Cours'
ALTER TABLE [dbo].[Cours]
ADD CONSTRAINT [PK_Cours]
    PRIMARY KEY CLUSTERED ([noCours] ASC);
GO

-- Creating primary key on [nbInscrits] in table 'Forfait'
ALTER TABLE [dbo].[Forfait]
ADD CONSTRAINT [PK_Forfait]
    PRIMARY KEY CLUSTERED ([nbInscrits] ASC);
GO

-- Creating primary key on [noGroupe] in table 'Groupe'
ALTER TABLE [dbo].[Groupe]
ADD CONSTRAINT [PK_Groupe]
    PRIMARY KEY CLUSTERED ([noGroupe] ASC);
GO

-- Creating primary key on [noGroupeDAge] in table 'GroupeDAge'
ALTER TABLE [dbo].[GroupeDAge]
ADD CONSTRAINT [PK_GroupeDAge]
    PRIMARY KEY CLUSTERED ([noGroupeDAge] ASC);
GO

-- Creating primary key on [noHoraire] in table 'Horaire'
ALTER TABLE [dbo].[Horaire]
ADD CONSTRAINT [PK_Horaire]
    PRIMARY KEY CLUSTERED ([noHoraire] ASC);
GO

-- Creating primary key on [noJour] in table 'Jour'
ALTER TABLE [dbo].[Jour]
ADD CONSTRAINT [PK_Jour]
    PRIMARY KEY CLUSTERED ([noJour] ASC);
GO

-- Creating primary key on [noListeDAttente] in table 'ListeDAttente'
ALTER TABLE [dbo].[ListeDAttente]
ADD CONSTRAINT [PK_ListeDAttente]
    PRIMARY KEY CLUSTERED ([noListeDAttente] ASC);
GO

-- Creating primary key on [noMembre] in table 'Membre'
ALTER TABLE [dbo].[Membre]
ADD CONSTRAINT [PK_Membre]
    PRIMARY KEY CLUSTERED ([noMembre] ASC);
GO

-- Creating primary key on [noPaiement] in table 'Paiement'
ALTER TABLE [dbo].[Paiement]
ADD CONSTRAINT [PK_Paiement]
    PRIMARY KEY CLUSTERED ([noPaiement] ASC);
GO

-- Creating primary key on [noProvince] in table 'Province'
ALTER TABLE [dbo].[Province]
ADD CONSTRAINT [PK_Province]
    PRIMARY KEY CLUSTERED ([noProvince] ASC);
GO

-- Creating primary key on [noSession] in table 'Session'
ALTER TABLE [dbo].[Session]
ADD CONSTRAINT [PK_Session]
    PRIMARY KEY CLUSTERED ([noSession] ASC);
GO

-- Creating primary key on [noSpécialité] in table 'Spécialité'
ALTER TABLE [dbo].[Spécialité]
ADD CONSTRAINT [PK_Spécialité]
    PRIMARY KEY CLUSTERED ([noSpécialité] ASC);
GO

-- Creating primary key on [Id] in table 'SpécialitéAnimateur'
ALTER TABLE [dbo].[SpécialitéAnimateur]
ADD CONSTRAINT [PK_SpécialitéAnimateur]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Animateur_noAnimateur] in table 'Groupe'
ALTER TABLE [dbo].[Groupe]
ADD CONSTRAINT [FK_AnimateurGroupe]
    FOREIGN KEY ([Animateur_noAnimateur])
    REFERENCES [dbo].[Animateur]
        ([noAnimateur])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_AnimateurGroupe'
CREATE INDEX [IX_FK_AnimateurGroupe]
ON [dbo].[Groupe]
    ([Animateur_noAnimateur]);
GO

-- Creating foreign key on [Province_noProvince] in table 'Animateur'
ALTER TABLE [dbo].[Animateur]
ADD CONSTRAINT [FK_AnimateurProvince]
    FOREIGN KEY ([Province_noProvince])
    REFERENCES [dbo].[Province]
        ([noProvince])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_AnimateurProvince'
CREATE INDEX [IX_FK_AnimateurProvince]
ON [dbo].[Animateur]
    ([Province_noProvince]);
GO

-- Creating foreign key on [Animateur_noAnimateur] in table 'SpécialitéAnimateur'
ALTER TABLE [dbo].[SpécialitéAnimateur]
ADD CONSTRAINT [FK_AnimateurSpécialitéAnimateur]
    FOREIGN KEY ([Animateur_noAnimateur])
    REFERENCES [dbo].[Animateur]
        ([noAnimateur])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_AnimateurSpécialitéAnimateur'
CREATE INDEX [IX_FK_AnimateurSpécialitéAnimateur]
ON [dbo].[SpécialitéAnimateur]
    ([Animateur_noAnimateur]);
GO

-- Creating foreign key on [Catégorie_noCatégorie] in table 'Cours'
ALTER TABLE [dbo].[Cours]
ADD CONSTRAINT [FK_CatégorieCours]
    FOREIGN KEY ([Catégorie_noCatégorie])
    REFERENCES [dbo].[Catégorie]
        ([noCatégorie])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CatégorieCours'
CREATE INDEX [IX_FK_CatégorieCours]
ON [dbo].[Cours]
    ([Catégorie_noCatégorie]);
GO

-- Creating foreign key on [Compte_noCompte] in table 'Membre'
ALTER TABLE [dbo].[Membre]
ADD CONSTRAINT [FK_CompteMembre]
    FOREIGN KEY ([Compte_noCompte])
    REFERENCES [dbo].[Compte]
        ([noCompte])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CompteMembre'
CREATE INDEX [IX_FK_CompteMembre]
ON [dbo].[Membre]
    ([Compte_noCompte]);
GO

-- Creating foreign key on [Province_noProvince] in table 'Compte'
ALTER TABLE [dbo].[Compte]
ADD CONSTRAINT [FK_CompteProvince]
    FOREIGN KEY ([Province_noProvince])
    REFERENCES [dbo].[Province]
        ([noProvince])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CompteProvince'
CREATE INDEX [IX_FK_CompteProvince]
ON [dbo].[Compte]
    ([Province_noProvince]);
GO

-- Creating foreign key on [lePrerequis_noCours] in table 'Cours'
ALTER TABLE [dbo].[Cours]
ADD CONSTRAINT [FK_CoursCours]
    FOREIGN KEY ([lePrerequis_noCours])
    REFERENCES [dbo].[Cours]
        ([noCours])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CoursCours'
CREATE INDEX [IX_FK_CoursCours]
ON [dbo].[Cours]
    ([lePrerequis_noCours]);
GO

-- Creating foreign key on [Cours_noCours] in table 'Groupe'
ALTER TABLE [dbo].[Groupe]
ADD CONSTRAINT [FK_GroupeCours]
    FOREIGN KEY ([Cours_noCours])
    REFERENCES [dbo].[Cours]
        ([noCours])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_GroupeCours'
CREATE INDEX [IX_FK_GroupeCours]
ON [dbo].[Groupe]
    ([Cours_noCours]);
GO

-- Creating foreign key on [GroupeDAge_noGroupeDAge] in table 'Cours'
ALTER TABLE [dbo].[Cours]
ADD CONSTRAINT [FK_GroupeDAgeCours]
    FOREIGN KEY ([GroupeDAge_noGroupeDAge])
    REFERENCES [dbo].[GroupeDAge]
        ([noGroupeDAge])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_GroupeDAgeCours'
CREATE INDEX [IX_FK_GroupeDAgeCours]
ON [dbo].[Cours]
    ([GroupeDAge_noGroupeDAge]);
GO

-- Creating foreign key on [Session_noSession] in table 'Cours'
ALTER TABLE [dbo].[Cours]
ADD CONSTRAINT [FK_SessionCours]
    FOREIGN KEY ([Session_noSession])
    REFERENCES [dbo].[Session]
        ([noSession])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_SessionCours'
CREATE INDEX [IX_FK_SessionCours]
ON [dbo].[Cours]
    ([Session_noSession]);
GO

-- Creating foreign key on [Groupe_noGroupe] in table 'Paiement'
ALTER TABLE [dbo].[Paiement]
ADD CONSTRAINT [FK_GroupePaiement]
    FOREIGN KEY ([Groupe_noGroupe])
    REFERENCES [dbo].[Groupe]
        ([noGroupe])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_GroupePaiement'
CREATE INDEX [IX_FK_GroupePaiement]
ON [dbo].[Paiement]
    ([Groupe_noGroupe]);
GO

-- Creating foreign key on [Groupe_noGroupe] in table 'Horaire'
ALTER TABLE [dbo].[Horaire]
ADD CONSTRAINT [FK_HoraireGroupe]
    FOREIGN KEY ([Groupe_noGroupe])
    REFERENCES [dbo].[Groupe]
        ([noGroupe])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_HoraireGroupe'
CREATE INDEX [IX_FK_HoraireGroupe]
ON [dbo].[Horaire]
    ([Groupe_noGroupe]);
GO

-- Creating foreign key on [Groupe_noGroupe] in table 'ListeDAttente'
ALTER TABLE [dbo].[ListeDAttente]
ADD CONSTRAINT [FK_ListeDAttenteGroupe]
    FOREIGN KEY ([Groupe_noGroupe])
    REFERENCES [dbo].[Groupe]
        ([noGroupe])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ListeDAttenteGroupe'
CREATE INDEX [IX_FK_ListeDAttenteGroupe]
ON [dbo].[ListeDAttente]
    ([Groupe_noGroupe]);
GO

-- Creating foreign key on [Jour_noJour] in table 'Horaire'
ALTER TABLE [dbo].[Horaire]
ADD CONSTRAINT [FK_JourHoraire]
    FOREIGN KEY ([Jour_noJour])
    REFERENCES [dbo].[Jour]
        ([noJour])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_JourHoraire'
CREATE INDEX [IX_FK_JourHoraire]
ON [dbo].[Horaire]
    ([Jour_noJour]);
GO

-- Creating foreign key on [Membre_noMembre] in table 'ListeDAttente'
ALTER TABLE [dbo].[ListeDAttente]
ADD CONSTRAINT [FK_ListeDAttenteMembre]
    FOREIGN KEY ([Membre_noMembre])
    REFERENCES [dbo].[Membre]
        ([noMembre])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ListeDAttenteMembre'
CREATE INDEX [IX_FK_ListeDAttenteMembre]
ON [dbo].[ListeDAttente]
    ([Membre_noMembre]);
GO

-- Creating foreign key on [Membre_noMembre] in table 'Paiement'
ALTER TABLE [dbo].[Paiement]
ADD CONSTRAINT [FK_MembrePaiement]
    FOREIGN KEY ([Membre_noMembre])
    REFERENCES [dbo].[Membre]
        ([noMembre])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_MembrePaiement'
CREATE INDEX [IX_FK_MembrePaiement]
ON [dbo].[Paiement]
    ([Membre_noMembre]);
GO

-- Creating foreign key on [Spécialité_noSpécialité] in table 'SpécialitéAnimateur'
ALTER TABLE [dbo].[SpécialitéAnimateur]
ADD CONSTRAINT [FK_SpécialitéSpécialitéAnimateur]
    FOREIGN KEY ([Spécialité_noSpécialité])
    REFERENCES [dbo].[Spécialité]
        ([noSpécialité])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_SpécialitéSpécialitéAnimateur'
CREATE INDEX [IX_FK_SpécialitéSpécialitéAnimateur]
ON [dbo].[SpécialitéAnimateur]
    ([Spécialité_noSpécialité]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------