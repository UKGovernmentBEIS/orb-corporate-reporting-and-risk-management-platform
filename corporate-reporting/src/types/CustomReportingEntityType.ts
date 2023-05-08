import { ICustomReportingEntity } from "./CustomReportingEntity";
import { IReportingField } from "./CustomReportingField";
import { Entity, IEntity } from "./Entity";
import { IReportType } from "./ReportType";

export interface ICustomReportingEntityType extends IEntity {
    ReportTypeID: number;
    InheritReportSchedule: boolean;
    IsHeadlineSection: boolean;
    UpdateHasRag: boolean;
    UpdateRagIsRequired: boolean;
    UpdateHasNarrative: boolean;
    UpdateNarrativeIsRequired: boolean;
    UpdateNarrativeMaxChars: number;
    UpdateHasDeliveryDates: boolean;
    UpdateDeliveryDatesIsRequired: boolean;
    HasUpperAndLowerTargets: boolean;
    UpdateHasMeasurement: boolean;
    UpdateMeasurementIsRequired: boolean;
    CustomFields: IReportingField[];

    ReportType?: IReportType;
    ReportingEntities?: ICustomReportingEntity[];
}

export class CustomReportingEntityType extends Entity implements ICustomReportingEntityType {
    public ReportTypeID = null;
    public InheritReportSchedule = false;
    public IsHeadlineSection = false;
    public UpdateHasRag = false;
    public UpdateRagIsRequired = false;
    public UpdateHasNarrative = false;
    public UpdateNarrativeIsRequired = false;
    public UpdateNarrativeMaxChars = 500;
    public UpdateHasDeliveryDates = false;
    public UpdateDeliveryDatesIsRequired = false;
    public HasUpperAndLowerTargets = false;
    public UpdateHasMeasurement = false;
    public UpdateMeasurementIsRequired = false;
    public CustomFields: IReportingField[] = [];
}
