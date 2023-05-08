import React, { useContext } from 'react';
import { EntityValidations, ISpecificEntityFormProps } from '../../types';
import styles from '../../styles/cr.module.scss';
import { CrTextField } from '../cr/CrTextField';
import { CrNumberTextField } from '../cr/CrNumberTextField';
import { IThreshold, Threshold } from '../../types/Threshold';
import { EntityForm } from '../EntityForm';
import { NumberService, ValidationService } from '../../services';
import { DataContext } from '../DataContext';

export class ThresholdValidations extends EntityValidations {
    public Priority: string = null;
}

export const ThresholdForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices: { thresholdService } } = useContext(DataContext);

    const validateEntity = (threshold: IThreshold): Promise<ThresholdValidations> => {
        const errors = new ThresholdValidations();

        if (threshold.Title === null || threshold.Title === '' || (threshold.Title && threshold.Title.length == 0)) {
            errors.Title = 'Name is required';
            errors.Valid = false;
        }
        else
            errors.Title = null;

        if (threshold.Priority === null) {
            errors.Priority = 'Priority is required';
            errors.Valid = false;
        } else if (threshold.Priority !== null && (isNaN(Number(threshold.Priority)) || Number(threshold.Priority) <= 0)) {
            errors.Priority = 'Priority must be a number and greater than 0';
            errors.Valid = false;
        } else if (threshold.Priority !== null && !ValidationService.validSqlDecimal(Number(threshold.Priority))) {
            errors.Priority = 'Priority is too big';
            errors.Valid = false;
        }
        else
            errors.Priority = null;

        return Promise.resolve(errors);
    };

    return (
        <EntityForm<IThreshold, ThresholdValidations>
            {...props}
            entityName="Threshold"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: threshold, ValidationErrors: errors } = formState;
                return (
                    <div>
                        <CrTextField
                            label="Name"
                            className={styles.formField}
                            required={true}
                            maxLength={255}
                            value={threshold.Title}
                            onChange={v => changeHandlers.changeTextField(v, 'Title')}
                            errorMessage={errors.Title} />
                        <CrNumberTextField
                            label="Priority"
                            required={true}
                            className={styles.formField}
                            maxLength={19}
                            value={threshold.Priority}
                            onChange={v => changeHandlers.changeTextField(v, 'Priority')}
                            errorMessage={errors.Priority} />
                    </div>
                );
            }}
            loadEntity={id => thresholdService.read(id, true, true)}
            loadNewEntity={() => new Threshold()}
            loadEntityValidations={() => new ThresholdValidations()}
            onValidateEntity={validateEntity}
            onCreate={u => thresholdService.create(u)}
            onUpdate={u => thresholdService.update(u.ID, u)}
            onBeforeSave={threshold => threshold.Priority = NumberService.ToNumberOrNull(threshold.Priority)}
        />
    );
};
