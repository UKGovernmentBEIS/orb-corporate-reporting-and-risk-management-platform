import { format, formatDistanceToNow, parse } from 'date-fns';

export class DateService {

	public static ukDateFormat = 'dd/MM/yyyy'; // For date-fns formatting
	public static ukLongDateFormat = 'd MMMM yyyy'; // For date-fns formatting
	public static ukTimeFormat = 'HH:mm'; // For date-fns formatting
	public static ukDateTimeFormat = 'dd/MM/yyyy HH:mm'; // For date-fns formatting
	public static isDateString = new RegExp(/^[0-9]{4}-[01][0-9]-[0-3][0-9]T[0-2][0-9]:[0-5][0-9]:[0-5][0-9](\.[0-9]{1,7})?[+-]?([01][0-9]:[0-5][0-9])?Z?$/);
	public static monthNameFormat = 'MMMM yyyy'; // For date-fns formatting
	public static timestamp(): number { return (new Date()).getTime(); }

	public static parseUkDate(value: string): Date {
		return parse(value, DateService.ukDateFormat, new Date());
	}

	public static setLocaleDateToUTC(d: Date): Date {
		return new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate(), 0, 0, 0));
	}

	public static dateToUkDate(d: Date): string {
		return d instanceof Date ? format(d, DateService.ukDateFormat) : '';
	}

	public static dateToUkDateTime(d: Date): string {
		return d instanceof Date ? format(d, DateService.ukDateTimeFormat) : '';
	}

	public static dateToUkLongDate(d: Date): string {
		return d instanceof Date ? format(d, DateService.ukLongDateFormat) : '';
	}

	public static dateToUkTime(d: Date): string {
		return d instanceof Date ? format(d, DateService.ukTimeFormat) : '';
	}

	public static dateToMonthNameFormat(d: Date): string {
		return d instanceof Date ? format(d, DateService.monthNameFormat) : '';
	}

	public static lastDateOfMonth = (d: Date): Date => {
		return d instanceof Date ? new Date(Date.UTC(d.getUTCFullYear(), d.getMonth() + 1, 0)) : null;
	}

	public static convertODataDates(dataObject: unknown): unknown {
		DateService.convertObjectDates(dataObject);
		return dataObject;
	}

	private static convertObjectDates(dataObject: unknown): void {
		if (dataObject) {
			Object.keys(dataObject).forEach(key => {
				if (typeof dataObject[key] === 'object') {
					DateService.convertObjectDates(dataObject[key]);
				}
				else if (DateService.isDateString.test(dataObject[key])) {
					dataObject[key] = new Date(dataObject[key]);
				}
			});
		}
	}

	public static relativeToNow = (d: Date): string => {
		return d instanceof Date ? formatDistanceToNow(d) : ``;
	}
}