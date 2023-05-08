import React, { useState, useEffect, useCallback, useContext } from 'react';
import { useHistory, useLocation } from 'react-router-dom';
import { INavLink, Nav } from 'office-ui-fabric-react';
import { IWithErrorHandlingProps } from './withErrorHandling';
import { ICustomReportingEntityType } from '../types/CustomReportingEntityType';
import { ReportTypes } from '../refData/ReportTypes';
import { DataContext } from './DataContext';
import { OrbUserContext } from './OrbUserContext';

interface IOrbMenu extends IWithErrorHandlingProps {
    showSpSiteNavLinks: boolean;
    onLinkClicked?: () => void;
}

export const OrbMenu = ({ errorHandling: { clearErrors }, showSpSiteNavLinks, onLinkClicked }: IOrbMenu): React.ReactElement => {
    const { userPermissions: up } = useContext(OrbUserContext);
    const { dataServices: { siteService, reportingEntityTypeService } } = useContext(DataContext);
    const history = useHistory();
    const { pathname } = useLocation();
    const [navs, setNavs] = useState([]);
    const [spNavs, setSpNavs] = useState([]);
    const [performanceReportingExpanded, setPerformanceReportingExpanded] = useState(pathname.startsWith('/performance-reporting/'));
    const [riskReportingExpanded, setRiskReportingExpanded] = useState(pathname.startsWith('/risk-reporting/'));
    const [partnerOrgReportingExpanded, setPartnerOrgReportingExpanded] = useState(pathname.startsWith('/partner-organisation-reporting/'));
    const [adminExpanded, setAdminExpanded] = useState(pathname.startsWith('/admin/'));
    const [customReportingEntityTypes, setCustomReportingEntityTypes] = useState<ICustomReportingEntityType[]>([]);

    const resetErrors = useCallback(clearErrors, [clearErrors]);

    useEffect(() => {
        if (showSpSiteNavLinks) {
            (async () => setSpNavs(await siteService.getSiteNav()))();
        }
    }, [showSpSiteNavLinks, siteService]);

    useEffect(() => {
        const loadCustomReportingEntities = async () => {
            setCustomReportingEntityTypes(await reportingEntityTypeService.readAllForNavigation());
        };

        loadCustomReportingEntities();
    }, [reportingEntityTypeService]);

    useEffect(() => {
        const routerNav = (path: string): void => {
            resetErrors();
            history.push(path);
            if (onLinkClicked) onLinkClicked();
        };

        const NamePathToNavLink = ({ name, path }): INavLink => {
            return { key: path, name: name, url: `#${path}`, onClick: () => routerNav(path) };
        };

        const links: INavLink[] = [
            { name: 'Home', path: '/my-updates' },
            { name: 'Report archive', path: '/report-archive' }
        ].map(NamePathToNavLink);

        if (up.UserCanViewRiskEntities()) {
            links.push(NamePathToNavLink({ name: 'Risk register', path: '/risk-register' }));
        }

        if (up.UserCanViewFinancialRiskEntities()) {
            links.push(NamePathToNavLink({ name: 'Financial risk register', path: '/financial-risk-register' }));
        }

        if (up.UserIsSystemAdmin() || up.UserCanViewDirectorateEntities() || up.UserCanViewProjectEntities()) {
            links.push({
                key: 'performance-reporting',
                name: 'Performance reporting',
                url: null,
                isExpanded: performanceReportingExpanded,
                onClick: () => setPerformanceReportingExpanded(e => !e),
                links: [
                    up.UserIsSystemAdmin() && { name: 'Groups', path: '/performance-reporting/groups' },
                    up.UserCanViewDirectorateEntities() && { name: 'Directorates', path: '/performance-reporting/directorates' },
                    up.UserCanViewProjectEntities() && { name: 'Projects', path: '/performance-reporting/projects' },
                    up.UserCanViewDirectorateEntities() && { name: 'Key work areas', path: '/performance-reporting/key-work-areas' },
                    up.UserCanViewProjectEntities() && { name: 'Work streams', path: '/performance-reporting/work-streams' },
                    up.UserCanViewDirectorateEntities() && { name: 'Metrics', path: '/performance-reporting/metrics' },
                    (up.UserCanViewDirectorateEntities() || up.UserCanViewProjectEntities()) && { name: 'Milestones', path: '/performance-reporting/milestones' },
                    up.UserCanViewProjectEntities() && { name: 'Benefits', path: '/performance-reporting/benefits' },
                    up.UserCanViewDirectorateEntities() && { name: 'Commitments', path: '/performance-reporting/commitments' },
                    up.UserCanViewProjectEntities() && { name: 'Dependencies', path: '/performance-reporting/dependencies' },
                    ...customReportingEntityTypes
                        .filter(cret =>
                            (up.UserCanViewDirectorateEntities() && cret.ReportTypeID === ReportTypes.Directorate)
                            || (up.UserCanViewProjectEntities() && cret.ReportTypeID === ReportTypes.Project))
                        .map(cret => ({ name: cret.Title, path: `/performance-reporting/${cret.ID}` }))
                ].filter(r => r).map(NamePathToNavLink)
            });
        }

        if (up.UserCanViewRiskEntities() || up.UserCanViewFinancialRiskEntities()) {
            const riskLinks = [];
            if (up.UserCanViewRiskEntities()) {
                riskLinks.push(
                    { name: 'Risks', path: '/risk-reporting/risks' },
                    { name: 'Risk mitigating actions', path: '/risk-reporting/risk-mitigating-actions' }
                );
            }
            if (up.UserCanViewFinancialRiskEntities()) {
                riskLinks.push(
                    { name: 'Financial risks', path: '/risk-reporting/financial-risks' },
                    { name: 'Financial risk mitigating actions', path: '/risk-reporting/financial-risk-mitigating-actions' }
                );
            }
            links.push({
                key: 'risk-reporting',
                name: 'Risk reporting',
                url: null,
                isExpanded: riskReportingExpanded,
                onClick: () => setRiskReportingExpanded(e => !e),
                links: riskLinks.filter(r => r).map(NamePathToNavLink)
            });
        }

        if (up.UserCanViewPartnerOrganisationEntities()) {
            links.push({
                key: 'partner-organisation-reporting',
                name: 'Partner organisation reporting',
                url: null,
                isExpanded: partnerOrgReportingExpanded,
                onClick: () => setPartnerOrgReportingExpanded(e => !e),
                links: [
                    { name: 'Partner organisations', path: '/partner-organisation-reporting/partner-organisations' },
                    { name: 'Risks', path: '/partner-organisation-reporting/risks' },
                    { name: 'Risk mitigating actions', path: '/partner-organisation-reporting/risk-mitigating-actions' },
                    { name: 'Milestones', path: '/partner-organisation-reporting/milestones' },
                    ...customReportingEntityTypes
                        .filter(cret => cret.ReportTypeID === ReportTypes.PartnerOrganisation)
                        .map(cret => ({ name: cret.Title, path: `/partner-organisation-reporting/${cret.ID}` }))
                ].filter(r => r).map(NamePathToNavLink)
            });
        }

        if (up.UserIsSystemAdmin() || up.UserIsCustomSectionsAdmin() || up.UserIsFinancialRiskAdmin()) {
            const adminLinks = [];
            if (up.UserIsSystemAdmin()) {
                adminLinks.push(
                    { name: 'Users', path: '/admin/users' },
                    { name: 'User groups', path: '/admin/user-groups' },
                    { name: 'User directorates', path: '/admin/user-directorates' },
                    { name: 'User partner orgs', path: '/admin/user-partner-organisations' },
                    { name: 'User projects', path: '/admin/user-projects' },
                    { name: 'Milestone types', path: '/admin/milestone-types' },
                    { name: 'Benefit types', path: '/admin/benefit-types' },
                    { name: 'Attributes', path: '/admin/attributes' },
                    { name: 'Reporting frequencies', path: '/admin/reporting-frequencies' },
                    { name: 'Risk types', path: '/admin/risk-types' },
                    { name: 'Risk discussion forums', path: '/admin/risk-discussion-forums' },
                    { name: 'Units', path: '/admin/units' },
                    { name: 'Thresholds', path: '/admin/thresholds' },
                    { name: 'Threshold appetites', path: '/admin/threshold-appetites' },
                    { name: 'Administrators', path: '/admin/administrators' }
                );
            }

            if (up.UserIsCustomSectionsAdmin()) {
                adminLinks.push(
                    { name: 'Custom report sections', path: '/admin/custom-report-sections' }
                );
            }

            if (up.UserIsFinancialRiskAdmin()) {
                adminLinks.push(
                    { name: 'Financial risk user groups', path: '/admin/financial-risk-user-groups' }
                );
            }

            links.push({
                key: 'service-admin',
                name: 'Service admin',
                url: null,
                isExpanded: adminExpanded,
                onClick: () => setAdminExpanded(ae => !ae),
                links: adminLinks.map(NamePathToNavLink)
            });
        }

        links.push(...spNavs.map(n => ({ key: n.Url, name: n.Title, url: n.Url })));

        setNavs(links);
    }, [up, spNavs, customReportingEntityTypes, adminExpanded, partnerOrgReportingExpanded, performanceReportingExpanded,
        riskReportingExpanded, history, onLinkClicked, resetErrors]);

    return (
        <Nav
            selectedKey={pathname === '/draft-reports' || pathname === '/sign-off' ? '/my-updates' : pathname}
            styles={{ link: { color: '#323130' } }}
            groups={[{ links: navs }]}
        />
    );
};
