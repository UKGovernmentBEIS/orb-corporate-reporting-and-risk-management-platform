BEGIN TRAN;

SET IDENTITY_INSERT [dbo].[RiskRegisters] ON;

IF NOT EXISTS (SELECT [ID] FROM [dbo].[RiskRegisters] WHERE [ID] = 1)
INSERT INTO [dbo].[RiskRegisters] ([ID], [Title], [RiskCodePrefix]) VALUES (1, N'Departmental', N'DEP-');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[RiskRegisters] WHERE [ID] = 2)
INSERT INTO [dbo].[RiskRegisters] ([ID], [Title], [RiskCodePrefix]) VALUES (2, N'Group', N'GRP-');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[RiskRegisters] WHERE [ID] = 3)
INSERT INTO [dbo].[RiskRegisters] ([ID], [Title], [RiskCodePrefix]) VALUES (3, N'Directorate', N'DIR-');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[RiskRegisters] WHERE [ID] = 4)
INSERT INTO [dbo].[RiskRegisters] ([ID], [Title], [RiskCodePrefix]) VALUES (4, N'Project', N'PRO-');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[RiskRegisters] WHERE [ID] = 5)
INSERT INTO [dbo].[RiskRegisters] ([ID], [Title], [RiskCodePrefix]) VALUES (5, N'Financial', N'FIN-');

SET IDENTITY_INSERT [dbo].[RiskRegisters] OFF;

COMMIT;