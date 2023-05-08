import React from 'react';
import { IEntityValidations } from '../../types';
import { FieldErrorMessage } from './FieldDecorators';

export const FormErrorsList = ({ errors }: { errors: IEntityValidations }): React.ReactElement => {
    return (
        <>
            {!errors.Valid &&
                <FieldErrorMessage value="The values you have entered have the following errors:" />
            }
            {!errors.Valid && Object.keys(errors).map(e => e !== 'FormMessage' && errors[e] != null &&
                <FieldErrorMessage value={errors[e]} />
            )}
        </>
    );
};