import React, { useCallback, useContext, useEffect, useMemo, useState } from 'react';
import { SearchBox } from 'office-ui-fabric-react';
import { Period } from '../refData/Period';
import { Role } from '../refData/Role';
import styles from '../styles/cr.module.scss';
import {
    IBenefit, ICommitment, ICorporateRisk, ICorporateRiskMitigationAction, ICustomReportingEntity, IDependency,
    IDirectorate, IFinancialRisk, IFinancialRiskMitigationAction, IKeyWorkArea, IMetric, IMilestone,
    IPartnerOrganisation, IPartnerOrganisationRisk, IPartnerOrganisationRiskMitigationAction, IProject,
    IUserEntities, IWebPartComponentProps, IWorkStream
} from '../types';
import { ReportEntitiesDirectorate } from './ReportEntitiesDirectorate';
import { ReportEntitiesDirectorateRisks } from './ReportEntitiesDirectorateRisks';
import { ReportEntitiesPartnerOrganisation } from './ReportEntitiesPartnerOrganisation';
import { ReportEntitiesProject } from './ReportEntitiesProject';
import { IWithErrorHandlingProps } from './withErrorHandling';
import { CrLoadingOverlay } from './cr/CrLoadingOverlay';
import { addMonths, addWeeks } from 'date-fns';
import { ReportEntitiesFinancialRisks } from './ReportEntitiesFinancialRisks';
import { CrCommandBar } from './cr/CrCommandBar';
import { OrbUserContext } from './OrbUserContext';
import { DataContext } from './DataContext';

export interface IReportEntitiesProps extends IWebPartComponentProps, IWithErrorHandlingProps { }

enum FilterTimeOptions {
    OneWeek = 1,
    OneMonth,
    ThreeMonths,
    Anytime
}

