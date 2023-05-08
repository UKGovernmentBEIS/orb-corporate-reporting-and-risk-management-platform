import { useCallback, useEffect, useState } from 'react';
import { IDataServices, IUserContext, UserContext } from '../types';
import { UserPermissionService } from '../services';
import { IUserPermissionService } from '../services/UserPermissionService';
import { IErrorHandling } from './withErrorHandling';

export interface IUseUserContextProps {
    userContext: IUserContext;
    userPermissions: IUserPermissionService;
}

export const useUserContext = (apiConnected: boolean, { userService }: IDataServices, { onError }: IErrorHandling): IUseUserContextProps => {
    const [state, setState] = useState<{ UserContext: IUserContext, UserPermissions: UserPermissionService }>({
        UserContext: new UserContext(),
        UserPermissions: new UserPermissionService(new UserContext())
    });
    const logError = useCallback(onError, [onError]);

    useEffect(() => {
        const loadUserPermissions = async (): Promise<void> => {
            try {
                const user = await userService.readMyPermissions();
                const uc: IUserContext = {
                    UserId: user.ID,
                    Username: user.Username,
                    UserEntities: {
                        EntitiesTimestamp: new Date().getTime(),
                        UserRoles: user.UserRoles,
                        UserGroups: user.UserGroups,
                        UserDirectorates: user.UserDirectorates,
                        UserProjects: user.UserProjects,
                        UserPartnerOrganisations: user.UserPartnerOrganisations,
                        FinancialRiskUserGroups: user.FinancialRiskUserGroups
                    },
                    DirectorOf: user.DirectorateDirectorUsers,
                    ApproverOfDirectorates: user.DirectorateReportApproverUsers,
                    SROOf: user.ProjectSeniorResponsibleOwnerUsers,
                    ApproverOfProjects: user.ProjectReportApproverUsers,
                    RiskOwnerOf: [...user.CorporateRiskRiskOwnerUsers, ...user.FinancialRiskRiskOwnerUsers],
                    AlternativeApproverOfRisks: user.CorporateRiskReportApproverUsers,
                    AlternativeApproverOfFinancialRisks: user.FinancialRiskReportApproverUsers,
                    LeadPolicySponsorOfPartnerOrgs: user.PartnerOrganisationLeadPolicySponsorUsers,
                    ReportAuthorOfPartnerOrgs: user.PartnerOrganisationReportAuthorUsers,
                    ContributorTo: user.ContributorContributorUsers
                };
                setState({ UserContext: uc, UserPermissions: new UserPermissionService(uc) });
            } catch (err) {
                logError(`Error loading user context`, err.message);
            }
        };

        if (apiConnected) {
            loadUserPermissions();
        }
    }, [apiConnected, userService, logError]);

    return { userContext: state.UserContext, userPermissions: state.UserPermissions };
};
