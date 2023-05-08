/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, mount, ReactWrapper } from "enzyme";

import { CrTextField, ICrTextFieldProps } from './CrTextField';
import { TextField } from 'office-ui-fabric-react/lib/TextField';
import { Label } from 'office-ui-fabric-react/lib/Label';
import { setIconOptions } from 'office-ui-fabric-react/lib/Styling';

// Suppress icon warnings.
setIconOptions({ disableWarnings: true });

configure({ adapter: new Adapter() });

describe('<CrTextField />', () => {
    let reactComponent: ReactWrapper<ICrTextFieldProps>;
    let textFieldValue: string;

    beforeEach(() => {
        textFieldValue = "test text";
        reactComponent = mount(
            <CrTextField
                placeholder="Test placeholder text"
                value={textFieldValue}
                onChange={v => textFieldValue = v}
                charCounter={true}
                maxLength={50}
                history="previous comment"
                errorMessage="error!" />
        );
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a textfield', () => {
        expect(reactComponent.find(TextField)).toHaveLength(1);
    });

    it('should render a textfield with a label', () => {
        reactComponent.setProps({ label: "My text field" });
        expect(reactComponent.find(TextField)).toHaveLength(1);
        expect(reactComponent.find(Label)).toHaveLength(1);
    });

    it('should update text value', () => {
        const testTextChange = "test text changed";
        const textbox = reactComponent.find('input');
        textbox.simulate('change', { target: { value: testTextChange } });
        expect(textFieldValue).toBe(testTextChange);
    });
});
