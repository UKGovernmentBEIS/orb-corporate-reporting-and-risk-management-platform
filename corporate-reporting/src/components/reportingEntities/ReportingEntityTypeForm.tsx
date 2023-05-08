import { DetailsListLayoutMode, Icon, SelectionMode } from 'office-ui-fabric-react';
import React, { useContext, useState } from 'react';
import { ReportTypes } from '../../refData/ReportTypes';
import { NewFieldName } from '../../services/ReportingFieldHelpers';
import { GetFieldTypeName } from '../../services/ReportingFieldTypeHelpers';
import styles from '../../styles/cr.module.scss';
import { EntityValidations, ISpecificEntityFormProps, ICustomReportingEntityType, CustomReportingEntityType, ReportingField, IReportingField } from '../../types';
import { ConfirmDialog } from '../cr/ConfirmDialog';
import { CrCheckbox } from '../cr/CrCheckbox';
import { CrDropdown } from '../cr/CrDropdown';
import { CrList } from '../cr/CrList';
import { CrSlider } from '../cr/CrSlider';
import { CrTextField } from '../cr/CrTextField';
import { FieldErrorMessage } from '../cr/FieldDecorators';
import { ListCommandBar } from '../cr/ListCommandBar';
import { DataContext } from '../DataContext';
import { EntityForm } from '../EntityForm';
import { CustomFieldForm } from '../reportingFields/CustomFieldForm';

export class ReportingEntityTypeValidations extends EntityValidations {
    public Report: string = null;
    public UpdateFields: string = null;
}

