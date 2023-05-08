BEGIN TRAN;

SET IDENTITY_INSERT [dbo].[RagOptions] ON;

IF NOT EXISTS (SELECT [ID] FROM [dbo].[RagOptions] WHERE [ID] = 1)
INSERT INTO [dbo].[RagOptions] ([ID], [Name], [ReportName]) VALUES (1, N'Red', N'R');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[RagOptions] WHERE [ID] = 2)
INSERT INTO [dbo].[RagOptions] ([ID], [Name], [ReportName]) VALUES (2, N'Amber Red', N'AR');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[RagOptions] WHERE [ID] = 3)
INSERT INTO [dbo].[RagOptions] ([ID], [Name], [ReportName]) VALUES (3, N'Amber', N'A');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[RagOptions] WHERE [ID] = 4)
INSERT INTO [dbo].[RagOptions] ([ID], [Name], [ReportName]) VALUES (4, N'Amber Green', N'AG');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[RagOptions] WHERE [ID] = 5)
INSERT INTO [dbo].[RagOptions] ([ID], [Name], [ReportName]) VALUES (5, N'Green', N'G');

SET IDENTITY_INSERT [dbo].[RagOptions] OFF;

COMMIT;