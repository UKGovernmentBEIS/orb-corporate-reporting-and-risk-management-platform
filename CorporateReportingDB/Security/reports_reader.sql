/****** Object:  DatabaseRole [reports_reader]    Script Date: 11/04/2019 15:15:52 ******/
CREATE ROLE [reports_reader];
GO

-- PRINT 'Configure permissions for the reports_reader role'

GRANT SELECT ON SCHEMA::reports TO [reports_reader];
GO

GRANT EXECUTE ON SCHEMA::reports TO [reports_reader];
GO