import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityUpdateService } from './EntityUpdateService';
import { IBenefitUpdate, IDataAPI } from '../types';

export class BenefitUpdateService extends EntityUpdateService<IBenefitUpdate> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/BenefitUpdates`);
    }

    public async readLatestUpdateForPeriod(benefitId: number, period: Date): Promise<IBenefitUpdate> {
        return (await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser`
            + `&$filter=BenefitID eq ${benefitId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=UpdateDate desc`
        ))?.[0];
    }

    public readLatestUpdateBetweenDates = async (benefitId: number, from: Date, to: Date): Promise<IBenefitUpdate> => {
        return (await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser`
            + `&$filter=BenefitID eq ${benefitId} and UpdatePeriod gt ${from.toISOString()} and UpdatePeriod le ${to.toISOString()}`
            + `&$orderby=UpdateDate desc`
        ))?.[0];
    }

    public async readLastSignedOffUpdateForPeriod(benefitId: number, period: Date): Promise<IBenefitUpdate> {
        return (await this.readAll(
            `?$top=1`
            + `&$filter=BenefitID eq ${benefitId} and UpdatePeriod eq ${period.toISOString()} and SignOffID ne null`
            + `&$orderby=SignOffID desc`
        ))?.[0];
    }

    public async readLastSignedOffUpdateBeforeDate(benefitId: number, beforeDate: Date): Promise<IBenefitUpdate> {
        return (await this.readAll(
            `?$top=1`
            + `&$filter=BenefitID eq ${benefitId} and UpdatePeriod le ${beforeDate.toISOString()} and SignOffID ne null`
            + `&$orderby=UpdatePeriod desc`
        ))?.[0];
    }
}