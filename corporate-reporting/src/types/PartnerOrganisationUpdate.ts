import { IPartnerOrganisation } from "./PartnerOrganisation";
import { IRagOption } from "./RagOption";
import { IReportingProgressUpdate, ReportingProgressUpdate } from "./ReportingProgressUpdate";

export interface IPartnerOrganisationUpdate extends IReportingProgressUpdate {
    PartnerOrganisationID: number;
    OverallRagOptionID: number;
    FinanceRagOptionID: number;
    FinanceComment: string;
    PeopleRagOptionID: number;
    PeopleComment: string;
    MilestonesRagOptionID: number;
    MilestonesComment: string;
    KPIRagOptionID: number;
    KPIComment: string;
    ProgressUpdate: string;
    FutureActions: string;
    Escalations: string;
    PartnerOrganisation?: IPartnerOrganisation;
    OverallRagOption?: IRagOption;
    FinanceRagOption?: IRagOption;
    PeopleRagOption?: IRagOption;
    MilestonesRagOption?: IRagOption;
    MetricsRagOption?: IRagOption;
}

export class PartnerOrganisationUpdate extends ReportingProgressUpdate implements IPartnerOrganisationUpdate {
    public PartnerOrganisationID = null;
    public OverallRagOptionID = null;
    public FinanceRagOptionID = null;
    public FinanceComment = '';
    public PeopleRagOptionID = null;
    public PeopleComment = '';
    public MilestonesRagOptionID = null;
    public MilestonesComment = '';
    public KPIRagOptionID = null;
    public KPIComment = '';
    public ProgressUpdate = '';
    public FutureActions = '';
    public Escalations = '';

    public PartnerOrganisation = null;
    public UpdateUser = null;

    constructor(period: Date, partnerOrganisationId?: number, partnerOrganisation?: IPartnerOrganisation) {
        super(period);
        if (partnerOrganisationId) this.PartnerOrganisationID = partnerOrganisationId;
        if (partnerOrganisation) this.PartnerOrganisation = partnerOrganisation;
    }
}