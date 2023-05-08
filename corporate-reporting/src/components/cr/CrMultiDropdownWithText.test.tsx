/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, mount, ReactWrapper } from "enzyme";

import { CrMultiDropdownWithText, ICrMultiDropdownWithTextProps, ICrMultiDropdownWithTextValue } from './CrMultiDropdownWithText';
import { Dropdown } from 'office-ui-fabric-react/lib/Dropdown';
import { CrTextField } from './CrTextField';
import { setIconOptions } from 'office-ui-fabric-react/lib/Styling';

// Suppress icon warnings.
setIconOptions({ disableWarnings: true });

configure({ adapter: new Adapter() });

describe('<CrMultiDropdownWithText />', () => {
    let reactComponent: ReactWrapper<ICrMultiDropdownWithTextProps>;
    let defaultSelectedItems: ICrMultiDropdownWithTextValue[];

    beforeEach(() => {
        defaultSelectedItems = [
            { Key: 2, Text: "Test text for option 2" },
            { Key: 3, Text: "Test text for option 3" }
        ];
        reactComponent = mount(
            <CrMultiDropdownWithText
                options={[
                    { key: 1, text: 'Option 1', textRequired: false },
                    { key: 2, text: 'Option 2', textRequired: true },
                    { key: 3, text: 'Option 3', textRequired: false },
                    { key: 4, text: 'Option 4', textRequired: false }
                ]}
                selectedItems={defaultSelectedItems}
                onChange={value => defaultSelectedItems = value}
            />
        );
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a dropdown and a textfield for each selected option', () => {
        expect(reactComponent.find(Dropdown)).toHaveLength(1);
        expect(reactComponent.find(CrTextField)).toHaveLength(2);
    });

    it('should render a dropdown and a textfield for each selected option', () => {
        reactComponent.setProps({ selectedItems: [{ Key: 3, Text: "Test text for option 3" }] });
        expect(reactComponent.find(Dropdown)).toHaveLength(1);
        expect(reactComponent.find(CrTextField)).toHaveLength(1);
    });

    it('should push dropdown changes to props onChange when new item checked', () => {
        reactComponent.find('div.ms-Dropdown').simulate('click');
        const cb = reactComponent.find('input[type="checkbox"][checked=false]').first();
        cb.simulate('change', { target: { value: true } });
        expect(defaultSelectedItems.length).toBe(3);
    });

    it('should push dropdown changes to props onChange when selected item unchecked', () => {
        reactComponent.find('div.ms-Dropdown').simulate('click');
        const cb = reactComponent.find('input[type="checkbox"][checked=true]').first();
        cb.simulate('change', { target: { value: false } });
        expect(defaultSelectedItems.length).toBe(1);
    });

    it('should not push dropdown changes to props if no onChange provided', () => {
        reactComponent.setProps({ onChange: undefined });
        reactComponent.find('div.ms-Dropdown').simulate('click');
        const cb = reactComponent.find('input[type="checkbox"][checked=true]').first();
        cb.simulate('change', { target: { value: false } });
        expect(defaultSelectedItems.length).toBe(2);
    });

    it('should push text changes to props onChange', () => {
        const testTextChange = "changed text for test";
        reactComponent.find('input').first().simulate('change', { target: { value: testTextChange } });
        expect(defaultSelectedItems[0].Text).toBe(testTextChange);
    });

    it('should not push text changes to props if no onChange provided', () => {
        reactComponent.setProps({ onChange: undefined });
        const defaultText = defaultSelectedItems[0].Text;
        reactComponent.find('input').first().simulate('change', { target: { value: "changed text for test" } });
        expect(defaultSelectedItems[0].Text).toBe(defaultText);
    });
});
