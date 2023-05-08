/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { ConfirmDialog, IConfirmDialogProps } from './ConfirmDialog';
import Dialog from 'office-ui-fabric-react/lib/Dialog';

configure({ adapter: new Adapter() });

describe('<ConfirmDialog />', () => {
    let reactComponent: ShallowWrapper<IConfirmDialogProps>;

    beforeEach(() => {
        reactComponent = shallow(
            <ConfirmDialog hidden={false} title="Test dialog" confirmButtonText="Confirm" handleConfirm={() => undefined} handleCancel={() => undefined} />
        );
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a dialog', () => {
        expect(reactComponent.find(Dialog)).toHaveLength(1);
    });
});
