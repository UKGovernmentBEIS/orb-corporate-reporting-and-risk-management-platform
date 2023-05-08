CREATE TABLE [History].[UserPartnerOrganisations]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(50) NULL,
	[UserID] INT NOT NULL,
	[PartnerOrganisationID] INT NOT NULL,
	[IsAdmin] BIT NOT NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[ModifiedByUserID] INT NULL,
	[HideHeadlines] BIT NULL,
	[HideMilestones] BIT NULL,
	[HideCustomSections] BIT NULL
) ON [PRIMARY]