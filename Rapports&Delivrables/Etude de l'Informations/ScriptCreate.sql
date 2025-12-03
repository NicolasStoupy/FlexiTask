IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
CREATE TABLE [AspNetRoles] (
    [Id] nvarchar(450) NOT NULL,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
);

CREATE TABLE [AspNetUsers] (
    [Id] nvarchar(450) NOT NULL,
    [UserName] nvarchar(256) NULL,
    [NormalizedUserName] nvarchar(256) NULL,
    [Email] nvarchar(256) NULL,
    [NormalizedEmail] nvarchar(256) NULL,
    [EmailConfirmed] bit NOT NULL,
    [PasswordHash] nvarchar(max) NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [LockoutEnabled] bit NOT NULL,
    [AccessFailedCount] int NOT NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
);

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [RoleId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [UserId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserRoles] (
    [UserId] nvarchar(450) NOT NULL,
    [RoleId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserTokens] (
    [UserId] nvarchar(450) NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);

CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;

CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);

CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);

CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);

CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'00000000000000_CreateIdentitySchema', N'9.0.7');


CREATE TABLE Plant(
   PlantID INT IDENTITY,
   Code VARCHAR(4)  NOT NULL,
   CreatedAt DATETIME2 NOT NULL,
   CommonName VARCHAR(50) ,
   LanguageEnum VARCHAR(50) NOT NULL,
   Created           DATETIMEOFFSET(7) NOT NULL, /* Auditable entity */
   CreatedBy         NVARCHAR(100)     NULL,/* Auditable entity */
   LastModified      DATETIMEOFFSET(7) NOT NULL,/* Auditable entity */
   LastModifiedBy    NVARCHAR(100)     NULL,/* Auditable entity */
   PRIMARY KEY(PlantID),
   UNIQUE(Code)
);

CREATE TABLE WorkAreaType(
   WorkAreaTypeID INT IDENTITY,
   Code VARCHAR(10) ,
   Label VARCHAR(50) ,
   Created           DATETIMEOFFSET(7) NOT NULL, /* Auditable entity */
   CreatedBy         NVARCHAR(100)     NULL,/* Auditable entity */
   LastModified      DATETIMEOFFSET(7) NOT NULL,/* Auditable entity */
   LastModifiedBy    NVARCHAR(100)     NULL,/* Auditable entity */

   PRIMARY KEY(WorkAreaTypeID)
);

CREATE TABLE TaskHeader(
   TaskHeaderID INT IDENTITY,
   Created           DATETIMEOFFSET(7) NOT NULL, /* Auditable entity */
   CreatedBy         NVARCHAR(100)     NULL,/* Auditable entity */
   LastModified      DATETIMEOFFSET(7) NOT NULL,/* Auditable entity */
   LastModifiedBy    NVARCHAR(100)     NULL,/* Auditable entity */
   PRIMARY KEY(TaskHeaderID)
);

CREATE TABLE TaskStatus(
   TaskStatusID INT IDENTITY,
   Code VARCHAR(5)  NOT NULL,
   Description VARCHAR(50)  NOT NULL,
   Created           DATETIMEOFFSET(7) NOT NULL, /* Auditable entity */
   CreatedBy         NVARCHAR(100)     NULL,/* Auditable entity */
   LastModified      DATETIMEOFFSET(7) NOT NULL,/* Auditable entity */
   LastModifiedBy    NVARCHAR(100)     NULL,/* Auditable entity */
   PRIMARY KEY(TaskStatusID),
   UNIQUE(Code)
);

CREATE TABLE Product(
   ProductID INT,
   Description VARCHAR(50)  NOT NULL,
   Created           DATETIMEOFFSET(7) NOT NULL, /* Auditable entity */
   CreatedBy         NVARCHAR(100)     NULL,/* Auditable entity */
   LastModified      DATETIMEOFFSET(7) NOT NULL,/* Auditable entity */
   LastModifiedBy    NVARCHAR(100)     NULL,/* Auditable entity */
   PRIMARY KEY(ProductID)
);

