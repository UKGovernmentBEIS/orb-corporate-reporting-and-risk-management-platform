import { WebPartContext } from '@microsoft/sp-webpart-base';

export class ContextService {
    public static Username(spfxContext: WebPartContext): string {
        return this.alterUsername(spfxContext.pageContext.user.loginName);
    }

    public static alterUsername(userName: string): string {
        return userName
            .replace('cirrus.', '')
            .replace("'", "''");
    }
}