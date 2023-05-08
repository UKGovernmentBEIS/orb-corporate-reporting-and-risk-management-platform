import { EntityWithStatusService } from './EntityWithStatusService';
import { ContextService } from './ContextService';
import { IBenefit, IDataAPI, IEntityChildren } from '../types';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityStatus } from '../refData/EntityStatus';
import { Period } from '../refData/Period';

export class BenefitService extends EntityWithStatusService<IBenefit> {
    public readonly parentEntities = ['Project', 'LeadUser', 'MeasurementUnit'];
    protected childrenEntities = ['Contributors($expand=ContributorUser)', 'Attributes($expand=AttributeType)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/Benefits`);
    }

    public readMyBenefits(): Promise<IBenefit[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        const filters = [
            `LeadUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];
        return this.readAllQuery(`$filter=EntityStatusID eq ${EntityStatus.Open} and (${filters.join(' or ')})`);
    }

    public readAllForList(includeClosedBenefits?: boolean): Promise<IBenefit[]> {
        return this.readAll(
            `?$select=ID,Title,TargetPerformanceLowerLimit,TargetPerformanceUpperLimit`
            + `&$orderby=Title`
            + `&$expand=EntityStatus($select=Title),Project($select=Title),LeadUser($select=Title),Contributors($select=ContributorUser;$expand=ContributorUser($select=Title))`
            + (includeClosedBenefits ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readProjectBenefitsInPeriod(projectId: number, period: Period): Promise<IBenefit[]> {
        if (projectId) {
            return this.readAll(
                `/GetBenefitsDueInPeriod(ProjectId=${projectId},Period=${period})`
                + `?$expand=LeadUser,MeasurementUnit,Attributes($expand=AttributeType),Contributors,BenefitType`
            );
        }
        return Promise.resolve([]);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        return this.entityChildrenSingle(id, 'Benefit updates', 'BenefitUpdates', false);
    }
}