CREATE TABLE JsonSchemaTemplate(
   JsonSchemaTemplateID INT IDENTITY,
   Label VARCHAR(50)  NOT NULL,
   JsonSchema VARCHAR(max) NOT NULL,
   Version INT NOT NULL,
   Created           DATETIMEOFFSET(7) NOT NULL, /* Auditable entity */
   CreatedBy         NVARCHAR(100)     NULL,/* Auditable entity */
   LastModified      DATETIMEOFFSET(7) NOT NULL,/* Auditable entity */
   LastModifiedBy    NVARCHAR(100)   NULL,/* Auditable entity */
   PRIMARY KEY(JsonSchemaTemplateID),
    CONSTRAINT CK_JsonSchemaTemplate_ValidJson
        CHECK (ISJSON(JsonSchema) = 1)
);

CREATE TABLE TaskData(
   TaskDataID INT IDENTITY,
   JsonData VARCHAR(max) NOT NULL,
   JsonSchemaTemplateID INT NOT NULL,
    Created           DATETIMEOFFSET(7) NOT NULL, /* Auditable entity */
   CreatedBy         NVARCHAR(100)     NULL,/* Auditable entity */
   LastModified      DATETIMEOFFSET(7) NOT NULL,/* Auditable entity */
   LastModifiedBy    NVARCHAR(100)   NULL,/* Auditable entity */
   PRIMARY KEY(TaskDataID),
   FOREIGN KEY(JsonSchemaTemplateID) REFERENCES JsonSchemaTemplate(JsonSchemaTemplateID),
    CONSTRAINT CK_JsonTaskData_ValidJson
        CHECK (ISJSON(JsonData) = 1)
);

CREATE TABLE WorkArea(
   WorkAreaID INT IDENTITY,
   Code VARCHAR(5)  NOT NULL,
   CommonName VARCHAR(50)  NOT NULL,
   PlantID INT NOT NULL,
   WorkAreaTypeID INT NOT NULL,
    Created           DATETIMEOFFSET(7) NOT NULL, /* Auditable entity */
   CreatedBy         NVARCHAR(100)     NULL,/* Auditable entity */
   LastModified      DATETIMEOFFSET(7) NOT NULL,/* Auditable entity */
   LastModifiedBy    NVARCHAR(100)   NULL,/* Auditable entity */
   PRIMARY KEY(WorkAreaID),
   UNIQUE(Code),
   FOREIGN KEY(PlantID) REFERENCES Plant(PlantID),
   FOREIGN KEY(WorkAreaTypeID) REFERENCES WorkAreaType(WorkAreaTypeID)
);

CREATE TABLE EntityChange(
   EntityChangeID INT IDENTITY,
   Entity VARCHAR(50)  NOT NULL,
   EntityField VARCHAR(50)  NOT NULL,
   FieldType VARCHAR(50)  NOT NULL,
   OldValue VARCHAR(50)  NOT NULL,
   NewValue VARCHAR(50)  NOT NULL,
   ChangedAt DATETIME2,
   ChangedBy nvarchar(450) NOT NULL,
   PRIMARY KEY(EntityChangeID),
   FOREIGN KEY(ChangedBy) REFERENCES AspNetUsers(Id)
);

CREATE TABLE Location(
   LocationID VARCHAR(10) ,
   Label VARCHAR(20)  NOT NULL,
   WorkAreaID INT NOT NULL,
   PRIMARY KEY(LocationID),
   UNIQUE(Label),
   FOREIGN KEY(WorkAreaID) REFERENCES WorkArea(WorkAreaID)
);

CREATE TABLE TaskItemType(
   TaskItemType_ID VARCHAR(4) ,
   InstructionDescription VARCHAR(20)  NOT NULL,
   JsonSchemaTemplateID INT NOT NULL,
   PRIMARY KEY(TaskItemType_ID),
   FOREIGN KEY(JsonSchemaTemplateID) REFERENCES JsonSchemaTemplate(JsonSchemaTemplateID)
);

