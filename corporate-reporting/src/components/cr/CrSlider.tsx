import React from 'react';
import { CrLabel } from './CrLabel';
import { Slider, ISliderProps } from 'office-ui-fabric-react';

export const CrSlider = ({ label, className, ...otherProps }: ISliderProps): React.ReactElement => {
    return (
        <div className={className}>
            <CrLabel text={label} icon="Slider" />
            <Slider {...otherProps} />
        </div>
    );
};
