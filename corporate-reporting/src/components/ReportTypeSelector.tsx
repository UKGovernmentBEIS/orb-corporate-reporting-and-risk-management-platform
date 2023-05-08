import React from 'react';
import { CrDropdown } from './cr/CrDropdown';
import { SignOffType } from '../refData/SignOffType';

export interface IReportTypeSelectorProps {
    className?: string;
    placeholder?: string;
    disabled?: boolean;
    types: SignOffType[];
    selectedType: SignOffType;
    onChange: (type: SignOffType) => void;
}

export const ReportTypeSelector = ({ placeholder, types, selectedType, onChange, ...others }: IReportTypeSelectorProps): React.ReactElement => {
    return (
        <CrDropdown
            {...others}
            options={types.map(t => ({
                key: t, text: t === SignOffType.Directorate ? 'Directorate'
                    : t === SignOffType.PartnerOrganisation ? 'Partner organisation'
                        : t === SignOffType.Project ? 'Project'
                            : t === SignOffType.Risk ? 'Risk'
                                : t === SignOffType.FinancialRisk ? 'Financial risk' : null
            }))}
            selectedKey={selectedType}
            onChange={(_, o) => onChange(Number(o.key))}
            placeholder={placeholder || 'Select report type'}
        />
    );
};
