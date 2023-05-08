import { Period } from "../refData/Period";
import { IBaseComponentProps } from "./BaseComponentProps";
import { IEntity } from "./Entity";
import { IReportDueDates } from "./ReportDueDates";

export interface IEntityProgressUpdateFormProps<E extends IEntity> extends IBaseComponentProps {
    entityId: number;
    entity?: E;
    reportPeriod?: Period;
    reportDates: IReportDueDates;
    entityUpdateId?: number;
    defaultShowForm?: boolean;
    onSaved?: () => void;
    onCancelled?: () => void;
    filters?: { text: string, dueBy: Date };
}
