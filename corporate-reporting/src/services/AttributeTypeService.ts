import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService, IEntityService } from './EntityService';
import { IAttributeType, IDataAPI, IEntityChildren } from '../types';

export class AttributeTypeService extends EntityService<IAttributeType> implements IEntityService<IAttributeType> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/AttributeTypes`);
    }

    public readAllForLookup(): Promise<IAttributeType[]> {
        return this.readAll(`?$select=ID,Title,Display&$orderby=Title`);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        const attributes = await this.getEntities(`${this.entityUrl}(${id})/Attributes?$select=BenefitID,CommitmentID,DirectorateID,KeyWorkAreaID,MetricID,MilestoneID,ProjectID,RiskID,PartnerOrganisationRiskID,WorkStreamID&$top=10`);
        return [
            { ChildType: 'Benefits', CanBeAdopted: true, ChildIDs: attributes.filter(a => a['BenefitID']).map(b => b['BenefitID']) },
            { ChildType: 'Commitments', CanBeAdopted: true, ChildIDs: attributes.filter(a => a['CommitmentID']).map(c => c['CommitmentID']) },
            { ChildType: 'Directorates', CanBeAdopted: true, ChildIDs: attributes.filter(a => a['DirectorateID']).map(d => d['DirectorateID']) },
            { ChildType: 'Key work areas', CanBeAdopted: true, ChildIDs: attributes.filter(a => a['KeyWorkAreaID']).map(k => k['KeyWorkAreaID']) },
            { ChildType: 'Metrics', CanBeAdopted: true, ChildIDs: attributes.filter(a => a['MetricID']).map(m => m['MetricID']) },
            { ChildType: 'Milestones', CanBeAdopted: true, ChildIDs: attributes.filter(a => a['MilestoneID']).map(m => m['MilestoneID']) },
            { ChildType: 'Projects', CanBeAdopted: true, ChildIDs: attributes.filter(a => a['ProjectID']).map(p => p['ProjectID']) },
            { ChildType: 'Risks', CanBeAdopted: true, ChildIDs: attributes.filter(a => a['RiskID']).map(r => r['RiskID']) },
            { ChildType: 'Partner organisation risks', CanBeAdopted: true, ChildIDs: attributes.filter(a => a['PartnerOrganisationRiskID']).map(p => p['PartnerOrganisationRiskID']) },
            { ChildType: 'Work streams', CanBeAdopted: true, ChildIDs: attributes.filter(a => a['WorkStreamID']).map(w => w['WorkStreamID']) }
        ];
    }
}