SET IDENTITY_INSERT [dbo].[ReportTypes] ON 
GO
IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportTypes] WHERE [ID] = 1)
INSERT [dbo].[ReportTypes] ([ID], [Title]) VALUES (1, N'Directorate')
GO
IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportTypes] WHERE [ID] = 2)
INSERT [dbo].[ReportTypes] ([ID], [Title]) VALUES (2, N'Project')
GO
IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportTypes] WHERE [ID] = 3)
INSERT [dbo].[ReportTypes] ([ID], [Title]) VALUES (3, N'Partner organisation')
GO
SET IDENTITY_INSERT [dbo].[ReportTypes] OFF
GO
