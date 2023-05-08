BEGIN TRAN;

SET IDENTITY_INSERT [dbo].[ReportingFrequencies] ON;

IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingFrequencies] WHERE [ID] = 1)
INSERT INTO [dbo].[ReportingFrequencies] ([ID], [Title], [RemindAuthorsDaysBeforeDue], [RemindApproverDaysBeforeDue]) VALUES (1, N'Monthly', 10, 3);

IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingFrequencies] WHERE [ID] = 2)
INSERT INTO [dbo].[ReportingFrequencies] ([ID], [Title], [RemindAuthorsDaysBeforeDue], [RemindApproverDaysBeforeDue]) VALUES (2, N'Quarterly', 10, 4);

IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingFrequencies] WHERE [ID] = 3)
INSERT INTO [dbo].[ReportingFrequencies] ([ID], [Title], [RemindAuthorsDaysBeforeDue], [RemindApproverDaysBeforeDue]) VALUES (3, N'Biannually', 30, 4);

IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingFrequencies] WHERE [ID] = 4)
INSERT INTO [dbo].[ReportingFrequencies] ([ID], [Title], [RemindAuthorsDaysBeforeDue], [RemindApproverDaysBeforeDue]) VALUES (4, N'Annually', 30, 4);

IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingFrequencies] WHERE [ID] = 5)
INSERT INTO [dbo].[ReportingFrequencies] ([ID], [Title]) VALUES (5, N'Daily');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingFrequencies] WHERE [ID] = 6)
INSERT INTO [dbo].[ReportingFrequencies] ([ID], [Title]) VALUES (6, N'Weekly');

IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingFrequencies] WHERE [ID] = 7)
INSERT INTO [dbo].[ReportingFrequencies] ([ID], [Title], [RemindAuthorsDaysBeforeDue], [RemindApproverDaysBeforeDue]) VALUES (7, N'Fortnightly', 1, 1);

IF NOT EXISTS (SELECT [ID] FROM [dbo].[ReportingFrequencies] WHERE [ID] = 8)
INSERT INTO [dbo].[ReportingFrequencies] ([ID], [Title], [RemindAuthorsDaysBeforeDue], [RemindApproverDaysBeforeDue]) VALUES (8, N'Monthly weekday', 10, 4);

SET IDENTITY_INSERT [dbo].[ReportingFrequencies] OFF;

COMMIT;