import React from 'react';
import { ISliderProps, Slider } from "office-ui-fabric-react";

export const ProximitySlider = (props: ISliderProps): React.ReactElement =>
    <Slider
        {...props}
        styles={{ root: { display: 'flex' } }}
        min={1}
        max={4}
        valueFormat={value => value === 1 ? 'within a week' : value === 2 ? 'within a month' : value === 3 ? 'within 3 months' : 'anytime'}
    />;