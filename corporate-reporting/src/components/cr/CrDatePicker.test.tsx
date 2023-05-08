/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, mount, ReactWrapper } from "enzyme";

import { CrDatePicker, ICrDatePickerProps } from './CrDatePicker';
import { DatePicker } from 'office-ui-fabric-react/lib/DatePicker';
import { FieldErrorMessage, FieldHistory } from './FieldDecorators';
import { setIconOptions } from 'office-ui-fabric-react/lib/Styling';

// Suppress icon warnings.
setIconOptions({ disableWarnings: true });

configure({ adapter: new Adapter() });

describe('<CrDatePicker />', () => {
    let reactComponent: ReactWrapper<ICrDatePickerProps>;

    beforeEach(() => {
        reactComponent = mount(<CrDatePicker label="My test date picker" value={new Date()} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a datepicker', () => {
        expect(reactComponent.find(DatePicker)).toHaveLength(1);
    });

    it('should render history text', () => {
        reactComponent.setProps({ history: new Date(2018, 5, 23) });
        expect(reactComponent.find(FieldHistory)).toHaveLength(1);
    });

    it('should render an error message', () => {
        reactComponent.setProps({ errorMessage: "Test error message" });
        expect(reactComponent.find(FieldErrorMessage)).toHaveLength(1);
    });
});
