/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { FormButtons, IFormButtonsProps } from './FormButtons';
import { DefaultButton, PrimaryButton } from 'office-ui-fabric-react/lib/Button';
import { SaveIndicator } from './SaveIndicator';

configure({ adapter: new Adapter() });

describe('<FormButtons />', () => {
    let reactComponent: ShallowWrapper<IFormButtonsProps>;

    beforeEach(() => {
        reactComponent = shallow(<FormButtons onPrimaryClick={() => undefined} onSecondaryClick={() => undefined} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a primary button, a default button and a save indicator', () => {
        expect(reactComponent.find(PrimaryButton)).toHaveLength(1);
        expect(reactComponent.find(DefaultButton)).toHaveLength(1);
        expect(reactComponent.find(SaveIndicator)).toHaveLength(1);
    });
});
