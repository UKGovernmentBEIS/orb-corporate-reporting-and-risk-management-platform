/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrApprovalDetails, ICrApprovalDetailsProps } from './CrApprovalDetails';

configure({ adapter: new Adapter() });

describe('<CrApprovalDetails />', () => {
    let reactComponent: ShallowWrapper<ICrApprovalDetailsProps>;

    beforeEach(() => {
        reactComponent = shallow(<CrApprovalDetails approverName="" approvalDate={new Date(2018, 1, 21)} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render the approval details', () => {
        expect(reactComponent.find('p')).toHaveLength(1);
        expect(reactComponent.text()).toBe('Approved by [unknown] on 21/02/2018');
    });
});
