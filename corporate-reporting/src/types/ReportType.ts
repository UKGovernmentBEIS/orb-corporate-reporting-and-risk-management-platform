import { ICustomReportingEntityType } from "./CustomReportingEntityType";
import { Entity, IEntity } from "./Entity";

export interface IReportType extends IEntity {
    ReportingEntityTypes?: ICustomReportingEntityType[];
}

export class ReportType extends Entity implements IReportType {
}
