/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

-- PRINT 'Configure permissions for the api_user role'

-- ALTER ROLE db_datareader ADD MEMBER api_user
-- GO

-- ALTER ROLE db_datawriter ADD MEMBER api_user
-- GO

-- PRINT 'Configure permissions for the reports_reader role'

-- GRANT SELECT ON SCHEMA::reports TO [reports_reader]
-- GO

-- CARP-704: Remove Risks DIR-82 and DIR-93, which were entered in error, from the Production database
-- Also remove Contributors, Risk Updates and SignOffs for these Risks (which are preventing deletion through the application)
-- This change was run successfully against the Production database on 9th October 2019 and has been removed

-- CARP-729: Update SignOffs to set the Title for Risk Update approvals
-- This change was run successfully against the Production database on 9th October 2019 and has been removed

-- (CARP-780/797) Remove TARGETPERFORMANCEUPPERLIMIT and TARGETPERFORMANCELOWERLIMIT that are equal to zero 
-- THIS HAS BEEN REMOVED AS PART OF CARP-825 TO AVOID REMOVING THE DATA AGAIN
-- This change was run successfully against the Production database on 9th October 2019

-- CARP-870: populate the RagOptionsMapping table
-- This change was run successfully against the Production database on 5th November 2019 and has been removed


-- CARP-818: Add new role for PO Admins
--This change was run successfully against the Production database on 29th November 2019 and has been removed 


			
-- Remove TARGETPERFORMANCEUPPERLIMIT and TARGETPERFORMANCELOWERLIMIT that are equal to zero 
-- (CARP-780) to allow for the new functionality to have null values for these fields
-- This change was run successfully against the Production database in December 2019 and has been removed 

-- OS-01 - 2020 Support 
-- Rename legacy risk objectives to following format: LEGACY - *RISK OBJ* - DO NOT USE
-- Create new risk objectives
-- This change was run successfully against the Production database in January 2020 and has been removed 


-- OS-07 - 2020 Support 
-- (Temp Workaround) Insert Approvers and contributors for records where the form in not functioning correctly
-- This change was run successfully against the Production database in February 2020 and has been removed 

-- OS-18 New Risk Labeling System
-- Impact Levels and Probability ranges to be updated to align to risk management framework
-- Update Risk Probability and Risk Impact Level reference data to add new labels and retire the existing ones
-- This change was run successfully against the Production database in March 2020 and has been removed 

-- OE-17 Set CreatedDate for existing risks
-- Deployed to prod
--UPDATE r
--SET r.CreatedDate = firstVersion.SysStartTime
--FROM [dbo].[Risks] AS r
--INNER JOIN
--(SELECT ID, SysStartTime
--FROM   (SELECT   ROW_NUMBER() OVER (PARTITION BY ID ORDER BY SysStartTime ASC) rownumber, ID, SysStartTime
--          FROM     dbo.Risks FOR SYSTEM_TIME ALL) AS r1
--WHERE  r1.rownumber = 1) AS firstVersion
--ON r.ID = firstVersion.ID
--WHERE r.CreatedDate IS NULL
--GO

-- OE-136 Set CreatedDate and EntityStatus for existing users
-- Deployed to prod 18/12/2020
--
-- UPDATE u
-- SET u.CreatedDate = firstVersion.SysStartTime, u.EntityStatusID = 1, u.EntityStatusDate = firstVersion.SysStartTime
-- FROM [dbo].[Users] AS u
-- INNER JOIN
-- (SELECT ID, SysStartTime
-- FROM   (SELECT   ROW_NUMBER() OVER (PARTITION BY ID ORDER BY SysStartTime ASC) rownumber, ID, SysStartTime
--           FROM     dbo.Users FOR SYSTEM_TIME ALL) AS r1
-- WHERE  r1.rownumber = 1) AS firstVersion
-- ON u.ID = firstVersion.ID
-- WHERE u.CreatedDate IS NULL
-- GO

-- OE-140 Set CreatedDate for existing partner organisations
-- Deployed to prod 18/12/2020
--
-- UPDATE po
-- SET po.CreatedDate = firstVersion.SysStartTime
-- FROM [dbo].[PartnerOrganisations] AS po
-- INNER JOIN
-- (SELECT ID, SysStartTime
-- FROM   (SELECT   ROW_NUMBER() OVER (PARTITION BY ID ORDER BY SysStartTime ASC) rownumber, ID, SysStartTime
--           FROM     [dbo].[PartnerOrganisations] FOR SYSTEM_TIME ALL) AS r1
-- WHERE  r1.rownumber = 1) AS firstVersion
-- ON po.ID = firstVersion.ID
-- WHERE po.CreatedDate IS NULL
-- GO


-- OE-193 Set reporting cycles for all entities
-- Deployed to prod 19/02/2021

