import React from 'react';
import { IEntity } from '../../types';
import styles from '../../styles/cr.module.scss';
import { TagPicker, ITag } from 'office-ui-fabric-react/lib/Pickers';
import { FieldErrorMessage } from './FieldDecorators';
import { CrLabel } from './CrLabel';

export interface ICrEntityPickerProps {
    entities: IEntity[];
    label?: string;
    required?: boolean;
    className?: string;
    disabled?: boolean;
    itemLimit?: number;
    selectedEntities?: number[];
    errorMessage?: string;
    onChange?: (entities?: number[]) => void;
}

export interface ICrEntityPickerState {
    SelectedEntities: ITag[];
}

export class CrEntityPicker extends React.Component<ICrEntityPickerProps, ICrEntityPickerState> {
    constructor(props: ICrEntityPickerProps) {
        super(props);
        this.state = { SelectedEntities: [] };
    }

    public render(): JSX.Element {
        return (
            <div className={this.props.className}>
                {this.props.label &&
                    <CrLabel text={this.props.label} required={this.props.required} icon="PageHeaderEdit" />
                }
                <TagPicker
                    className={this.props.errorMessage && styles.userPickerInvalid}
                    disabled={this.props.disabled}
                    itemLimit={this.props.itemLimit || 1}
                    selectedItems={this.state.SelectedEntities}
                    onResolveSuggestions={this.resolveEntity}
                    onChange={this.entitiesChanged}
                    pickerSuggestionsProps={{ noResultsFoundText: 'No items found' }}
                />
                {this.props.errorMessage &&
                    <FieldErrorMessage value={this.props.errorMessage} />
                }
            </div>
        );
    }

    public componentDidUpdate(prevProps: ICrEntityPickerProps): void {
        const { entities, selectedEntities } = this.props;
        if (!prevProps.entities && entities
            || !prevProps.selectedEntities && selectedEntities
            || selectedEntities && JSON.stringify(prevProps.selectedEntities.sort()) !== JSON.stringify(selectedEntities.sort()))
            this.loadSelectedEntities(selectedEntities, entities);
    }

    private loadSelectedEntities = (entityIds: number[], entities: IEntity[]): void => {
        let selectedEntities = entityIds.map(entityId => {
            const entity = entities.filter(e => e.ID === entityId);
            return entity.length > 0 ? this.entityToTag(entity[0]) : null;
        }).filter(e => e);
        if (entityIds.length > 0 && selectedEntities.length === 0) {
            selectedEntities = [{ key: '0', name: `Could not load selections. ${JSON.stringify(entityIds)}` }];
        }
        this.setState({ SelectedEntities: selectedEntities });
    }

    private resolveEntity = (filterText: string): ITag[] => {
        return filterText ? this.props.entities.filter(e =>
            e.Title.toLowerCase().indexOf(filterText.toLowerCase()) !== -1
        ).map(e => this.entityToTag(e)) : [];
    }

    private entitiesChanged = (items: ITag[]) => {
        this.setState({ SelectedEntities: items });
        if (this.props.onChange) {
            this.props.onChange(items.length > 0 ? items.map(i => Number(i.key)) : []);
        }
    }

    private entityToTag(entity: IEntity): ITag {
        return { key: entity.ID.toString(), name: entity.Title };
    }
}
