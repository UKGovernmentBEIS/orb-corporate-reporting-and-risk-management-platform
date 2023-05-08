export interface IEntity {
    ID: number;
    Title: string;
    Description?: string;
}

export class Entity implements IEntity {
    public ID = 0;
    public Title = '';
}