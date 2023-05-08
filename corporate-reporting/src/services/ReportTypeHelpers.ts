import { ReportTypes } from "../refData/ReportTypes";

export const GetReportTypeName = (reportTypeId: number): string => {
    if (reportTypeId === ReportTypes.Directorate) {
        return 'Directorate';
    }
    if (reportTypeId === ReportTypes.Project) {
        return 'Project';
    }
    if (reportTypeId === ReportTypes.PartnerOrganisation) {
        return 'Partner organisation';
    }
    return '';
};