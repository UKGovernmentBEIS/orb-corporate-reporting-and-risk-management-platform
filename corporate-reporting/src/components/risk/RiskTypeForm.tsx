import React, { useContext, useMemo } from 'react';
import { EntityValidations, ISpecificEntityFormProps } from '../../types';
import { CrTextField } from '../cr/CrTextField';
import styles from '../../styles/cr.module.scss';
import { IRiskType, RiskType } from '../../types/RiskType';
import { CrDropdown } from '../cr/CrDropdown';
import { EntityForm } from '../EntityForm';
import { LookupService } from '../../services';
import { DataContext } from '../DataContext';

export const RiskTypeForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices: { riskTypeService }, lookupData, loadLookupData: { thresholds } } = useContext(DataContext);

    useMemo(() => thresholds(), [thresholds]);

    return (
        <EntityForm<IRiskType, EntityValidations>
            {...props}
            entityName="Risk type"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: riskType, ValidationErrors: errors } = formState;
                return (
                    <div>
                        <CrTextField
                            label="Name"
                            className={styles.formField}
                            required={true}
                            maxLength={255}
                            value={riskType.Title}
                            onChange={v => changeHandlers.changeTextField(v, 'Title')}
                            errorMessage={errors.Title} />
                        <CrDropdown
                            label="Threshold"
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptions(lookupData.Thresholds)}
                            selectedKey={riskType.ThresholdID}
                            onChange={(_e, v) => changeHandlers.changeDropdown(v, 'ThresholdID')} />
                    </div>
                );
            }}
            loadEntity={id => riskTypeService.read(id, true, true)}
            loadNewEntity={() => new RiskType()}
            loadEntityValidations={() => new EntityValidations()}
            onCreate={rt => riskTypeService.create(rt)}
            onUpdate={rt => riskTypeService.update(rt.ID, rt)}
        />
    );
};