CREATE TABLE TaskItems(
   TaskHeaderID INT,
   TaskItemsID INT IDENTITY,
   StartingTask BIT NOT NULL,
   EndingTask BIT NOT NULL,
   TaskDataID INT NOT NULL,
   TaskItemType_ID VARCHAR(4)  NOT NULL,
   TaskStatusID INT NOT NULL,
   LinkedWorkArea INT,
   PRIMARY KEY(TaskHeaderID, TaskItemsID),
   FOREIGN KEY(TaskHeaderID) REFERENCES TaskHeader(TaskHeaderID),
   FOREIGN KEY(TaskDataID) REFERENCES TaskData(TaskDataID),
   FOREIGN KEY(TaskItemType_ID) REFERENCES TaskItemType(TaskItemType_ID),
   FOREIGN KEY(TaskStatusID) REFERENCES TaskStatus(TaskStatusID),
   FOREIGN KEY(LinkedWorkArea) REFERENCES WorkArea(WorkAreaID)
);

CREATE TABLE Storage(
   LocationID VARCHAR(10) ,
   StorageID VARCHAR(10) ,
   Description VARCHAR(50)  NOT NULL,
   LengthInMillimeters FLOAT NOT NULL,
   Empty BIT NOT NULL,
   PRIMARY KEY(LocationID, StorageID),
   FOREIGN KEY(LocationID) REFERENCES Location(LocationID)
);

CREATE TABLE Lot(
   LocationID VARCHAR(10) ,
   StorageID VARCHAR(10) ,
   LotID VARCHAR(10) ,
   Blocked BIT NOT NULL,
   PositionStorage INT,
   ProductID INT NOT NULL,
   PRIMARY KEY(LocationID, StorageID, LotID),
   FOREIGN KEY(LocationID, StorageID) REFERENCES Storage(LocationID, StorageID),
   FOREIGN KEY(ProductID) REFERENCES Product(ProductID)
);
CREATE TABLE TransportTask(
   TaskHeaderID INT,
   TaskItemsID INT,
   Support VARCHAR(20) ,
   CreatedBy VARCHAR(50) ,
   UpdatedBy VARCHAR(50) ,
   CreatedTime VARCHAR(50) ,
   UpdatedTime DATETIME2,
   DestinationArea INT,
   SourceArea INT,
   PRIMARY KEY(TaskHeaderID, TaskItemsID),
   FOREIGN KEY(TaskHeaderID, TaskItemsID) REFERENCES TaskItems(TaskHeaderID, TaskItemsID),
   FOREIGN KEY(DestinationArea) REFERENCES WorkArea(WorkAreaID),
   FOREIGN KEY(SourceArea) REFERENCES WorkArea(WorkAreaID)
);

CREATE TABLE LoadingTask(
   TaskHeaderID INT,
   TaskItemsID INT,
   Product VARCHAR(50)  NOT NULL,
   Qty FLOAT NOT NULL,
   Support VARCHAR(50) ,
   CreatedBy VARCHAR(50) ,
   UpdatedBy VARCHAR(50) ,
   CreatedTime DATETIME2,
   UpdatedTime DATETIME2,
   AreaForLoading INT,
   PRIMARY KEY(TaskHeaderID, TaskItemsID),
   FOREIGN KEY(TaskHeaderID, TaskItemsID) REFERENCES TaskItems(TaskHeaderID, TaskItemsID),
   FOREIGN KEY(AreaForLoading) REFERENCES WorkArea(WorkAreaID)
);


CREATE TABLE TaskItemDependency(
   TaskHeaderID_DependOn INT,
   TaskItemsID_DependOn INT,
   TaskHeaderID INT,
   TaskItemsID INT,
   PRIMARY KEY(TaskHeaderID_DependOn, TaskItemsID_DependOn, TaskHeaderID, TaskItemsID),
   FOREIGN KEY(TaskHeaderID_DependOn, TaskItemsID_DependOn) REFERENCES TaskItems(TaskHeaderID, TaskItemsID),
   FOREIGN KEY(TaskHeaderID, TaskItemsID) REFERENCES TaskItems(TaskHeaderID, TaskItemsID)
);

CREATE TABLE PlantIDentity(
   PlantID INT,
   Id_AspnetIdentity nvarchar(450),
   PRIMARY KEY(PlantID, Id_AspnetIdentity),
   FOREIGN KEY(PlantID) REFERENCES Plant(PlantID),
   FOREIGN KEY(Id_AspnetIdentity) REFERENCES AspNetUsers(Id)
);
COMMIT;
GO