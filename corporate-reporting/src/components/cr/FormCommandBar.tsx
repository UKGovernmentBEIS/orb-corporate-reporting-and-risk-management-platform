import React from 'react';
import { ICommandBarItemProps } from 'office-ui-fabric-react/lib/CommandBar';
import { CrCommandBar } from './CrCommandBar';

export interface IFormCommandBarProps {
    primaryText?: string;
    onSave: () => void;
    onCancel: () => void;
}

export const FormCommandBar = ({ primaryText, onSave, onCancel }: IFormCommandBarProps): React.ReactElement => {
    const commandBarItems: ICommandBarItemProps[] = [
        { key: 'save', text: primaryText || 'Save', iconProps: { iconName: 'Save' }, onClick: onSave },
        { key: 'cancel', text: 'Cancel', iconProps: { iconName: 'Cancel' }, onClick: onCancel }
    ];
    const farCommandBarItems: ICommandBarItemProps[] = [
        { key: 'close', text: 'Close', iconOnly: true, iconProps: { iconName: 'Cancel' }, onClick: onCancel },
    ];
    return <CrCommandBar items={commandBarItems} farItems={farCommandBarItems} />;
};
