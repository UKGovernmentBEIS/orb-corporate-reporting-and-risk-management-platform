import React from 'react';
import {
    IEntity, IAttribute, IEntityWithTimerange, IAttributeType, ILookupData, IReportingEntity, IUser, ICommitment,
    IKeyWorkArea, IBenefit, IDependency, IMilestone, IPartnerOrganisationRisk, IWorkStream, IRisk,
    IPartnerOrganisationRiskMitigationAction, IRiskMitigationAction, ICustomReportingEntity
} from '../types';
import { ISelectableOption } from 'office-ui-fabric-react/lib/SelectableOption';
import { IChoiceGroupOption } from 'office-ui-fabric-react/lib/ChoiceGroup';
import { TooltipHost } from 'office-ui-fabric-react/lib/Tooltip';
import { ICrMultiDropdownWithTextOption, ICrMultiDropdownWithTextValue } from '../components/cr/CrMultiDropdownWithText';
import { RiskRegister } from '../refData/RiskRegister';
import { IDropdownOption } from 'office-ui-fabric-react';

export class LookupService {
    public static entitiesToSelectableOptions = <T extends IEntity>(
        entities: T[],
        formatters?: { optionKey?: (entity: T) => string, optionText?: (entity: T) => string }
    ): ISelectableOption[] => {
        return entities ? formatters ?
            entities.map(e => ({ key: formatters.optionKey?.(e) || e.ID, text: formatters.optionText?.(e) || e.Title }))
            :
            entities.map(e => ({ key: e.ID, text: e.Title }))
            :
            [];
    }

    public static entitiesToSelectableOptionsFilteredByDate = (filterDate: Date, entities: IEntityWithTimerange[]): ISelectableOption[] =>
        entities?.filter(en => (!en.StartUpdatePeriod || filterDate >= en.StartUpdatePeriod) && (!en.EndUpdatePeriod || filterDate <= en.EndUpdatePeriod))
            .map((li): ISelectableOption => ({ key: li.ID, text: li.Title })) || []

    private static renderLabel(option: IChoiceGroupOption, description?: string) {
        return (
            <TooltipHost content={description}>
                <span style={{ paddingLeft: '26px' }}>{option.text}</span>
            </TooltipHost>
        );
    }

    public static entitiesToChoiceGroupOptionsFilteredByDate = (filterDate: Date, entities: IEntityWithTimerange[]): IChoiceGroupOption[] =>
        entities?.filter(e => (!e.StartUpdatePeriod || filterDate >= e.StartUpdatePeriod) && (!e.EndUpdatePeriod || filterDate <= e.EndUpdatePeriod))
            .map((e): IChoiceGroupOption =>
            ({
                key: e.ID?.toString(),
                text: e.Title,
                onRenderLabel: option => LookupService.renderLabel(option, e.Description)
            })
            ) || []

    public static entitiesToChoiceGroupOptions = (entities: IEntity[]): IChoiceGroupOption[] =>
        entities?.map((e): IChoiceGroupOption =>
        ({
            key: e.ID?.toString(),
            text: e.Title,
            onRenderLabel: option => LookupService.renderLabel(option, e.Description)
        })
        ) || []

    public static attributesToDropdownWithText = (attributes: IAttribute[]): ICrMultiDropdownWithTextValue[] =>
        attributes?.map(a => ({ Key: a.AttributeTypeID, Text: a.AttributeValue })) || []

    public static attributeTypesToMultiDropdownWithTextOptions = (attributeTypes: IAttributeType[]): ICrMultiDropdownWithTextOption[] =>
        attributeTypes?.map(a => ({ key: a.ID, text: a.Title, textRequired: false })) || []

    public static getLookupName = (lookupData: IEntity[], optionId: number | string, noMatchText = 'To be completed'): string =>
        lookupData?.find(ld => ld.ID === Number(optionId))?.Title || noMatchText

    public static userIsInDirectorate = (lookupData: ILookupData, userId: number, directorateId: number): boolean =>
        lookupData?.UserDirectorates?.filter(ud => ud.DirectorateID === directorateId).some(ud => ud.UserID === userId) || false

