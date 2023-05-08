CREATE ROLE [drafts_reader];
GO

-- PRINT 'Configure permissions for the drafts_reader role'

GRANT SELECT ON SCHEMA::drafts TO [drafts_reader];
GO

GRANT EXECUTE ON SCHEMA::drafts TO [drafts_reader];
GO