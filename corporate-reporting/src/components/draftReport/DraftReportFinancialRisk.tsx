import React, { useContext } from 'react';
import { ISignOff, IReportDueDates, IReportingEntity, IBaseComponentProps } from '../../types';
import { EntityStatus } from '../../refData/EntityStatus';
import { FinancialRiskProgressUpdateReviewList } from '../financialRisk/FinancialRiskProgressUpdateReviewList';
import { FinancialRiskMitigationActionProgressUpdateReviewList } from '../financialRisk/FinancialRiskMitigationActionProgressUpdateReviewList';
import { DataContext } from '../DataContext';
import { DraftReportHeader } from './DraftReportHeader';

interface IDraftReportFinancialRiskProps extends IBaseComponentProps {
    reportDates: IReportDueDates;
    report: Partial<ISignOff>;
    loadReport: () => void;
}

export const DraftReportFinancialRisk = (props: IDraftReportFinancialRiskProps): React.ReactElement => {
    const { reportDates, report, loadReport } = props;
    const { dataServices } = useContext(DataContext);

    const isOpen = (entity: IReportingEntity, updatesProp: string): boolean => entity.EntityStatusID === EntityStatus.Open || entity[updatesProp]?.length > 0;

    return (
        <div>
            <DraftReportHeader
                title={report?.FinancialRisk?.Title}
                reportDate={reportDates?.Next}
                attributes={report?.FinancialRisk?.Attributes?.filter(a => a.AttributeType?.Display).map(a => a.AttributeType)}
                parents={report?.FinancialRisk?.OwnedByMultipleGroups
                    ? ['Central']
                    : [report?.FinancialRisk?.Group?.Title, report?.FinancialRisk?.OwnedByDgOffice ? 'DG Office' : report?.FinancialRisk?.Directorate?.Title].filter(p => p)}
            />
            <FinancialRiskProgressUpdateReviewList
                {...props}
                risk={report.FinancialRisk}
                riskUpdate={report.FinancialRisk?.FinancialRiskUpdates?.[0]}
                onChange={loadReport}
                reportDates={reportDates}
            />
            <FinancialRiskMitigationActionProgressUpdateReviewList
                {...props}
                entities={report.FinancialRiskMitigationActions?.filter(a => isOpen(a, 'FinancialRiskMitigationActionUpdates'))}
                previousEntities={[]}
                reportDates={reportDates}
                risk={report.Risk}
                hideClosedNoUpdates={true}
                onChange={loadReport}
                riskService={dataServices.financialRiskService}
                riskActionService={dataServices.financialRiskMitigationActionService}
                riskActionUpdateService={dataServices.financialRiskMitigationActionUpdateService}
            />
        </div>
    );
};
