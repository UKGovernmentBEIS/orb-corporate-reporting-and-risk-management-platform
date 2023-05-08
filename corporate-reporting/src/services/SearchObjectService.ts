import { IObjectWithKey } from "office-ui-fabric-react";

export class SearchObjectService {
	//#region From AngularJS
	private static comparator(obj: unknown, text: string): boolean {
		if (obj && text && typeof obj === 'object' && typeof text === 'object') {
			for (const objKey in obj) {
				if (objKey.charAt(0) !== '$' && Object.prototype.hasOwnProperty.call(obj, objKey) &&
					this.comparator(obj[objKey], text[objKey])) {
					return true;
				}
			}
			return false;
		}
		text = ('' + text).toLowerCase();
		return ('' + obj).toLowerCase().indexOf(text) > -1;
	}
	public static search(obj: unknown, text: string): boolean {
		if (typeof text == 'string' && text.charAt(0) === '!') {
			return !SearchObjectService.search(obj, text.substr(1));
		}
		switch (typeof obj) {
			case "boolean":
			case "number":
			case "string":
				return SearchObjectService.comparator(obj, text);
			case "object":
				switch (typeof text) {
					case "object":
						return SearchObjectService.comparator(obj, text);
					default:
						for (const objKey in obj) {
							if (objKey.charAt(0) !== '$' && SearchObjectService.search(obj[objKey], text)) {
								return true;
							}
						}
						break;
				}
				return false;
			default:
				return false;
		}
	}
	//#endregion

	public static filterEntities(entities: IObjectWithKey[], filterText?: string): IObjectWithKey[] {
		if (filterText === undefined || filterText === null || filterText === '')
			return entities;
		return entities.filter((e) => {
			return SearchObjectService.search(e, filterText);
		});
	}
}