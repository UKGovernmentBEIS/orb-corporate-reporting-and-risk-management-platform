/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { RagIndicator, IRagIndicatorProps } from './RagIndicator';

configure({ adapter: new Adapter() });

describe('<RagIndicator />', () => {
    let reactComponent: ShallowWrapper<IRagIndicatorProps>;

    beforeEach(() => {
        reactComponent = shallow(<RagIndicator rag={1} />);
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a red RAG indicator', () => {
        expect(reactComponent.find('div.ragIndicator')).toHaveLength(1);
        expect(reactComponent.find('div.indicator.red')).toHaveLength(1);
    });

    it('should render an amber red RAG indicator', () => {
        reactComponent.setProps({ rag: 2 });
        expect(reactComponent.find('div.indicator.amberRed')).toHaveLength(1);
    });

    it('should render an amber RAG indicator', () => {
        reactComponent.setProps({ rag: 3 });
        expect(reactComponent.find('div.indicator.amber')).toHaveLength(1);
    });

    it('should render an amber green RAG indicator', () => {
        reactComponent.setProps({ rag: 4 });
        expect(reactComponent.find('div.indicator.amberGreen')).toHaveLength(1);
    });

    it('should render a green RAG indicator', () => {
        reactComponent.setProps({ rag: 5 });
        expect(reactComponent.find('div.indicator.green')).toHaveLength(1);
    });

    it('should render a grey RAG indicator', () => {
        reactComponent.setProps({ rag: null });
        expect(reactComponent.find('div.indicator.grey')).toHaveLength(1);
    });
});