    public static userIsInGroup = (lookupData: ILookupData, userId: number, groupId: number): boolean =>
        lookupData?.UserGroups?.filter(ug => ug.GroupID === groupId).some(ug => ug.UserID === userId) || false

    public static userIsInGroupDirectorates = (lookupData: ILookupData, userId: number, groupId: number): boolean => {
        const groupDirectorates = lookupData.Directorates.filter(d => d.GroupID === groupId).map(d => d.ID);
        return lookupData?.UserDirectorates?.filter(ud => groupDirectorates.includes(ud.DirectorateID)).some(ud => ud.UserID === userId) || false;
    }

    public static directorateUsers = (ld: ILookupData, directorateId: number, entity: ICommitment | IKeyWorkArea | IMilestone | ICustomReportingEntity): IUser[] => {
        if (ld?.Users?.All && directorateId && entity) {
            return ld.Users.All.filter(u => LookupService.userIsInDirectorate(ld, u.ID, directorateId)
                || LookupService.userIsContributor(entity, u.ID)
                || u.ID === entity.LeadUserID
            );
        }
        return [];
    }

    public static userIsInProject = (lookupData: ILookupData, userId: number, projectId: number): boolean =>
        lookupData?.UserProjects?.filter(up => up.ProjectID === projectId).some(up => up.UserID === userId) || false

    public static projectUsers = (ld: ILookupData, projectId: number, entity: IBenefit | IDependency | IMilestone | IWorkStream | ICustomReportingEntity): IUser[] => {
        if (ld?.Users?.All && projectId && entity) {
            return ld.Users.All.filter(u => LookupService.userIsInProject(ld, u.ID, projectId)
                || LookupService.userIsContributor(entity, u.ID)
                || u.ID === entity.LeadUserID
            );
        }
        return [];
    }

    public static userIsInPartnerOrganisation = (lookupData: ILookupData, userId: number, partnerOrganisationId: number): boolean =>
        lookupData?.UserPartnerOrganisations?.filter(upo => upo.PartnerOrganisationID === partnerOrganisationId).some(upo => upo.UserID === userId) || false

    public static partnerOrganisationUsers = (ld: ILookupData, partnerOrganisationId: number, entity: IMilestone | ICustomReportingEntity): IUser[] => {
        if (ld?.Users?.All && partnerOrganisationId) {
            return ld.Users.All.filter(u => LookupService.userIsInPartnerOrganisation(ld, u.ID, partnerOrganisationId)
                || LookupService.userIsContributor(entity, u.ID)
                || u.ID === entity.LeadUserID
            );
        }
        return [];
    }

    public static userIsContributor = (entity: IReportingEntity, userId: number): boolean =>
        entity?.Contributors?.some(c => c.ContributorUserID === userId) || false

    public static riskUsers = (ld: ILookupData, risk: IRisk): IUser[] => {
        if (ld?.Users?.All && risk) {
            if (risk.IsProjectRisk && risk.ProjectID) {
                if (risk.RiskRegisterID === RiskRegister.Group) {
                    const groupId = ld.Directorates.find(d => d.ID === risk.DirectorateID)?.GroupID;
                    return ld.Users.All.filter(u =>
                        LookupService.userIsInProject(ld, u.ID, risk.ProjectID)
                        || LookupService.userIsInGroupDirectorates(ld, u.ID, groupId)
                        || LookupService.userIsContributor(risk, u.ID)
                        || u.ID === risk.RiskOwnerUserID
                        || u.ID === risk.ReportApproverUserID
                    );
                }

                return ld.Users.All.filter(u =>
                    LookupService.userIsInProject(ld, u.ID, risk.ProjectID)
                    || LookupService.userIsContributor(risk, u.ID)
                    || u.ID === risk.RiskOwnerUserID
                    || u.ID === risk.ReportApproverUserID
                );
            } else if (risk.DirectorateID) {
                const groupId = ld.Directorates.find(d => d.ID === risk.DirectorateID)?.GroupID;
                if (risk.RiskRegisterID === RiskRegister.Group) {
                    return ld.Users.All.filter(u =>
                        LookupService.userIsInGroup(ld, u.ID, groupId)
                        || LookupService.userIsInGroupDirectorates(ld, u.ID, groupId)
                        || LookupService.userIsContributor(risk, u.ID)
                        || u.ID === risk.RiskOwnerUserID
                        || u.ID === risk.ReportApproverUserID
                    );
                }

                return ld.Users.All.filter(u =>
                    LookupService.userIsInDirectorate(ld, u.ID, risk.DirectorateID)
                    || LookupService.userIsInGroup(ld, u.ID, groupId)
                    || LookupService.userIsContributor(risk, u.ID)
                    || u.ID === risk.RiskOwnerUserID
                    || u.ID === risk.ReportApproverUserID
                );
            }
        }
        return [];
    }

