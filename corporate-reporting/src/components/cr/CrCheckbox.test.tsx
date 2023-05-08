/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrCheckbox, ICrCheckboxProps } from './CrCheckbox';
import { Checkbox } from 'office-ui-fabric-react/lib/Checkbox';
import { FieldErrorMessage } from './FieldDecorators';

configure({ adapter: new Adapter() });

describe('<CrCheckbox />', () => {
    let reactComponent: ShallowWrapper<ICrCheckboxProps>;

    beforeEach(() => {
        reactComponent = shallow(<CrCheckbox />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a checkbox', () => {
        expect(reactComponent.find(Checkbox)).toHaveLength(1);
    });

    it('should render an error message', () => {
        reactComponent.setProps({ errorMessage: "Test error message" });
        expect(reactComponent.find(FieldErrorMessage)).toHaveLength(1);
    });
});
