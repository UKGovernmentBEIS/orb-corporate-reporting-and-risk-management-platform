import React from 'react';
import { IUser } from '../../types';
import styles from '../../styles/cr.module.scss';
import { Label } from 'office-ui-fabric-react/lib/Label';
import { TagPicker, ITag } from 'office-ui-fabric-react/lib/Pickers';
import { FieldErrorMessage } from './FieldDecorators';
import { UserService } from '../../services';

export interface ICrUserPicker2Props {
    onError?: (error: string, errorDetails: string) => void;
    userService: UserService;
    users: IUser[];
    label?: string;
    required?: boolean;
    className?: string;
    disabled?: boolean;
    itemLimit?: number;
    selectedUsers?: number[];
    errorMessage?: string;
    onChange?: (users?: number[]) => void;
}

export interface ICrUserPickerState {
    SelectedUsers: ITag[];
}

export class CrUserPicker2 extends React.Component<ICrUserPicker2Props, ICrUserPickerState> {
    constructor(props: ICrUserPicker2Props) {
        super(props);
        this.state = { SelectedUsers: [] };
    }

    public render(): JSX.Element {
        return (
            <div className={this.props.className}>
                {this.props.label &&
                    <Label required={this.props.required}>{this.props.label}</Label>
                }
                <TagPicker
                    className={this.props.errorMessage && styles.userPickerInvalid}
                    disabled={this.props.disabled}
                    itemLimit={this.props.itemLimit || 1}
                    selectedItems={this.state.SelectedUsers}
                    onResolveSuggestions={this.resolveUser}
                    onChange={this.usersChanged}
                    pickerSuggestionsProps={{ noResultsFoundText: 'No users found' }}
                    resolveDelay={500}
                />
                {this.props.errorMessage &&
                    <FieldErrorMessage value={this.props.errorMessage} />
                }
            </div>
        );
    }

    public componentDidUpdate(prevProps: ICrUserPicker2Props): void {
        const { selectedUsers } = this.props;
        if ((!prevProps.selectedUsers && selectedUsers)
            || (prevProps.selectedUsers && selectedUsers && JSON.stringify(prevProps.selectedUsers.sort()) !== JSON.stringify(selectedUsers.sort())))
            this.loadSelectedUsers(selectedUsers);
    }

    private loadSelectedUsers = (userIds: number[]): void => {
        if (userIds) {
            this.setState({ SelectedUsers: [] }, () =>
                userIds.forEach(async userId => {
                    try {
                        const user = await this.props.userService.readForLookup(userId);
                        this.setState(s => ({ SelectedUsers: [...s.SelectedUsers, this.userToTag(user)] }));
                    } catch (err) {
                        if (this.props.onError) this.props.onError(`Error loading user`, err.message);
                    }
                })
            );
        }
    }

    private resolveUser = async (filterText: string, selectedItems: ITag[]): Promise<ITag[]> => {
        const selectedIds = selectedItems.map(i => Number(i.key));
        if (filterText.length > 2) {
            const users = await this.props.userService.search(filterText);
            return users.filter(user => selectedIds.indexOf(user.ID) === -1).map(user => this.userToTag(user));
        }
    }

    private usersChanged = (items: ITag[]): void => {
        this.setState({ SelectedUsers: items });
        if (this.props.onChange) {
            this.props.onChange(items.length > 0 ? items.map(i => Number(i.key)) : []);
        }
    }

    private userToTag(user: IUser): ITag {
        return { key: user.ID && user.ID.toString(), name: `${user.Title} (${user.Username})` };
    }
}
