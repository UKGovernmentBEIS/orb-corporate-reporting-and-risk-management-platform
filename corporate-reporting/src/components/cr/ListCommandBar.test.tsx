/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, mount, ReactWrapper } from "enzyme";

import { ListCommandBar, IListCommandBarProps } from './ListCommandBar';
import { CommandBar } from 'office-ui-fabric-react/lib/CommandBar';
import { setIconOptions } from 'office-ui-fabric-react/lib/Styling';

// Suppress icon warnings.
setIconOptions({ disableWarnings: true });

configure({ adapter: new Adapter() });

describe('<ListCommandBar />', () => {
    let reactComponent: ReactWrapper<IListCommandBarProps>;

    beforeEach(() => {
        reactComponent = mount(<ListCommandBar onAdd={() => undefined} onEdit={() => undefined} onDelete={() => undefined} onFilterChange={() => undefined} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a command bar with new, edit and delete buttons', () => {
        expect(reactComponent.find(CommandBar)).toHaveLength(1);
        expect(reactComponent.find(CommandBar).prop('items')).toHaveLength(3);
    });

    it('should render a command bar with new button', () => {
        reactComponent.setProps({ editDisabled: true, deleteDisabled: true });
        expect(reactComponent.find(CommandBar).prop('items')).toHaveLength(1);
    });

    it('should render a command bar with add child button', () => {
        reactComponent.setProps({ onAddChild: () => undefined, addChildName: 'Sub-entity' });
        expect(reactComponent.find(CommandBar).prop('items')).toHaveLength(4);
    });
});
