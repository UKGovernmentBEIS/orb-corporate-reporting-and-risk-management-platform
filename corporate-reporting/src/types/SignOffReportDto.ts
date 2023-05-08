export interface ISignOffDto {
    LastApproved?: Date;
    LastApprovedBy?: string;
    ChangedSinceApproval?: boolean;
}

export interface ISignOffDirectorateDto extends ISignOffDto {
    Directorate: string;
    Commitments: string;
    KeyWorkAreas: string;
    Milestones: string;
    Metrics: string;
    Projects: string;
    ReportingEntityTypes: string;
}

export interface ISignOffPartnerOrganisationDto extends ISignOffDto {
    PartnerOrganisation: string;
    Milestones: string;
    PartnerOrganisationRiskMitigationActions: string;
    PartnerOrganisationRisks: string;
    ReportingEntityTypes: string;
}

export interface ISignOffProjectDto extends ISignOffDto {
    Project: string;
    Benefits: string;
    Dependencies: string;
    Milestones: string;
    WorkStreams: string;
    Projects: string;
    ReportingEntityTypes: string;
}

export interface ISignOffCorporateRiskDto extends ISignOffDto {
    Risk: string;
    RiskMitigationActions: string;
}

export interface ISignOffFinancialRiskDto extends ISignOffDto {
    FinancialRisk: string;
    FinancialRiskMitigationActions: string;
}
