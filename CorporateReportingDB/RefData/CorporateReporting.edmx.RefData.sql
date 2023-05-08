USE [corporate-reporting-dev]
GO
SET IDENTITY_INSERT [dbo].[Groups] ON 
GO
INSERT [dbo].[Groups] ([ID], [Title]) VALUES (1, N'Business & Science')
GO
INSERT [dbo].[Groups] ([ID], [Title]) VALUES (2, N'Corporate Services')
GO
INSERT [dbo].[Groups] ([ID], [Title]) VALUES (3, N'Energy & Security')
GO
INSERT [dbo].[Groups] ([ID], [Title]) VALUES (4, N'Energy Transformation & Clean Growth')
GO
INSERT [dbo].[Groups] ([ID], [Title]) VALUES (5, N'International, Growth & Analysis')
GO
INSERT [dbo].[Groups] ([ID], [Title]) VALUES (6, N'Market Frameworks')
GO
SET IDENTITY_INSERT [dbo].[Groups] OFF
GO
SET IDENTITY_INSERT [dbo].[Directorates] ON 
GO
INSERT [dbo].[Directorates] ([ID], [Title], [GroupID], [DirectorUserID], [Objectives]) VALUES (1, N'Advanced Manufacturing', 1, NULL, NULL)
GO
INSERT [dbo].[Directorates] ([ID], [Title], [GroupID], [DirectorUserID], [Objectives]) VALUES (2, N'Business Growth', 1, NULL, NULL)
GO
INSERT [dbo].[Directorates] ([ID], [Title], [GroupID], [DirectorUserID], [Objectives]) VALUES (3, N'Business Investment', 1, NULL, NULL)
GO
INSERT [dbo].[Directorates] ([ID], [Title], [GroupID], [DirectorUserID], [Objectives]) VALUES (4, N'Cities & Local Growth', 1, NULL, NULL)
GO
INSERT [dbo].[Directorates] ([ID], [Title], [GroupID], [DirectorUserID], [Objectives]) VALUES (5, N'Industrial Strategy', 1, NULL, NULL)
GO
INSERT [dbo].[Directorates] ([ID], [Title], [GroupID], [DirectorUserID], [Objectives]) VALUES (6, N'Infrastructure & Materials', 1, NULL, NULL)
GO
INSERT [dbo].[Directorates] ([ID], [Title], [GroupID], [DirectorUserID], [Objectives]) VALUES (7, N'Comms, Partnerships & Governance', 2, NULL, NULL)
GO
INSERT [dbo].[Directorates] ([ID], [Title], [GroupID], [DirectorUserID], [Objectives]) VALUES (8, N'Digital, Data & Technology', 2, NULL, NULL)
GO
INSERT [dbo].[Directorates] ([ID], [Title], [GroupID], [DirectorUserID], [Objectives]) VALUES (9, N'Financial & Portfolio', 2, NULL, NULL)
GO
INSERT [dbo].[Directorates] ([ID], [Title], [GroupID], [DirectorUserID], [Objectives]) VALUES (10, N'HR', 2, NULL, NULL)
GO
INSERT [dbo].[Directorates] ([ID], [Title], [GroupID], [DirectorUserID], [Objectives]) VALUES (11, N'Operations', 2, NULL, NULL)
GO
INSERT [dbo].[Directorates] ([ID], [Title], [GroupID], [DirectorUserID], [Objectives]) VALUES (12, N'Transformation', 2, NULL, NULL)
GO
INSERT [dbo].[Directorates] ([ID], [Title], [GroupID], [DirectorUserID], [Objectives]) VALUES (13, N'Heat & Business Energy', 4, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Directorates] OFF
GO
SET IDENTITY_INSERT [dbo].[BenefitTypes] ON 
GO
INSERT [dbo].[BenefitTypes] ([ID], [Title]) VALUES (1, N'Cashable')
GO
INSERT [dbo].[BenefitTypes] ([ID], [Title]) VALUES (2, N'Non-cashable')
GO
INSERT [dbo].[BenefitTypes] ([ID], [Title]) VALUES (3, N'Social')
GO
SET IDENTITY_INSERT [dbo].[BenefitTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[MilestoneAttributeTypes] ON 
GO
INSERT [dbo].[MilestoneAttributeTypes] ([ID], [Title]) VALUES (1, N'Manifesto')
GO
INSERT [dbo].[MilestoneAttributeTypes] ([ID], [Title]) VALUES (2, N'SDP')
GO
INSERT [dbo].[MilestoneAttributeTypes] ([ID], [Title]) VALUES (3, N'Clean Growth')
GO
INSERT [dbo].[MilestoneAttributeTypes] ([ID], [Title]) VALUES (4, N'SDG')
GO
SET IDENTITY_INSERT [dbo].[MilestoneAttributeTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[MilestoneTypes] ON 
GO
INSERT [dbo].[MilestoneTypes] ([ID], [Title]) VALUES (1, N'Policy')
GO
INSERT [dbo].[MilestoneTypes] ([ID], [Title]) VALUES (2, N'Project')
GO
SET IDENTITY_INSERT [dbo].[MilestoneTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[ProjectBusinessCaseTypes] ON 
GO
INSERT [dbo].[ProjectBusinessCaseTypes] ([ID], [Title]) VALUES (1, N'Strategic Business Case')
GO
INSERT [dbo].[ProjectBusinessCaseTypes] ([ID], [Title]) VALUES (2, N'Outline Business Case')
GO
INSERT [dbo].[ProjectBusinessCaseTypes] ([ID], [Title]) VALUES (3, N'Full Business Case')
GO
INSERT [dbo].[ProjectBusinessCaseTypes] ([ID], [Title]) VALUES (4, N'Other/Hybrid')
GO
SET IDENTITY_INSERT [dbo].[ProjectBusinessCaseTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[ProjectPhases] ON 
GO
INSERT [dbo].[ProjectPhases] ([ID], [Title]) VALUES (1, N'Pipeline')
GO
INSERT [dbo].[ProjectPhases] ([ID], [Title]) VALUES (2, N'Business Case')
GO
INSERT [dbo].[ProjectPhases] ([ID], [Title]) VALUES (3, N'Delivery')
GO
INSERT [dbo].[ProjectPhases] ([ID], [Title]) VALUES (4, N'Closure')
GO
INSERT [dbo].[ProjectPhases] ([ID], [Title]) VALUES (5, N'On Hold')
GO
SET IDENTITY_INSERT [dbo].[ProjectPhases] OFF
GO
SET IDENTITY_INSERT [dbo].[RagOptions] ON 
GO
INSERT [dbo].[RagOptions] ([ID], [Name], [ReportName]) VALUES (1, N'Red', N'R')
GO
INSERT [dbo].[RagOptions] ([ID], [Name], [ReportName]) VALUES (2, N'Amber Red', N'AR')
GO
INSERT [dbo].[RagOptions] ([ID], [Name], [ReportName]) VALUES (3, N'Amber', N'A')
GO
INSERT [dbo].[RagOptions] ([ID], [Name], [ReportName]) VALUES (4, N'Amber Green', N'AG')
GO
INSERT [dbo].[RagOptions] ([ID], [Name], [ReportName]) VALUES (5, N'Green', N'G')
GO
SET IDENTITY_INSERT [dbo].[RagOptions] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([ID], [Title]) VALUES (1, N'Admin')
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[RiskRegisters] ON 
GO
INSERT [dbo].[RiskRegisters] ([ID], [Title], [RiskCodePrefix]) VALUES (1, N'Departmental', N'DEP-')
GO
INSERT [dbo].[RiskRegisters] ([ID], [Title], [RiskCodePrefix]) VALUES (2, N'Group', N'GRP-')
GO
INSERT [dbo].[RiskRegisters] ([ID], [Title], [RiskCodePrefix]) VALUES (3, N'Directorate', N'DIR-')
GO
SET IDENTITY_INSERT [dbo].[RiskRegisters] OFF
GO