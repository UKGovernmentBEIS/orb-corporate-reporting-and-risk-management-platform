import React from 'react';
import styles from '../../styles/RagIndicator.module.scss';
import { TooltipHost, TooltipOverflowMode } from 'office-ui-fabric-react/lib/Tooltip';
import { RagColours } from '../../refData/RagColours';

export interface IRagIndicatorProps {
    rag: RagColours;
    label?: string;
}

export const RagIndicator = ({ rag, label }: IRagIndicatorProps): React.ReactElement => {
    return (
        <div className={styles.ragIndicator}>
            {rag === RagColours.Red &&
                <div className={`${styles.fontSize14} ${styles.indicator} ${styles.red}`}>
                    <TooltipHost content={label || 'Red'} overflowMode={TooltipOverflowMode.Parent}>{label || 'Red'}</TooltipHost>
                </div>
            }
            {rag === RagColours.AmberRed &&
                <div className={`${styles.fontSize14} ${styles.indicator} ${styles.amberRed}`}>
                    <TooltipHost content={label || 'Amber Red'} overflowMode={TooltipOverflowMode.Parent}>{label || 'Amber Red'}</TooltipHost>
                </div>
            }
            {rag === RagColours.Amber &&
                <div className={`${styles.fontSize14} ${styles.indicator} ${styles.amber}`}>
                    <TooltipHost content={label || 'Amber'} overflowMode={TooltipOverflowMode.Parent}>{label || 'Amber'}</TooltipHost>
                </div>
            }
            {rag === RagColours.AmberGreen &&
                <div className={`${styles.fontSize14} ${styles.indicator} ${styles.amberGreen}`}>
                    <TooltipHost content={label || 'Amber Green'} overflowMode={TooltipOverflowMode.Parent}>{label || 'Amber Green'}</TooltipHost>
                </div>
            }
            {rag === RagColours.Green &&
                <div className={`${styles.fontSize14} ${styles.indicator} ${styles.green}`}>
                    <TooltipHost content={label || 'Green'} overflowMode={TooltipOverflowMode.Parent}>{label || 'Green'}</TooltipHost>
                </div>
            }
            {(rag === null || rag === undefined) &&
                <div className={`${styles.fontSize14} ${styles.indicator} ${styles.grey}`}>
                    <TooltipHost content={label || 'To be completed'} overflowMode={TooltipOverflowMode.Parent}>{label || 'To be completed'}</TooltipHost>
                </div>
            }
        </div>
    );
};
