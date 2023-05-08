/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { AddNewEntityCommandBar, IAddNewEntityCommandBarProps } from './AddNewEntityCommandBar';
import { CrCommandBar } from './CrCommandBar';

configure({ adapter: new Adapter() });

describe('<AddNewEntityCommandBar />', () => {
    let reactComponent: ShallowWrapper<IAddNewEntityCommandBarProps>;

    beforeEach(() => {
        reactComponent = shallow(<AddNewEntityCommandBar onAdd={() => undefined} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a commandbar', () => {
        expect(reactComponent.find(CrCommandBar)).toHaveLength(1);
    });
});