export const ReportingEntityTypeForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices: { reportingEntityTypeService } } = useContext(DataContext);
    const [showCustomFieldForm, setShowCustomFieldForm] = useState(false);
    const [selectedFieldId, setSelectedFieldId] = useState(null);
    const [showConfirmDelete, setShowConfirmDelete] = useState(false);

    const validateEntity = (type: ICustomReportingEntityType): Promise<ReportingEntityTypeValidations> => {
        const errors = new ReportingEntityTypeValidations();

        if (type.Title == null || type.Title === '') {
            errors.Title = 'Name is required';
            errors.Valid = false;
        }
        else {
            errors.Title = null;
        }

        if (type.ReportTypeID === null) {
            errors.Report = 'Report is required';
            errors.Valid = false;
        }
        else {
            errors.Report = null;
        }

        if (!type.UpdateHasRag && !type.UpdateHasNarrative && !type.UpdateHasDeliveryDates && !type.UpdateHasMeasurement) {
            errors.UpdateFields = 'Please select at least one field for the update form';
            errors.Valid = false;
        } else {
            errors.UpdateFields = null;
        }

        return Promise.resolve(errors);
    };

    return (
        <EntityForm<ICustomReportingEntityType, ReportingEntityTypeValidations>
            {...props}
            entityName="Report section"
            renderFormFields={({ changeDropdown, changeTextField, changeCheckbox, changeNumberField, changeJson }, { FormData, ValidationErrors: errors }) =>
                <>
                    <CrDropdown
                        label="Report"
                        required={true}
                        className={styles.formField}
                        options={[
                            { key: ReportTypes.Directorate, text: 'Directorate' },
                            { key: ReportTypes.Project, text: 'Project' },
                            { key: ReportTypes.PartnerOrganisation, text: 'Partner organisation' }
                        ]}
                        selectedKey={FormData.ReportTypeID}
                        onChange={(_, o) => changeDropdown(o, 'ReportTypeID')}
                        errorMessage={errors.Report}
                    />
                    <CrTextField
                        label="Name"
                        maxLength={250}
                        className={styles.formField}
                        required={true}
                        value={FormData.Title}
                        onChange={v => changeTextField(v, 'Title')}
                        errorMessage={errors.Title}
                    />
                    <CrCheckbox
                        label="Headline section?"
                        className={styles.formField}
                        checked={FormData.IsHeadlineSection}
                        onChange={(_, v) => changeCheckbox(v, 'IsHeadlineSection')}
                    />
                    <div className={styles.formField}>
                        <div className={styles.formSectionHeading}>Report item form fields</div>
                        <div className={styles.formText}>All report items have fields: Name, Description, Lead, Contributors and Attributes.</div>
                        <CrCheckbox
                            label="Baseline delivery date"
                            className={`${styles.checkbox} ${styles.formField}`}
                            checked={FormData.UpdateHasDeliveryDates}
                            onChange={(_, v) => changeCheckbox(v, 'UpdateHasDeliveryDates', () => v || changeCheckbox(false, 'UpdateDeliveryDatesIsRequired'))}
                        />
                        <CrCheckbox
                            label="Numeric upper and lower targets"
                            className={`${styles.checkbox} ${styles.formField}`}
                            checked={FormData.HasUpperAndLowerTargets}
                            onChange={(_, v) => changeCheckbox(v, 'HasUpperAndLowerTargets')}
                        />
                        <div className={styles.formField}>
                            <ListCommandBar
                                className={styles.crCommandBarFloating}
                                onAdd={() => { setSelectedFieldId(null); setShowCustomFieldForm(true); }}
                                onEdit={() => setShowCustomFieldForm(true)}
                                onDelete={() => setShowConfirmDelete(true)}
                                editDisabled={selectedFieldId === null}
                                deleteDisabled={selectedFieldId === null}
                                additionalFarItems={[
                                    {
                                        key: 'help',
                                        name: 'To reorder columns, select a column and then drag-and-drop it to the desired position',
                                        iconProps: { iconName: 'Unknown' },
                                        iconOnly: true
                                    }
                                ]}
                            />
                            <CrList
                                layoutMode={DetailsListLayoutMode.justified}
                                selectionMode={SelectionMode.single}
                                getItemId={(i: IReportingField) => i.FieldName}
                                onSelectedIdChange={i => setSelectedFieldId(i)}
                                columns={[
                                    { key: '0', name: 'Column name', fieldName: 'Title', minWidth: 50, maxWidth: 100, isResizable: true },
                                    { key: '1', name: 'Column type', fieldName: 'Type', minWidth: 50, isResizable: true, onRender: item => GetFieldTypeName(item.Type) }
                                ]}
                                items={FormData.CustomFields}
                                onOrderChange={items => changeJson(items, 'CustomFields')}
                            />
                            <ConfirmDialog
                                title="Are you sure you want to delete this column?"
                                hidden={!showConfirmDelete}
                                confirmButtonText="Delete"
                                handleConfirm={() => selectedFieldId != null && changeJson(FormData.CustomFields.filter(f => f.FieldName !== selectedFieldId), 'CustomFields', () => setShowConfirmDelete(false))}
                                handleCancel={() => setShowConfirmDelete(false)}
                            >
                                <div className={styles.grid}>
                                    <div className={styles.gridRow}>
                                        <div className={`${styles.gridCol} ${styles.sm3}`}>
                                            <Icon iconName="Warning" className={styles.fontSize42} />
                                        </div>
                                        <div className={`${styles.gridCol} ${styles.sm9}`}>
                                            Deleting a column cannot be undone, and any data stored in this column will be lost.
                                        </div>
                                    </div>
                                </div>
                            </ConfirmDialog>
                            {showCustomFieldForm &&
                                <CustomFieldForm
                                    {...props}
                                    showForm={showCustomFieldForm}
                                    reportType={FormData.ReportTypeID}
                                    field={selectedFieldId == null ? new ReportingField() : FormData.CustomFields.find(f => f.FieldName === selectedFieldId)}
                                    onDone={f => {
                                        if (selectedFieldId == null) {
                                            f.FieldName = NewFieldName();
                                            changeJson([...FormData.CustomFields, f], 'CustomFields');
                                        }
                                        else {
                                            changeJson(FormData.CustomFields.map(obj => obj.FieldName === selectedFieldId ? f : obj), 'CustomFields');
                                        }
                                        setShowCustomFieldForm(false);
                                    }}
                                    onCancel={() => setShowCustomFieldForm(false)}
                                />
                            }
                        </div>
                    </div>
                    <div className={styles.formField}>
                        <div className={styles.formField}>
                            <div className={styles.formSectionHeading}>Update form fields</div>
                            <CrCheckbox
                                label="RAG rating"
                                className={styles.checkbox}
                                checked={FormData.UpdateHasRag}
                                onChange={(_, v) => changeCheckbox(v, 'UpdateHasRag', () => changeCheckbox(false, 'UpdateRagIsRequired'))}
                            />
                            <CrCheckbox
                                label="RAG rating is required"
                                disabled={!FormData.UpdateHasRag}
                                className={styles.checkbox}
                                checked={FormData.UpdateRagIsRequired}
                                onChange={(_, v) => changeCheckbox(v, 'UpdateRagIsRequired')}
                            />
                        </div>
                        <div className={styles.formField}>
                            <CrCheckbox
                                label="Narrative"
                                className={styles.checkbox}
                                checked={FormData.UpdateHasNarrative}
                                onChange={(_, v) => changeCheckbox(v, 'UpdateHasNarrative', () => changeCheckbox(false, 'UpdateNarrativeIsRequired'))}
                            />
                            <CrCheckbox
                                label="Narrative is required"
                                disabled={!FormData.UpdateHasNarrative}
                                className={styles.checkbox}
                                checked={FormData.UpdateNarrativeIsRequired}
                                onChange={(_, v) => changeCheckbox(v, 'UpdateNarrativeIsRequired')}
                            />
                            <CrSlider
                                label="Narrative maximum characters"
                                disabled={!FormData.UpdateHasNarrative}
                                min={100}
                                max={1000}
                                step={50}
                                value={FormData.UpdateNarrativeMaxChars}
                                onChange={v => changeNumberField(v, 'UpdateNarrativeMaxChars')}
                            />
                        </div>
                        <div className={styles.formField}>
                            <CrCheckbox
                                label="Delivery date"
                                className={styles.checkbox}
                                checked={FormData.UpdateHasDeliveryDates}
                                onChange={(_, v) => changeCheckbox(v, 'UpdateHasDeliveryDates', () => changeCheckbox(false, 'UpdateDeliveryDatesIsRequired'))}
                            />
                            <CrCheckbox
                                label="Delivery date is required"
                                disabled={!FormData.UpdateHasDeliveryDates}
                                className={styles.checkbox}
                                checked={FormData.UpdateDeliveryDatesIsRequired}
                                onChange={(_, v) => changeCheckbox(v, 'UpdateDeliveryDatesIsRequired')}
                            />
                        </div>
                        <div className={styles.formField}>
                            <CrCheckbox
                                label="Current performance"
                                className={styles.checkbox}
                                checked={FormData.UpdateHasMeasurement}
                                onChange={(_, v) => changeCheckbox(v, 'UpdateHasMeasurement', () => v || changeCheckbox(false, 'UpdateMeasurementIsRequired'))}
                            />
                            <CrCheckbox
                                label="Current performance is required"
                                disabled={!FormData.UpdateHasMeasurement}
                                className={styles.checkbox}
                                checked={FormData.UpdateMeasurementIsRequired}
                                onChange={(_, v) => changeCheckbox(v, 'UpdateMeasurementIsRequired')}
                            />
                        </div>
                        <FieldErrorMessage value={errors.UpdateFields} />
                    </div>
                </>
            }
            loadEntity={id => reportingEntityTypeService.read(id)}
            loadNewEntity={() => new CustomReportingEntityType()}
            loadEntityValidations={() => new ReportingEntityTypeValidations()}
            onValidateEntity={validateEntity}
            includePropertiesOnSave={['CustomFields']}
            onCreate={r => reportingEntityTypeService.create(r)}
            onUpdate={r => reportingEntityTypeService.update(r.ID, r)}
        />
    );
};