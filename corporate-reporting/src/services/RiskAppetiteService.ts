import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IDataAPI, IEntity, IPartnerOrganisationRiskRiskType, IRisk, IRiskRiskType, IRiskUpdate } from '../types';
import { IRiskType } from '../types/RiskType';
import { IThreshold } from '../types/Threshold';

export class RiskAppetiteService extends EntityService<IEntity> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/RiskAppetites`);
    }

    public readAllForLookup(): Promise<IEntity[]> {
        return this.readAll(`?$select=ID,Title&$orderby=ID`);
    }

    public static getRiskAppetite = (riskRiskTypes: IRiskRiskType[], riskTypes: IRiskType[]): string => {
        if (riskRiskTypes && riskRiskTypes.length > 0) {
            const riskTypeIDs = riskRiskTypes.map(rrt => rrt.RiskTypeID);
            const filteredRiskTypes = riskTypes.filter(rt => riskTypeIDs && riskTypeIDs.indexOf(rt.ID) > -1);
            const thresholds = filteredRiskTypes.map(rt => rt.Threshold).filter(th => th);
            if (thresholds && thresholds.length > 0) {
                const orderedThreshold = thresholds.sort((th1, th2) => th1.Priority - th2.Priority).reverse();
                return orderedThreshold[0].Title;
            }
        }
        return null;
    }

    public static getPartnerOrganisationRiskAppetite = (riskRiskTypes: IPartnerOrganisationRiskRiskType[], riskTypes: IRiskType[]): string => {
        if (riskRiskTypes && riskRiskTypes.length > 0) {
            const riskTypeIDs = riskRiskTypes.map(rrt => rrt.RiskTypeID);
            const filteredRiskTypes = riskTypes.filter(rt => riskTypeIDs && riskTypeIDs.indexOf(rt.ID) > -1);
            const thresholds = filteredRiskTypes.map(rt => rt.Threshold).filter(th => th);
            if (thresholds && thresholds.length > 0) {
                const orderedThreshold = thresholds.sort((th1, th2) => th1.Priority - th2.Priority).reverse();
                return orderedThreshold[0].Title;
            }
        }
        return null;
    }

    public static riskWithinBoundary = (riskTypes: IRiskType[], ru: IRiskUpdate, r: IRisk): boolean => {
        if (ru.RiskImpactLevelID && ru.RiskProbabilityID && r.RiskRiskTypes) {
            const riskTypeIDs = r.RiskRiskTypes.map(rrt => rrt.RiskTypeID);

            const filteredRiskTypes: IRiskType[] = riskTypes.filter(rt => riskTypeIDs && riskTypeIDs.indexOf(rt.ID) > -1);
            const thresholds: IThreshold[] = filteredRiskTypes.map(rt => rt.Threshold).filter(th => th);
            // Get the Thresholds for the Risk Types associated with the Risk (note that Risk Types may not have Thresholds)

            if (thresholds && thresholds.length > 0) {
                const orderedThreshold = thresholds.sort((th1, th2) => th1.Priority - th2.Priority);
                const priorityThresholdAppetites = orderedThreshold[0];

                return !priorityThresholdAppetites.ThresholdAppetites
                    .some(ta =>
                        ta.RiskImpactLevelID === ru.RiskImpactLevelID
                        && ta.RiskProbabilityID === ru.RiskProbabilityID
                        && ta.Acceptable === false);
            }
        }
        return true;
    }
}