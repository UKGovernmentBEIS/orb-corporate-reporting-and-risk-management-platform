import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityUpdateService } from './EntityUpdateService';
import { IProjectUpdate, IDataAPI } from '../types';

export class ProjectUpdateService extends EntityUpdateService<IProjectUpdate> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/ProjectUpdates`);
    }

    public async readLatestUpdateForPeriod(projectId: number, period: Date): Promise<IProjectUpdate> {
        const pu = await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser,Project($select=ID,Title,Objectives)`
            + `&$filter=ProjectID eq ${projectId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=UpdateDate desc`
        );
        if (pu.length > 0)
            return pu[0];
    }

    public readLatestUpdateBetweenDates = async (projectId: number, from: Date, to: Date): Promise<IProjectUpdate> => {
        const pu = await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser`
            + `&$filter=ProjectID eq ${projectId} and UpdatePeriod gt ${from.toISOString()} and UpdatePeriod le ${to.toISOString()}`
            + `&$orderby=UpdateDate desc`
        );
        if (pu.length > 0)
            return pu[0];
    }

    public async readLastSignedOffUpdateForPeriod(projectId: number, period: Date): Promise<IProjectUpdate> {
        const pu = await this.readAll(
            `?$top=1`
            + `&$expand=ProjectPhase,BusinessCaseType,OverallRagOption,FinanceRagOption,PeopleRagOption,MilestonesRagOption,BenefitsRagOption`
            + `&$filter=ProjectID eq ${projectId} and UpdatePeriod eq ${period.toISOString()} and SignOffID ne null`
            + `&$orderby=SignOffID desc`
        );
        if (pu.length > 0)
            return pu[0];
    }

    public async readLastSignedOffUpdateRagForPreviousPeriod(projectId: number, period: Date): Promise<IProjectUpdate> {
        const pu = await this.readAll(
            `?$top=1`
            + `&$select=OverallRagOptionID`
            + `&$filter=ProjectID eq ${projectId} and UpdatePeriod lt ${period.toISOString()} and SignOffID ne null`
            + `&$orderby=UpdatePeriod desc,SignOffID desc`
        );
        if (pu.length > 0)
            return pu[0];
    }

    public readAllForDirectorateReport(directorateId: number, period: Date): Promise<IProjectUpdate[]> {
        return this.readAll(
            `?$filter=UpdatePeriod eq ${period.toISOString()} and SignOffID ne null and Project/DirectorateID eq ${directorateId} and Project/ShowOnDirectorateReport eq true`
            + `&$expand=Project($select=ID,Title,Objectives;$expand=Attributes($expand=AttributeType)),UpdateUser($select=Title)`
        );
    }

    public readAllChildProjects(projectId: number, period: Date): Promise<IProjectUpdate[]> {
        return this.readAll(
            `?$filter=UpdatePeriod eq ${period.toISOString()} and SignOffID ne null and Project/ParentProjectID eq ${projectId}`
            + `&$expand=Project($select=ID,Title;$expand=Attributes($expand=AttributeType)),UpdateUser($select=Title)`
        );
    }
}
