/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { MessageDialog, IMessageDialogProps } from './MessageDialog';
import { Dialog } from 'office-ui-fabric-react/lib/Dialog';

configure({ adapter: new Adapter() });

describe('<MessageDialog />', () => {
    let reactComponent: ShallowWrapper<IMessageDialogProps>;

    beforeEach(() => {
        reactComponent = shallow(<MessageDialog hidden={false} title="Confirm" handleOk={() => undefined} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a dialog', () => {
        expect(reactComponent.find(Dialog)).toHaveLength(1);
    });
});
