using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class Contributor : EntityWithEditor
    {
        public int? ContributorUserID { get; set; }
        public int? BenefitID { get; set; }
        public int? CommitmentID { get; set; }
        public int? DependencyID { get; set; }
        public int? DirectorateID { get; set; }
        public int? KeyWorkAreaID { get; set; }
        public int? MetricID { get; set; }
        public int? MilestoneID { get; set; }
        public int? PartnerOrganisationID { get; set; }
        public int? PartnerOrganisationRiskID { get; set; }
        public int? PartnerOrganisationRiskMitigationActionID { get; set; }
        public int? ProjectID { get; set; }
        public int? ReportingEntityID { get; set; }
        public int? RiskID { get; set; }
        public int? RiskMitigationActionID { get; set; }
        public int? WorkStreamID { get; set; }
        public bool? IsReadOnly { get; set; }

        public virtual Benefit Benefit { get; set; }
        public virtual Commitment Commitment { get; set; }
        public virtual User ContributorUser { get; set; }
        public virtual CorporateRisk CorporateRisk { get; set; }
        public virtual CorporateRiskMitigationAction CorporateRiskMitigationAction { get; set; }
        public virtual Dependency Dependency { get; set; }
        public virtual Directorate Directorate { get; set; }
        public virtual FinancialRisk FinancialRisk { get; set; }
        public virtual FinancialRiskMitigationAction FinancialRiskMitigationAction { get; set; }
        public virtual KeyWorkArea KeyWorkArea { get; set; }
        public virtual Metric Metric { get; set; }
        public virtual Milestone Milestone { get; set; }
        public virtual PartnerOrganisation PartnerOrganisation { get; set; }
        public virtual PartnerOrganisationRisk PartnerOrganisationRisk { get; set; }
        public virtual PartnerOrganisationRiskMitigationAction PartnerOrganisationRiskMitigationAction { get; set; }
        public virtual Project Project { get; set; }
        public virtual CustomReportingEntity ReportingEntity { get; set; }
        public virtual WorkStream WorkStream { get; set; }
    }
}
