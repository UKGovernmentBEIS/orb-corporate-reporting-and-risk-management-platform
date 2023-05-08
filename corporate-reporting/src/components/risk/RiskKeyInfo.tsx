import { Label } from 'office-ui-fabric-react/lib/Label';
import React from 'react';
import { RiskAppetiteService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { IEntity, IRisk } from '../../types';
import { IRiskType } from '../../types/RiskType';
import { CrExpandableTextDisplay } from '../cr/CrExpandableTextDisplay';
import { RiskRagIndicator } from '../cr/RiskRagIndicator';

export interface IRiskKeyInfoProps {
    risk: IRisk;
    riskImpactLevels: IEntity[];
    riskProbabilities: IEntity[];
    riskTypes: IRiskType[];
}

export const RiskKeyInfo = ({ risk, riskImpactLevels, riskProbabilities, riskTypes }: IRiskKeyInfoProps): React.ReactElement => {
    return (
        <div className={styles.grid}>
            <div className={styles.gridRow}>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.lg4}`}>
                    <CrExpandableTextDisplay label="Risk event description" text={risk.RiskEventDescription} shortenedCharCount={50} />
                </div>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.lg4}`}>
                    <CrExpandableTextDisplay label="Risk cause description" text={risk.RiskCauseDescription} shortenedCharCount={50} />
                </div>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.lg4}`}>
                    <CrExpandableTextDisplay label="Risk impact description" text={risk.RiskImpactDescription} shortenedCharCount={50} />
                </div>
            </div>
            <div className={styles.gridRow}>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.lg4}`}>
                    <Label>Unmitigated rating</Label>
                    <RiskRagIndicator
                        impactLevel={riskImpactLevels.find(il => il.ID === risk.UnmitigatedRiskImpactLevelID)}
                        probability={riskProbabilities.find(p => p.ID === risk.UnmitigatedRiskProbabilityID)}
                    />
                </div>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.lg4}`}>
                    <Label>Target rating</Label>
                    <RiskRagIndicator
                        impactLevel={riskImpactLevels.find(il => il.ID === risk.TargetRiskImpactLevelID)}
                        probability={riskProbabilities.find(p => p.ID === risk.TargetRiskProbabilityID)}
                    />
                </div>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.lg4}`}>
                    <Label>Risk appetite</Label>
                    <div style={{ padding: '3px' }}>
                        {RiskAppetiteService.getRiskAppetite(risk.RiskRiskTypes, riskTypes) || 'To be completed'}
                    </div>
                </div>
            </div>
        </div>
    );
};
