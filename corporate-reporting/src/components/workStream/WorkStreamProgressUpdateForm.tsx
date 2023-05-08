import React, { useContext, useMemo } from 'react';
import { EntityPeopleService } from '../../services';
import {
    IWorkStream, IWorkStreamUpdate, WorkStreamUpdate, WorkStream,
    IEntityProgressUpdateFormProps, CrUpdateFormState, IProgressUpdateValidations, ProgressUpdateValidations
} from '../../types';
import { DataContext } from '../DataContext';
import { ProgressUpdateForm, ValidateProgressUpdate } from '../ProgressUpdateForm';

export class WorkStreamProgressUpdateFormState extends CrUpdateFormState<IWorkStreamUpdate, IProgressUpdateValidations, IWorkStream> {
    constructor(workStreamId: number, period: Date, parentEntity?: IWorkStream, showForm?: boolean) {
        super(
            new WorkStreamUpdate(workStreamId, period),
            parentEntity || new WorkStream(),
            new WorkStreamUpdate(workStreamId),
            new ProgressUpdateValidations(),
            showForm || false
        );
    }
}

export const WorkStreamProgressUpdateForm = (
    { entityId, entity, reportDates, ...otherProps }: IEntityProgressUpdateFormProps<IWorkStream>
): React.ReactElement => { //progupdate//
    const { dataServices, lookupData, loadLookupData: { reportingFrequencies } } = useContext(DataContext);
    useMemo(() => reportingFrequencies(), [reportingFrequencies]);
    return (
        <ProgressUpdateForm<IWorkStreamUpdate, IProgressUpdateValidations, IWorkStream>
            {...otherProps}
            disableSave={ws => ws.Attributes.filter(x => x.AttributeTypeID === 1000).length > 0 }
            vertoMsg={ws => ws.Attributes.filter(x => x.AttributeTypeID === 1000).length > 0 }
            dueDate={() => reportDates?.Next}
            maxCommentLength={500}
            loadPeople={async ws => {
                const people = [];
                if (ws) {
                    if (ws.LeadUser)
                        people.push({ role: 'Lead', names: [ws.LeadUser.Title] });
                    if (ws.Contributors && ws.Contributors.length > 0)
                        people.push({ role: 'Contributors', names: ws.Contributors.map(c => c.ContributorUser && c.ContributorUser.Title) });
                    people.push(...await EntityPeopleService.GetProjectEntityPeople({
                        projectService: dataServices.projectService,
                        userProjectService: dataServices.userProjectService,
                        projectId: ws.ProjectID
                    }));
                }
                return people;
            }}
            loadEntity={id => dataServices.workStreamService.read(id, true, true)}
            loadEntityUpdate={id => dataServices.workStreamUpdateService.read(id)}
            loadNewEntityUpdate={() => new WorkStreamUpdate(entityId)}
            loadLastSavedProgressUpdate={() => reportDates?.Next &&
                dataServices.workStreamUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next)}
            loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                dataServices.workStreamUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
            onValidateUpdate={wsu => ValidateProgressUpdate(wsu)}
            onSaveUpdate={wsu => dataServices.workStreamUpdateService.create(wsu)}
            onClearForm={(ws, showForm) => new WorkStreamProgressUpdateFormState(entityId, reportDates?.Next, ws, showForm)}
            reportDates={reportDates}
            entityId={entityId}
            entity={entity}
            reportingFrequencies={lookupData?.ReportingFrequencies}
        />
    );
};
