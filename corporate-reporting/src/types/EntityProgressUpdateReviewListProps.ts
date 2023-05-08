import { IEntity } from "./Entity";
import { IBaseComponentProps } from "./BaseComponentProps";
import { IReportDueDates } from "./ReportDueDates";
import { IListConfig } from "./ListConfig";

export interface IEntityProgressUpdateReviewListProps<T extends IEntity> extends IBaseComponentProps {
    entities: T[];
    previousEntities: T[];
    reportDates: IReportDueDates;
    readOnly?: boolean;
    onChange?: () => void;
    showPreviousUpdate?: boolean;
    listTitle?: string;
    listConfig?: IListConfig;
    progressUpdateFormTitle?: string;
}
