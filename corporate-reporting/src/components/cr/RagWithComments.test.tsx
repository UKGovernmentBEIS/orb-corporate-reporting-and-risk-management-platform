/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, ShallowWrapper } from "enzyme";

import { RagWithComments, IRagWithCommentsProps } from './RagWithComments';
import { RagPicker } from './RagPicker';
import { CrTextField } from './CrTextField';
import { CrLabel } from './CrLabel';

configure({ adapter: new Adapter() });

describe('<RagWithComments />', () => {
    let reactComponent: ShallowWrapper<IRagWithCommentsProps>;

    beforeEach(() => {
        reactComponent = shallow(
            <RagWithComments
                history={{ color: 2, comment: '' }}
                onColorChanged={id => id}
                onCommentChanged={value => value}
                commentsMaxLength={100} />
        );
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a RAG picker and a text field', () => {
        expect(reactComponent.find(RagPicker)).toHaveLength(1);
        expect(reactComponent.find(CrTextField)).toHaveLength(1);
    });

    it('should render a label when label value supplied', () => {
        expect(reactComponent.find(CrLabel)).toHaveLength(0);
        reactComponent.setProps({ label: 'test label' });
        expect(reactComponent.find(CrLabel)).toHaveLength(1);
    });
});
