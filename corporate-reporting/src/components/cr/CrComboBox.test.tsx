/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrComboBox, ICrComboBoxProps } from './CrComboBox';
import { ComboBox } from 'office-ui-fabric-react/lib/ComboBox';
import { FieldErrorMessage, FieldHistory } from './FieldDecorators';

configure({ adapter: new Adapter() });

describe('<CrComboBox />', () => {
    let reactComponent: ShallowWrapper<ICrComboBoxProps>;

    beforeEach(() => {
        reactComponent = shallow(<CrComboBox options={[{ key: 1, text: 'Option 1' }, { key: 2, text: 'Option 2' }]} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a combobox', () => {
        expect(reactComponent.find(ComboBox)).toHaveLength(1);
    });

    it('should render history text', () => {
        reactComponent.setProps({ history: "Test history text" });
        expect(reactComponent.find(FieldHistory)).toHaveLength(1);
    });

    it('should render an error message', () => {
        reactComponent.setProps({ errorMessage: "Test error message" });
        expect(reactComponent.find(FieldErrorMessage)).toHaveLength(1);
    });
});
