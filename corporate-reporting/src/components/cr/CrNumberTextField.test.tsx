/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrNumberTextField, ICrNumberTextFieldProps } from './CrNumberTextField';
import { CrTextField } from './CrTextField';
import { setIconOptions } from 'office-ui-fabric-react/lib/Styling';

// Suppress icon warnings.
setIconOptions({ disableWarnings: true });

configure({ adapter: new Adapter() });

describe('<CrNumberTextField />', () => {
    let reactComponent: ShallowWrapper<ICrNumberTextFieldProps>;
    let numberFieldValue: number | string;

    beforeEach(() => {
        numberFieldValue = 123;
        reactComponent = shallow(
            <CrNumberTextField
                label="My test number field"
                value={numberFieldValue}
                onChange={v => numberFieldValue = v}
                maxLength={5}
                history={2345.67}
                errorMessage="error!" />
        );
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a crtextfield', () => {
        expect(reactComponent.find(CrTextField)).toHaveLength(1);
    });

    it('should render number with comma thousands separator if value is >= 1000', () => {
        reactComponent.setProps({ value: '3456' });
        const num = reactComponent.find('div.formattedNumber');
        expect(num).toHaveLength(1);
        expect(num.text()).toBe('3,456');
    });
});
