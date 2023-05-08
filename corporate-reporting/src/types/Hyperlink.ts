export interface IHyperlink {
    LinkText: string;
    LinkUrl: string;
}

export class Hyperlink implements IHyperlink {
    public LinkText = '';
    public LinkUrl = '';
}