/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import {
    FieldErrorMessage, IFieldErrorMessageProps,
    FieldHistory, IFieldHistoryProps,
    TextFieldCharCounter, ITextFieldCharCounterProps
} from './FieldDecorators';

configure({ adapter: new Adapter() });

describe('<FieldErrorMessage />', () => {
    let reactComponent: ShallowWrapper<IFieldErrorMessageProps>;

    beforeEach(() => {
        reactComponent = shallow(<FieldErrorMessage value="Test error message" />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render an error message', () => {
        expect(reactComponent.find('span')).toHaveLength(2);
        expect(reactComponent.find('div')).toHaveLength(1);
        expect(reactComponent.find('p')).toHaveLength(1);
        expect(reactComponent.text()).toBe('Test error message');
    });
});

describe('<FieldHistory />', () => {
    let reactComponent: ShallowWrapper<IFieldHistoryProps>;

    beforeEach(() => {
        reactComponent = shallow(<FieldHistory value="Test history text" />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render the field history text', () => {
        expect(reactComponent.find('div')).toHaveLength(2);
        expect(reactComponent.text()).toBe('Last reporting period: Test history text');
    });
});

describe('<TextFieldCharCounter />', () => {
    let reactComponent: ShallowWrapper<ITextFieldCharCounterProps>;

    beforeEach(() => {
        reactComponent = shallow(<TextFieldCharCounter text="Some text with 28 characters" maxChars={50} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a character counter', () => {
        expect(reactComponent.find('div')).toHaveLength(1);
        expect(reactComponent.text()).toBe('22 characters remaining');
    });

    it('should render a character counter with maxChars', () => {
        reactComponent.setProps({ text: null });
        expect(reactComponent.find('div')).toHaveLength(1);
        expect(reactComponent.text()).toBe('50 characters remaining');
    });
});
