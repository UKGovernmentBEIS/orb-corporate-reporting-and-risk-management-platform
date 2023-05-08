import { IReportingEntityWithDeliveryDates } from "../types";

export const currentDeliveryDate = (reportingEntity: IReportingEntityWithDeliveryDates): Date => reportingEntity?.ForecastDate || reportingEntity?.BaselineDate;