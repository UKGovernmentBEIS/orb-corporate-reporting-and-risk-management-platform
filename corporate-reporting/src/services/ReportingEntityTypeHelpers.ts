import { ReportingEntityTypes } from "../refData/ReportingEntityTypes";
import { IEntity, ILoadLookupData, ILookupData } from "../types";

export class ReportingEntityTypeHelpers {
    public static GetLookupsForFixedReportingEntities = (lookupData: ILookupData, reportingEntityTypeId: number): IEntity[] => {
        if (reportingEntityTypeId === ReportingEntityTypes.KeyWorkAreas) {
            return lookupData.KeyWorkAreas;
        }
        if (reportingEntityTypeId === ReportingEntityTypes.DirectorateMilestones) {
            return lookupData.Milestones.filter(m => m.KeyWorkAreaID != null);
        }
        if (reportingEntityTypeId === ReportingEntityTypes.Metrics) {
            return lookupData.Metrics;
        }
        if (reportingEntityTypeId === ReportingEntityTypes.Commitments) {
            return lookupData.Commitments;
        }
        if (reportingEntityTypeId === ReportingEntityTypes.WorkStreams) {
            return lookupData.WorkStreams;
        }
        if (reportingEntityTypeId === ReportingEntityTypes.ProjectMilestones) {
            return lookupData.Milestones.filter(m => m.WorkStreamID != null);
        }
        if (reportingEntityTypeId === ReportingEntityTypes.Benefits) {
            return lookupData.Benefits;
        }
        if (reportingEntityTypeId === ReportingEntityTypes.Dependencies) {
            return lookupData.Dependencies;
        }
        if (reportingEntityTypeId === ReportingEntityTypes.PartnerOrganisationMilestones) {
            return lookupData.Milestones.filter(m => m.PartnerOrganisationID != null);
        }
        if (reportingEntityTypeId === ReportingEntityTypes.PartnerOrganisationRisks) {
            return lookupData.PartnerOrganisationRisks;
        }
        if (reportingEntityTypeId === ReportingEntityTypes.PartnerOrganisationRiskMitigatingActions) {
            return lookupData.PartnerOrganisationRiskMitigationActions;
        }
        return null;
    }

    public static LoadLookupsForFixedReportingEntities = (loadLookupData: ILoadLookupData, reportingEntityTypeId: number): void => {
        if (reportingEntityTypeId === ReportingEntityTypes.KeyWorkAreas) {
            loadLookupData.keyWorkAreas();
        }
        if (reportingEntityTypeId === ReportingEntityTypes.DirectorateMilestones) {
            loadLookupData.milestones();
        }
        if (reportingEntityTypeId === ReportingEntityTypes.Metrics) {
            loadLookupData.metrics();
        }
        if (reportingEntityTypeId === ReportingEntityTypes.Commitments) {
            loadLookupData.commitments();
        }
        if (reportingEntityTypeId === ReportingEntityTypes.WorkStreams) {
            loadLookupData.workStreams();
        }
        if (reportingEntityTypeId === ReportingEntityTypes.ProjectMilestones) {
            loadLookupData.milestones();
        }
        if (reportingEntityTypeId === ReportingEntityTypes.Benefits) {
            loadLookupData.benefits();
        }
        if (reportingEntityTypeId === ReportingEntityTypes.Dependencies) {
            loadLookupData.dependencies();
        }
        if (reportingEntityTypeId === ReportingEntityTypes.PartnerOrganisationMilestones) {
            loadLookupData.milestones();
        }
        if (reportingEntityTypeId === ReportingEntityTypes.PartnerOrganisationRisks) {
            loadLookupData.partnerOrganisationRisks();
        }
        if (reportingEntityTypeId === ReportingEntityTypes.PartnerOrganisationRiskMitigatingActions) {
            loadLookupData.partnerOrganisationRiskMitigationActions();
        }
    }
}