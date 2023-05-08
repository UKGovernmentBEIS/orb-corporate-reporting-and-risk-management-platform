/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrBadge, ICrBadgeProps } from './CrBadge';

configure({ adapter: new Adapter() });

describe('<CrBadge />', () => {
    let reactComponent: ShallowWrapper<ICrBadgeProps>;

    beforeEach(() => {
        reactComponent = shallow(<CrBadge text="Test badge" />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render the badge', () => {
        expect(reactComponent.find('span.badge')).toHaveLength(1);
    });

    it('should render the badge with description', () => {
        const testDescription = 'This is a test badge';
        reactComponent.setProps({ description: testDescription });
        expect(reactComponent.find('span.badge').prop('title')).toBe(testDescription);
    });

    it('should render the badge with description', () => {
        reactComponent = shallow(<CrBadge><span>Test badge with children</span></CrBadge>);
        expect(reactComponent.find('span')).toHaveLength(2);
        expect(reactComponent.text()).toBe('Test badge with children');
    });
});
