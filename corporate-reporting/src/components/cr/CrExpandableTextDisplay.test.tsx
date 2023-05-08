/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { CrExpandableTextDisplay, ICrExpandableTextDisplayProps } from './CrExpandableTextDisplay';
import { Link } from 'office-ui-fabric-react/lib/Link';

configure({ adapter: new Adapter() });

describe('<CrExpandableTextDisplay />', () => {
    let reactComponent: ShallowWrapper<ICrExpandableTextDisplayProps>;
    const shortText = `Test text for expandable display`;
    const longText = `Video provides a powerful way to help you prove your point. 
    When you click Online Video, you can paste in the embed code for the video you want to add. 
    You can also type a keyword to search online for the video that best fits your document.`;

    beforeEach(() => {
        reactComponent = shallow(<CrExpandableTextDisplay text={shortText} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render some divs', () => {
        expect(reactComponent.find('div').length).toBeGreaterThan(0);
    });

    it('should render [Missing] when no text is provided', () => {
        reactComponent.setProps({ text: null });
        expect(reactComponent.text()).toContain('[Missing]');
    });

    it('should render a h3 when largeLabel is set', () => {
        reactComponent.setProps({ label: 'Test label', largeLabel: true });
        expect(reactComponent.find('h3')).toHaveLength(1);
    });

    it('should render a link when text content is > 100 characters', () => {
        reactComponent.setProps({ text: longText });
        expect(reactComponent.text()).not.toContain(longText);
        expect(reactComponent.text()).toContain(longText.slice(0, 101));
        expect(reactComponent.find(Link)).toHaveLength(1);
    });

    it('should expand when link is clicked', () => {
        reactComponent.setProps({ text: longText });
        reactComponent.find(Link).simulate('click');
        expect(reactComponent.text()).toContain(longText);
    });
});
