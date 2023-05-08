import React from 'react';
import { ICommandBarItemProps } from 'office-ui-fabric-react/lib/CommandBar';
import { CrCommandBar } from './CrCommandBar';

export interface IAddNewEntityCommandBarProps {
    className?: string;
    onAdd: () => void;
}

export const AddNewEntityCommandBar = ({ className, onAdd }: IAddNewEntityCommandBarProps): React.ReactElement => {
    const commandBarItems: ICommandBarItemProps[] = [
        { key: 'new', text: 'New', iconProps: { iconName: 'Add' }, onClick: onAdd }
    ];
    return <CrCommandBar className={className} items={commandBarItems} />;
};
