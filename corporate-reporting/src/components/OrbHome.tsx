import React, { useContext, useMemo } from 'react';
import { useHistory, useLocation } from 'react-router-dom';
import styles from '../styles/cr.module.scss';
import { IWebPartComponentProps } from '../types';
import { Pivot, PivotItem } from 'office-ui-fabric-react/lib/Pivot';
import { SignOffList } from './signOff/SignOffList';
import { DraftReportList } from './draftReport/DraftReportList';
import { IWithErrorHandlingProps, withErrorHandling } from './withErrorHandling';
import { ReportEntities } from './ReportEntities';
import { CrDropdown } from './cr/CrDropdown';
import { IDropdownOption } from 'office-ui-fabric-react';
import { DataContext } from './DataContext';
import { OrbUserContext } from './OrbUserContext';

interface IOrbHomeProps extends IWebPartComponentProps, IWithErrorHandlingProps {
    apiConnected: boolean;
    emphasiseProjectsWithAttribute: string;
    emphasisedProjectsHeaderText: string;
    otherProjectsHeaderText: string;
}

const OrbHome = (props: IOrbHomeProps) => {
    const { errorHandling, isFullPage } = props;
    const { userContext: {
        DirectorOf, ApproverOfDirectorates, SROOf, ApproverOfProjects, RiskOwnerOf,
        AlternativeApproverOfRisks: AlternativeRiskApprover, AlternativeApproverOfFinancialRisks: AlternativeFinancialRiskApprover,
        LeadPolicySponsorOfPartnerOrgs, ReportAuthorOfPartnerOrgs } } = useContext(OrbUserContext);
    const history = useHistory();
    const { pathname } = useLocation();
    const { loadLookupData: { reportingFrequencies } } = useContext(DataContext);

    useMemo(() => reportingFrequencies(), [reportingFrequencies]);

    const onClickTab = (tabName: string): void => {
        errorHandling.clearErrors();
        history.push(tabName);
    };

    const isDirector: boolean = ((DirectorOf?.length || 0) + (ApproverOfDirectorates?.length || 0)) > 0;
    const isSRO: boolean = ((SROOf?.length || 0) + (ApproverOfProjects?.length || 0)) > 0;
    const isPartnerOrgSponsor: boolean = ((LeadPolicySponsorOfPartnerOrgs?.length || 0) + (ReportAuthorOfPartnerOrgs?.length || 0)) > 0;
    const isRiskOwner: boolean = (
        (RiskOwnerOf?.length || 0) + (AlternativeRiskApprover?.length || 0) + (AlternativeFinancialRiskApprover?.length || 0)
    ) > 0;

    const tabs: IDropdownOption[] = [
        { key: '/my-updates', text: 'My updates' },
        { key: '/draft-reports', text: 'Draft reports' },
        (isDirector || isSRO || isRiskOwner || isPartnerOrgSponsor) && { key: '/sign-off', text: 'Review and sign-off' }
    ].filter(t => t);

    const listScrollFix = isFullPage ? { 'data-is-scrollable': 'true' } : {};

    // Nothing worked to make PivotItems conditional; className, {isDirector && <PivotItem/>}...
    return (
        <div className={`${styles.cr} ${isFullPage ? styles.crFullPage : ''}`}>
            <div className={styles.homeMenuDropdown}>
                <CrDropdown className={isFullPage ? styles.crFullPagePivot : ''} options={tabs} selectedKey={pathname} onChange={(_, o) => onClickTab(o.key.toString())} />
            </div>
            <div className={styles.homeMenuTabs}>
                {
                    (isDirector || isSRO || isRiskOwner || isPartnerOrgSponsor) &&
                    <Pivot className={isFullPage ? styles.crFullPagePivot : ''} headersOnly={true} selectedKey={pathname} onLinkClick={i => onClickTab(i.props.itemKey)}>
                        <PivotItem headerText="My updates" itemKey="/my-updates" />
                        <PivotItem headerText="Draft reports" itemKey="/draft-reports" />
                        <PivotItem headerText="Review and sign-off" itemKey="/sign-off" />
                    </Pivot>
                    ||
                    <Pivot className={isFullPage ? styles.crFullPagePivot : ''} headersOnly={true} selectedKey={pathname} onLinkClick={i => onClickTab(i.props.itemKey)}>
                        <PivotItem headerText="My updates" itemKey="/my-updates" />
                        <PivotItem headerText="Draft reports" itemKey="/draft-reports" />
                    </Pivot>
                }
            </div>
            {pathname === '/my-updates' &&
                <div className={isFullPage ? styles.crFullPagePivotContent : ''}>
                    <ReportEntities {...props} />
                </div>
            }
            {pathname === '/draft-reports' &&
                <div className={isFullPage ? styles.crFullPagePivotContent : ''} {...listScrollFix}>
                    <DraftReportList {...props} />
                </div>
            }
            {pathname === '/sign-off' &&
                <div className={isFullPage ? styles.crFullPagePivotContent : ''} {...listScrollFix}>
                    <SignOffList {...props} />
                </div>
            }
        </div>
    );
};

export default withErrorHandling(OrbHome);
