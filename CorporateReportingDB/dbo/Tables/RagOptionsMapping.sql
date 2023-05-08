CREATE TABLE [dbo].[RagOptionsMapping]
(
	ID INT IDENTITY(1,1) NOT NULL,
	RiskProbabilityID INT NOT NULL,
	RiskImpactLevelID INT NOT NULL,
	RagOptionID INT NOT NULL,
	CONSTRAINT PK_RagOptionsMapping PRIMARY KEY (ID),
	CONSTRAINT FK_RagOptionsMapping_RiskProbabilities FOREIGN KEY (RiskProbabilityID) REFERENCES RiskProbabilities(ID),
	CONSTRAINT FK_RagOptionsMapping_RiskImpactLevels FOREIGN KEY (RiskImpactLevelID) REFERENCES RiskImpactLevels(ID),
	CONSTRAINT FK_RagOptionsMapping_RagOptions FOREIGN KEY (RagOptionID) REFERENCES RagOptions(ID)
)
