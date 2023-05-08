import { BaseService } from './BaseService';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import {
    IBenefit, ICommitment, ICorporateRisk, ICorporateRiskMitigationAction, ICustomReportingEntityType, IDataAPI, IDependency, IDirectorate,
    IFinancialRisk, IKeyWorkArea, IMetric, IMilestone, IPartnerOrganisation, IPartnerOrganisationRisk, IPartnerOrganisationRiskMitigationAction,
    IProject, IRiskMitigationAction, ISignOff, ISignOffAndMetadata, ISignOffCorporateRiskDto, ISignOffDirectorateDto, ISignOffDto, ISignOffFinancialRiskDto,
    ISignOffPartnerOrganisationDto, ISignOffProjectDto, IWorkStream
} from '../types';
import { DateService } from './DateService';
import { AadHttpClient, HttpClientResponse } from '@microsoft/sp-http';

export interface IReportBuilderService {
    buildDirectorateReport: (directorateId: number, reportDate: Date) => Promise<ISignOffAndMetadata>;
    buildProjectReport: (projectId: number, reportDate: Date) => Promise<ISignOffAndMetadata>;
    buildPartnerOrganisationReport: (partnerOrganisationId: number, reportDate: Date) => Promise<ISignOffAndMetadata>;
    buildRiskReport: (riskId: number, reportDate: Date) => Promise<ISignOffAndMetadata>;
    buildFinancialRiskReport: (riskId: number, reportDate: Date) => Promise<ISignOffAndMetadata>;
}

