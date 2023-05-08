/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, mount, ReactWrapper } from "enzyme";

import { RagPicker, IRagPickerProps } from './RagPicker';
import { SwatchColorPicker } from 'office-ui-fabric-react/lib/SwatchColorPicker';
import { setIconOptions } from 'office-ui-fabric-react/lib/Styling';

// Suppress icon warnings.
setIconOptions({ disableWarnings: true });

// Mock document object for SwatchColorPicker hack
Object.defineProperty(document, 'querySelectorAll', {
    value: () => {
        const doc = document.createElement('template');
        doc.innerHTML = `<div />`;
        return doc.content.childNodes;
    }
});

configure({ adapter: new Adapter() });

describe('<RagPicker />', () => {
    let reactComponent: ReactWrapper<IRagPickerProps>;
    let selectedRag: number;

    beforeEach(() => {
        selectedRag = 2;
        reactComponent = mount(
            <RagPicker
                label="Test RAG picker"
                required={true}
                selectedRAG={selectedRag}
                onColorChanged={id => selectedRag = id}
                errorMessage="Test error message" />
        );
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a RAG picker', () => {
        expect(reactComponent.find(SwatchColorPicker)).toHaveLength(1);
    });

    it('should render a RAG picker with history', () => {
        reactComponent.setProps({ history: 4 });
        expect(reactComponent.find(SwatchColorPicker)).toHaveLength(2);
    });

    it('should change selected RAG colour', () => {
        reactComponent.find('button').first().simulate('click');
        expect(selectedRag).toBe(1);
    });

    it('should not change selected RAG colour if no callback provided', () => {
        reactComponent.setProps({ onColorChanged: null });
        reactComponent.find('button').first().simulate('click');
        expect(selectedRag).toBe(2);
    });
});
