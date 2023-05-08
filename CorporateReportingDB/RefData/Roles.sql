BEGIN TRAN;

SET IDENTITY_INSERT [dbo].[Roles] ON;

IF NOT EXISTS (SELECT [ID] FROM [dbo].[Roles] WHERE [ID] = 1)
INSERT INTO [dbo].[Roles] ([ID], [Title]) VALUES (1, N'Directorate/project reporting admin');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[Roles] WHERE [ID] = 2)
INSERT INTO [dbo].[Roles] ([ID], [Title]) VALUES (2, N'Department risk manager');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[Roles] WHERE [ID] = 3)
INSERT INTO [dbo].[Roles] ([ID], [Title]) VALUES (3, N'Departmental partner org admin');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[Roles] WHERE [ID] = 4)
INSERT INTO [dbo].[Roles] ([ID], [Title]) VALUES (4, N'Financial risk admin');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[Roles] WHERE [ID] = 5)
INSERT INTO [dbo].[Roles] ([ID], [Title]) VALUES (5, N'Custom report sections admin');

SET IDENTITY_INSERT [dbo].[Roles] OFF;

COMMIT;