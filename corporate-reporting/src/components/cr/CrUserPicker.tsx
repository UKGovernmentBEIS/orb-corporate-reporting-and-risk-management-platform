import React from 'react';
import { IUser } from '../../types';
import styles from '../../styles/cr.module.scss';
import { TagPicker, ITag, IBasePickerSuggestionsProps } from 'office-ui-fabric-react/lib/Pickers';
import { FieldErrorMessage } from './FieldDecorators';
import { CrLabel } from './CrLabel';

export interface ICrUserPickerProps {
    users: IUser[];
    label?: string;
    required?: boolean;
    className?: string;
    disabled?: boolean;
    itemLimit?: number;
    selectedUsers: number[];
    errorMessage?: string;
    onChange: (users?: number[]) => void;
    initialSuggestions?: IUser[];
    initialSuggestionsHeaderText?: string;
    noResultsFoundText?: string;
}

export const CrUserPicker = (
    { users, label, required, className, disabled, itemLimit, selectedUsers, errorMessage, onChange, initialSuggestions, initialSuggestionsHeaderText, noResultsFoundText }: ICrUserPickerProps
): React.ReactElement => {
    const userToTag = (user: IUser): ITag => {
        return { key: user.ID.toString(), name: `${user.Title} (${user.Username})` };
    };

    const loadSelectedUsers = (userIds: number[]): ITag[] => {
        return userIds ? userIds.map(userId => {
            const user = users.filter(u => u.ID === userId);
            return user.length > 0 ? userToTag(user[0]) : null;
        }).filter(u => u) : [];
    };

    const resolveUser = (filterText: string): ITag[] => {
        return filterText ? users.filter(user =>
            user.Title.toLowerCase().indexOf(filterText.toLowerCase()) !== -1
            || user.Username.toLowerCase().indexOf(filterText.toLowerCase()) !== -1
        ).map(user => userToTag(user)) : [];
    };

    const usersChanged = (items: ITag[]): void => {
        onChange(items.length > 0 ? items.map(i => Number(i.key)) : []);
    };

    const pickerSuggestionsProps: IBasePickerSuggestionsProps = {};
    pickerSuggestionsProps.noResultsFoundText = noResultsFoundText || 'No users found';
    if (initialSuggestionsHeaderText) {
        pickerSuggestionsProps.mostRecentlyUsedHeaderText = initialSuggestionsHeaderText;
    }

    const onEmptyFocus = initialSuggestions ? { onEmptyInputFocus: () => initialSuggestions.map(s => userToTag(s)) } : {};

    return (
        <div className={className}>
            {label &&
                <CrLabel text={label} required={required} icon="Contact" />
            }
            <TagPicker
                className={errorMessage && styles.userPickerInvalid}
                disabled={disabled}
                itemLimit={itemLimit || 1}
                selectedItems={loadSelectedUsers(selectedUsers)}
                resolveDelay={200}
                onResolveSuggestions={resolveUser}
                onChange={usersChanged}
                pickerSuggestionsProps={pickerSuggestionsProps}
                {...onEmptyFocus}
            />
            {errorMessage &&
                <FieldErrorMessage value={errorMessage} />
            }
        </div>
    );
};
