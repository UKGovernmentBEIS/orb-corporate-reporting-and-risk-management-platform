import React from 'react';
import { IEntity } from '../../types';
import { RagIndicator } from './RagIndicator';
import { RiskRagService } from '../../services';

export interface IRiskRagIndicatorProps {
    impactLevel: IEntity;
    probability: IEntity;
}

export const RiskRagIndicator = ({ impactLevel, probability }: IRiskRagIndicatorProps): React.ReactElement =>
    <RagIndicator
        rag={impactLevel && probability && RiskRagService.calculateRiskRag(impactLevel.ID, probability.ID)}
        label={impactLevel && probability && `${impactLevel?.Title}/${probability?.Title}` || `To be completed`}
    />;
