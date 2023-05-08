import { useCallback, useState } from 'react';
import { IDataServices, ILoadLookupData, ILookupData, LookupData } from '../types';
import { IErrorHandling } from './withErrorHandling';

export interface IUseDataContextProps {
    dataServices: IDataServices;
    lookupData: ILookupData;
    loadLookupData: ILoadLookupData;
}

export const useDataContext = (apiConnected: boolean, dataServices: IDataServices, { onError }: IErrorHandling): IUseDataContextProps => {
    const { attributeTypeService, benefitService, benefitTypeService, commitmentService, corporateRiskService, departmentalObjectivesService,
        dependencyService, directorateService, economicRingfenceService, entityStatusService, financialRiskService, fundingClassificationService,
        groupService, keyWorkAreaService, measurementUnitService, metricService, milestoneService, milestoneTypeService, partnerOrganisationRiskMitigationActionService,
        partnerOrganisationRiskService, partnerOrganisationService, policyRingfenceService, projectBusinessCaseTypeService, projectPhaseService, reportingEntityTypeService,
        reportingFrequencyService, riskAppetiteService, riskDiscussionForumService, riskRegisterService, riskImpactLevelService, riskProbabilityService, riskTypeService, roleService,
        thresholdAppetiteService, thresholdService, budgetingEntitiesService, userGroupService, userPartnerOrganisationService,
        projectService, userDirectorateService, userProjectService, userService, workStreamService } = dataServices;
    const [lookupData, setLookupData] = useState(new LookupData());
    const logError = useCallback(onError, [onError]);

    const lld: ILoadLookupData = {
        attributeTypes: useCallback(async forceReload => {
            if (apiConnected && (lookupData.AttributeTypes.length === 0 || forceReload)) {
                try {
                    const at = await attributeTypeService.readAllForLookup();
                    setLookupData(s => ({ ...s, AttributeTypes: at }));
                } catch (err) { logError(`Error loading attribute types`, err); }
            }
        }, [apiConnected, lookupData.AttributeTypes.length, attributeTypeService, logError]),
        benefits: useCallback(async forceReload => {
            if (apiConnected && (lookupData.Benefits.length === 0 || forceReload)) {
                try {
                    const b = await benefitService.readAllForLookup();
                    setLookupData(s => ({ ...s, Benefits: b }));
                } catch (err) { logError(`Error loading benefits`, err); }
            }
        }, [apiConnected, lookupData.Benefits.length, benefitService, logError]),
        benefitTypes: useCallback(async forceReload => {
            if (apiConnected && (lookupData.BenefitTypes.length === 0 || forceReload)) {
                try {
                    const bt = await benefitTypeService.readAllForLookup();
                    setLookupData(s => ({ ...s, BenefitTypes: bt }));
                } catch (err) { logError(`Error loading benefit types`, err); }
            }
        }, [apiConnected, lookupData.BenefitTypes.length, benefitTypeService, logError]),
        commitments: useCallback(async forceReload => {
            if (apiConnected && (lookupData.Commitments.length === 0 || forceReload)) {
                try {
                    const c = await commitmentService.readAllForLookup();
                    setLookupData(s => ({ ...s, Commitments: c }));
                } catch (err) { logError(`Error loading commitments`, err); }
            }
        }, [apiConnected, lookupData.Commitments.length, commitmentService, logError]),
        corporateRisks: useCallback(async forceReload => {
            if (apiConnected && (lookupData.CorporateRisks.length === 0 || forceReload)) {
                try {
                    const cr = await corporateRiskService.readAllForLookup();
                    setLookupData(s => ({ ...s, CorporateRisks: cr }));
                } catch (err) { logError(`Error loading corporate risks`, err); }
            }
        }, [apiConnected, lookupData.CorporateRisks.length, corporateRiskService, logError]),
        departmentalObjectives: useCallback(async forceReload => {
            if (apiConnected && (lookupData.DepartmentalObjectives.length === 0 || forceReload)) {
                try {
                    const d = await departmentalObjectivesService.readAllForLookup();
                    setLookupData(s => ({ ...s, DepartmentalObjectives: d }));
                } catch (err) { logError(`Error loading departmental objectives`, err); }
            }
        }, [apiConnected, lookupData.DepartmentalObjectives.length, departmentalObjectivesService, logError]),
        dependencies: useCallback(async forceReload => {
            if (apiConnected && (lookupData.Dependencies.length === 0 || forceReload)) {
                try {
                    const d = await dependencyService.readAllForLookup();
                    setLookupData(s => ({ ...s, Dependencies: d }));
                } catch (err) { logError(`Error loading dependencies`, err); }
            }
        }, [apiConnected, lookupData.Dependencies.length, dependencyService, logError]),
        directorates: useCallback(async forceReload => {
            if (apiConnected && (lookupData.Directorates.length === 0 || forceReload)) {
                try {
                    const d = await directorateService.readAllForLookup();
                    setLookupData(s => ({ ...s, Directorates: d }));
                } catch (err) { logError(`Error loading directorates`, err); }
            }
        }, [apiConnected, lookupData.Directorates.length, directorateService, logError]),
        economicRingfences: useCallback(async forceReload => {
            if (apiConnected && (lookupData.EconomicRingfences.length === 0 || forceReload)) {
                try {
                    const f = await economicRingfenceService.getItems();
                    setLookupData(s => ({ ...s, EconomicRingfences: f }));
                } catch (err) { logError(`Error loading economic ring-fences`, err); }
            }
        }, [apiConnected, lookupData.EconomicRingfences.length, economicRingfenceService, logError]),
        entityStatuses: useCallback(async forceReload => {
            if (apiConnected && (lookupData.EntityStatuses.length === 0 || forceReload)) {
                try {
                    const e = await entityStatusService.readAllForLookup();
                    setLookupData(s => ({ ...s, EntityStatuses: e }));
                } catch (err) { logError(`Error loading entity statuses`, err); }
            }
        }, [apiConnected, lookupData.EntityStatuses.length, entityStatusService, logError]),
        financialRisks: useCallback(async forceReload => {
            if (apiConnected && (lookupData.FinancialRisks.length === 0 || forceReload)) {
                try {
                    const r = await financialRiskService.readAllForLookup();
                    setLookupData(s => ({ ...s, FinancialRisks: r }));
                } catch (err) { logError(`Error loading financial risks`, err); }
            }
        }, [apiConnected, lookupData.FinancialRisks.length, financialRiskService, logError]),
        fundingClassifications: useCallback(async forceReload => {
            if (apiConnected && (lookupData.FundingClassifications.length === 0 || forceReload)) {
                try {
                    const f = await fundingClassificationService.getItems();
                    setLookupData(s => ({ ...s, FundingClassifications: f }));
                } catch (err) { logError(`Error loading funding classifications`, err); }
            }
        }, [apiConnected, lookupData.FundingClassifications.length, fundingClassificationService, logError]),
        groups: useCallback(async forceReload => {
            if (apiConnected && (lookupData.Groups.length === 0 || forceReload)) {
                try {
                    const g = await groupService.readAllForLookup();
                    setLookupData(s => ({ ...s, Groups: g }));
                } catch (err) { logError(`Error loading groups`, err); }
            }
        }, [apiConnected, lookupData.Groups.length, groupService, logError]),
        keyWorkAreas: useCallback(async forceReload => {
            if (apiConnected && (lookupData.KeyWorkAreas.length === 0 || forceReload)) {
                try {
                    const kwa = await keyWorkAreaService.readAllForLookup();
                    setLookupData(s => ({ ...s, KeyWorkAreas: kwa }));
                } catch (err) { logError(`Error loading key work areas`, err); }
            }
        }, [apiConnected, lookupData.KeyWorkAreas.length, keyWorkAreaService, logError]),
        measurementUnits: useCallback(async forceReload => {
            if (apiConnected && (lookupData.MeasurementUnits.length === 0 || forceReload)) {
                try {
                    const mu = await measurementUnitService.readAllForLookup();
                    setLookupData(s => ({ ...s, MeasurementUnits: mu }));
                } catch (err) { logError(`Error loading measurement units`, err); }
            }
        }, [apiConnected, lookupData.MeasurementUnits.length, measurementUnitService, logError]),
        metrics: useCallback(async forceReload => {
            if (apiConnected && (lookupData.Metrics.length === 0 || forceReload)) {
                try {
                    const m = await metricService.readAllForLookup();
                    setLookupData(s => ({ ...s, Metrics: m }));
                } catch (err) { logError(`Error loading metrics`, err); }
            }
        }, [apiConnected, lookupData.Metrics.length, metricService, logError]),
        milestones: useCallback(async forceReload => {
            if (apiConnected && (lookupData.Milestones.length === 0 || forceReload)) {
                try {
                    const m = await milestoneService.readAllForLookup();
                    setLookupData(s => ({ ...s, Milestones: m }));
                } catch (err) { logError(`Error loading milestones`, err); }
            }
        }, [apiConnected, lookupData.Milestones.length, milestoneService, logError]),
        milestoneTypes: useCallback(async forceReload => {
            if (apiConnected && (lookupData.MilestoneTypes.length === 0 || forceReload)) {
                try {
                    const mt = await milestoneTypeService.readAllForLookup();
                    setLookupData(s => ({ ...s, MilestoneTypes: mt }));
                } catch (err) { logError(`Error loading milestone types`, err); }
            }
        }, [apiConnected, lookupData.MilestoneTypes.length, milestoneTypeService, logError]),
        partnerOrganisationRiskMitigationActions: useCallback(async forceReload => {
            if (apiConnected && (lookupData.PartnerOrganisationRiskMitigationActions.length === 0 || forceReload)) {
                try {
                    const porma = await partnerOrganisationRiskMitigationActionService.readAllForLookup();
                    setLookupData(s => ({ ...s, PartnerOrganisationRiskMitigationActions: porma }));
                } catch (err) { logError(`Error loading partner organisation risk mitigating actions`, err); }
            }
        }, [apiConnected, lookupData.PartnerOrganisationRiskMitigationActions.length, partnerOrganisationRiskMitigationActionService, logError]),
        partnerOrganisationRisks: useCallback(async forceReload => {
            if (apiConnected && (lookupData.PartnerOrganisationRisks.length === 0 || forceReload)) {
                try {
                    const por = await partnerOrganisationRiskService.readAllForLookup();
                    setLookupData(s => ({ ...s, PartnerOrganisationRisks: por }));
                } catch (err) { logError(`Error loading partner organisation risks`, err); }
            }
        }, [apiConnected, lookupData.PartnerOrganisationRisks.length, partnerOrganisationRiskService, logError]),
        partnerOrganisations: useCallback(async forceReload => {
            if (apiConnected && (lookupData.PartnerOrganisations.length === 0 || forceReload)) {
                try {
                    const po = await partnerOrganisationService.readAllForLookup();
                    setLookupData(s => ({ ...s, PartnerOrganisations: po }));
                } catch (err) { logError(`Error loading partner organisations`, err); }
            }
        }, [apiConnected, lookupData.PartnerOrganisations.length, partnerOrganisationService, logError]),
        policyRingfences: useCallback(async forceReload => {
            if (apiConnected && (lookupData.PolicyRingfences.length === 0 || forceReload)) {
                try {
                    const p = await policyRingfenceService.getItems();
                    setLookupData(s => ({ ...s, PolicyRingfences: p }));
                } catch (err) { logError(`Error loading policy ring-fences`, err); }
            }
        }, [apiConnected, lookupData.PolicyRingfences.length, policyRingfenceService, logError]),
        projectPhases: useCallback(async forceReload => {
            if (apiConnected && (lookupData.ProjectPhases.length === 0 || forceReload)) {
                try {
                    const pp = await projectPhaseService.readAllForLookup();
                    setLookupData(s => ({ ...s, ProjectPhases: pp }));
                } catch (err) { logError(`Error loading project phases`, err); }
            }
        }, [apiConnected, lookupData.ProjectPhases.length, projectPhaseService, logError]),
        projectBusinessCaseTypes: useCallback(async forceReload => {
            if (apiConnected && (lookupData.ProjectBusinessCaseTypes.length === 0 || forceReload)) {
                try {
                    const pbct = await projectBusinessCaseTypeService.readAllForLookup();
                    setLookupData(s => ({ ...s, ProjectBusinessCaseTypes: pbct }));
                } catch (err) { logError(`Error loading project business case types`, err); }
            }
        }, [apiConnected, lookupData.ProjectBusinessCaseTypes.length, projectBusinessCaseTypeService, logError]),
        projects: useCallback(async forceReload => {
            if (apiConnected && (lookupData.Projects.length === 0 || forceReload)) {
                try {
                    const e = await projectService.readAllForLookup();
                    setLookupData(s => ({ ...s, Projects: e }));
                } catch (err) { logError(`Error loading projects`, err); }
            }
        }, [apiConnected, lookupData.Projects.length, projectService, logError]),
        reportingEntityTypes: useCallback(async forceReload => {
            if (apiConnected && (lookupData.ReportingEntityTypes.length === 0 || forceReload)) {
                try {
                    const r = await reportingEntityTypeService.readAllForLookup();
                    setLookupData(s => ({ ...s, ReportingEntityTypes: r }));
                } catch (err) { logError(`Error loading reporting entity types`, err); }
            }
        }, [apiConnected, lookupData.ReportingEntityTypes.length, reportingEntityTypeService, logError]),
        reportingFrequencies: useCallback(async forceReload => {
            if (apiConnected && (lookupData.ReportingFrequencies.length === 0 || forceReload)) {
                try {
                    const r = await reportingFrequencyService.readAllForLookup();
                    setLookupData(s => ({ ...s, ReportingFrequencies: r }));
                } catch (err) { logError(`Error loading reporting frequencies`, err); }
            }
        }, [apiConnected, lookupData.ReportingFrequencies.length, reportingFrequencyService, logError]),
        riskAppetites: useCallback(async forceReload => {
            if (apiConnected && (lookupData.RiskAppetites.length === 0 || forceReload)) {
                try {
                    const ra = await riskAppetiteService.readAllForLookup();
                    setLookupData(s => ({ ...s, RiskAppetites: ra }));
                } catch (err) { logError(`Error loading risk appetites`, err); }
            }
        }, [apiConnected, lookupData.RiskAppetites.length, riskAppetiteService, logError]),
        riskDiscussionForums: useCallback(async forceReload => {
            if (apiConnected && (lookupData.RiskDiscussionForums.length === 0 || forceReload)) {
                try {
                    const ra = await riskDiscussionForumService.readAllForLookup();
                    setLookupData(s => ({ ...s, RiskDiscussionForums: ra }));
                } catch (err) { logError(`Error loading risk discussion forums`, err); }
            }
        }, [apiConnected, lookupData.RiskDiscussionForums.length, riskDiscussionForumService, logError]),
        riskRegisters: useCallback(async forceReload => {
            if (apiConnected && (lookupData.RiskRegisters.length === 0 || forceReload)) {
                try {
                    const rr = await riskRegisterService.readAllForLookup();
                    setLookupData(s => ({ ...s, RiskRegisters: rr }));
                } catch (err) { logError(`Error loading risk registers`, err); }
            }
        }, [apiConnected, lookupData.RiskRegisters.length, riskRegisterService, logError]),
        riskImpactLevels: useCallback(async forceReload => {
            if (apiConnected && (lookupData.RiskImpactLevels.length === 0 || forceReload)) {
                try {
                    const ril = await riskImpactLevelService.readAllForLookup();
                    setLookupData(s => ({ ...s, RiskImpactLevels: ril }));
                } catch (err) { logError(`Error loading risk impact levels`, err); }
            }
        }, [apiConnected, lookupData.RiskImpactLevels.length, riskImpactLevelService, logError]),
        riskProbabilities: useCallback(async forceReload => {
            if (apiConnected && (lookupData.RiskProbabilities.length === 0 || forceReload)) {
                try {
                    const rp = await riskProbabilityService.readAllForLookup();
                    setLookupData(s => ({ ...s, RiskProbabilities: rp }));
                } catch (err) { logError(`Error loading risk probabilities`, err); }
            }
        }, [apiConnected, lookupData.RiskProbabilities.length, riskProbabilityService, logError]),
        riskTypes: useCallback(async forceReload => {
            if (apiConnected && (lookupData.RiskTypes.length === 0 || forceReload)) {
                try {
                    const rt = await riskTypeService.readAllForLookup();
                    setLookupData(s => ({ ...s, RiskTypes: rt }));
                } catch (err) { logError(`Error loading risk types`, err); }
            }
        }, [apiConnected, lookupData.RiskTypes.length, riskTypeService, logError]),
        roles: useCallback(async forceReload => {
            if (apiConnected && (lookupData.Roles.length === 0 || forceReload)) {
                try {
                    const r = await roleService.readAllForLookup();
                    setLookupData(s => ({ ...s, Roles: r }));
                } catch (err) { logError(`Error loading roles`, err); }
            }
        }, [apiConnected, lookupData.Roles.length, roleService, logError]),
        thresholdAppetites: useCallback(async forceReload => {
            if (apiConnected && (lookupData.ThresholdAppetites.length === 0 || forceReload)) {
                try {
                    const ta = await thresholdAppetiteService.readAllForLookup();
                    setLookupData(s => ({ ...s, ThresholdAppetites: ta }));
                } catch (err) { logError(`Error loading threshold appetites`, err); }
            }
        }, [apiConnected, lookupData.ThresholdAppetites.length, thresholdAppetiteService, logError]),
        thresholds: useCallback(async forceReload => {
            if (apiConnected && (lookupData.Thresholds.length === 0 || forceReload)) {
                try {
                    const t = await thresholdService.readAllForLookup();
                    setLookupData(s => ({ ...s, Thresholds: t }));
                } catch (err) { logError(`Error loading thresholds`, err); }
            }
        }, [apiConnected, lookupData.Thresholds.length, thresholdService, logError]),
        budgetingEntities: useCallback(async forceReload => {
            if (apiConnected && (lookupData.BudgetingEntities.length === 0 || forceReload)) {
                try {
                    const u = await budgetingEntitiesService.getItems();
                    setLookupData(s => ({ ...s, BudgetingEntities: u }));
                } catch (err) { logError(`Error loading budgeting entities`, err); }
            }
        }, [apiConnected, lookupData.BudgetingEntities.length, budgetingEntitiesService, logError]),
        users: {
            all: useCallback(async forceReload => {
                if (apiConnected && (lookupData.Users.All.length === 0 || forceReload)) {
                    try {
                        const u = await userService.readAllForLookup(true);
                        setLookupData(s => ({ ...s, Users: { ...s.Users, All: u } }));
                    } catch (err) { logError(`Error loading all users`, err); }
                }
            }, [apiConnected, lookupData.Users.All.length, userService, logError]),
            enabled: useCallback(async forceReload => {
                if (apiConnected && (lookupData.Users.Enabled.length === 0 || forceReload)) {
                    try {
                        const u = await userService.readAllForLookup(false);
                        setLookupData(s => ({ ...s, Users: { ...s.Users, Enabled: u } }));
                    } catch (err) { logError(`Error loading enabled users`, err); }
                }
            }, [apiConnected, lookupData.Users.Enabled.length, userService, logError])
        },
        userDirectorates: useCallback(async forceReload => {
            if (apiConnected && (lookupData.UserDirectorates.length === 0 || forceReload)) {
                try {
                    const ud = await userDirectorateService.readAllForLookup();
                    setLookupData(s => ({ ...s, UserDirectorates: ud }));
                } catch (err) { logError(`Error loading user directorates`, err); }
            }
        }, [apiConnected, lookupData.UserDirectorates.length, userDirectorateService, logError]),
        userGroups: useCallback(async forceReload => {
            if (apiConnected && (lookupData.UserGroups.length === 0 || forceReload)) {
                try {
                    const u = await userGroupService.readAllForLookup();
                    setLookupData(s => ({ ...s, UserGroups: u }));
                } catch (err) { logError(`Error loading user groups`, err); }
            }
        }, [apiConnected, lookupData.UserGroups.length, userGroupService, logError]),
        userPartnerOrganisations: useCallback(async forceReload => {
            if (apiConnected && (lookupData.UserPartnerOrganisations.length === 0 || forceReload)) {
                try {
                    const u = await userPartnerOrganisationService.readAllForLookup();
                    setLookupData(s => ({ ...s, UserPartnerOrganisations: u }));
                } catch (err) { logError(`Error loading user partner organisations`, err); }
            }
        }, [apiConnected, lookupData.UserPartnerOrganisations.length, userPartnerOrganisationService, logError]),
        userProjects: useCallback(async forceReload => {
            if (apiConnected && (lookupData.UserProjects.length === 0 || forceReload)) {
                try {
                    const up = await userProjectService.readAllForLookup();
                    setLookupData(s => ({ ...s, UserProjects: up }));
                } catch (err) { logError(`Error loading user projects`, err); }
            }
        }, [apiConnected, lookupData.UserProjects.length, userProjectService, logError]),
        workStreams: useCallback(async forceReload => {
            if (apiConnected && (lookupData.WorkStreams.length === 0 || forceReload)) {
                try {
                    const ws = await workStreamService.readAllForLookup();
                    setLookupData(s => ({ ...s, WorkStreams: ws }));
                } catch (err) { logError(`Error loading work streams`, err); }
            }
        }, [apiConnected, lookupData.WorkStreams.length, workStreamService, logError])
    };

    return { dataServices: dataServices, lookupData: lookupData, loadLookupData: lld };
};