    public static riskMitigationActionUsers = (ld: ILookupData, action: IRiskMitigationAction): IUser[] => {
        if (ld?.Users?.All && action.RiskID) {
            const corpRisk = ld.CorporateRisks.find(r => r.ID === action.RiskID);
            const finRisk = ld.FinancialRisks.find(r => r.ID === action.RiskID);
            if (finRisk) {
                return ld.Users.All;
            } else if (corpRisk?.IsProjectRisk && corpRisk?.ProjectID) {
                if (corpRisk.RiskRegisterID === RiskRegister.Group) {
                    const groupId = ld.Directorates.find(d => d.ID === corpRisk.DirectorateID)?.GroupID;
                    return ld.Users.All.filter(u =>
                        LookupService.userIsInProject(ld, u.ID, corpRisk.ProjectID)
                        || LookupService.userIsInGroupDirectorates(ld, u.ID, groupId)
                        || LookupService.userIsContributor(action, u.ID)
                        || u.ID === action.OwnerUserID
                    );
                }
                return ld.Users.All.filter(u =>
                    LookupService.userIsInProject(ld, u.ID, corpRisk.ProjectID)
                    || LookupService.userIsContributor(action, u.ID)
                    || u.ID === action.OwnerUserID
                );
            } else if (corpRisk?.DirectorateID) {
                const groupId = ld.Directorates.find(d => d.ID === corpRisk.DirectorateID)?.GroupID;
                if (corpRisk.RiskRegisterID === RiskRegister.Group) {
                    return ld.Users.All.filter(u =>
                        LookupService.userIsInDirectorate(ld, u.ID, corpRisk.DirectorateID)
                        || LookupService.userIsInGroup(ld, u.ID, groupId)
                        || LookupService.userIsInGroupDirectorates(ld, u.ID, groupId)
                        || LookupService.userIsContributor(action, u.ID)
                        || u.ID === action.OwnerUserID
                    );
                }
                return ld.Users.All.filter(u =>
                    LookupService.userIsInDirectorate(ld, u.ID, corpRisk.DirectorateID)
                    || LookupService.userIsInGroup(ld, u.ID, groupId)
                    || LookupService.userIsContributor(action, u.ID)
                    || u.ID === action.OwnerUserID
                );
            }
        }
        return [];
    }

    public static partnerOrganisationRiskUsers = (ld: ILookupData, risk: IPartnerOrganisationRisk): IUser[] => {
        if (ld?.Users?.All && risk?.PartnerOrganisationID) {
            return ld.Users.All.filter(u => LookupService.userIsInPartnerOrganisation(ld, u.ID, risk.PartnerOrganisationID)
                || LookupService.userIsContributor(risk, u.ID)
                || u.ID === risk.BeisRiskOwnerUserID
                || u.ID === risk.RiskOwnerUserID
            );
        }
        return [];
    }

    public static partnerOrganisationRiskMitigationActionUsers = (ld: ILookupData, risk: IPartnerOrganisationRisk, action: IPartnerOrganisationRiskMitigationAction): IUser[] => {
        if (ld?.Users?.All && risk?.PartnerOrganisationID) {
            return ld.Users.All.filter(u => LookupService.userIsInPartnerOrganisation(ld, u.ID, risk.PartnerOrganisationID)
                || LookupService.userIsContributor(action, u.ID)
                || u.ID === action.OwnerUserID
            );
        }
        return [];
    }

    public static arrayToDropdownOptions = (arr: string[]): IDropdownOption[] => arr?.map(e => ({ key: e, text: e }));
}
