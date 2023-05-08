/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { UpdateSectionHeader, IUpdateSectionHeaderProps } from './UpdateSectionHeader';
import { Icon } from 'office-ui-fabric-react/lib/Icon';
import { CrBadge } from './CrBadge';

configure({ adapter: new Adapter() });

describe('<UpdateSectionHeader />', () => {
    let reactComponent: ShallowWrapper<IUpdateSectionHeaderProps>;

    beforeEach(() => {
        reactComponent = shallow(<UpdateSectionHeader title="My test title" numberOfItems={2} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render the title and an expand icon', () => {
        expect(reactComponent.find('div')).toHaveLength(2);
        expect(reactComponent.find(Icon)).toHaveLength(1);
        expect(reactComponent.find(Icon).prop('iconName')).toBe('ChevronRight');
        expect(reactComponent.find(CrBadge).prop('description')).toBe('There are 2 items in this section');
    });

    it('should render a collapse icon', () => {
        reactComponent.setProps({ isOpen: true });
        expect(reactComponent.find(Icon).prop('iconName')).toBe('ChevronDown');
    });

    it('should render different text for 1 item', () => {
        reactComponent.setProps({ numberOfItems: 1 });
        expect(reactComponent.find(CrBadge).prop('description')).toBe('There is 1 item in this section');
    });

    it('should render different text for 0 items', () => {
        reactComponent.setProps({ numberOfItems: 0 });
        expect(reactComponent.find(CrBadge).prop('description')).toBe('There are no items in this section');
    });
});
