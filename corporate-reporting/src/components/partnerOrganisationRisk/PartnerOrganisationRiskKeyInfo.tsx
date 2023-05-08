import { Label } from 'office-ui-fabric-react/lib/Label';
import React from 'react';
import { LookupService, RiskAppetiteService, RiskRagService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { IEntity, IPartnerOrganisationRisk } from '../../types';
import { IRiskType } from '../../types/RiskType';
import { CrExpandableTextDisplay } from '../cr/CrExpandableTextDisplay';
import { RagIndicator } from '../cr/RagIndicator';

export interface IPartnerOrganisationRiskKeyInfoProps {
    risk: IPartnerOrganisationRisk;
    riskAppetites: IEntity[];
    riskImpactLevels: IEntity[];
    riskProbabilities: IEntity[];
    riskTypes: IRiskType[];
}

export const PartnerOrganisationRiskKeyInfo = ({ risk, riskAppetites, riskImpactLevels, riskProbabilities, riskTypes }: IPartnerOrganisationRiskKeyInfoProps): React.ReactElement => {
    return (
        <div className={styles.grid}>
            <div className={styles.gridRow}>
                <div className={`${styles.gridCol} ${styles.sm4}`}>
                    <CrExpandableTextDisplay label={"Risk Description Event"} text={risk.RiskEventDescription} shortenedCharCount={50} />
                </div>
                <div className={`${styles.gridCol} ${styles.sm4}`}>
                    <CrExpandableTextDisplay label={"Risk Description Cause"} text={risk.RiskCauseDescription} shortenedCharCount={50} />
                </div>
                <div className={`${styles.gridCol} ${styles.sm4}`}>
                    <CrExpandableTextDisplay label={"Risk Description Impact"} text={risk.RiskImpactDescription} shortenedCharCount={50} />
                </div>
            </div>
            <div className={styles.gridRow}>
                <div className={`${styles.gridCol} ${styles.sm4}`}>
                    <Label>Partner organisation unmitigated rating</Label>
                    <RagIndicator
                        rag={RiskRagService.calculateRiskRag(risk.UnmitigatedRiskImpactLevelID, risk.UnmitigatedRiskProbabilityID)}
                        label={`${LookupService.getLookupName(riskImpactLevels, risk.UnmitigatedRiskImpactLevelID)}/${LookupService.getLookupName(riskProbabilities, risk.UnmitigatedRiskProbabilityID)}`} />
                </div>
                <div className={`${styles.gridCol} ${styles.sm4}`}>
                    <Label>Partner organisation target rating</Label>
                    <RagIndicator
                        rag={RiskRagService.calculateRiskRag(risk.TargetRiskImpactLevelID, risk.TargetRiskProbabilityID)}
                        label={`${LookupService.getLookupName(riskImpactLevels, risk.TargetRiskImpactLevelID)}/${LookupService.getLookupName(riskProbabilities, risk.TargetRiskProbabilityID)}`} />
                </div>
                <div className={`${styles.gridCol} ${styles.sm4}`}>
                    <Label>Partner organisation risk appetite</Label>
                    <div style={{ padding: '3px' }}>
                        {LookupService.getLookupName(riskAppetites, risk.RiskAppetiteID)}
                    </div>
                </div>
            </div>
            <div className={styles.gridRow}>
                <div className={`${styles.gridCol} ${styles.sm4}`}>
                    <Label>BEIS unmitigated rating</Label>
                    <RagIndicator
                        rag={RiskRagService.calculateRiskRag(risk.BEISUnmitigatedRiskImpactLevelID, risk.BEISUnmitigatedRiskProbabilityID)}
                        label={`${LookupService.getLookupName(riskImpactLevels, risk.BEISUnmitigatedRiskImpactLevelID)}/${LookupService.getLookupName(riskProbabilities, risk.BEISUnmitigatedRiskProbabilityID)}`} />
                </div>
                <div className={`${styles.gridCol} ${styles.sm4}`}>
                    <Label>BEIS target rating</Label>
                    <RagIndicator
                        rag={RiskRagService.calculateRiskRag(risk.BEISTargetRiskImpactLevelID, risk.BEISTargetRiskProbabilityID)}
                        label={`${LookupService.getLookupName(riskImpactLevels, risk.BEISTargetRiskImpactLevelID)}/${LookupService.getLookupName(riskProbabilities, risk.BEISTargetRiskProbabilityID)}`} />
                </div>

                <div className={`${styles.gridCol} ${styles.sm4}`}>
                    <Label>BEIS risk appetite</Label>
                    <div style={{ padding: '3px' }}>{RiskAppetiteService.getPartnerOrganisationRiskAppetite(risk.PartnerOrganisationRiskRiskTypes, riskTypes) || 'To be completed'}</div>
                </div>
            </div>
        </div>
    );
};
