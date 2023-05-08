/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrReviewListHistory, ICrReviewListHistoryProps } from './CrReviewListHistory';

configure({ adapter: new Adapter() });

describe('<CrReviewListHistory />', () => {
    let reactComponent: ShallowWrapper<ICrReviewListHistoryProps>;
    const historyText = "Test history text";

    beforeEach(() => {
        reactComponent = shallow(<CrReviewListHistory value={historyText} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render some divs', () => {
        expect(reactComponent.find('div')).toHaveLength(4);
        expect(reactComponent.text()).toContain('Last reporting period:');
        expect(reactComponent.text()).toContain(historyText);
    });
});
