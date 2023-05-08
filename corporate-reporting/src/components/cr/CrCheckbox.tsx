import React from 'react';
import { Checkbox, ICheckboxProps } from 'office-ui-fabric-react/lib/Checkbox';
import { FieldDescriptionBelow, FieldErrorMessage } from './FieldDecorators';

export interface ICrCheckboxProps extends ICheckboxProps {
    description?: string;
    errorMessage?: string;
}

export const CrCheckbox = ({ className, description, errorMessage, ...otherProps }: ICrCheckboxProps): React.ReactElement => {
    return (
        <div className={className}>
            <Checkbox {...otherProps} />
            {description && <FieldDescriptionBelow value={description} />}
            {errorMessage && <FieldErrorMessage value={errorMessage} />}
        </div>
    );
};
