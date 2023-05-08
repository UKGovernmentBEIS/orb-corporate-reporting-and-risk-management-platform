CREATE VIEW [reports].[Directorates]
AS
SELECT    Directorates.ID AS [Directorate ID]
			,dbo.Groups.Title AS [Group]
			,Directorates.Title AS [Directorate]
			,DirectorUser.Title AS [Director]
			,Directorates.Objectives AS [Objectives]
FROM     dbo.Directorates AS Directorates LEFT OUTER JOIN
            dbo.Groups ON Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
            dbo.Users AS DirectorUser ON Directorates.DirectorUserID = DirectorUser.ID