export class ReportBuilderService extends BaseService<HttpClientResponse> implements IReportBuilderService {
    protected Api: IDataAPI;
    protected spfxContext: WebPartContext;

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super();
        this.Api = api;
        this.spfxContext = spfxContext;
    }

    public async buildDirectorateReport(directorateId: number, reportDate: Date): Promise<ISignOffAndMetadata> {
        const request = this.Api.ApiClient
            .get(`${this.Api.URL}/BuildDirectorateReport(DirectorateID=${directorateId},ReportPeriod=${reportDate.toISOString()})`,
                AadHttpClient.configurations.v1);
        return ReportBuilderService.mapDirectorateDtoToSignOff(await this.makeRequest(request));
    }

    public async buildProjectReport(projectId: number, reportDate: Date): Promise<ISignOffAndMetadata> {
        const request = this.Api.ApiClient
            .get(`${this.Api.URL}/BuildProjectReport(ProjectID=${projectId},ReportPeriod=${reportDate.toISOString()})`,
                AadHttpClient.configurations.v1);
        return ReportBuilderService.mapProjectDtoToSignOff(await this.makeRequest(request));
    }

    public async buildPartnerOrganisationReport(partnerOrganisationId: number, reportDate: Date): Promise<ISignOffAndMetadata> {
        const request = this.Api.ApiClient
            .get(`${this.Api.URL}/BuildPartnerOrganisationReport(PartnerOrganisationID=${partnerOrganisationId},ReportPeriod=${reportDate.toISOString()})`,
                AadHttpClient.configurations.v1);
        return ReportBuilderService.mapPartnerOrganisationDtoToSignOff(await this.makeRequest(request));
    }

    public async buildRiskReport(riskId: number, reportDate: Date): Promise<ISignOffAndMetadata> {
        const request = this.Api.ApiClient
            .get(`${this.Api.URL}/BuildRiskReport(RiskID=${riskId},ReportPeriod=${reportDate.toISOString()})`,
                AadHttpClient.configurations.v1);
        return ReportBuilderService.mapCorporateRiskDtoToSignOff(await this.makeRequest(request));
    }

    public async buildFinancialRiskReport(riskId: number, reportDate: Date): Promise<ISignOffAndMetadata> {
        const request = this.Api.ApiClient
            .get(`${this.Api.URL}/BuildFinancialRiskReport(RiskID=${riskId},ReportPeriod=${reportDate.toISOString()})`,
                AadHttpClient.configurations.v1);
        return ReportBuilderService.mapFinancialRiskDtoToSignOff(await this.makeRequest(request));
    }

    private static getMetadataFromSignOffDto = (signOff: ISignOffDto) => ({
        LastApproved: signOff.LastApproved,
        LastApprovedBy: signOff.LastApprovedBy,
        ChangedSinceApproval: signOff.ChangedSinceApproval
    });

    public static mapDirectorateDtoToSignOff = (signOffDto: ISignOffDirectorateDto): ISignOffAndMetadata => {
        const signOff: Partial<ISignOff> = {};
        signOff.Commitments = DateService.convertODataDates(JSON.parse(signOffDto.Commitments)) as ICommitment[] || [];
        signOff.Directorate = DateService.convertODataDates(JSON.parse(signOffDto.Directorate)) as IDirectorate;
        signOff.KeyWorkAreas = DateService.convertODataDates(JSON.parse(signOffDto.KeyWorkAreas)) as IKeyWorkArea[] || [];
        signOff.Metrics = DateService.convertODataDates(JSON.parse(signOffDto.Metrics)) as IMetric[] || [];
        signOff.Milestones = DateService.convertODataDates(JSON.parse(signOffDto.Milestones)) as IMilestone[] || [];
        signOff.Projects = DateService.convertODataDates(JSON.parse(signOffDto.Projects)) as IProject[] || [];
        signOff.ReportingEntityTypes = DateService.convertODataDates(JSON.parse(signOffDto.ReportingEntityTypes)) as ICustomReportingEntityType[] || [];
        return { report: signOff, metadata: ReportBuilderService.getMetadataFromSignOffDto(signOffDto) };
    }

    public static mapPartnerOrganisationDtoToSignOff = (signOffDto: ISignOffPartnerOrganisationDto): ISignOffAndMetadata => {
        const signOff: Partial<ISignOff> = {};
        signOff.Milestones = DateService.convertODataDates(JSON.parse(signOffDto.Milestones)) as IMilestone[] || [];
        signOff.PartnerOrganisation = DateService.convertODataDates(JSON.parse(signOffDto.PartnerOrganisation)) as IPartnerOrganisation;
        signOff.PartnerOrganisationRisks = DateService.convertODataDates(JSON.parse(signOffDto.PartnerOrganisationRisks)) as IPartnerOrganisationRisk[] || [];
        signOff.PartnerOrganisationRiskMitigationActions =
            DateService.convertODataDates(JSON.parse(signOffDto.PartnerOrganisationRiskMitigationActions)) as IPartnerOrganisationRiskMitigationAction[] || [];
        signOff.ReportingEntityTypes = DateService.convertODataDates(JSON.parse(signOffDto.ReportingEntityTypes)) as ICustomReportingEntityType[] || [];
        return { report: signOff, metadata: ReportBuilderService.getMetadataFromSignOffDto(signOffDto) };
    }

    public static mapProjectDtoToSignOff = (signOffDto: ISignOffProjectDto): ISignOffAndMetadata => {
        const signOff: Partial<ISignOff> = {};
        signOff.Benefits = DateService.convertODataDates(JSON.parse(signOffDto.Benefits)) as IBenefit[] || [];
        signOff.Dependencies = DateService.convertODataDates(JSON.parse(signOffDto.Dependencies)) as IDependency[] || [];
        signOff.Milestones = DateService.convertODataDates(JSON.parse(signOffDto.Milestones)) as IMilestone[] || [];
        signOff.Project = DateService.convertODataDates(JSON.parse(signOffDto.Project)) as IProject;
        signOff.WorkStreams = DateService.convertODataDates(JSON.parse(signOffDto.WorkStreams)) as IWorkStream[] || [];
        signOff.Projects = DateService.convertODataDates(JSON.parse(signOffDto.Projects)) as IProject[] || [];
        signOff.ReportingEntityTypes = DateService.convertODataDates(JSON.parse(signOffDto.ReportingEntityTypes)) as ICustomReportingEntityType[] || [];
        return { report: signOff, metadata: ReportBuilderService.getMetadataFromSignOffDto(signOffDto) };
    }

    public static mapCorporateRiskDtoToSignOff = (signOffDto: ISignOffCorporateRiskDto): ISignOffAndMetadata => {
        const signOff: Partial<ISignOff> = {};
        signOff.Risk = DateService.convertODataDates(JSON.parse(signOffDto.Risk)) as ICorporateRisk;
        signOff.RiskMitigationActions = DateService.convertODataDates(JSON.parse(signOffDto.RiskMitigationActions)) as ICorporateRiskMitigationAction[] || [];
        return { report: signOff, metadata: ReportBuilderService.getMetadataFromSignOffDto(signOffDto) };
    }

    public static mapFinancialRiskDtoToSignOff = (signOffDto: ISignOffFinancialRiskDto): ISignOffAndMetadata => {
        const signOff: Partial<ISignOff> = {};
        signOff.FinancialRisk = DateService.convertODataDates(JSON.parse(signOffDto.FinancialRisk)) as IFinancialRisk;
        signOff.FinancialRiskMitigationActions = DateService.convertODataDates(JSON.parse(signOffDto.FinancialRiskMitigationActions)) as IRiskMitigationAction[] || [];
        return { report: signOff, metadata: ReportBuilderService.getMetadataFromSignOffDto(signOffDto) };
    }
}
