/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { SaveIndicator, ISaveIndicatorProps } from './SaveIndicator';
import { SaveStatus } from '../../types/SaveStatus';
import { Spinner } from 'office-ui-fabric-react/lib/Spinner';
import { Icon } from 'office-ui-fabric-react/lib/Icon';
import { setIconOptions } from 'office-ui-fabric-react/lib/Styling';

// Suppress icon warnings.
setIconOptions({ disableWarnings: true });

configure({ adapter: new Adapter() });

describe('<SaveIndicator />', () => {
    let reactComponent: ShallowWrapper<ISaveIndicatorProps>;

    beforeEach(() => {
        reactComponent = shallow(<SaveIndicator saveStatus={SaveStatus.None} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render an empty div', () => {
        reactComponent.setProps({ timeout: 1 });
        expect(reactComponent.find(`*`)).toHaveLength(1);
    });

    it('should render a spinner while saving', () => {
        reactComponent.setProps({ saveStatus: SaveStatus.Pending });

        expect(reactComponent.find(Spinner)).toHaveLength(1);
        expect(reactComponent.text()).toContain(`Saving...`);
    });

    it('should render a checkmark when saved', () => {
        reactComponent.setProps({ saveStatus: SaveStatus.Pending });
        reactComponent.setProps({ saveStatus: SaveStatus.Success });

        const icon = reactComponent.find(Icon);
        expect(icon.prop(`iconName`)).toBe(`Accept`);
        expect(reactComponent.text()).toContain(`Saved`);
    });

    it('should render a warning when save failed', () => {
        reactComponent.setProps({ saveStatus: SaveStatus.Pending });
        reactComponent.setProps({ saveStatus: SaveStatus.Error });

        const icon = reactComponent.find(Icon);
        expect(icon.prop(`iconName`)).toBe(`Error`);
        expect(reactComponent.text()).toContain(`Error`);
    });

    it('should clear a saved status after 2 seconds', () => {
        jest.useFakeTimers();
        reactComponent.setProps({ saveStatus: SaveStatus.Pending });
        reactComponent.setProps({ saveStatus: SaveStatus.Success });
        const icon = reactComponent.find(Icon);
        expect(icon.prop(`iconName`)).toBe(`Accept`);
        expect(reactComponent.text()).toContain(`Saved`);
        jest.advanceTimersByTime(2000);
        expect(reactComponent.find(`*`)).toHaveLength(1);
    });
});
