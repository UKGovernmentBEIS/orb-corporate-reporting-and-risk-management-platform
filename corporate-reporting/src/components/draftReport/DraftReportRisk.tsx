import React, { useContext } from 'react';
import { ISignOff, IReportDueDates, IReportingEntity, ICorporateRisk, IBaseComponentProps } from '../../types';
import { RiskMitigationActionProgressUpdateReviewList } from '../riskMitigationAction/RiskMitigationActionProgressUpdateReviewList';
import { RiskProgressUpdateReviewList } from '../risk/RiskProgressUpdateReviewList';
import { EntityStatus } from '../../refData/EntityStatus';
import { DataContext } from '../DataContext';
import { DraftReportHeader } from './DraftReportHeader';

interface IDraftReportRiskProps extends IBaseComponentProps {
    reportDates: IReportDueDates;
    report: Partial<ISignOff>;
    loadReport: () => void;
}

export const DraftReportRisk = (props: IDraftReportRiskProps): React.ReactElement => {
    const { reportDates, report, loadReport } = props;
    const { dataServices } = useContext(DataContext);

    const isOpen = (entity: IReportingEntity, updatesProp: string): boolean => entity.EntityStatusID === EntityStatus.Open || entity[updatesProp]?.length > 0;

    return (
        <div>
            <DraftReportHeader
                title={report?.Risk?.Title}
                reportDate={reportDates?.Next}
                attributes={report?.Risk?.Attributes?.filter(a => a.AttributeType?.Display).map(a => a.AttributeType)}
            />
            <RiskProgressUpdateReviewList
                {...props}
                risk={report.Risk}
                riskUpdate={(report.Risk as ICorporateRisk)?.RiskUpdates?.[0]}
                onChange={loadReport}
                reportDates={reportDates}
            />
            <RiskMitigationActionProgressUpdateReviewList
                {...props}
                entities={report.RiskMitigationActions?.filter(a => isOpen(a, 'RiskMitigationActionUpdates'))}
                previousEntities={[]}
                reportDates={reportDates}
                risk={report.Risk}
                hideClosedNoUpdates={true}
                onChange={loadReport}
                riskService={dataServices.corporateRiskService}
                riskActionService={dataServices.corporateRiskMitigationActionService}
                riskActionUpdateService={dataServices.corporateRiskMitigationActionUpdateService}
            />
        </div>
    );
};
