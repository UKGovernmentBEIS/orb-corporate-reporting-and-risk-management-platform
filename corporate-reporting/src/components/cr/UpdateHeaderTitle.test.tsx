/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { UpdateHeaderTitle, IUpdateHeaderTitleProps } from './UpdateHeaderTitle';
import { CrBadges } from './CrBadges';

configure({ adapter: new Adapter() });

describe('<UpdateHeaderTitle />', () => {
    let reactComponent: ShallowWrapper<IUpdateHeaderTitleProps>;

    beforeEach(() => {
        reactComponent = shallow(<UpdateHeaderTitle title="My test title" tags={['badge1']} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render the header title and badges', () => {
        expect(reactComponent.text()).toContain('My test title');
        expect(reactComponent.find(CrBadges)).toHaveLength(1);
    });
});
