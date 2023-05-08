import React from 'react';
import appStyles from '../../styles/cr.module.scss';
import styles from '../../styles/DraftReportHeader.module.scss';
import { DateService } from "../../services";
import { CrBadges } from '../cr/CrBadges';
import { IAttributeType } from '../../types';
import { CrBreadcrumb } from '../cr/CrBreadcrumb';

export const DraftReportHeader = ({ title, reportDate, attributes, parents }: { title: string, reportDate: Date, attributes?: IAttributeType[], parents?: string[] }): React.ReactElement =>
    <div className={styles.draftReportHeader}>
        <div className={`${appStyles.fontSize20} ${appStyles.fontWeightSemibold}`}>
            <span>
                {title && <span>{title}{reportDate && ` - ${DateService.dateToUkLongDate(reportDate)}`} </span>}
                <CrBadges badges={attributes?.map(a => ({ text: a?.Title, badgeClass: appStyles.badgeSecondary }))} />
            </span>
        </div>
        {parents?.length > 0 &&
            <div className={`${styles.headerCrumbs} ${appStyles.fontSize16} ${appStyles.fontWeightSemibold}`}>
                <CrBreadcrumb items={parents} />
            </div>
        }
    </div>