/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrChoiceGroup, ICrChoiceGroupProps } from './CrChoiceGroup';
import { ChoiceGroup } from 'office-ui-fabric-react/lib/ChoiceGroup';
import { FieldErrorMessage, FieldHistory } from './FieldDecorators';

configure({ adapter: new Adapter() });

describe('<CrChoiceGroup />', () => {
    let reactComponent: ShallowWrapper<ICrChoiceGroupProps>;

    beforeEach(() => {
        reactComponent = shallow(<CrChoiceGroup />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a choicegroup', () => {
        expect(reactComponent.find(ChoiceGroup)).toHaveLength(1);
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
