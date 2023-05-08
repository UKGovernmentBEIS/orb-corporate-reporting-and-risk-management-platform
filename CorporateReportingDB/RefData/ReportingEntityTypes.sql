SET IDENTITY_INSERT [dbo].[ReportingEntityTypes] ON 
GO
IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingEntityTypes] WHERE [ID] = -1)
INSERT [dbo].[ReportingEntityTypes] ([ID], [Title], [ReportTypeID]) VALUES (-1, N'Key work areas', 1)
GO
IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingEntityTypes] WHERE [ID] = -2)
INSERT [dbo].[ReportingEntityTypes] ([ID], [Title], [ReportTypeID]) VALUES (-2, N'Milestones', 1)
GO
IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingEntityTypes] WHERE [ID] = -3)
INSERT [dbo].[ReportingEntityTypes] ([ID], [Title], [ReportTypeID]) VALUES (-3, N'Metrics', 1)
GO
IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingEntityTypes] WHERE [ID] = -4)
INSERT [dbo].[ReportingEntityTypes] ([ID], [Title], [ReportTypeID]) VALUES (-4, N'Commitments', 1)
GO
IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingEntityTypes] WHERE [ID] = -5)
INSERT [dbo].[ReportingEntityTypes] ([ID], [Title], [ReportTypeID]) VALUES (-5, N'Work streams', 2)
GO
IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingEntityTypes] WHERE [ID] = -6)
INSERT [dbo].[ReportingEntityTypes] ([ID], [Title], [ReportTypeID]) VALUES (-6, N'Milestones', 2)
GO
IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingEntityTypes] WHERE [ID] = -7)
INSERT [dbo].[ReportingEntityTypes] ([ID], [Title], [ReportTypeID]) VALUES (-7, N'Benefits', 2)
GO
IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingEntityTypes] WHERE [ID] = -8)
INSERT [dbo].[ReportingEntityTypes] ([ID], [Title], [ReportTypeID]) VALUES (-8, N'Dependencies', 2)
GO
IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingEntityTypes] WHERE [ID] = -9)
INSERT [dbo].[ReportingEntityTypes] ([ID], [Title], [ReportTypeID]) VALUES (-9, N'Milestones', 3)
GO
IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingEntityTypes] WHERE [ID] = -10)
INSERT [dbo].[ReportingEntityTypes] ([ID], [Title], [ReportTypeID]) VALUES (-10, N'Partner organisation risks', 3)
GO
IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingEntityTypes] WHERE [ID] = -11)
INSERT [dbo].[ReportingEntityTypes] ([ID], [Title], [ReportTypeID]) VALUES (-11, N'Partner organisation risk mitigating actions', 3)
GO
SET IDENTITY_INSERT [dbo].[ReportingEntityTypes] OFF
GO
