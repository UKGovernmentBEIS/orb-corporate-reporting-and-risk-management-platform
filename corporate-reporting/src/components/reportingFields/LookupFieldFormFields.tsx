import { Toggle } from 'office-ui-fabric-react';
import React, { useContext, useEffect, useMemo, useState } from 'react';
import { LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { ICustomReportingEntityType } from '../../types';
import { DataContext } from '../DataContext';
import { CrDropdown } from '../cr/CrDropdown';

interface ILookupFieldFormFieldsProps {
    reportType: number;
    value: { lookupList: number, isRequired: boolean };
    onChange: (value: { lookupList: number, isRequired: boolean }) => void;
    errorMessages?: { lookupList: string };
}

export const LookupFieldFormFields = ({ reportType, value, onChange, errorMessages }: ILookupFieldFormFieldsProps): React.ReactElement => {
    const [reportingEntityTypes, setReportingEntityTypes] = useState<ICustomReportingEntityType[]>([]);
    const { lookupData, loadLookupData: { reportingEntityTypes: loadReportingEntityTypes } } = useContext(DataContext);

    useMemo(() => loadReportingEntityTypes(), [loadReportingEntityTypes]);

    useEffect(() => {
        setReportingEntityTypes(lookupData.ReportingEntityTypes?.filter(ret => ret.ReportTypeID === reportType));
    }, [reportType, lookupData.ReportingEntityTypes]);

    return (
        <>
            <CrDropdown
                label="Lookup list"
                required={true}
                className={styles.formField}
                options={[...LookupService.entitiesToSelectableOptions(reportingEntityTypes)]}
                selectedKey={value.lookupList}
                onChange={(_, v) => onChange({ ...value, lookupList: Number(v.key) })}
                errorMessage={errorMessages?.lookupList}
            />
            <Toggle
                label="Require that this column contains information"
                className={styles.formField}
                checked={value.isRequired}
                onChange={(_, c) => onChange({ ...value, isRequired: c })}
            />
        </>
    );
};