/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrLastEdit, ICrLastEditProps } from './CrLastEdit';

configure({ adapter: new Adapter() });

describe('<CrLastEdit />', () => {
    let reactComponent: ShallowWrapper<ICrLastEditProps>;

    beforeEach(() => {
        reactComponent = shallow(<CrLastEdit author="John Smith" editDate={new Date(2018, 5, 5, 15, 47)} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render the last edit details', () => {
        expect(reactComponent.find('div')).toHaveLength(1);
        expect(reactComponent.text()).toBe('Last edited by John Smith at 15:47 on 05/06/2018');
    });
});
