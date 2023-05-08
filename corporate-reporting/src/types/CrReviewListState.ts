export interface ICrReviewListState<T, U> {
    SelectedEntityUpdate: number;
    Entities: T[];
    EntityUpdates: U[];
}

export class CrReviewListState<T, U> implements ICrReviewListState<T, U>{
    public SelectedEntityUpdate = null;
    public Entities: T[] = [];
    public EntityUpdates: U[] = [];
}