
CREATE SCHEMA History
GO


ALTER TABLE Attributes   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_Attributes_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00') -- SYSUTCDATETIME()  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_Attributes_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE Attributes   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.Attributes))   
;


ALTER TABLE Benefits   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_Benefits_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_Benefits_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE Benefits   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.Benefits))   
;


ALTER TABLE Commitments   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_Commitments_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_Commitments_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE Commitments   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.Commitments))   
;


ALTER TABLE Contributors   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_Contributors_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_Contributors_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE Contributors   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.Contributors))   
;


ALTER TABLE Dependencies   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_Dependencies_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_Dependencies_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE Dependencies   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.Dependencies))   
;


ALTER TABLE Directorates   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_Directorates_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_Directorates_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE Directorates   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.Directorates))   
;


ALTER TABLE Groups   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_Groups_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_Groups_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE Groups   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.Groups))   
;


ALTER TABLE KeyWorkAreas   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_KeyWorkAreas_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_KeyWorkAreas_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE KeyWorkAreas   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.KeyWorkAreas))   
;


ALTER TABLE Metrics   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_Metrics_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_Metrics_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE Metrics   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.Metrics))   
;


ALTER TABLE Milestones   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_Milestones_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_Milestones_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE Milestones   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.Milestones))   
;


ALTER TABLE Projects   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_Projects_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_Projects_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE Projects   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.Projects))   
;


ALTER TABLE ProjectAttributes   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_ProjectAttributes_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_ProjectAttributes_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE ProjectAttributes   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.ProjectAttributes))   
;


ALTER TABLE RiskMitigationActions   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_RiskMitigationActions_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_RiskMitigationActions_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE RiskMitigationActions   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.RiskMitigationActions))   
;


ALTER TABLE Risks   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_Risks_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_Risks_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE Risks   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.Risks))   
;


ALTER TABLE UserDirectorates   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_UserDirectorates_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_UserDirectorates_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE UserDirectorates   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.UserDirectorates))   
;


ALTER TABLE UserGroups   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_UserGroups_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_UserGroups_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE UserGroups   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.UserGroups))   
;


ALTER TABLE UserProjects   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_UserProjects_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_UserProjects_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE UserProjects   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.UserProjects))   
;


ALTER TABLE UserRoles   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_UserRoles_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_UserRoles_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE UserRoles   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.UserRoles))   
;


ALTER TABLE Users   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_Users_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_Users_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE Users   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.Users))   
;


ALTER TABLE WorkStreams   
   ADD   
      SysStartTime datetime2(0) GENERATED ALWAYS AS ROW START HIDDEN    
           CONSTRAINT DF_WorkStreams_SysStart DEFAULT CONVERT(datetime2 (0), '2018-01-01 00:00:00')  
      , SysEndTime datetime2(0) GENERATED ALWAYS AS ROW END HIDDEN    
           CONSTRAINT DF_WorkStreams_SysEnd DEFAULT CONVERT(datetime2 (0), '9999-12-31 23:59:59'),   
      PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);   
GO   
ALTER TABLE WorkStreams   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.WorkStreams))   
;


ALTER TABLE Attributes DROP CONSTRAINT DF_Attributes_SysStart
ALTER TABLE Attributes ADD CONSTRAINT DF_Attributes_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE Benefits DROP CONSTRAINT DF_Benefits_SysStart
ALTER TABLE Benefits ADD CONSTRAINT DF_Benefits_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE Commitments DROP CONSTRAINT DF_Commitments_SysStart
ALTER TABLE Commitments ADD CONSTRAINT DF_Commitments_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE Contributors DROP CONSTRAINT DF_Contributors_SysStart
ALTER TABLE Contributors ADD CONSTRAINT DF_Contributors_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE Dependencies DROP CONSTRAINT DF_Dependencies_SysStart
ALTER TABLE Dependencies ADD CONSTRAINT DF_Dependencies_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE Directorates DROP CONSTRAINT DF_Directorates_SysStart
ALTER TABLE Directorates ADD CONSTRAINT DF_Directorates_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE Groups DROP CONSTRAINT DF_Groups_SysStart
ALTER TABLE Groups ADD CONSTRAINT DF_Groups_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE KeyWorkAreas DROP CONSTRAINT DF_KeyWorkAreas_SysStart
ALTER TABLE KeyWorkAreas ADD CONSTRAINT DF_KeyWorkAreas_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE Metrics DROP CONSTRAINT DF_Metrics_SysStart
ALTER TABLE Metrics ADD CONSTRAINT DF_Metrics_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE Milestones DROP CONSTRAINT DF_Milestones_SysStart
ALTER TABLE Milestones ADD CONSTRAINT DF_Milestones_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE Projects DROP CONSTRAINT DF_Projects_SysStart
ALTER TABLE Projects ADD CONSTRAINT DF_Projects_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE ProjectAttributes DROP CONSTRAINT DF_ProjectAttributes_SysStart
ALTER TABLE ProjectAttributes ADD CONSTRAINT DF_ProjectAttributes_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE RiskMitigationActions DROP CONSTRAINT DF_RiskMitigationActions_SysStart
ALTER TABLE RiskMitigationActions ADD CONSTRAINT DF_RiskMitigationActions_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE Risks DROP CONSTRAINT DF_Risks_SysStart
ALTER TABLE Risks ADD CONSTRAINT DF_Risks_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE UserDirectorates DROP CONSTRAINT DF_UserDirectorates_SysStart
ALTER TABLE UserDirectorates ADD CONSTRAINT DF_UserDirectorates_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE UserGroups DROP CONSTRAINT DF_UserGroups_SysStart
ALTER TABLE UserGroups ADD CONSTRAINT DF_UserGroups_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE UserProjects DROP CONSTRAINT DF_UserProjects_SysStart
ALTER TABLE UserProjects ADD CONSTRAINT DF_UserProjects_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE UserRoles DROP CONSTRAINT DF_UserRoles_SysStart
ALTER TABLE UserRoles ADD CONSTRAINT DF_UserRoles_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE Users DROP CONSTRAINT DF_Users_SysStart
ALTER TABLE Users ADD CONSTRAINT DF_Users_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime

ALTER TABLE WorkStreams DROP CONSTRAINT DF_WorkStreams_SysStart
ALTER TABLE WorkStreams ADD CONSTRAINT DF_WorkStreams_SysStart DEFAULT SYSUTCDATETIME() FOR SysStartTime
