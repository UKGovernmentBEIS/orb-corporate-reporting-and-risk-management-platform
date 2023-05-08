/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrReportingCycleMonthPicker, ICrReportingCycleMonthPickerProps } from './CrReportingCycleMonthPicker';
import { CrDropdown } from './CrDropdown';

configure({ adapter: new Adapter() });

describe('<CrReportingCycleMonthPicker />', () => {
    let reactComponent: ShallowWrapper<ICrReportingCycleMonthPickerProps>;

    beforeEach(() => {
        reactComponent = shallow(<CrReportingCycleMonthPicker frequency={2} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a crdropdown with 3 options', () => {
        expect(reactComponent.find(CrDropdown)).toHaveLength(1);
        expect(reactComponent.find(CrDropdown).prop('options')).toHaveLength(3);
    });

    it('should render a crdropdown with 6 options', () => {
        reactComponent.setProps({ frequency: 3 });
        expect(reactComponent.find(CrDropdown)).toHaveLength(1);
        expect(reactComponent.find(CrDropdown).prop('options')).toHaveLength(6);
    });

    it('should render a crdropdown with 12 options', () => {
        reactComponent.setProps({ frequency: 4 });
        expect(reactComponent.find(CrDropdown)).toHaveLength(1);
        expect(reactComponent.find(CrDropdown).prop('options')).toHaveLength(12);
    });
});
