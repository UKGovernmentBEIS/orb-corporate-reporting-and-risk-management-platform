/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrEntityCompleteIcon } from './CrEntityCompleteIcon';
import { Icon } from 'office-ui-fabric-react/lib/Icon';

configure({ adapter: new Adapter() });

describe('<CrEntityCompleteIcon />', () => {
    let reactComponent: ShallowWrapper<{ title?: string }>;

    beforeEach(() => {
        reactComponent = shallow(<CrEntityCompleteIcon />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render an icon', () => {
        expect(reactComponent.find(Icon)).toHaveLength(1);
    });
});
