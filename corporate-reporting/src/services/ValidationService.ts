export class ValidationService {
    public static validSqlDecimal(num: number, decimalPrecision?: number, decimalScale?: number): boolean {
        if (num.toString().indexOf('.') !== -1) {
            const p = num.toString().split('.')[0];
            const s = num.toString().split('.')[1];
            if (p.length <= ((decimalPrecision || 18) - (decimalScale || 4)) && s.length <= (decimalScale || 4))
                return true;
            return false;
        } else {
            if (num.toString().length <= ((decimalPrecision || 18) - (decimalScale || 4)))
                return true;
            return false;
        }
    }
}