-- Benefits
-- Some benefits already have custom reporting cycles
-- UPDATE [dbo].[Benefits]
-- SET [ReportingDueDay] = 100, [ReportingStartDate] = CASE [ReportingStartMonth] 
-- WHEN 1 THEN '2020-01-01' 
-- WHEN 2 THEN '2020-02-01' 
-- WHEN 3 THEN '2020-03-01'
-- WHEN 4 THEN '2020-04-01'
-- WHEN 5 THEN '2020-05-01'
-- WHEN 6 THEN '2020-06-01'
-- WHEN 7 THEN '2020-07-01'
-- WHEN 8 THEN '2020-08-01'
-- WHEN 9 THEN '2020-09-01'
-- WHEN 10 THEN '2020-10-01'
-- WHEN 11 THEN '2020-11-01'
-- WHEN 12 THEN '2020-12-01' END
-- WHERE [ReportingDueDay] IS NULL AND [ReportingFrequency] IS NOT NULL;

-- UPDATE [dbo].[Benefits]
-- SET [ReportingFrequency] = 1, [ReportingDueDay] = 100
-- WHERE [ReportingFrequency] IS NULL;

-- Commitments
-- UPDATE [dbo].[Commitments]
-- SET [ReportingFrequency] = 1, [ReportingDueDay] = 100
-- WHERE [ReportingFrequency] IS NULL;

-- Dependencies
-- UPDATE [dbo].[Dependencies]
-- SET [ReportingFrequency] = 1, [ReportingDueDay] = 100
-- WHERE [ReportingFrequency] IS NULL;

-- Directorates
-- UPDATE [dbo].[Directorates]
-- SET [ReportingFrequency] = 1, [ReportingDueDay] = 100
-- WHERE [ReportingFrequency] IS NULL;

-- Key work areas
-- UPDATE [dbo].[KeyWorkAreas]
-- SET [ReportingFrequency] = 1, [ReportingDueDay] = 100
-- WHERE [ReportingFrequency] IS NULL;

-- Metrics
-- Some metrics already have custom reporting cycles
-- UPDATE [dbo].[Metrics]
-- SET [ReportingDueDay] = 100, [ReportingStartDate] = CASE [ReportingStartMonth] 
-- WHEN 1 THEN '2020-01-01' 
-- WHEN 2 THEN '2020-02-01' 
-- WHEN 3 THEN '2020-03-01'
-- WHEN 4 THEN '2020-04-01'
-- WHEN 5 THEN '2020-05-01'
-- WHEN 6 THEN '2020-06-01'
-- WHEN 7 THEN '2020-07-01'
-- WHEN 8 THEN '2020-08-01'
-- WHEN 9 THEN '2020-09-01'
-- WHEN 10 THEN '2020-10-01'
-- WHEN 11 THEN '2020-11-01'
-- WHEN 12 THEN '2020-12-01' END
-- WHERE [ReportingDueDay] IS NULL AND [ReportingFrequency] IS NOT NULL;

-- UPDATE [dbo].[Metrics]
-- SET [ReportingFrequency] = 1, [ReportingDueDay] = 100
-- WHERE [ReportingFrequency] IS NULL;

-- Milestones
-- UPDATE [dbo].[Milestones]
-- SET [ReportingFrequency] = 1, [ReportingDueDay] = 100
-- WHERE [ReportingFrequency] IS NULL;

-- PO risk mitigating actions
-- UPDATE [dbo].[PartnerOrganisationRiskMitigationActions]
-- SET [ReportingFrequency] = 1, [ReportingDueDay] = 100
-- WHERE [ReportingFrequency] IS NULL;

-- PO risks
-- UPDATE [dbo].[PartnerOrganisationRisks]
-- SET [ReportingFrequency] = 1, [ReportingDueDay] = 100
-- WHERE [ReportingFrequency] IS NULL;

-- Partner orgs
-- Some partner orgs already have custom reporting cycles
-- UPDATE [dbo].[PartnerOrganisations]
-- SET [ReportingDueDay] = 100, [ReportingStartDate] = CASE [ReportingStartMonth] 
-- WHEN 1 THEN '2020-01-01' 
-- WHEN 2 THEN '2020-02-01' 
-- WHEN 3 THEN '2020-03-01'
-- WHEN 4 THEN '2020-04-01'
-- WHEN 5 THEN '2020-05-01'
-- WHEN 6 THEN '2020-06-01'
-- WHEN 7 THEN '2020-07-01'
-- WHEN 8 THEN '2020-08-01'
-- WHEN 9 THEN '2020-09-01'
-- WHEN 10 THEN '2020-10-01'
-- WHEN 11 THEN '2020-11-01'
-- WHEN 12 THEN '2020-12-01' END
-- WHERE [ReportingDueDay] IS NULL AND [ReportingFrequency] IS NOT NULL;

-- UPDATE [dbo].[PartnerOrganisations]
-- SET [ReportingFrequency] = 1, [ReportingDueDay] = 100
-- WHERE [ReportingFrequency] IS NULL;