export const ReportEntities = (props: IReportEntitiesProps): React.ReactElement => {
    const { errorHandling: { onError } } = props;
    const { dataServices } = useContext(DataContext);
    const { userContext } = useContext(OrbUserContext);
    const [loading, setLoading] = useState(false);
    const [reportPeriod, setReportPeriod] = useState(Period.Current);
    const [filterText, setFilterText] = useState('');
    const [filterTime, setFilterTime] = useState<{ option: number, maxProximity: Date }>({ option: FilterTimeOptions.Anytime, maxProximity: null });
    const [directorates, setDirectorates] = useState<IDirectorate[]>([]);
    const [keyWorkAreas, setKeyWorkAreas] = useState<IKeyWorkArea[]>([]);
    const [milestones, setMilestones] = useState<IMilestone[]>([]);
    const [metrics, setMetrics] = useState<IMetric[]>([]);
    const [commitments, setCommitments] = useState<ICommitment[]>([]);
    const [projects, setProjects] = useState<IProject[]>([]);
    const [workStreams, setWorkStreams] = useState<IWorkStream[]>([]);
    const [benefits, setBenefits] = useState<IBenefit[]>([]);
    const [dependencies, setDependencies] = useState<IDependency[]>([]);
    const [partnerOrgs, setPartnerOrgs] = useState<IPartnerOrganisation[]>([]);
    const [partnerOrgRisks, setPartnerOrgRisks] = useState<IPartnerOrganisationRisk[]>([]);
    const [partnerOrgRiskActions, setPartnerOrgRiskActions] = useState<IPartnerOrganisationRiskMitigationAction[]>([]);
    const [risks, setRisks] = useState<ICorporateRisk[]>([]);
    const [riskActions, setRiskActions] = useState<ICorporateRiskMitigationAction[]>([]);
    const [financialRisks, setFinancialRisks] = useState<IFinancialRisk[]>([]);
    const [financialRiskActions, setFinancialRiskActions] = useState<IFinancialRiskMitigationAction[]>([]);
    const [reportingEntities, setReportingEntities] = useState<ICustomReportingEntity[]>([]);

    const logError = useCallback(onError, [onError]);

    const userEntitiesString = useMemo(() => JSON.stringify(userContext.UserEntities), [userContext.UserEntities]);
    useEffect(() => {
        const loadReportEntities = async (userEntities: IUserEntities): Promise<void> => {
            try {
                setLoading(true);
                let d = [], p = [], po = [], m = [];
                let loadMilestones = false;

                if (userEntities.UserDirectorates.length > 0) {
                    d = [
                        dataServices.directorateService.readMyDirectorates().then(setDirectorates),
                        dataServices.keyWorkAreaService.readMyKeyWorkAreas().then(setKeyWorkAreas),
                        dataServices.metricService.readMyMetrics().then(setMetrics),
                        dataServices.commitmentService.readMyCommitments().then(setCommitments),
                        dataServices.corporateRiskService.readMyRisks(userEntities.UserDirectorates).then(setRisks),
                        dataServices.corporateRiskMitigationActionService.readMyActions(userEntities.UserDirectorates).then(setRiskActions)
                    ];
                    loadMilestones = true;
                }

                if (userEntities.UserProjects.length > 0) {
                    p = [
                        dataServices.projectService.readMyProjects().then(setProjects),
                        dataServices.workStreamService.readMyWorkStreams().then(setWorkStreams),
                        dataServices.benefitService.readMyBenefits().then(setBenefits),
                        dataServices.dependencyService.readMyDependencies().then(setDependencies)
                    ];
                    loadMilestones = true;
                }

                if (userEntities.UserPartnerOrganisations.length > 0 || userEntities.UserRoles?.some(ur => ur.RoleID == Role.PartnerOrganisationAdmin)) {
                    po = [
                        dataServices.partnerOrganisationService.readMyPartnerOrganisations(userEntities.UserPartnerOrganisations, true, userEntities.UserRoles).then(setPartnerOrgs),
                        dataServices.partnerOrganisationRiskService.readMyRisks(userEntities.UserPartnerOrganisations, userEntities.UserRoles).then(setPartnerOrgRisks),
                        dataServices.partnerOrganisationRiskMitigationActionService.readMyActions(userEntities.UserPartnerOrganisations, userEntities.UserRoles).then(setPartnerOrgRiskActions)
                    ];
                    loadMilestones = true;
                }

                if (loadMilestones) {
                    m = [
                        dataServices.milestoneService.readMyMilestones().then(setMilestones)
                    ];
                }

                const repEntities = dataServices.reportingEntityService.readMyEntities().then(setReportingEntities);
                const finRisks = dataServices.financialRiskService.readMyRisks().then(setFinancialRisks);
                const finRiskActions = dataServices.financialRiskMitigationActionService.readMyActions().then(setFinancialRiskActions);

                // Await promises to remove loading animation
                await Promise.all([...d, ...p, ...po, ...m, repEntities, finRisks, finRiskActions]);

            } catch (err) {
                logError('Error loading report entities', err.Message);
            } finally {
                setLoading(false);
            }
        };

        loadReportEntities(JSON.parse(userEntitiesString));
    }, [userEntitiesString, dataServices.benefitService, dataServices.commitmentService, dataServices.corporateRiskMitigationActionService,
        dataServices.corporateRiskService, dataServices.dependencyService, dataServices.directorateService, dataServices.financialRiskMitigationActionService,
        dataServices.financialRiskService, dataServices.keyWorkAreaService, dataServices.metricService, dataServices.milestoneService,
        dataServices.partnerOrganisationRiskMitigationActionService, dataServices.partnerOrganisationRiskService, dataServices.partnerOrganisationService,
        dataServices.projectService, dataServices.reportingEntityService, dataServices.workStreamService, logError]);

    const radioMenuIcon = (isSelected: boolean) => ({ iconName: isSelected ? 'RadioBtnOn' : 'RadioBtnOff' });

    return (
        <div className={styles.cr}>
            <CrCommandBar
                className={styles.crCommandBarFloating}
                items={[
                    {
                        key: 'period title',
                        text: `Report period: ${reportPeriod === Period.Current ? 'Current period' : 'Last period'}`,
                        iconProps: { iconName: reportPeriod === Period.Previous ? 'Rewind' : 'Play' },
                        subMenuProps: {
                            items: [
                                {
                                    key: 'previous',
                                    text: 'Last period',
                                    onClick: () => setReportPeriod(Period.Previous),
                                    iconProps: radioMenuIcon(reportPeriod === Period.Previous)
                                },
                                {
                                    key: 'current',
                                    text: 'Current period',
                                    onClick: () => setReportPeriod(Period.Current),
                                    iconProps: radioMenuIcon(reportPeriod === Period.Current)
                                }
                            ]
                        }
                    }
                ]}
                farItems={[
                    {
                        key: 'proximity',
                        text: 'Report due...',
                        iconProps: { iconName: 'DateTime' },
                        subMenuProps: {
                            items: [
                                {
                                    key: FilterTimeOptions.OneWeek.toString(),
                                    text: 'Within a week',
                                    onClick: () => setFilterTime({ option: FilterTimeOptions.OneWeek, maxProximity: addWeeks(new Date(), 1) }),
                                    iconProps: radioMenuIcon(filterTime.option === FilterTimeOptions.OneWeek)
                                },
                                {
                                    key: FilterTimeOptions.OneMonth.toString(),
                                    text: 'Within a month',
                                    onClick: () => setFilterTime({ option: FilterTimeOptions.OneMonth, maxProximity: addMonths(new Date(), 1) }),
                                    iconProps: radioMenuIcon(filterTime.option === FilterTimeOptions.OneMonth)
                                },
                                {
                                    key: FilterTimeOptions.ThreeMonths.toString(),
                                    text: 'Within 3 months',
                                    onClick: () => setFilterTime({ option: FilterTimeOptions.ThreeMonths, maxProximity: addMonths(new Date(), 3) }),
                                    iconProps: radioMenuIcon(filterTime.option === FilterTimeOptions.ThreeMonths)
                                },
                                {
                                    key: FilterTimeOptions.Anytime.toString(),
                                    text: 'Anytime',
                                    onClick: () => setFilterTime({ option: FilterTimeOptions.Anytime, maxProximity: null }),
                                    iconProps: radioMenuIcon(filterTime.option === FilterTimeOptions.Anytime)
                                }
                            ]
                        }
                    },
                    {
                        key: 'filter',
                        name: 'List filter',
                        inActive: true,
                        onRender: function renderSearch() {
                            return (
                                <div className={styles.crCommandBarContainer}>
                                    <SearchBox
                                        placeholder="Filter items"
                                        className={styles.listFilterBox}
                                        value={filterText}
                                        onChange={(_, v) => setFilterText(v)}
                                    />
                                </div>
                            );
                        }
                    }
                ]}
            />
            <div className={`${styles.crList} ${styles.updateList}`}>
                <CrLoadingOverlay isLoading={loading} />
                <ReportEntitiesFinancialRisks
                    {...props}
                    filters={{ text: filterText, dueBy: filterTime.maxProximity }}
                    risks={financialRisks}
                    riskActions={financialRiskActions}
                    reportPeriod={reportPeriod}
                />
                {userContext?.UserEntities?.UserDirectorates?.map(ud =>
                    <>
                        <ReportEntitiesDirectorate
                            {...props}
                            filters={{ text: filterText, dueBy: filterTime.maxProximity }}
                            directorate={ud.Directorate}
                            directorates={directorates.filter(dir => dir.ID === ud.DirectorateID)}
                            keyWorkAreas={keyWorkAreas.filter(k => k.DirectorateID === ud.DirectorateID)}
                            milestones={milestones.filter(m => m.KeyWorkArea?.DirectorateID === ud.DirectorateID)}
                            commitments={commitments.filter(c => c.DirectorateID === ud.DirectorateID)}
                            metrics={metrics.filter(m => m.DirectorateID === ud.DirectorateID)}
                            reportingEntities={reportingEntities.filter(re => re.DirectorateID === ud.DirectorateID)}
                            reportPeriod={reportPeriod}
                        />
                        {risks.filter(r => r.DirectorateID === ud.DirectorateID).length + riskActions.filter(a => a.Risk?.DirectorateID === ud.DirectorateID).length > 0 &&
                            <ReportEntitiesDirectorateRisks
                                {...props}
                                filters={{ text: filterText, dueBy: filterTime.maxProximity }}
                                directorate={ud.Directorate}
                                risks={risks.filter(r => r.DirectorateID === ud.DirectorateID)}
                                riskActions={riskActions.filter(a => a.Risk?.DirectorateID === ud.DirectorateID || a.CorporateRiskRiskMitigationActions?.some(rrma => rrma.Risk?.DirectorateID === ud.DirectorateID))}
                                reportPeriod={reportPeriod}
                            />
                        }
                    </>
                )}
                {userContext?.UserEntities?.UserProjects?.map(up =>
                    <>
                        <ReportEntitiesProject
                            {...props}
                            filters={{ text: filterText, dueBy: filterTime.maxProximity }}
                            project={up.Project}
                            projects={projects.filter(proj => proj.ID === up.ProjectID)}
                            workStreams={workStreams.filter(w => w.ProjectID === up.ProjectID)}
                            milestones={milestones.filter(m => m.WorkStream?.ProjectID === up.ProjectID)}
                            dependencies={dependencies.filter(d => d.ProjectID === up.ProjectID)}
                            benefits={benefits.filter(b => b.ProjectID === up.ProjectID)}
                            reportingEntities={reportingEntities.filter(re => re.ProjectID === up.ProjectID)}
                            reportPeriod={reportPeriod}
                        />
                    </>
                )}
                {userContext?.UserEntities?.UserPartnerOrganisations?.map(upo =>
                    <ReportEntitiesPartnerOrganisation
                        key={upo.ID}
                        {...props}
                        filters={{ text: filterText, dueBy: filterTime.maxProximity }}
                        partnerOrganisation={upo.PartnerOrganisation}
                        partnerOrganisations={partnerOrgs.filter(po => po.ID === upo.PartnerOrganisationID)}
                        milestones={milestones.filter(m => m.PartnerOrganisationID === upo.PartnerOrganisationID)}
                        reportingEntities={reportingEntities.filter(re => re.PartnerOrganisationID === upo.PartnerOrganisationID)}
                        risks={partnerOrgRisks.filter(r => r.PartnerOrganisationID === upo.PartnerOrganisationID)}
                        riskActions={partnerOrgRiskActions.filter(a => a.PartnerOrganisationRisk?.PartnerOrganisationID === upo.PartnerOrganisationID)}
                        reportPeriod={reportPeriod}
                    />
                )}
                {filterTime.option !== FilterTimeOptions.Anytime &&
                    <div className={styles.hide}><p>No updates match the &apos;Report due...&apos; filter</p></div>
                }
            </div>
        </div>
    );
};
