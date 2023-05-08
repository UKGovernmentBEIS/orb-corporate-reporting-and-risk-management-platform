export interface IEntityValidations {
    Valid: boolean;
    Title: string;
}

export class EntityValidations implements IEntityValidations {
    public Valid = true;
    public Title = null;
}
