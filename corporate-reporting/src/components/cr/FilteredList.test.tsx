/// <reference types="jest" />

import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { configure, mount, ReactWrapper } from "enzyme";

import { FilteredList, IFilteredListProps } from './FilteredList';
import { DetailsList, IColumn, IObjectWithKey } from 'office-ui-fabric-react/lib/DetailsList';
import { setIconOptions } from 'office-ui-fabric-react/lib/Styling';
import { ArrayService } from '../../services/ArrayService';

// Suppress icon warnings.
setIconOptions({ disableWarnings: true });

configure({ adapter: new Adapter() });

interface ITestItems extends IObjectWithKey {
    name: string; number: number; text: string;
}

describe('<FilteredList />', () => {
    let reactComponent: ReactWrapper<IFilteredListProps>;
    let testColumns: IColumn[], testItems: ITestItems[];

    beforeEach(() => {
        testColumns = [
            { key: '1', name: 'Column 1', fieldName: 'name', minWidth: 100 },
            { key: '2', name: 'Column 2', fieldName: 'number', minWidth: 50 }
        ];
        testItems = [
            { key: 1, name: 'Item 1', number: 32, text: 'yucca' },
            { key: 2, name: 'Item 2', number: 52, text: 'drawing' },
            { key: 3, name: 'Item 3', number: 98, text: 'possible' },
            { key: 4, name: 'Item 4', number: 36, text: 'assumption' },
            { key: 5, name: 'Item 5', number: 52, text: 'photocopy' },
            { key: 6, name: 'Item 6', number: null, text: null },
        ];
        reactComponent = mount(
            <FilteredList columns={testColumns} items={{ Timestamp: 1, Items: testItems }} />
        );
    });

    afterEach(() => {
        reactComponent.unmount();
    });

    it('should render a details list', () => {
        expect(reactComponent.find(DetailsList)).toHaveLength(1);
    });

    it('should update list items', () => {
        reactComponent.setProps({ items: { Timestamp: 2, Items: testItems.slice(0, 2) } });
        expect(reactComponent.state('FilteredItems')).toHaveLength(2);
    });

    it('should update columns', () => {
        reactComponent.setProps({ columns: [{ key: '1', name: 'Column 1 test', minWidth: 100 }] });
        expect(reactComponent.state('Columns')).toHaveLength(1);
    });

    it('should sort by clicked column of strings', () => {
        reactComponent.setProps({ columns: [...testColumns, { key: '3', name: 'Column 3', fieldName: 'text', minWidth: 100 }] });
        reactComponent.update();
        const columnHeader = reactComponent.find('div[role="columnheader"] span.ms-DetailsHeader-cellTitle').last();
        columnHeader.simulate('click');
        expect(reactComponent.state('FilteredItems')).toEqual(ArrayService.sortObjectArray(JSON.parse(JSON.stringify(testItems)), 'text', true));
    });

    it('should sort by clicked column of numbers', () => {
        const columnHeader = reactComponent.find('div[role="columnheader"] span.ms-DetailsHeader-cellTitle').last();
        columnHeader.simulate('click');
        expect(reactComponent.state('FilteredItems')).toEqual(ArrayService.sortObjectArray(JSON.parse(JSON.stringify(testItems)), 'number', true));
    });

    it('should sort reverse order by double-clicked column', () => {
        const columnHeader = reactComponent.find('div[role="columnheader"] span.ms-DetailsHeader-cellTitle').last();
        columnHeader.simulate('click');
        columnHeader.simulate('click');
        expect(reactComponent.state('FilteredItems')).toEqual(ArrayService.sortObjectArray(JSON.parse(JSON.stringify(testItems)), 'number', false));
    });

    it('should not sort by clicked column if property not on items', () => {
        reactComponent.setProps({ columns: [...testColumns, { key: '3', name: 'Column 3', fieldName: 'test', minWidth: 100 }] });
        reactComponent.update();
        const columnHeader = reactComponent.find('div[role="columnheader"] span.ms-DetailsHeader-cellTitle').last();
        columnHeader.simulate('click');
        expect(reactComponent.state('FilteredItems')).toEqual(testItems);
    });

    it('should not sort by clicked column if column fieldName not set', () => {
        reactComponent.setProps({ columns: [...testColumns, { key: '3', name: 'Column 3', minWidth: 100 }] });
        reactComponent.update();
        const columnHeader = reactComponent.find('div[role="columnheader"] span.ms-DetailsHeader-cellTitle').last();
        columnHeader.simulate('click');
        expect(reactComponent.state('FilteredItems')).toEqual(testItems);
    });
});
