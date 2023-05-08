/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { FormCommandBar, IFormCommandBarProps } from './FormCommandBar';
import { CrCommandBar } from './CrCommandBar';

configure({ adapter: new Adapter() });

describe('<FormCommandBar />', () => {
    let reactComponent: ShallowWrapper<IFormCommandBarProps>;

    beforeEach(() => {
        reactComponent = shallow(<FormCommandBar onSave={() => undefined} onCancel={() => undefined} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a command bar', () => {
        expect(reactComponent.find(CrCommandBar)).toHaveLength(1);
    });
});
