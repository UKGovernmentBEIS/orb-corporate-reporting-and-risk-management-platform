import React, { useState } from 'react';
import { ITooltipHostProps } from 'office-ui-fabric-react/lib/Tooltip';
import { Link } from 'office-ui-fabric-react/lib/Link';
import { Label } from 'office-ui-fabric-react/lib/Label';
import styles from '../../styles/cr.module.scss';
import componentStyles from '../../styles/CrExpandableTextDisplay.module.scss';

export interface ICrExpandableTextDisplayProps extends ITooltipHostProps {
    label?: string;
    text: string;
    showAll?: boolean;
    shortenedCharCount?: number;
    largeLabel?: boolean;
}

export const CrExpandableTextDisplay = (props: ICrExpandableTextDisplayProps): React.ReactElement => {
    const { largeLabel, label, text, shortenedCharCount } = props;
    const [showAll, setShowAll] = useState(props.showAll);

    return (
        <div className={componentStyles.expandableTextDisplay}>
            <div className={styles.cr}>
                {label && largeLabel ?
                    <h3 className={styles.reviewListTitle}>{label}</h3>
                    :
                    <Label>{label}</Label>
                }
            </div>
            <div>
                {text?.length > 0 ?
                    (showAll ? text : text.slice(0, (shortenedCharCount || 100) + 1))
                    :
                    "[Missing]"
                }
                {text && (text.length > (shortenedCharCount || 100) + 1) &&
                    <Link onClick={() => setShowAll(!showAll)} >
                        {showAll ? " Show Less" : "...Show More"}
                    </Link>
                }
            </div>
        </div>
    );
};
