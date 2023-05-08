import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IPartnerOrganisation, IDataAPI, IUserPartnerOrganisation, IUserRole, IEntityChildren } from '../types';
import { ContextService } from './ContextService';
import { Role } from "../refData/Role";
import { EntityStatus } from '../refData/EntityStatus';

export class PartnerOrganisationService extends EntityService<IPartnerOrganisation> {
    public readonly parentEntities = ['Directorate'];
    protected childrenEntities = ['Contributors($expand=ContributorUser)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/PartnerOrganisations`);
    }

    public readAllForLookup(includeClosedPartnerOrgs?: boolean): Promise<IPartnerOrganisation[]> {
        return this.readAll(
            `?$select=ID,Title`
            + `&$orderby=Title`
            + (includeClosedPartnerOrgs ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readAllForList(showClosedPartnerOrgs?: boolean): Promise<IPartnerOrganisation[]> {
        return this.readAll(
            `?$orderby=Title`
            + `&$expand=Directorate($expand=Group),LeadPolicySponsorUser,ReportAuthorUser,Contributors($select=ContributorUser,IsReadOnly;$expand=ContributorUser($select=Title)),EntityStatus`
            + (showClosedPartnerOrgs ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readMyPartnerOrganisations(userPartnerOrganisations?: IUserPartnerOrganisation[], includeContributors?: boolean, userRoles?: IUserRole[]): Promise<IPartnerOrganisation[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext))
        let filters = [
            `LeadPolicySponsorUser/Username eq '${username}'`,
            `ReportAuthorUser/Username eq '${username}'`
        ];

        if (includeContributors) {
            filters.push(`Contributors/any(c: c/ContributorUser/Username eq '${username}')`);
        }

        if (userPartnerOrganisations) {
            filters = filters.concat(userPartnerOrganisations.filter(upo => upo.IsAdmin).map(upo => `ID eq ${upo.PartnerOrganisationID}`));
        }

        if (userRoles?.some(ur => ur.RoleID == Role.PartnerOrganisationAdmin)) {
            filters = filters.concat(`true`);
        }

        return this.readAllQuery(`$filter=(${filters.join(' or ')})`);
    }

    public readPartnerOrganisationApprovers = (partnerOrganisationId: number): Promise<IPartnerOrganisation> => {
        return this.read(partnerOrganisationId, false, false, ['LeadPolicySponsorUser', 'ReportAuthorUser']);
    }

    public readDraftReportPartnerOrganisations = (): Promise<IPartnerOrganisation[]> => {
        return this.readAll(`?$orderby=Title&$filter=EntityStatusID eq ${EntityStatus.Open}`);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        const pOrgUrl = `${this.entityUrl}(${id})`;
        const milestones = this.getEntities(`${pOrgUrl}/Milestones?$select=ID&$top=10`);
        const risks = this.getEntities(`${pOrgUrl}/PartnerOrganisationRisks?$select=ID&$top=10`);
        const updates = this.getEntities(`${pOrgUrl}/PartnerOrganisationUpdates?$select=ID&$top=10`);
        const signOffs = this.getEntities(`${pOrgUrl}/SignOffs?$select=ID&$top=10`);
        const userPartnerOrgs = this.getEntities(`${pOrgUrl}/UserPartnerOrganisations?$select=ID&$top=10`);
        return [
            { ChildType: 'Milestones', CanBeAdopted: true, ChildIDs: (await milestones).map(m => m.ID) },
            { ChildType: 'Partner organisation risks', CanBeAdopted: true, ChildIDs: (await risks).map(p => p.ID) },
            { ChildType: 'Partner organisation updates', CanBeAdopted: false, ChildIDs: (await updates).map(p => p.ID) },
            { ChildType: 'Reports', CanBeAdopted: false, ChildIDs: (await signOffs).map(s => s.ID) },
            { ChildType: 'User partner organisations', CanBeAdopted: true, ChildIDs: (await userPartnerOrgs).map(u => u.ID) }
        ];
    }
}