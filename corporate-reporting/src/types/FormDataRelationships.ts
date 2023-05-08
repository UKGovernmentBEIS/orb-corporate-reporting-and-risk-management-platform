import { IEntityService } from "../services";

export interface IFormDataChildEntities {
    ObjectParentProperty: string;
    ParentIdProperty: string;
    ChildIdProperty: string;
    ChildService: IEntityService<unknown>;
}
