import React from 'react';
import { ICommandBarItemProps } from 'office-ui-fabric-react/lib/CommandBar';
import { SearchBox } from 'office-ui-fabric-react/lib/SearchBox';
import styles from '../../styles/cr.module.scss';
import { CrCommandBar } from './CrCommandBar';
import { PrimaryButton } from 'office-ui-fabric-react';

export interface IListCommandBarProps {
    className?: string;
    onAdd: () => void;
    onAddMultiple?: () => void;
    onEdit: () => void;
    onDelete: () => void;
    onFilterChange?: (filterText: string) => void;
    addDisabled?: boolean;
    editDisabled?: boolean;
    deleteDisabled?: boolean;
    addChildDisabled?: boolean;
    onAddChild?: () => void;
    addChildName?: string;
    additionalItems?: ICommandBarItemProps[];
    additionalFarItems?: ICommandBarItemProps[];
}

export const ListCommandBar = (props: IListCommandBarProps): React.ReactElement => {
    const { className, onAdd, onAddMultiple, onEdit, onDelete, onFilterChange, addDisabled, editDisabled,
        deleteDisabled, addChildDisabled, onAddChild, addChildName, additionalItems, additionalFarItems } = props;

    const addMultipleItems = onAddMultiple ?
        {
            split: true,
            menuProps: {
                items: [{
                    key: 'newMultiple',
                    text: 'New (multiple reports)',
                    iconProps: { iconName: 'CPlusPlusLanguage' },
                    onClick: onAddMultiple
                }]
            }
        } : {};

    const addItem: ICommandBarItemProps = {
        key: 'new',
        text: 'New',
        iconProps: { iconName: 'Add' },
        onClick: onAdd,
        onRender: function renderAdd() {
            return (
                <div className={styles.crCommandBarContainer}>
                    <div className={styles.crCommandBarPrimaryButton}>
                        <PrimaryButton
                            text="New"
                            iconProps={{ iconName: 'Add' }}
                            onClick={onAdd}
                            {...addMultipleItems}
                        />
                    </div>
                </div>
            );
        }
    };

    const editItem: ICommandBarItemProps = {
        key: 'edit',
        text: 'Edit',
        iconProps: { iconName: 'Edit' },
        onClick: onEdit,
        disabled: editDisabled
    };

    const deleteItem = {
        key: 'delete',
        text: 'Delete',
        iconProps: { iconName: 'Delete' },
        onClick: onDelete,
        disabled: deleteDisabled
    };

    const addChildItem: ICommandBarItemProps = {
        key: 'addChild',
        text: `Add ${addChildName}`,
        iconProps: { iconName: 'Add' },
        onClick: onAddChild
    };

    const commandBarItems: ICommandBarItemProps[] = [];

    if (!addDisabled) {
        commandBarItems.push(addItem);
    }
    if (!editDisabled) {
        commandBarItems.push(editItem);
    }
    if (!deleteDisabled) {
        commandBarItems.push(deleteItem);
    }
    if (!addChildDisabled && onAddChild && addChildName) {
        commandBarItems.push(addChildItem);
    }
    if (additionalItems) {
        commandBarItems.push(...additionalItems);
    }

    const farCommandBarItems: ICommandBarItemProps[] = [];

    if (onFilterChange) {
        farCommandBarItems.push(
            {
                key: 'filter',
                text: 'List filter',
                inActive: true,
                onRender: function renderFilter() {
                    return (
                        <div className={styles.crCommandBarContainer}>
                            <SearchBox placeholder="Filter items" onChange={(_, v) => onFilterChange(v)} className={styles.listFilterBox} />
                        </div>
                    );
                }
            }
        );
    }
    if (additionalFarItems) {
        farCommandBarItems.push(...additionalFarItems);
    }

    return <CrCommandBar className={className} items={commandBarItems} farItems={farCommandBarItems} />;
};
