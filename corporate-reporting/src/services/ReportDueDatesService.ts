import { WebPartContext } from '@microsoft/sp-webpart-base';
import { Period } from '../refData/Period';
import { IDataAPI, IReportDueDates, ReportDueDates } from '../types';
import { DataService } from './DataService';

export class ReportDueDatesService extends DataService<IReportDueDates> {
    private baseUrl: string;

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api);
        this.baseUrl = `${api.URL}/`;
    }

    public getBenefitReportDueDates = async (benefitId: number, atDate: Date, period?: Period): Promise<IReportDueDates> => {
        const url = `${this.baseUrl}GetBenefitReportDueDates`;
        if (benefitId) {
            const dates = await this.getEntity(`${url}(ID=${benefitId},AtDate=${atDate.toISOString()})`);
            if (period && period === Period.Previous) {
                return await this.getEntity(`${url}(ID=${benefitId},AtDate=${dates.Previous.toISOString()})`);
            }
            return dates;
        }
        return Promise.resolve(new ReportDueDates());
    }

    public getDirectorateReportDueDates = async (directorateId: number, atDate: Date, period?: Period): Promise<IReportDueDates> => {
        const url = `${this.baseUrl}GetDirectorateReportDueDates`;
        if (directorateId) {
            const dates = await this.getEntity(`${url}(ID=${directorateId},AtDate=${atDate.toISOString()})`);
            if (period && period === Period.Previous) {
                return await this.getEntity(`${url}(ID=${directorateId},AtDate=${dates.Previous.toISOString()})`);
            }
            return dates;
        }
        return Promise.resolve(new ReportDueDates());
    }

    public getMetricReportDueDates = async (metricId: number, atDate: Date, period?: Period): Promise<IReportDueDates> => {
        const url = `${this.baseUrl}GetMetricReportDueDates`;
        if (metricId) {
            const dates = await this.getEntity(`${url}(ID=${metricId},AtDate=${atDate.toISOString()})`);
            if (period && period === Period.Previous) {
                return await this.getEntity(`${url}(ID=${metricId},AtDate=${dates.Previous.toISOString()})`);
            }
            return dates;
        }
        return Promise.resolve(new ReportDueDates());
    }

    public getPartnerOrganisationReportDueDates = async (partnerOrganisationId: number, atDate: Date, period?: Period): Promise<IReportDueDates> => {
        const url = `${this.baseUrl}GetPartnerOrganisationReportDueDates`;
        if (partnerOrganisationId) {
            const dates = await this.getEntity(`${url}(ID=${partnerOrganisationId},AtDate=${atDate.toISOString()})`);
            if (period && period === Period.Previous) {
                return await this.getEntity(`${url}(ID=${partnerOrganisationId},AtDate=${dates.Previous.toISOString()})`);
            }
            return dates;
        }
        return Promise.resolve(new ReportDueDates());
    }

    public getProjectReportDueDates = async (projectId: number, atDate: Date, period?: Period): Promise<IReportDueDates> => {
        const url = `${this.baseUrl}GetProjectReportDueDates`;
        if (projectId) {
            const dates = await this.getEntity(`${url}(ID=${projectId},AtDate=${atDate.toISOString()})`);
            if (period && period === Period.Previous) {
                return await this.getEntity(`${url}(ID=${projectId},AtDate=${dates.Previous.toISOString()})`);
            }
            return dates;
        }
        return Promise.resolve(new ReportDueDates());
    }

    public getFinancialRiskReportDueDates = async (riskId: number, atDate: Date, period?: Period): Promise<IReportDueDates> => {
        const url = `${this.baseUrl}GetFinancialRiskReportDueDates`;
        if (riskId) {
            const dates = await this.getEntity(`${url}(ID=${riskId},AtDate=${atDate.toISOString()})`);
            if (period && period === Period.Previous) {
                return await this.getEntity(`${url}(ID=${riskId},AtDate=${dates.Previous.toISOString()})`);
            }
            return dates;
        }
        return Promise.resolve(new ReportDueDates());
    }
}
