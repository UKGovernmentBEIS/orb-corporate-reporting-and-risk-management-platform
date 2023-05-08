import React, { useContext, useEffect, useMemo, useState } from 'react';
import {
    Contributor, Attribute, EntityValidations, ISpecificEntityFormProps
} from '../../types';
import { LookupService, NumberService, ReportingEntityTypeHelpers, ValidationService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrDropdown } from '../cr/CrDropdown';
import { CrUserPicker } from '../cr/CrUserPicker';
import { EntityStatus } from '../../refData/EntityStatus';
import { CrTextField } from '../cr/CrTextField';
import { CrMultiDropdownWithText } from '../cr/CrMultiDropdownWithText';
import { EntityForm } from '../EntityForm';
import { CustomReportingEntity, ICustomReportingEntity } from '../../types/CustomReportingEntity';
import { ICustomReportingEntityType } from '../../types/CustomReportingEntityType';
import { CrNumberTextField } from '../cr/CrNumberTextField';
import { ChoiceFieldTypes, FieldTypes } from '../../refData/FieldTypes';
import { CrComboBox } from '../cr/CrComboBox';
import { ReportTypes } from '../../refData/ReportTypes';
import { CrDatePicker } from '../cr/CrDatePicker';
import { CrChoiceGroup } from '../cr/CrChoiceGroup';
import { GetReportTypeName } from '../../services/ReportTypeHelpers';
import { DataContext } from '../DataContext';

export class ReportingEntityValidations extends EntityValidations {
    public DirectorateID: string = null;
    public ProjectID: string = null;
    public PartnerOrganisationID: string = null;
    public TargetPerformanceLowerLimit: string = null;
    public TargetPerformanceUpperLimit: string = null;
}

export interface IReportingEntityFormProps extends ISpecificEntityFormProps {
    reportingEntityTypeId: number;
}

