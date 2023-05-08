import { EntityService } from './EntityService';
import { ISignOff, IDataAPI } from '../types';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import { sub } from 'date-fns';
import { SignOffType } from '../refData/SignOffType';
import { DateService } from './DateService';

export class SignOffService extends EntityService<ISignOff> {
    public readonly parentEntities = ['SignOffUser'];
    protected childrenEntities = [
        'DirectorateUpdates($expand=UpdateUser,Directorate)',
        'ProjectUpdates($expand=UpdateUser,Project)',
        'PartnerOrganisationUpdates($expand=UpdateUser,PartnerOrganisation)',
        'KeyWorkAreaUpdates($expand=UpdateUser,KeyWorkArea($expand=LeadUser))',
        'WorkStreamUpdates($expand=UpdateUser,WorkStream($expand=LeadUser))',
        'MetricUpdates($expand=UpdateUser,Metric($expand=LeadUser,MeasurementUnit))',
        'BenefitUpdates($expand=UpdateUser,Benefit($expand=LeadUser,MeasurementUnit))',
        'CommitmentUpdates($expand=UpdateUser,Commitment($expand=LeadUser))',
        'DependencyUpdates($expand=UpdateUser,Dependency($expand=LeadUser))',
        'MilestoneUpdates($expand=UpdateUser,Milestone($expand=LeadUser))',
        'RiskUpdates($expand=UpdateUser,Risk($expand=RiskOwnerUser,ReportApproverUser))',
        'RiskMitigationActionUpdates($expand=UpdateUser,RiskMitigationAction($expand=OwnerUser))'
    ];
    protected readonly childrenEntitiesRisk = [
        'RiskUpdates($expand=UpdateUser,RiskImpactLevel,RiskProbability'
        + ',Risk($expand=RiskRiskTypes,RiskOwnerUser,ReportApproverUser,UnmitigatedRiskImpactLevel,UnmitigatedRiskProbability,RiskAppetite,ChildRisks($select=Title)))',
        'RiskMitigationActionUpdates($expand=UpdateUser,RiskMitigationAction($expand=OwnerUser))'
    ];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/SignOffs`);
    }

    public readCompleteSignOff(id: number, signOffType: SignOffType): Promise<ISignOff> {
        if (signOffType === SignOffType.Risk)
            return this.read(id, true, false, this.childrenEntitiesRisk);
    }

    public async readSignOff(id: number): Promise<ISignOff> {
        const signOff = await this.read(id, true);
        SignOffService.mapReportJsonToProperties(signOff);
        return signOff;
    }

    public static mapReportJsonToProperties = (signOff: ISignOff): void => {
        const report = DateService.convertODataDates(JSON.parse(signOff.ReportJson)) as ISignOff;
        signOff.Benefits = report.Benefits;
        signOff.Commitments = report.Commitments;
        signOff.Dependencies = report.Dependencies;
        signOff.Directorate = report.Directorate;
        signOff.FinancialRisk = report.FinancialRisk;
        signOff.FinancialRiskMitigationActions = report.FinancialRiskMitigationActions;
        signOff.KeyWorkAreas = report.KeyWorkAreas;
        signOff.Metrics = report.Metrics;
        signOff.Milestones = report.Milestones;
        signOff.PartnerOrganisation = report.PartnerOrganisation;
        signOff.PartnerOrganisationRiskMitigationActions = report.PartnerOrganisationRiskMitigationActions;
        signOff.PartnerOrganisationRisks = report.PartnerOrganisationRisks;
        signOff.Project = report.Project;
        signOff.Projects = report.Projects;
        signOff.ReportingEntityTypes = report.ReportingEntityTypes;
        signOff.Risk = report.Risk;
        signOff.RiskMitigationActions = report.RiskMitigationActions;
        signOff.WorkStreams = report.WorkStreams;
    }

    public readAllLastMonth(): Promise<ISignOff[]> {
        const oneMonthAgo = sub(new Date(), { months: 1 });
        return this.readAll(
            `?$select=ID,ReportMonth`
            + `&$expand=Directorate($select=ID,Title),Project($select=ID,Title)`
            + `&$filter=IsCurrent eq true and ReportMonth gt ${oneMonthAgo.toISOString()}`
            + `&$orderby=ReportMonth desc`
        );
    }

    public readAllLastSixMonths(): Promise<ISignOff[]> {
        const sixMonthsAgo = sub(new Date(), { months: 6 });
        return this.readAll(
            `?$select=ID,ReportMonth`
            + `&$expand=Directorate($select=ID,Title,Objectives),Project($select=ID,Title,Objectives;$expand=Attributes($expand=AttributeType))`
            + `,PartnerOrganisation($select=ID,Title)`
            + `&$filter=RiskID eq null and IsCurrent eq true and ReportMonth gt ${sixMonthsAgo.toISOString()}`
            + `&$orderby=ReportMonth desc,Directorate/Title`
        );
    }

    public readDirectorateReportsSince = (directorateId: number, sinceDate: Date): Promise<ISignOff[]> => {
        return this.readAll(
            `?$select=ID,ReportMonth,DirectorateID`
            + `&$expand=Directorate($select=ID,Title,Objectives)`
            + `&$filter=DirectorateID eq ${directorateId} and IsCurrent eq true and ReportMonth gt ${sinceDate.toISOString()}`
            + `&$orderby=ReportMonth desc,Directorate/Title`
        );
    }

    public readProjectReportsSince = (projectId: number, sinceDate: Date): Promise<ISignOff[]> => {
        return this.readAll(
            `?$select=ID,ReportMonth,ProjectID`
            + `&$expand=Project($select=ID,Title,Objectives;$expand=Attributes($expand=AttributeType))`
            + `&$filter=ProjectID eq ${projectId} and IsCurrent eq true and ReportMonth gt ${sinceDate.toISOString()}`
            + `&$orderby=ReportMonth desc,Project/Title`
        );
    }

    public readPartnerOrganisationReportsSince = (partnerOrganisationId: number, sinceDate: Date): Promise<ISignOff[]> => {
        return this.readAll(
            `?$select=ID,ReportMonth,PartnerOrganisationID`
            + `&$expand=PartnerOrganisation($select=ID,Title)`
            + `&$filter=PartnerOrganisationID eq ${partnerOrganisationId} and IsCurrent eq true and ReportMonth gt ${sinceDate.toISOString()}`
            + `&$orderby=ReportMonth desc,PartnerOrganisation/Title`
        );
    }

    public readRagSummary(): Promise<ISignOff[]> {
        return this.readAll(
            `?$select=ID,DirectorateID,ProjectID,ReportMonth`
            + `&$filter=DirectorateID ne null and IsCurrent eq true`
            + `&$expand=Directorate($select=Title),Directorate($expand=Group($select=Title))`
            + `,DirectorateUpdates($select=OverallRagOptionID,FinanceRagOptionID,PeopleRagOptionID,MilestonesRagOptionID,MetricsRagOptionID)`
        );
    }

    public async readPreviousDirectorateSignOff(directorateId: number, reportDate: Date): Promise<ISignOff> {
        const signOffs = await this.readAll(
            `?$top=1`
            + `&$orderby=ReportMonth desc`
            + `&$expand=SignOffUser`
            + `&$filter=DirectorateID eq ${directorateId} and IsCurrent eq true and ReportMonth lt ${reportDate.toISOString()}`); // Query by less than current date in case report cycle has changed
        if (signOffs?.length > 0) {
            const signOff = signOffs[0];
            SignOffService.mapReportJsonToProperties(signOff);
            return signOff;
        }
    }

    public async readPreviousProjectSignOff(projectId: number, reportDate: Date): Promise<ISignOff> {
        const signOffs = await this.readAll(
            `?$top=1`
            + `&$orderby=ReportMonth desc`
            + `&$expand=SignOffUser`
            + `&$filter=ProjectID eq ${projectId} and IsCurrent eq true and ReportMonth lt ${reportDate.toISOString()}`); // Query by less than current date in case report cycle has changed
        if (signOffs?.length > 0) {
            const signOff = signOffs[0];
            SignOffService.mapReportJsonToProperties(signOff);
            return signOff;
        }
    }

    public async readPreviousPartnerOrganisationSignOff(partnerOrganisationId: number, reportDate: Date): Promise<ISignOff> {
        const signOffs = await this.readAll(
            `?$top=1`
            + `&$orderby=ReportMonth desc`
            + `&$expand=SignOffUser`
            + `&$filter=PartnerOrganisationID eq ${partnerOrganisationId} and IsCurrent eq true and ReportMonth lt ${reportDate.toISOString()}`);
        if (signOffs?.length > 0) {
            const signOff = signOffs[0];
            SignOffService.mapReportJsonToProperties(signOff);
            return signOff;
        }
    }

    public readAllLastSixMonthsRiskSignOffs(): Promise<ISignOff[]> {
        const sixMonthsAgo = sub(new Date(), { months: 6 });
        return this.readAll(
            `?$select=ID,Title,ReportMonth`
            + `&$expand=Directorate($select=ID,Title),Project($select=ID,Title),PartnerOrganisation($select=ID,Title)`
            + `&$filter=RiskID ne null and IsCurrent eq true and ReportMonth gt ${sixMonthsAgo.toISOString()}`
            + `&$orderby=ReportMonth desc,Directorate/Title`);
    }

    public async readAllFinancialRiskSignOffsSince(since: Date): Promise<ISignOff[]> {
        const signOffs = await this.readAll(
            `?$select=ID,Title,RiskID,ReportMonth,ReportJson`
            + `&$filter=RiskID ne null and FinancialRisk ne null and IsCurrent eq true and ReportMonth gt ${since.toISOString()}`
            + `&$orderby=ReportMonth desc`);
        signOffs.forEach(so => SignOffService.mapReportJsonToProperties(so));
        return signOffs;
    }

    public async create(entity: ISignOff): Promise<ISignOff> {
        const createdSignOff = await this.postEntity(entity, this.entityUrl);
        SignOffService.mapReportJsonToProperties(createdSignOff);
        return createdSignOff;
    }
}