import React from 'react';
import { ProgressUpdateList } from '../ProgressUpdateList';
import { ICustomReportingEntity, ICustomReportingEntityType, IReportDueDates, IWebPartComponentProps } from '../../types';
import { IWithErrorHandlingProps } from '../withErrorHandling';
import { ReportingEntityProgressUpdateForm } from './ReportingEntityProgressUpdateForm';

interface IReportingEntityProgressUpdateListProps extends IWebPartComponentProps, IWithErrorHandlingProps {
    type: ICustomReportingEntityType;
    entities: ICustomReportingEntity[];
    reportDates: IReportDueDates;
}

export const ReportingEntityProgressUpdateList = ({ type, entities, ...props }: IReportingEntityProgressUpdateListProps): React.ReactElement => {
    return (
        <ProgressUpdateList<ICustomReportingEntity>
            listTitle={`${type.Title} updates`}
            expandContent={true}
            entityName={`user's ${type.Title} updates`}
            {...props}
            entities={entities}
            renderProgressUpdateForm={re =>
                <ReportingEntityProgressUpdateForm
                    {...props}
                    entityType={type}
                    entityId={re.ID}
                    entity={re}
                />
            }
        />
    );
};