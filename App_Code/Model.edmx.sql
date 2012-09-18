
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 09/18/2012 09:40:31
-- Generated from EDMX file: C:\Users\Katherine\Documents\A2012\Projet I\Projet-1\App_Code\Model.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [test];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_CompteProvince]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CompteSet] DROP CONSTRAINT [FK_CompteProvince];
GO
IF OBJECT_ID(N'[dbo].[FK_PaysCompte]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CompteSet] DROP CONSTRAINT [FK_PaysCompte];
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
IF OBJECT_ID(N'[dbo].[FK_PrérequisCours_Prérequis]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PrérequisCours] DROP CONSTRAINT [FK_PrérequisCours_Prérequis];
GO
IF OBJECT_ID(N'[dbo].[FK_PrérequisCours_Cours]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PrérequisCours] DROP CONSTRAINT [FK_PrérequisCours_Cours];
GO
IF OBJECT_ID(N'[dbo].[FK_AnimateurProvince]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[AnimateurSet] DROP CONSTRAINT [FK_AnimateurProvince];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[ProvinceSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProvinceSet];
GO
IF OBJECT_ID(N'[dbo].[PaysSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PaysSet];
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
IF OBJECT_ID(N'[dbo].[PrérequisSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PrérequisSet];
GO
IF OBJECT_ID(N'[dbo].[PrérequisCours]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PrérequisCours];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'ProvinceSet'
CREATE TABLE [dbo].[ProvinceSet] (
    [noProvince] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'PaysSet'
CREATE TABLE [dbo].[PaysSet] (
    [noPays] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'CompteSet'
CREATE TABLE [dbo].[CompteSet] (
    [noCompte] int IDENTITY(1,1) NOT NULL,
    [Préposé] bit  NOT NULL,
    [Adresse] nvarchar(max)  NOT NULL,
    [Ville] nvarchar(max)  NOT NULL,
    [CodePostal] nvarchar(max)  NOT NULL,
    [Abonnement] nvarchar(max)  NULL,
    [ModePaiement] nvarchar(max)  NULL,
    [motDePasseCrypté] nvarchar(max)  NOT NULL,
    [Email] nvarchar(max)  NOT NULL,
    [Province_noProvince] int  NOT NULL,
    [Pays_noPays] int  NOT NULL
);
GO

-- Creating table 'MembreSet'
CREATE TABLE [dbo].[MembreSet] (
    [noMembre] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(max)  NOT NULL,
    [Prénom] nvarchar(max)  NOT NULL,
    [DateNaissance] datetime  NOT NULL,
    [Propriétaire] bit  NOT NULL,
    [Compte_noCompte] int  NOT NULL
);
GO

-- Creating table 'PaiementSet'
CREATE TABLE [dbo].[PaiementSet] (
    [ModePaiement] nvarchar(max)  NOT NULL,
    [Prix] float  NOT NULL,
    [noCours] int  NOT NULL,
    [noGroupe] int  NOT NULL,
    [noMembre] int  NOT NULL,
    [noPaypal] int  NOT NULL,
    [Membre_noMembre] int  NOT NULL,
    [Groupe_noGroupe] int  NOT NULL,
    [Groupe_noCours] int  NOT NULL
);
GO

-- Creating table 'CatégorieSet'
CREATE TABLE [dbo].[CatégorieSet] (
    [noCatégorie] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'CoursSet'
CREATE TABLE [dbo].[CoursSet] (
    [noCours] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(max)  NOT NULL,
    [Prix] float  NOT NULL,
    [Description] nvarchar(max)  NOT NULL,
    [Catégorie_noCatégorie] int  NOT NULL,
    [Session_noSession] int  NOT NULL,
    [GroupeDAge_noGroupeDAge] int  NOT NULL
);
GO

-- Creating table 'GroupeSet'
CREATE TABLE [dbo].[GroupeSet] (
    [noGroupe] int IDENTITY(1,1) NOT NULL,
    [Local] nvarchar(max)  NOT NULL,
    [DateDébut] datetime  NOT NULL,
    [DateFin] datetime  NOT NULL,
    [DateLimiteInscription] datetime  NOT NULL,
    [noCours] int  NOT NULL,
    [Âge] int  NOT NULL,
    [Animateur_noAnimateur] int  NOT NULL
);
GO

-- Creating table 'ListeDAttenteSet'
CREATE TABLE [dbo].[ListeDAttenteSet] (
    [DateAjout] datetime  NOT NULL,
    [noCours] int  NOT NULL,
    [noGroupe] int  NOT NULL,
    [noMembre] int  NOT NULL,
    [Membre_noMembre] int  NOT NULL,
    [Groupe_noGroupe] int  NOT NULL,
    [Groupe_noCours] int  NOT NULL
);
GO

-- Creating table 'SessionSet'
CREATE TABLE [dbo].[SessionSet] (
    [noSession] int IDENTITY(1,1) NOT NULL
);
GO

-- Creating table 'GroupeDAgeSet'
CREATE TABLE [dbo].[GroupeDAgeSet] (
    [noGroupeDAge] int IDENTITY(1,1) NOT NULL
);
GO

-- Creating table 'JourSet'
CREATE TABLE [dbo].[JourSet] (
    [noJour] int IDENTITY(1,1) NOT NULL
);
GO

-- Creating table 'HoraireSet'
CREATE TABLE [dbo].[HoraireSet] (
    [HeureDébut] datetime  NOT NULL,
    [HeureFin] datetime  NOT NULL,
    [noCours] int  NOT NULL,
    [noGroupe] int  NOT NULL,
    [noJour] int  NOT NULL,
    [Jour_noJour] int  NOT NULL,
    [Groupe_noGroupe] int  NOT NULL,
    [Groupe_noCours] int  NOT NULL
);
GO

-- Creating table 'AnimateurSet'
CREATE TABLE [dbo].[AnimateurSet] (
    [noAnimateur] int IDENTITY(1,1) NOT NULL,
    [Nom] nvarchar(max)  NOT NULL,
    [Prénom] nvarchar(max)  NOT NULL,
    [DateNaissance] datetime  NOT NULL,
    [Adresse] nvarchar(max)  NOT NULL,
    [Ville] nvarchar(max)  NOT NULL,
    [CodePostal] nvarchar(max)  NOT NULL,
    [noTéléphone] int  NOT NULL,
    [Province_noProvince] int  NOT NULL
);
GO

-- Creating table 'ForfaitSet'
CREATE TABLE [dbo].[ForfaitSet] (
    [nbInscrits] int IDENTITY(1,1) NOT NULL,
    [Coût] float  NOT NULL
);
GO

-- Creating table 'PrérequisSet'
CREATE TABLE [dbo].[PrérequisSet] (
    [noCoursRequis] int IDENTITY(1,1) NOT NULL,
    [noCours] int  NOT NULL
);
GO

-- Creating table 'PrérequisCours'
CREATE TABLE [dbo].[PrérequisCours] (
    [Prérequis_noCoursRequis] int  NOT NULL,
    [Prérequis_noCours] int  NOT NULL,
    [Cours_noCours] int  NOT NULL
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

-- Creating primary key on [noPays] in table 'PaysSet'
ALTER TABLE [dbo].[PaysSet]
ADD CONSTRAINT [PK_PaysSet]
    PRIMARY KEY CLUSTERED ([noPays] ASC);
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

-- Creating primary key on [noGroupe], [noCours] in table 'GroupeSet'
ALTER TABLE [dbo].[GroupeSet]
ADD CONSTRAINT [PK_GroupeSet]
    PRIMARY KEY CLUSTERED ([noGroupe], [noCours] ASC);
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

-- Creating primary key on [noCours], [noGroupe], [noJour] in table 'HoraireSet'
ALTER TABLE [dbo].[HoraireSet]
ADD CONSTRAINT [PK_HoraireSet]
    PRIMARY KEY CLUSTERED ([noCours], [noGroupe], [noJour] ASC);
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

-- Creating primary key on [noCoursRequis], [noCours] in table 'PrérequisSet'
ALTER TABLE [dbo].[PrérequisSet]
ADD CONSTRAINT [PK_PrérequisSet]
    PRIMARY KEY CLUSTERED ([noCoursRequis], [noCours] ASC);
GO

-- Creating primary key on [Prérequis_noCoursRequis], [Prérequis_noCours], [Cours_noCours] in table 'PrérequisCours'
ALTER TABLE [dbo].[PrérequisCours]
ADD CONSTRAINT [PK_PrérequisCours]
    PRIMARY KEY NONCLUSTERED ([Prérequis_noCoursRequis], [Prérequis_noCours], [Cours_noCours] ASC);
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

-- Creating foreign key on [Pays_noPays] in table 'CompteSet'
ALTER TABLE [dbo].[CompteSet]
ADD CONSTRAINT [FK_PaysCompte]
    FOREIGN KEY ([Pays_noPays])
    REFERENCES [dbo].[PaysSet]
        ([noPays])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_PaysCompte'
CREATE INDEX [IX_FK_PaysCompte]
ON [dbo].[CompteSet]
    ([Pays_noPays]);
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

-- Creating foreign key on [Groupe_noGroupe], [Groupe_noCours] in table 'PaiementSet'
ALTER TABLE [dbo].[PaiementSet]
ADD CONSTRAINT [FK_GroupePaiement]
    FOREIGN KEY ([Groupe_noGroupe], [Groupe_noCours])
    REFERENCES [dbo].[GroupeSet]
        ([noGroupe], [noCours])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_GroupePaiement'
CREATE INDEX [IX_FK_GroupePaiement]
ON [dbo].[PaiementSet]
    ([Groupe_noGroupe], [Groupe_noCours]);
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

-- Creating foreign key on [Groupe_noGroupe], [Groupe_noCours] in table 'ListeDAttenteSet'
ALTER TABLE [dbo].[ListeDAttenteSet]
ADD CONSTRAINT [FK_ListeDAttenteGroupe]
    FOREIGN KEY ([Groupe_noGroupe], [Groupe_noCours])
    REFERENCES [dbo].[GroupeSet]
        ([noGroupe], [noCours])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ListeDAttenteGroupe'
CREATE INDEX [IX_FK_ListeDAttenteGroupe]
ON [dbo].[ListeDAttenteSet]
    ([Groupe_noGroupe], [Groupe_noCours]);
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

-- Creating foreign key on [Groupe_noGroupe], [Groupe_noCours] in table 'HoraireSet'
ALTER TABLE [dbo].[HoraireSet]
ADD CONSTRAINT [FK_HoraireGroupe]
    FOREIGN KEY ([Groupe_noGroupe], [Groupe_noCours])
    REFERENCES [dbo].[GroupeSet]
        ([noGroupe], [noCours])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_HoraireGroupe'
CREATE INDEX [IX_FK_HoraireGroupe]
ON [dbo].[HoraireSet]
    ([Groupe_noGroupe], [Groupe_noCours]);
GO

-- Creating foreign key on [Prérequis_noCoursRequis], [Prérequis_noCours] in table 'PrérequisCours'
ALTER TABLE [dbo].[PrérequisCours]
ADD CONSTRAINT [FK_PrérequisCours_Prérequis]
    FOREIGN KEY ([Prérequis_noCoursRequis], [Prérequis_noCours])
    REFERENCES [dbo].[PrérequisSet]
        ([noCoursRequis], [noCours])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Cours_noCours] in table 'PrérequisCours'
ALTER TABLE [dbo].[PrérequisCours]
ADD CONSTRAINT [FK_PrérequisCours_Cours]
    FOREIGN KEY ([Cours_noCours])
    REFERENCES [dbo].[CoursSet]
        ([noCours])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_PrérequisCours_Cours'
CREATE INDEX [IX_FK_PrérequisCours_Cours]
ON [dbo].[PrérequisCours]
    ([Cours_noCours]);
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

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------