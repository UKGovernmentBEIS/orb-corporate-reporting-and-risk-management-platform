import React from 'react';
import styles from '../../styles/cr.module.scss';
import { CrBadges } from './CrBadges';
import { CrEntityCompleteIcon } from './CrEntityCompleteIcon';
import { CrLastEdit } from './CrLastEdit';
import { CrReviewListHistory } from './CrReviewListHistory';

export const ReviewListProgressUpdate = (
    { entityName, progressUpdate, updateAuthor, updateDate, toBeClosed, attributes, previousUpdate }
        : { entityName: string, progressUpdate: string, updateAuthor: string, updateDate: Date, toBeClosed: boolean, attributes?: string[], previousUpdate?: string }
): React.ReactElement =>
    <div>
        {toBeClosed &&
            <CrEntityCompleteIcon />
        }
        <div className={styles.fontWeightSemibold}>
            <span>{entityName} </span>
            {attributes &&
                <CrBadges badges={attributes && attributes.map(a => ({ text: a, description: `Attribute: ${a}`, badgeClass: styles.badgeSecondary }))} />
            }
        </div>
        <div>{progressUpdate}</div>
        <CrLastEdit author={updateAuthor} editDate={updateDate} />
        {previousUpdate &&
            <CrReviewListHistory value={previousUpdate} />
        }
    </div>;
