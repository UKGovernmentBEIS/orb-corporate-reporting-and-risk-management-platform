export interface IProgressUpdateValidations {
    Valid: boolean;
    RagOptionID: string;
    Comment: string;
}

export interface IProgressUpdateWithDeliveryDatesValidations extends IProgressUpdateValidations {
    ForecastDate: string;
    ActualDate: string;
}

export class ProgressUpdateValidations implements IProgressUpdateValidations {
    public Valid = true;
    public RagOptionID = null;
    public Comment = null;
}

export class ProgressUpdateWithDeliveryDatesValidations extends ProgressUpdateValidations implements IProgressUpdateWithDeliveryDatesValidations {
    public ForecastDate = null;
    public ActualDate = null;
}