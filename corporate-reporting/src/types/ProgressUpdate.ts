import { IEntity, Entity } from "./Entity";
import { IUser } from "./User";

export interface IProgressUpdate extends IEntity {
    UpdatePeriod?: Date;
    UpdateDate: Date;
    UpdateUserID: number;
    RagOptionID: number;
    Comment: string;
    ToBeClosed: boolean;
    UpdateUser?: IUser;
}

export interface IProgressUpdateWithDeliveryDates extends IProgressUpdate {
    ForecastDate: Date;
    ActualDate: Date;
}

export class ProgressUpdate extends Entity implements IProgressUpdate {
    public UpdatePeriod = null;
    public UpdateDate = null;
    public UpdateUserID = null;
    public RagOptionID = null;
    public Comment = '';
    public ToBeClosed = null;

    constructor(period: Date) {
        super();
        this.UpdatePeriod = period;
    }
}

export class ProgressUpdateWithDeliveryDates extends ProgressUpdate implements IProgressUpdateWithDeliveryDates {
    public ForecastDate = null;
    public ActualDate = null;
}
