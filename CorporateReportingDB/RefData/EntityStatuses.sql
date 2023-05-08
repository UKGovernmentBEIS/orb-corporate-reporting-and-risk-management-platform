BEGIN TRAN;

SET IDENTITY_INSERT [dbo].[EntityStatuses] ON;

IF NOT EXISTS (SELECT [ID] FROM [dbo].[EntityStatuses] WHERE [ID] = 1)
INSERT INTO [dbo].[EntityStatuses] ([ID], [Title]) VALUES (1, N'Open');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[EntityStatuses] WHERE [ID] = 2)
INSERT INTO [dbo].[EntityStatuses] ([ID], [Title]) VALUES (2, N'Closed');

SET IDENTITY_INSERT [dbo].[EntityStatuses] OFF;

COMMIT;