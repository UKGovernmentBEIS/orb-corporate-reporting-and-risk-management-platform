/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrDropdown, ICrDropdownProps } from './CrDropdown';
import { Dropdown } from 'office-ui-fabric-react/lib/Dropdown';
import { FieldErrorMessage, FieldHistory } from './FieldDecorators';

configure({ adapter: new Adapter() });

describe('<CrDropdown />', () => {
    let reactComponent: ShallowWrapper<ICrDropdownProps>;

    beforeEach(() => {
        reactComponent = shallow(<CrDropdown options={[{ key: 1, text: 'Option 1' }, { key: 2, text: 'Option 2' }]} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a dropdown', () => {
        expect(reactComponent.find(Dropdown)).toHaveLength(1);
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
