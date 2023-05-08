/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrLoadingOverlay, ICrLoadingOverlayProps } from './CrLoadingOverlay';
import { Overlay } from 'office-ui-fabric-react/lib/Overlay';
import { Spinner } from 'office-ui-fabric-react/lib/Spinner';

configure({ adapter: new Adapter() });

describe('<CrLoadingOverlay />', () => {
    let reactComponent: ShallowWrapper<ICrLoadingOverlayProps>;

    beforeEach(() => {
        reactComponent = shallow(<CrLoadingOverlay isLoading={true} opaque={false} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a loading animation', () => {
        expect(reactComponent.find(Overlay)).toHaveLength(1);
        expect(reactComponent.find(Spinner)).toHaveLength(1);
    });

    it('should hide the loading animation when isLoading is false', () => {
        reactComponent.setProps({ isLoading: false });
        expect(reactComponent.find(Overlay)).toHaveLength(0);
        expect(reactComponent.find(Spinner)).toHaveLength(0);
    });

    it('should not be transparent if opaque is specified', () => {
        reactComponent.setProps({ opaque: true });
        expect(reactComponent.find('.opaque')).toHaveLength(1);
        expect(reactComponent.find(Overlay)).toHaveLength(1);
        expect(reactComponent.find(Spinner)).toHaveLength(1);
    });
});
