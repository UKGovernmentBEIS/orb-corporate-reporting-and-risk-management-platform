/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrReportingCyclePicker, ICrReportingCyclePickerProps } from './CrReportingCyclePicker';
import { ChoiceGroup } from 'office-ui-fabric-react/lib/ChoiceGroup';
import { ReportingFrequency } from '../../refData/ReportingFrequency';
import { IReportingCycle } from '../../types';

configure({ adapter: new Adapter() });

describe('<CrReportingCyclePicker />', () => {
    let reactComponent: ShallowWrapper<ICrReportingCyclePickerProps>;
    let selectedCycle: IReportingCycle;

    beforeEach(() => {
        selectedCycle = { frequency: ReportingFrequency.Quarterly, dueDay: null, startDate: new Date(2021, 0, 4) };
        reactComponent = shallow(
            <CrReportingCyclePicker
                cycle={selectedCycle}
                onChange={cycle => selectedCycle = cycle}
            />
        );
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should not render a choicegroup', () => {
        expect(reactComponent.find(ChoiceGroup)).toHaveLength(0);
    });
});
