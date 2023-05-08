import React, { useContext, useMemo } from 'react';
import { EntityPeopleService } from '../../services';
import {
    IKeyWorkArea, IKeyWorkAreaUpdate, KeyWorkAreaUpdate, KeyWorkArea,
    IEntityProgressUpdateFormProps, CrUpdateFormState, IProgressUpdateValidations, ProgressUpdateValidations
} from '../../types';
import { DataContext } from '../DataContext';
import { ProgressUpdateForm, ValidateProgressUpdate } from '../ProgressUpdateForm';

export class KeyWorkAreaProgressUpdateFormState extends CrUpdateFormState<IKeyWorkAreaUpdate, IProgressUpdateValidations, IKeyWorkArea> {
    constructor(keyWorkAreaId: number, period: Date, parentEntity?: IKeyWorkArea, showForm?: boolean) {
        super(
            new KeyWorkAreaUpdate(keyWorkAreaId, period),
            parentEntity || new KeyWorkArea(),
            new KeyWorkAreaUpdate(keyWorkAreaId),
            new ProgressUpdateValidations(),
            showForm || false
        );
    }
}

export const KeyWorkAreaProgressUpdateForm = (
    { entityId, entity, reportDates, ...otherProps }: IEntityProgressUpdateFormProps<IKeyWorkArea>
): React.ReactElement => {
    const { dataServices, lookupData, loadLookupData: { reportingFrequencies } } = useContext(DataContext);
    useMemo(() => reportingFrequencies(), [reportingFrequencies]);

    return (
        <ProgressUpdateForm<IKeyWorkAreaUpdate, IProgressUpdateValidations, IKeyWorkArea>
            {...otherProps}
            entityId={entityId}
            entity={entity}
            dueDate={() => reportDates?.Next}
            maxCommentLength={500}
            loadPeople={async kwa => {
                const people = [];
                if (kwa) {
                    if (kwa.LeadUser)
                        people.push({ role: 'Lead', names: [kwa.LeadUser.Title] });
                    if (kwa.Contributors && kwa.Contributors.length > 0)
                        people.push({ role: 'Contributors', names: kwa.Contributors.map(c => c.ContributorUser && c.ContributorUser.Title) });
                    people.push(...await EntityPeopleService.GetDirectorateEntityPeople({
                        directorateService: dataServices.directorateService,
                        userDirectorateService: dataServices.userDirectorateService,
                        directorateId: kwa.DirectorateID
                    }));
                }
                return people;
            }}
            loadEntity={kwaId => dataServices.keyWorkAreaService.read(kwaId, true, true)}
            loadEntityUpdate={kwauId => dataServices.keyWorkAreaUpdateService.read(kwauId)}
            loadNewEntityUpdate={() => new KeyWorkAreaUpdate(entityId)}
            loadLastSavedProgressUpdate={() => reportDates?.Next &&
                dataServices.keyWorkAreaUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next)}
            loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                dataServices.keyWorkAreaUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
            onValidateUpdate={kwau => ValidateProgressUpdate(kwau)}
            onSaveUpdate={kwau => dataServices.keyWorkAreaUpdateService.create(kwau)}
            onClearForm={(kwa, showForm) => new KeyWorkAreaProgressUpdateFormState(entityId, reportDates?.Next, kwa, showForm)}
            reportDates={reportDates}
            reportingFrequencies={lookupData?.ReportingFrequencies}
        />
    );
};
