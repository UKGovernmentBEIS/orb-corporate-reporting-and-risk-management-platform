/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrEntityPicker, ICrEntityPickerProps } from './CrEntityPicker';
import { TagPicker } from 'office-ui-fabric-react/lib/Pickers';

configure({ adapter: new Adapter() });

describe('<CrEntityPicker />', () => {
    let reactComponent: ShallowWrapper<ICrEntityPickerProps>;

    beforeEach(() => {
        reactComponent = shallow(<CrEntityPicker entities={[]} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a tagpicker', () => {
        expect(reactComponent.find(TagPicker)).toHaveLength(1);
    });
});