export const ReportingEntityForm = (props: IReportingEntityFormProps): React.ReactElement => {
    const { reportingEntityTypeId } = props;
    const { dataServices, lookupData, loadLookupData } = useContext(DataContext);
    const { attributeTypes, directorates, entityStatuses, measurementUnits, partnerOrganisations, projects,
        userDirectorates, userPartnerOrganisations, userProjects, users: { all: allUsers } } = loadLookupData;
    const [reportingEntityType, setReportingEntityType] = useState<ICustomReportingEntityType>(null);
    const [lookupEntities, setLookupEntities] = useState<{ type: number, entities: ICustomReportingEntity[] }[]>([]);

    useMemo(() => attributeTypes(), [attributeTypes]);
    useMemo(() => directorates(), [directorates]);
    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => measurementUnits(), [measurementUnits]);
    useMemo(() => partnerOrganisations(), [partnerOrganisations]);
    useMemo(() => projects(), [projects]);
    useMemo(() => userDirectorates(), [userDirectorates]);
    useMemo(() => userPartnerOrganisations(), [userPartnerOrganisations]);
    useMemo(() => userProjects(), [userProjects]);
    useMemo(() => allUsers(), [allUsers]);

    useEffect(() => {
        const loadReportingEntityType = async () => {
            setReportingEntityType(await dataServices.reportingEntityTypeService.read(reportingEntityTypeId));
        };

        loadReportingEntityType();
    }, [dataServices.reportingEntityTypeService, reportingEntityTypeId]);

    useEffect(() => {
        const loadReportingEntities = async (type: number) => {
            if (!lookupEntities.some(e => e.type === type)) {
                const ents = await dataServices.reportingEntityService.readAllForReportingEntityLookup(type);
                setLookupEntities(e => [...e, { type: type, entities: ents }]);
            }
        };

        reportingEntityType?.CustomFields?.map(cf => {
            if (cf.Type === FieldTypes.Lookup) {
                if (cf.LookupList < 0) {
                    ReportingEntityTypeHelpers.LoadLookupsForFixedReportingEntities(loadLookupData, cf.LookupList);
                }
                if (cf.LookupList > 0) {
                    loadReportingEntities(cf.LookupList);
                }
            }
        });
    }, [reportingEntityType, dataServices.reportingEntityService, loadLookupData, lookupEntities]);

    const validateEntity = (reportingEntity: ICustomReportingEntity, type: ICustomReportingEntityType): Promise<ReportingEntityValidations> => {
        const errors = new ReportingEntityValidations();

        if (reportingEntity.Title === null || reportingEntity.Title === '') {
            errors.Title = 'Reporting entity name is required';
            errors.Valid = false;
        }
        else
            errors.Title = null;

        if (reportingEntity.DirectorateID == null && type.ReportTypeID === ReportTypes.Directorate) {
            errors.DirectorateID = 'Directorate is required';
            errors.Valid = false;
        } else {
            errors.DirectorateID = null;
        }

        if (reportingEntity.ProjectID == null && type.ReportTypeID === ReportTypes.Project) {
            errors.ProjectID = 'Project is required';
            errors.Valid = false;
        } else {
            errors.ProjectID = null;
        }

        if (reportingEntity.PartnerOrganisationID == null && type.ReportTypeID === ReportTypes.PartnerOrganisation) {
            errors.PartnerOrganisationID = 'Partner organisation is required';
            errors.Valid = false;
        } else {
            errors.PartnerOrganisationID = null;
        }

        if (type.HasUpperAndLowerTargets) {
            if (reportingEntity.TargetPerformanceLowerLimit != null && isNaN(Number(reportingEntity.TargetPerformanceLowerLimit))) {
                errors.TargetPerformanceLowerLimit = 'Target performance lower limit must be a number';
                errors.Valid = false;
            } else if (reportingEntity.TargetPerformanceLowerLimit != null && !ValidationService.validSqlDecimal(Number(reportingEntity.TargetPerformanceLowerLimit))) {
                errors.TargetPerformanceLowerLimit = 'Target performance lower limit is too big';
                errors.Valid = false;
            }
            else {
                errors.TargetPerformanceLowerLimit = null;
            }

            if (reportingEntity.TargetPerformanceUpperLimit != null && isNaN(Number(reportingEntity.TargetPerformanceUpperLimit))) {
                errors.TargetPerformanceUpperLimit = 'Target performance upper limit must be a number';
                errors.Valid = false;
            } else if (reportingEntity.TargetPerformanceUpperLimit != null && !ValidationService.validSqlDecimal(Number(reportingEntity.TargetPerformanceUpperLimit))) {
                errors.TargetPerformanceUpperLimit = 'Target performance upper limit is too big';
                errors.Valid = false;
            }
            else {
                errors.TargetPerformanceUpperLimit = null;
            }
        }

        type.CustomFields.forEach(cf => {
            switch (cf.Type) {
                case FieldTypes.SingleLineOfText:
                case FieldTypes.MultipleLinesOfText:
                case FieldTypes.Lookup:
                    if (cf.Required && (reportingEntity[cf.FieldName] == null || reportingEntity[cf.FieldName] === '')) {
                        errors[cf.FieldName] = `${cf.Title} is required`;
                        errors.Valid = false;
                    }
                    else {
                        errors[cf.FieldName] = null;
                    }
                    break;
                case FieldTypes.Number:
                    if (cf.Required && (reportingEntity[cf.FieldName] == null || reportingEntity[cf.FieldName] === '' || isNaN(Number(reportingEntity[cf.FieldName])))) {
                        errors[cf.FieldName] = `${cf.Title} is required and must be a number`;
                        errors.Valid = false;
                    } else if (!cf.Required && reportingEntity[cf.FieldName] != null && isNaN(Number(reportingEntity[cf.FieldName]))) {
                        errors[cf.FieldName] = `${cf.Title} must be a number`;
                        errors.Valid = false;
                    } else if ((reportingEntity[cf.FieldName] != null && reportingEntity[cf.FieldName] != '')
                        && ((cf.Min != null && Number(reportingEntity[cf.FieldName]) < cf.Min) || (cf.Max != null && Number(reportingEntity[cf.FieldName]) > cf.Max))) {
                        if (cf.Min == null) {
                            errors[cf.FieldName] = `${cf.Title} must be less than or equal to ${cf.Max}`;
                        } else if (cf.Max == null) {
                            errors[cf.FieldName] = `${cf.Title} must be greater than or equal to ${cf.Min}`;
                        } else {
                            errors[cf.FieldName] = `${cf.Title} must be between ${cf.Min} and ${cf.Max}`;
                        }
                        errors.Valid = false;
                    }
                    else {
                        errors[cf.FieldName] = null;
                    }
                    break;
                case FieldTypes.Person:
                    if (cf.Required) {
                        if (reportingEntity[cf.FieldName] == null || reportingEntity[cf.FieldName].length === 0) {
                            errors[cf.FieldName] = `${cf.Title} is required`;
                            errors.Valid = false;
                        } else {
                            errors[cf.FieldName] = null;
                        }
                    }
                    break;
                case FieldTypes.Choice:
                    if (cf.Required) {
                        if (cf.MultiSelect) {
                            if (reportingEntity[cf.FieldName] == null || !Array.isArray(reportingEntity[cf.FieldName]) || reportingEntity[cf.FieldName].length === 0) {
                                errors[cf.FieldName] = `${cf.Title} is required`;
                                errors.Valid = false;
                            } else {
                                errors[cf.FieldName] = null;
                            }
                        } else {
                            if (reportingEntity[cf.FieldName] == null || Array.isArray(reportingEntity[cf.FieldName])) {
                                errors[cf.FieldName] = `${cf.Title} is required`;
                                errors.Valid = false;
                            } else {
                                errors[cf.FieldName] = null;
                            }
                        }
                    }
                    break;
            }
        });

        return Promise.resolve(errors);
    };

    return (
        <EntityForm<ICustomReportingEntity, ReportingEntityValidations>
            {...props}
            entityName={reportingEntityType?.Title}
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: reportingEntity, ValidationErrors: errors } = formState;
                const mappedUsers = reportingEntityType?.ReportTypeID === ReportTypes.Directorate
                    ? LookupService.directorateUsers(lookupData, reportingEntity.DirectorateID, reportingEntity)
                    : reportingEntityType?.ReportTypeID === ReportTypes.Project
                        ? LookupService.projectUsers(lookupData, reportingEntity.ProjectID, reportingEntity)
                        : reportingEntityType?.ReportTypeID === ReportTypes.PartnerOrganisation
                            ? LookupService.partnerOrganisationUsers(lookupData, reportingEntity.PartnerOrganisationID, reportingEntity)
                            : [];
                const suggestions = {
                    initialSuggestionsHeaderText: `${GetReportTypeName(reportingEntityType?.ReportTypeID)} users`,
                    initialSuggestions: mappedUsers,
                    noResultsFoundText: mappedUsers.length === 0 ? `No users are mapped to this item's ${GetReportTypeName(reportingEntityType?.ReportTypeID).toLowerCase()}` : null
                };
                const noReportSelected = reportingEntity.DirectorateID == null && reportingEntity.ProjectID == null && reportingEntity.PartnerOrganisationID == null;

                return (
                    <div>
                        {reportingEntityType?.ReportTypeID === ReportTypes.Directorate &&
                            <CrComboBox
                                label="Directorate"
                                required={true}
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData.Directorates)}
                                selectedKey={reportingEntity.DirectorateID}
                                onChange={(_, o) => changeHandlers.changeComboBox(o, 'DirectorateID')}
                                errorMessage={errors.DirectorateID}
                            />
                        }
                        {reportingEntityType?.ReportTypeID === ReportTypes.Project &&
                            <CrComboBox
                                label="Project"
                                required={true}
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData.Projects)}
                                selectedKey={reportingEntity.ProjectID}
                                onChange={(_, o) => changeHandlers.changeComboBox(o, 'ProjectID')}
                                errorMessage={errors.ProjectID}
                            />
                        }
                        {reportingEntityType?.ReportTypeID === ReportTypes.PartnerOrganisation &&
                            <CrComboBox
                                label="Partner organisation"
                                required={true}
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData.PartnerOrganisations)}
                                selectedKey={reportingEntity.PartnerOrganisationID}
                                onChange={(_, o) => changeHandlers.changeComboBox(o, 'PartnerOrganisationID')}
                                errorMessage={errors.PartnerOrganisationID}
                            />
                        }
                        <CrTextField
                            label="Name"
                            required={true}
                            maxLength={255}
                            className={styles.formField}
                            value={reportingEntity.Title}
                            onChange={v => changeHandlers.changeTextField(v, 'Title')}
                            errorMessage={errors.Title}
                        />
                        <CrTextField
                            label="Description"
                            className={styles.formField}
                            value={reportingEntity.Description}
                            maxLength={1000}
                            onChange={v => changeHandlers.changeTextField(v, 'Description')}
                            multiline
                        />
                        <CrUserPicker
                            label="Lead"
                            className={styles.formField}
                            disabled={noReportSelected}
                            users={mappedUsers}
                            selectedUsers={reportingEntity.LeadUserID ? [reportingEntity.LeadUserID] : []}
                            onChange={v => changeHandlers.changeUserPicker(v, 'LeadUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Contributors"
                            className={styles.formField}
                            disabled={noReportSelected}
                            users={mappedUsers}
                            itemLimit={3}
                            selectedUsers={reportingEntity.Contributors?.map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPicker(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={null}
                            {...suggestions}
                        />
                        <CrMultiDropdownWithText
                            label="Attributes"
                            className={styles.formField}
                            textMaxLength={255}
                            options={lookupData.AttributeTypes.map(a => ({ key: a.ID, text: a.Title, textRequired: false }))}
                            selectedItems={LookupService.attributesToDropdownWithText(reportingEntity.Attributes)}
                            onChange={v => changeHandlers.changeMultiDropdownWithText(v, 'Attributes', new Attribute(), 'AttributeTypeID', 'AttributeValue')}
                        />
                        {reportingEntityType?.UpdateHasDeliveryDates &&
                            <CrDatePicker
                                label="Baseline delivery date"
                                className={styles.formField}
                                value={reportingEntity.BaselineDate}
                                onSelectDate={date => changeHandlers.changeDatePicker(date, 'BaselineDate')}
                            />
                        }
                        {reportingEntityType?.HasUpperAndLowerTargets &&
                            <>
                                <CrDropdown
                                    label="Target performance unit"
                                    className={styles.formField}
                                    options={LookupService.entitiesToSelectableOptions(lookupData.MeasurementUnits)}
                                    selectedKey={reportingEntity.MeasurementUnitID}
                                    onChange={(_, v) => changeHandlers.changeDropdown(v, 'MeasurementUnitID')}
                                />
                                <CrNumberTextField
                                    label="Target performance lower limit"
                                    maxLength={19}
                                    className={styles.formField}
                                    value={reportingEntity.TargetPerformanceLowerLimit || ''}
                                    onChange={v => changeHandlers.changeTextField(v, 'TargetPerformanceLowerLimit')}
                                    errorMessage={errors.TargetPerformanceLowerLimit}
                                />
                                <CrNumberTextField
                                    label="Target performance upper limit"
                                    maxLength={19}
                                    className={styles.formField}
                                    value={reportingEntity.TargetPerformanceUpperLimit || ''}
                                    onChange={v => changeHandlers.changeTextField(v, 'TargetPerformanceUpperLimit')}
                                    errorMessage={errors.TargetPerformanceUpperLimit}
                                />
                            </>
                        }
                        {reportingEntityType?.CustomFields.map(cf => {
                            if (cf.Type === FieldTypes.SingleLineOfText) {
                                return (
                                    <CrTextField
                                        label={cf.Title}
                                        className={styles.formField}
                                        required={cf.Required}
                                        maxLength={cf.MaxLength || 255}
                                        placeholder={cf.Description}
                                        value={reportingEntity?.[cf.FieldName] || ''}
                                        onChange={v => changeHandlers.changeTextField(v, cf.FieldName)}
                                        errorMessage={errors[cf.FieldName]}
                                    />
                                );
                            }
                            if (cf.Type === FieldTypes.MultipleLinesOfText) {
                                return (
                                    <CrTextField
                                        multiline
                                        label={cf.Title}
                                        className={styles.formField}
                                        required={cf.Required}
                                        placeholder={cf.Description}
                                        value={reportingEntity?.[cf.FieldName] || ''}
                                        onChange={v => changeHandlers.changeTextField(v, cf.FieldName)}
                                        errorMessage={errors[cf.FieldName]}
                                    />
                                );
                            }
                            if (cf.Type === FieldTypes.Lookup) {
                                return (
                                    <CrDropdown
                                        label={cf.Title}
                                        className={styles.formField}
                                        required={cf.Required}
                                        options={LookupService.entitiesToSelectableOptions(cf.LookupList < 0
                                            ? ReportingEntityTypeHelpers.GetLookupsForFixedReportingEntities(lookupData, cf.LookupList)
                                            : lookupEntities.find(e => e.type === cf.LookupList)?.entities)
                                        }
                                        selectedKey={reportingEntity?.[cf.FieldName]}
                                        onChange={(_, v) => changeHandlers.changeDropdown(v, cf.FieldName)}
                                        errorMessage={errors[cf.FieldName]}
                                    />
                                );
                            }
                            if (cf.Type === FieldTypes.Number) {
                                return (
                                    <CrNumberTextField
                                        label={cf.Title}
                                        className={styles.formField}
                                        required={cf.Required}
                                        value={NumberService.IsNullOrUndefined(reportingEntity?.[cf.FieldName]) ? '' : reportingEntity?.[cf.FieldName]}
                                        onChange={v => changeHandlers.changeTextField(v, cf.FieldName)}
                                        errorMessage={errors[cf.FieldName]}
                                    />
                                );
                            }
                            if (cf.Type === FieldTypes.Person) {
                                return (
                                    <CrUserPicker
                                        label={cf.Title}
                                        className={styles.formField}
                                        disabled={noReportSelected}
                                        required={cf.Required}
                                        itemLimit={cf.MultiSelect ? 20 : 1}
                                        users={mappedUsers}
                                        selectedUsers={reportingEntity?.[cf.FieldName] || []}
                                        onChange={v => changeHandlers.changeJson(v, cf.FieldName)}
                                        errorMessage={errors[cf.FieldName]}
                                        {...suggestions}
                                    />
                                );
                            }
                            if (cf.Type === FieldTypes.Choice) {
                                if (cf.ChoiceControl === ChoiceFieldTypes.DropDownMenu) {
                                    if (cf.MultiSelect) {
                                        return (
                                            <CrDropdown
                                                label={cf.Title}
                                                className={styles.formField}
                                                required={cf.Required}
                                                options={cf.Choices.split('\n').map(c => ({ key: c, text: c }))}
                                                multiSelect
                                                selectedKeys={reportingEntity?.[cf.FieldName] || []}
                                                onChange={(_, o) => changeHandlers.changeMultiDropdownStringArray(o, cf.FieldName)}
                                                errorMessage={errors[cf.FieldName]}
                                            />
                                        );
                                    } else {
                                        return (
                                            <CrDropdown
                                                label={cf.Title}
                                                className={styles.formField}
                                                required={cf.Required}
                                                options={cf.Choices.split('\n').map(c => ({ key: c, text: c }))}
                                                selectedKey={reportingEntity?.[cf.FieldName]?.[0]}
                                                onChange={(_, o) => changeHandlers.changeJson([o.key], cf.FieldName)}
                                                errorMessage={errors[cf.FieldName]}
                                            />
                                        );
                                    }
                                } else {
                                    return (
                                        <CrChoiceGroup
                                            label={cf.Title}
                                            className={styles.formField}
                                            required={cf.Required}
                                            options={cf.Choices.split('\n').map(c => ({ key: c, text: c }))}
                                            selectedKey={reportingEntity?.[cf.FieldName]}
                                            onChange={(_, o) => changeHandlers.changeChoiceGroup(o, cf.FieldName)}
                                            errorMessage={errors[cf.FieldName]}
                                        />
                                    );
                                }

                            }
                        })}
                        {formState.FormDataBeforeChanges.EntityStatusID === EntityStatus.Closed &&
                            <CrDropdown
                                label="Status"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                                selectedKey={reportingEntity.EntityStatusID}
                                onChange={(_, o) => changeHandlers.changeDropdown(o, 'EntityStatusID')}
                            />
                        }
                    </div>
                );
            }}
            loadEntity={id => dataServices.reportingEntityService.read(id, true, true)}
            loadNewEntity={() => new CustomReportingEntity(reportingEntityTypeId)}
            loadEntityValidations={() => new ReportingEntityValidations()}
            onValidateEntity={entity => validateEntity(entity, reportingEntityType)}
            includePropertiesOnSave={reportingEntityType?.CustomFields?.map(cf => cf.FieldName)}
            onCreate={e => dataServices.reportingEntityService.create(e)}
            onUpdate={e => dataServices.reportingEntityService.update(e.ID, e)}
            onBeforeSave={e => {
                e.TargetPerformanceLowerLimit = e.TargetPerformanceLowerLimit || e.TargetPerformanceLowerLimit === 0 ? Number(e.TargetPerformanceLowerLimit) : null;
                e.TargetPerformanceUpperLimit = e.TargetPerformanceUpperLimit || e.TargetPerformanceUpperLimit === 0 ? Number(e.TargetPerformanceUpperLimit) : null;
                reportingEntityType?.CustomFields.forEach(cf => {
                    if (cf.Type === FieldTypes.Number) {
                        e[cf.FieldName] = e[cf.FieldName] || e[cf.FieldName] === 0 ? Number(e[cf.FieldName]) : null;
                    }
                    if (cf.Type === FieldTypes.Person && e[cf.FieldName] != null) {
                        e[`${cf.FieldName}@odata.type`] = '#Collection(Int32)';
                    }
                    if (cf.Type === FieldTypes.Choice && e[cf.FieldName] != null) {
                        e[`${cf.FieldName}@odata.type`] = '#Collection(String)';
                    }
                });
            }}
            parentEntities={dataServices.reportingEntityService.parentEntities}
            childEntities={[
                {
                    ObjectParentProperty: 'Contributors', ParentIdProperty: 'ReportingEntityID',
                    ChildIdProperty: 'ContributorUserID', ChildService: dataServices.contributorService
                },
                {
                    ObjectParentProperty: 'Attributes', ParentIdProperty: 'ReportingEntityID',
                    ChildIdProperty: 'AttributeTypeID', ChildService: dataServices.attributeService
                }
            ]}
        />
    );
};
