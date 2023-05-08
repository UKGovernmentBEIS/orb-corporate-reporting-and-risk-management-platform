/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, mount, ReactWrapper } from "enzyme";

import { CrUpdatePeriodPicker, ICrUpdatePeriodPickerProps } from './CrUpdatePeriodPicker';
import { CrChoiceGroup } from './CrChoiceGroup';
import { setIconOptions } from 'office-ui-fabric-react/lib/Styling';
import { Period } from '../../refData/Period';

setIconOptions({ disableWarnings: true });

configure({ adapter: new Adapter() });

describe('<CrUpdatePeriodPicker />', () => {
    let reactComponent: ReactWrapper<ICrUpdatePeriodPickerProps>;
    let periodPicked: Period;

    beforeEach(() => {
        periodPicked = Period.Current;
        reactComponent = mount(<CrUpdatePeriodPicker value={periodPicked} onChange={d => periodPicked = d} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a crchoicegroup', () => {
        expect(reactComponent.find(CrChoiceGroup)).toHaveLength(1);
    });

    it('should update parent when period changed', () => {
        const cg = reactComponent.find('input').first();
        cg.simulate('change', { target: { checked: true } });
        expect(periodPicked).toEqual(Period.Previous);
    });
});
