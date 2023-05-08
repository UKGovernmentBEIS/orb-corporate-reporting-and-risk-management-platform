/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { UpdateHeader, IUpdateHeaderProps, Due } from './UpdateHeader';
import { Icon } from 'office-ui-fabric-react/lib/Icon';
import { TooltipHost } from 'office-ui-fabric-react/lib/Tooltip';
import { UpdateHeaderTitle } from './UpdateHeaderTitle';

configure({ adapter: new Adapter() });

describe('<UpdateHeader />', () => {
    let reactComponent: ShallowWrapper<IUpdateHeaderProps>;

    beforeEach(() => {
        reactComponent = shallow(<UpdateHeader title="My test title" tags={['badge1']} rag={2} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render the header, an expand icon, a title, and a people icon', () => {
        expect(reactComponent.find('div.updateHeader')).toHaveLength(1);
        expect(reactComponent.find(Icon)).toHaveLength(2);
        expect(reactComponent.find(Icon).first().prop('iconName')).toBe('ChevronRight');
        expect(reactComponent.find(UpdateHeaderTitle)).toHaveLength(1);
        expect(reactComponent.find(Icon).last().prop('iconName')).toBe('People');
        expect(reactComponent.find(Due)).toHaveLength(0);
    });

    it('should render a collapse icon', () => {
        reactComponent.setProps({ isOpen: true });
        expect(reactComponent.find(Icon).first().prop('iconName')).toBe('ChevronDown');
    });

    it('should render a due date', () => {
        reactComponent.setProps({ dueDate: new Date(2018, 4, 9) });
        expect(reactComponent.find(Due)).toHaveLength(1);
    });

    it('should render a lead user', () => {
        reactComponent.setProps({ people: [{ role: 'Lead', names: ['John Smith'] }] });
        const peopleContent = reactComponent.find(TooltipHost).last().prop('content');
        expect(peopleContent).toHaveLength(1);
    });
});

describe('<Due />', () => {
    let reactComponent: ShallowWrapper<IUpdateHeaderProps>;

    beforeEach(() => {
        reactComponent = shallow(<Due dueDate={new Date(2018, 4, 9)} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a due date', () => {
        expect(reactComponent.text()).toBe('Due: 9 May 2018');
    });

    it('should render a due date provided as a string', () => {
        reactComponent.setProps({ dueDate: "09 June 2018" });
        expect(reactComponent.text()).toBe('Due: 09 June 2018');
    });
});
