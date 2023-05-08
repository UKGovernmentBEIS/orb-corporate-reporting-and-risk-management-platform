import { EntityWithStatusService } from './EntityWithStatusService';
import { IDataAPI, IEntityChildren, IPartnerOrganisationRiskMitigationAction, IUserPartnerOrganisation, IUserRole } from '../types';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import { ContextService } from './ContextService';
import { EntityStatus } from '../refData/EntityStatus';
import { Role } from '../refData/Role';

export class PartnerOrganisationRiskMitigationActionService extends EntityWithStatusService<IPartnerOrganisationRiskMitigationAction> {
    public readonly parentEntities = ['PartnerOrganisationRisk($expand=PartnerOrganisation)', 'OwnerUser'];
    protected childrenEntities = ['Contributors($expand=ContributorUser)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/PartnerOrganisationRiskMitigationActions`);
    }

    public readAllForList(includeClosedRiskActions?: boolean): Promise<IPartnerOrganisationRiskMitigationAction[]> {
        return this.readAll(
            `?$select=ID,RiskMitigationActionCode,Title`
            + `&$orderby=Title`
            + `&$expand=PartnerOrganisationRisk($select=RiskCode,Title;$expand=PartnerOrganisation($select=Title)),OwnerUser($select=Title),EntityStatus($select=Title)`
            + (includeClosedRiskActions ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public async readMyActions(userPartnerOrganisations?: IUserPartnerOrganisation[], userRoles?: IUserRole[]): Promise<IPartnerOrganisationRiskMitigationAction[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        let filters = [
            `OwnerUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];

        if (userPartnerOrganisations) {
            filters = filters.concat(
                userPartnerOrganisations.filter(ad => ad.IsAdmin).map(ad => `PartnerOrganisationRisk/PartnerOrganisationID eq ${ad.PartnerOrganisationID}`)
            );
        }

        if (userRoles?.some(ur => ur.RoleID == Role.PartnerOrganisationAdmin)) {
            filters = filters.concat(`true`);
        }

        return this.readAllQuery(
            `?$select=ID,Title`
            + `&$expand=PartnerOrganisationRisk($select=Title,PartnerOrganisationID)`
            + `&$filter=EntityStatusID eq ${EntityStatus.Open} and (${filters.join(' or ')})`
            + `&$orderby=PartnerOrganisationRiskID,Title`
        );
    }

    public readMitigationActionsForRisk(riskId: number): Promise<IPartnerOrganisationRiskMitigationAction[]> {
        return this.readAll(`?$filter=PartnerOrganisationRiskID eq ${riskId}&$expand=OwnerUser($select=Title),PartnerOrganisationRisk`);
    }

    public readPartnerOrganisationRiskMitigationActions(partnerOrganisationId: number): Promise<IPartnerOrganisationRiskMitigationAction[]> {
        return this.readAll(`?$filter=PartnerOrganisationRisk/PartnerOrganisationID eq ${partnerOrganisationId}&$expand=OwnerUser($select=Title),Contributors&$orderby=Title`);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        return this.entityChildrenSingle(id, 'Partner organisation risk mitigation action updates', 'PartnerOrganisationRiskMitigationActionUpdates', false);
    }
}