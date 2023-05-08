/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrBreadcrumb, ICrBreadcrumbProps } from './CrBreadcrumb';
import { Icon } from 'office-ui-fabric-react/lib/Icon';

configure({ adapter: new Adapter() });

describe('<CrBreadcrumb />', () => {
    let reactComponent: ShallowWrapper<ICrBreadcrumbProps>;

    beforeEach(() => {
        reactComponent = shallow(<CrBreadcrumb items={['Parent', 'Child']} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a breadcrumb list', () => {
        expect(reactComponent.find('ol')).toHaveLength(1);
        expect(reactComponent.find('li')).toHaveLength(2);
        expect(reactComponent.find(Icon)).toHaveLength(1);
    });
});
