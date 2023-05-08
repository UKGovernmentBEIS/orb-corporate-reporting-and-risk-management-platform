/// <reference types="jest" />

import React from 'react';
import ReactDOM from 'react-dom';
import ReactTestUtils from 'react-dom/test-utils';
import Adapter from 'enzyme-adapter-react-16';
import { configure, mount, ReactWrapper } from "enzyme";

import { CrUserPicker, ICrUserPickerProps } from './CrUserPicker';
import { TagPicker, TagItem, Suggestions } from 'office-ui-fabric-react/lib/Pickers';
import { FieldErrorMessage } from './FieldDecorators';
import { Label } from 'office-ui-fabric-react/lib/Label';
import { IUser } from '../../types';
import { setIconOptions } from 'office-ui-fabric-react/lib/Styling';
import { IconButton } from 'office-ui-fabric-react/lib/Button';
import { EntityStatus } from '../../refData/EntityStatus';

setIconOptions({ disableWarnings: true });

configure({ adapter: new Adapter() });

describe('<CrUserPicker />', () => {
    let root: HTMLDivElement;
    let reactComponent: ReactWrapper<ICrUserPickerProps>;
    const testUsers: IUser[] = [
        { ID: 1, Title: 'John Smith', Username: 'js@beis.gov.uk', EmailAddress: 'js@beis.gov.uk', EntityStatusID: EntityStatus.Open, EntityStatusDate: new Date(2020, 10, 11) },
        { ID: 2, Title: 'Bob Jones', Username: 'bj@beis.gov.uk', EmailAddress: 'bj@beis.gov.uk', EntityStatusID: EntityStatus.Open, EntityStatusDate: new Date(2020, 10, 11) },
        { ID: 3, Title: 'Jane Brown', Username: 'jb@beis.gov.uk', EmailAddress: 'jb@beis.gov.uk', EntityStatusID: EntityStatus.Open, EntityStatusDate: new Date(2020, 10, 11) }
    ];
    let users: IUser[], selectedUsers: number[];

    beforeEach(() => {
        root = document.createElement('div');
        users = JSON.parse(JSON.stringify(testUsers));
        selectedUsers = [2];
        reactComponent = mount(
            <CrUserPicker users={users} selectedUsers={selectedUsers} onChange={u => selectedUsers = u} />
        );
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a tagpicker', () => {
        expect(reactComponent.find(TagPicker)).toHaveLength(1);
    });

    it('should render a label when supplied', () => {
        reactComponent.setProps({ label: 'Test label' });
        expect(reactComponent.find(Label)).toHaveLength(1);
    });

    it('should render an error message when supplied', () => {
        reactComponent.setProps({ errorMessage: 'Test error message' });
        expect(reactComponent.find(FieldErrorMessage)).toHaveLength(1);
    });

    it('should handle null selected users', () => {
        reactComponent.setProps({ selectedUsers: null });
        expect(reactComponent.find(TagItem)).toHaveLength(0);
    });

    it('should handle selected user not in users', () => {
        reactComponent.setProps({ selectedUsers: [4] });
        reactComponent.update();
        expect(reactComponent.find(TagItem)).toHaveLength(0);
    });

    it('should show suggestions', () => {
        reactComponent = mount(
            <CrUserPicker users={users} selectedUsers={[]} onChange={u => selectedUsers = u} initialSuggestions={[users[1]]} initialSuggestionsHeaderText="Project users" />
        );
        const tb = reactComponent.find('input').first();
        tb.simulate('focus');
        expect(reactComponent.find(Suggestions)).toHaveLength(1);
    });

    it('should clear selected users when removed', () => {
        const removeButton = reactComponent.find(IconButton);
        removeButton.simulate('click');
        expect(selectedUsers).toHaveLength(0);
    });

    it('should resolve and change users when text is typed', () => {
        jest.useFakeTimers();
        document.body.appendChild(root);

        ReactDOM.render(
            <CrUserPicker users={users} selectedUsers={[]} onChange={u => selectedUsers = u} />,
            root,
        );

        const input = document.querySelector('.ms-BasePicker-input') as HTMLInputElement;
        input.focus();
        input.value = 'joh';
        ReactTestUtils.Simulate.input(input);
        jest.runAllTimers();

        const suggestionOptions = document.querySelectorAll('.ms-Suggestions-itemButton');
        expect(suggestionOptions.length).toEqual(1);
        ReactTestUtils.Simulate.click(suggestionOptions[0]);

        expect(selectedUsers).toHaveLength(1);
    });

    it('should not error on resolving empty filter text', () => {
        jest.useFakeTimers();
        document.body.appendChild(root);

        ReactDOM.render(
            <CrUserPicker users={users} selectedUsers={[]} onChange={u => selectedUsers = u} />,
            root,
        );

        const input = document.querySelector('.ms-BasePicker-input') as HTMLInputElement;
        input.focus();
        input.value = '';
        ReactTestUtils.Simulate.input(input);
        jest.runAllTimers();

        const suggestionOptions = document.querySelectorAll('.ms-Suggestions-itemButton');
        expect(suggestionOptions.length).toEqual(0);
    });
});
