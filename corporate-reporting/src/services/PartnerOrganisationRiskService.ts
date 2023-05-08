import { IDataAPI, IUserPartnerOrganisation, IPartnerOrganisationRisk, IUserRole, IEntityChildren } from '../types';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityStatus } from '../refData/EntityStatus';
import { Role } from '../refData/Role';
import { EntityWithStatusService } from './EntityWithStatusService';
import { ContextService } from './ContextService';

export class PartnerOrganisationRiskService extends EntityWithStatusService<IPartnerOrganisationRisk> {
    public readonly parentEntities = ['PartnerOrganisation', 'RiskOwnerUser'];
    protected childrenEntities = ['PartnerOrganisationRiskRiskTypes', 'Contributors($expand=ContributorUser)', 'Attributes($expand=AttributeType)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/PartnerOrganisationRisks`);
    }

    public readAllForList(includeClosedRisks?: boolean): Promise<IPartnerOrganisationRisk[]> {
        return this.readAll(
            `?$select=ID,RiskCode,Title`
            + `&$orderby=Title`
            + `&$expand=PartnerOrganisation($select=Title),RiskOwnerUser($select=Title),PartnerOrganisationRiskMitigationActions($select=ID),EntityStatus($select=Title)`
            + (includeClosedRisks ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readExpandAll(riskId: number): Promise<IPartnerOrganisationRisk> {
        return this.read(riskId, false, true);
    }

    public async readMyRisks(userPartnerOrganisations?: IUserPartnerOrganisation[], userRoles?: IUserRole[]): Promise<IPartnerOrganisationRisk[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        let filters = [
            `RiskOwnerUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];
        if (userPartnerOrganisations) {
            filters = filters.concat(userPartnerOrganisations.filter(ad => ad.IsAdmin).map(ad => `PartnerOrganisationID eq ${ad.PartnerOrganisationID}`));
        }

        if (userRoles?.some(ur => ur.RoleID == Role.PartnerOrganisationAdmin)) {
            filters = filters.concat(`true`);
        }

        return this.readAllQuery(
            `$select=ID,Title,PartnerOrganisationID`
            + `&$filter=(${filters.join(' or ')}) and EntityStatusID eq ${EntityStatus.Open}`
            + `&$orderby=ID,Title`
        );
    }

    public readPartnerOrganisationRisks(period: Date, partnerOrganisationId: number): Promise<IPartnerOrganisationRisk[]> {
        return this.readAll(
            `?$filter=PartnerOrganisationID eq ${partnerOrganisationId} and EntityStatusID eq ${EntityStatus.Open}`
            + `&$expand=RiskOwnerUser($select=Title),Contributors,TargetRiskImpactLevel,TargetRiskProbability,BEISTargetRiskImpactLevel,BEISTargetRiskProbability`
            + `&$orderby=ID,Title`
        );
    }

    public readAllForLookup(includeClosedEntities?: boolean, additionalFields?: string): Promise<IPartnerOrganisationRisk[]> {
        return this.readAll(
            `?$select=ID,Title,PartnerOrganisationID${additionalFields ? `,${additionalFields}` : ''}`
            + `&$orderby=Title`
            + (includeClosedEntities ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        const riskUrl = `${this.entityUrl}(${id})`;
        const actions = this.getEntities(`${riskUrl}/PartnerOrganisationRiskMitigationActions`);
        const updates = this.getEntities(`${riskUrl}/PartnerOrganisationRiskUpdates`);
        return [
            { ChildType: 'Partner organisation risk mitigating actions', CanBeAdopted: true, ChildIDs: (await actions).map(p => p.ID) },
            { ChildType: 'Partner organisation risk updates', CanBeAdopted: false, ChildIDs: (await updates).map(p => p.ID) }
        ];
    }
}