-- UPDATE m
-- SET m.[ReportingFrequency] = po.[ReportingFrequency], m.[ReportingDueDay] = po.[ReportingDueDay], m.[ReportingStartDate] = po.[ReportingStartDate]
-- FROM [dbo].[Milestones] m
-- INNER JOIN [dbo].[PartnerOrganisations] po ON m.[PartnerOrganisationID] = po.[ID]
-- WHERE m.[ReportingFrequency] <> po.[ReportingFrequency] OR m.[ReportingDueDay] <> po.[ReportingDueDay] OR m.[ReportingStartDate] <> po.[ReportingStartDate];

-- UPDATE por
-- SET por.[ReportingFrequency] = po.[ReportingFrequency], por.[ReportingDueDay] = po.[ReportingDueDay], por.[ReportingStartDate] = po.[ReportingStartDate]
-- FROM [dbo].[PartnerOrganisationRisks] por
-- INNER JOIN [dbo].[PartnerOrganisations] po ON por.[PartnerOrganisationID] = po.[ID]
-- WHERE por.[ReportingFrequency] <> po.[ReportingFrequency] OR por.[ReportingDueDay] <> po.[ReportingDueDay] OR por.[ReportingStartDate] <> po.[ReportingStartDate];

-- UPDATE porma
-- SET porma.[ReportingFrequency] = por.[ReportingFrequency], porma.[ReportingDueDay] = por.[ReportingDueDay], porma.[ReportingStartDate] = por.[ReportingStartDate]
-- FROM [dbo].[PartnerOrganisationRiskMitigationActions] porma
-- INNER JOIN [dbo].[PartnerOrganisationRisks] por ON porma.[PartnerOrganisationRiskID] = por.[ID]
-- WHERE porma.[ReportingFrequency] <> por.[ReportingFrequency] OR porma.[ReportingDueDay] <> por.[ReportingDueDay] OR porma.[ReportingStartDate] <> por.[ReportingStartDate];

-- Projects
-- UPDATE [dbo].[Projects]
-- SET [ReportingFrequency] = 1, [ReportingDueDay] = 100
-- WHERE [ReportingFrequency] IS NULL;

-- Risk mitigating actions
-- UPDATE [dbo].[RiskMitigationActions]
-- SET [ReportingFrequency] = 1, [ReportingDueDay] = 100
-- WHERE [ReportingFrequency] IS NULL;

-- Risks
-- UPDATE [dbo].[Risks]
-- SET [ReportingFrequency] = 1, [ReportingDueDay] = 100
-- WHERE [ReportingFrequency] IS NULL;

-- Work streams
-- UPDATE [dbo].[WorkStreams]
-- SET [ReportingFrequency] = 1, [ReportingDueDay] = 100
-- WHERE [ReportingFrequency] IS NULL;


-- OE-241 Back-fill report snapshots
-- Deployed to prod 19/03/2021
-- 
-- ************************************************************************************
-- ***** N.B. This caused a timeout in the release pipeline. **************************
-- ***** Use a different approach in future for potentially long-running queries. *****
-- ************************************************************************************

-- UPDATE so
-- SET so.[ReportJson] = [dbo].[GenerateReportJson] (so.[ID])
-- FROM [dbo].[SignOffs] AS so
-- WHERE [ReportJson] IS NULL AND [IsCurrent] = 'true';


-- OE-257 Reset proj risk codes
-- Deployed to prod 16/04/2021

--UPDATE [dbo].[Risks]
--SET [RiskCode] = CONCAT('PRO-', [ID])
--WHERE [IsProjectRisk] = 'true';


-- OE-248 Consolidate attributes
-- 
-- N.B. Ensure project attribute types are copied to attribute types before deploying

-- INSERT INTO [dbo].[Attributes] ([AttributeTypeID], [ProjectID], [ModifiedByUserID])
-- SELECT attr.[ID], pa.[ProjectID], pa.[ModifiedByUserID] 
-- FROM [dbo].[ProjectAttributes] AS pa INNER JOIN
--     [dbo].[ProjectAttributeTypes] AS pat ON pa.[ProjectAttributeTypeID] = pat.[ID] INNER JOIN
--     [dbo].[AttributeTypes] AS attr ON pat.[Title] = attr.[Title]
-- WHERE NOT EXISTS 
-- (
--     SELECT * 
--     FROM [dbo].[Attributes] AS a WITH (updlock)
--     WHERE a.[ProjectID] = pa.[ProjectID] AND a.[AttributeTypeID] = attr.[ID]
-- );


-- RefData
-- 

:r ..\RefData\EntityStatuses.sql
:r ..\RefData\RagOptions.sql
:r ..\RefData\ReportTypes.sql
:r ..\RefData\ReportingEntityTypes.sql
:r ..\RefData\ReportingFrequencies.sql
:r ..\RefData\RiskRegisters.sql
:r ..\RefData\Roles.sql
