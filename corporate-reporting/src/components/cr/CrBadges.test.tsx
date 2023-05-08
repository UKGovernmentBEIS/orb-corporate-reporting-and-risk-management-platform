/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrBadges } from './CrBadges';
import { CrBadge, ICrBadgeProps } from './CrBadge';

configure({ adapter: new Adapter() });

describe('<CrBadges />', () => {
    let reactComponent: ShallowWrapper<{ badges: ICrBadgeProps[] }>;

    beforeEach(() => {
        reactComponent = shallow(<CrBadges badges={[{ text: "Test badge 1" }, { text: "Test badge 2" }]} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render 2 badges', () => {
        expect(reactComponent.find(CrBadge)).toHaveLength(2);
    });
});
