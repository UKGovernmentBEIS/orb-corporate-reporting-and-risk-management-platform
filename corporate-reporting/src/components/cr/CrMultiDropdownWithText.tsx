import React from 'react';
import { Dropdown, IDropdownOption } from 'office-ui-fabric-react/lib/Dropdown';
import { CrTextField } from '../cr/CrTextField';
import { CrLabel } from './CrLabel';

export interface ICrMultiDropdownWithTextOption extends IDropdownOption {
    textRequired: boolean;
}
export interface ICrMultiDropdownWithTextValue {
    Key: number;
    Text: string;
}

export interface ICrMultiDropdownWithTextProps {
    label?: string;
    className?: string;
    options: ICrMultiDropdownWithTextOption[];
    selectedItems?: ICrMultiDropdownWithTextValue[];
    disabled?: boolean;
    textMaxLength?: number;
    onChange?: (value: ICrMultiDropdownWithTextValue[]) => void;
}

export const CrMultiDropdownWithText = ({ className, label, options, selectedItems, textMaxLength, onChange }: ICrMultiDropdownWithTextProps): React.ReactElement => {
    const _onDropdownChange = (_, item: IDropdownOption): void => {
        let updatedSelectedItems: ICrMultiDropdownWithTextValue[] = JSON.parse(JSON.stringify(selectedItems));
        if (item.selected) {
            updatedSelectedItems.push({ Key: item.key as number, Text: null });
        } else {
            updatedSelectedItems = updatedSelectedItems.filter(i => i.Key !== item.key);
        }
        if (onChange) onChange(updatedSelectedItems);
    };

    const _onTextFieldChanged = (value: string, key: string | number): void => {
        const v: ICrMultiDropdownWithTextValue[] = JSON.parse(JSON.stringify(selectedItems));
        v.forEach(i => {
            if (i.Key === key) i.Text = value;
        });
        if (onChange) onChange(v);
    };

    return (
        <div className={className}>
            <Dropdown
                onRenderLabel={() => label &&
                    <CrLabel text={label} icon="Dropdown" />
                }
                multiSelect
                options={options}
                selectedKeys={selectedItems.map(i => i.Key)}
                onChange={_onDropdownChange}
            />
            {selectedItems.map(d => {
                const option = options.filter(o => o.key === d.Key)[0];
                return (
                    <CrTextField
                        key={d.Key}
                        style={{ marginLeft: '30px' }}
                        label={option?.text}
                        maxLength={textMaxLength}
                        value={d?.Text}
                        onChange={v => _onTextFieldChanged(v, d.Key)}
                    />
                );
            })}
        </div>
    );
};
