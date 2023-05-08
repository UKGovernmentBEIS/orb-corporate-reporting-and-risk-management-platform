export class NumberService {
    // Returns true if input is null or undefined. Useful for numbers because 0 is falsy.
    public static IsNullOrUndefined = (value: number | string): boolean => value == null;

    public static ToNumberOrNull = (value: number | string): number =>
        value == null || value === '' || isNaN(Number(value)) ? null : Number(value)

    public static FromNumberOrNull = (value: number | string): string =>
        value == null ? '' : value.toString()
}