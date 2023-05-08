export class RiskRagService {
    public static calculateRiskRag(riskImpactLevelID: number, riskProbabilityID: number): number {
        if (riskImpactLevelID && riskProbabilityID) {
            switch (riskImpactLevelID.toString() + riskProbabilityID) {
                case '15':
                case '14':
                case '13':
                case '22':
                case '12':
                case '41':
                case '31':
                case '21':
                case '11':
                case '610':
                case '69':
                case '68':
                case '77':
                case '67':
                case '96':
                case '86':
                case '76':
                case '66':
                    return 5; // G
                case '25':
                case '24':
                case '23':
                case '32':
                case '710':
                case '79':
                case '78':
                case '87':                    
                    return 4; // AG
                case '35':
                case '34':
                case '43':
                case '33':
                case '52':
                case '42':
                case '51':
                case '810':
                case '89':
                case '98':
                case '88':
                case '107':
                case '97':
                case '106':  
                    return 2; // AR
               case '55':
                case '45':
                case '54':
                case '44':
                case '53':
                case '1010':
                case '910':
                case '109':
                case '99':
                case '108':
                    return 1; // R
            }
        }
        return null;
    }
}