export class ArrayService {
    public static sortObjectArray = (items: unknown[], sortBy: string, descending: boolean): unknown[] => {
        return items.sort((a, b) => {
            if (!Object.prototype.hasOwnProperty.call(a, sortBy) || !Object.prototype.hasOwnProperty.call(b, sortBy)) {
                // property doesn't exist on either object
                return 0;
            }
            const multiplier = descending ? -1 : 1;
            const varA = (typeof a[sortBy] === 'string') ? a[sortBy].toLowerCase() : a[sortBy];
            const varB = (typeof b[sortBy] === 'string') ? b[sortBy].toLowerCase() : b[sortBy];

            let comparison = 0;
            if (varA === varB)
                comparison = 0;
            else if (varA == null || varA === '')
                comparison = 1;
            else if (varB == null || varB === '')
                comparison = -1;
            else
                comparison = varA.toString().localeCompare(varB.toString()) * multiplier;

            return comparison;
        });
    }
}
