import React, { useContext, useMemo } from 'react';
import { ISpecificEntityFormProps, EntityValidations } from '../../types';
import styles from '../../styles/cr.module.scss';
import { CrDropdown } from '../cr/CrDropdown';
import { Checkbox } from 'office-ui-fabric-react/lib/Checkbox';
import { IThresholdAppetite, ThresholdAppetite } from '../../types/ThresholdAppetite';
import { EntityForm } from '../EntityForm';
import { LookupService } from '../../services';
import { DataContext } from '../DataContext';

export class ThresholdAppetiteValidations extends EntityValidations {
    public ThresholdID: string = null;
    public RiskImpactLevelID: string = null;
    public RiskProbabilityID: string = null;
    public Acceptable: string = null;
}

export const ThresholdAppetiteForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices: { thresholdAppetiteService }, lookupData, loadLookupData: { thresholds, riskImpactLevels, riskProbabilities } } = useContext(DataContext);

    useMemo(() => thresholds(), [thresholds]);
    useMemo(() => riskImpactLevels(), [riskImpactLevels]);
    useMemo(() => riskProbabilities(), [riskProbabilities]);

    const validateEntity = (thresholdAppetite: IThresholdAppetite): Promise<ThresholdAppetiteValidations> => {
        const errors = new ThresholdAppetiteValidations();

        if (thresholdAppetite.ThresholdID === null) {
            errors.ThresholdID = 'Threshold is required';
            errors.Valid = false;
        }
        else
            errors.ThresholdID = null;

        if (thresholdAppetite.RiskImpactLevelID === null) {
            errors.RiskImpactLevelID = 'Risk Impact Level is required';
            errors.Valid = false;
        }
        else
            errors.RiskImpactLevelID = null;

        if (thresholdAppetite.RiskProbabilityID === null) {
            errors.RiskProbabilityID = 'Risk Probability is required';
            errors.Valid = false;
        }
        else
            errors.RiskProbabilityID = null;

        return Promise.resolve(errors);
    };

    return (
        <EntityForm<IThresholdAppetite, ThresholdAppetiteValidations>
            {...props}
            entityName="Threshold appetite"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: ta, ValidationErrors: errors } = formState;
                const today = new Date();
                return (
                    <div>
                        <CrDropdown
                            label="Thresholds"
                            className={styles.formField}
                            required={true}
                            options={LookupService.entitiesToSelectableOptions(lookupData.Thresholds)}
                            selectedKey={ta.ThresholdID}
                            onChange={(_e, v) => changeHandlers.changeDropdown(v, 'ThresholdID')}
                            errorMessage={errors.ThresholdID} />
                        <CrDropdown
                            label="Risk impact level"
                            className={styles.formField}
                            required={true}
                            options={LookupService.entitiesToSelectableOptionsFilteredByDate((new Date(Date.UTC(today.getFullYear(), today.getMonth() + 1, 0))), lookupData.RiskImpactLevels)}
                            selectedKey={ta.RiskImpactLevelID}
                            onChange={(_e, v) => changeHandlers.changeDropdown(v, 'RiskImpactLevelID')}
                            errorMessage={errors.RiskImpactLevelID} />
                        <CrDropdown
                            label="Risk probability"
                            className={styles.formField}
                            required={true}
                            options={LookupService.entitiesToSelectableOptionsFilteredByDate((new Date(Date.UTC(today.getFullYear(), today.getMonth() + 1, 0))), lookupData.RiskProbabilities)}
                            selectedKey={ta.RiskProbabilityID}
                            onChange={(_e, v) => changeHandlers.changeDropdown(v, 'RiskProbabilityID')}
                            errorMessage={errors.RiskProbabilityID} />
                        <Checkbox
                            className={`${styles.formField} ${styles.formField}`}
                            label="Within risk appetite boundary?"
                            checked={ta.Acceptable}
                            onChange={(_e, isChecked) => changeHandlers.changeCheckbox(isChecked, 'Acceptable')} />
                    </div>
                );
            }}
            loadEntity={id => thresholdAppetiteService.read(id, true, true)}
            loadNewEntity={() => new ThresholdAppetite()}
            loadEntityValidations={() => new ThresholdAppetiteValidations()}
            onValidateEntity={validateEntity}
            onCreate={ur => thresholdAppetiteService.create(ur)}
            onUpdate={ur => thresholdAppetiteService.update(ur.ID, ur)}
            onBeforeSave={ta => delete ta.Title}
        />
    );
};
