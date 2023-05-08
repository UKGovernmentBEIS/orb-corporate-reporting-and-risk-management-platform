using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class SignOff : Entity
    {
        public SignOff()
        {
            BenefitUpdates = new HashSet<BenefitUpdate>();
            CommitmentUpdates = new HashSet<CommitmentUpdate>();
            CorporateRiskMitigationActionUpdates = new HashSet<CorporateRiskMitigationActionUpdate>();
            CorporateRiskUpdates = new HashSet<CorporateRiskUpdate>();
            DependencyUpdates = new HashSet<DependencyUpdate>();
            DirectorateUpdates = new HashSet<DirectorateUpdate>();
            FinancialRiskMitigationActionUpdates = new HashSet<FinancialRiskMitigationActionUpdate>();
            FinancialRiskUpdates = new HashSet<FinancialRiskUpdate>();
            KeyWorkAreaUpdates = new HashSet<KeyWorkAreaUpdate>();
            MetricUpdates = new HashSet<MetricUpdate>();
            MilestoneUpdates = new HashSet<MilestoneUpdate>();
            PartnerOrganisationRiskMitigationActionUpdates = new HashSet<PartnerOrganisationRiskMitigationActionUpdate>();
            PartnerOrganisationRiskUpdates = new HashSet<PartnerOrganisationRiskUpdate>();
            PartnerOrganisationUpdates = new HashSet<PartnerOrganisationUpdate>();
            ProjectUpdates = new HashSet<ProjectUpdate>();
            WorkStreamUpdates = new HashSet<WorkStreamUpdate>();
        }

        public DateTime? SignOffDate { get; set; }
        public int? SignOffUserID { get; set; }
        public DateTime? ReportMonth { get; set; }
        public int? DirectorateID { get; set; }
        public int? ProjectID { get; set; }
        public string SignOffEntities { get; set; }
        public bool? IsCurrent { get; set; }
        public int? PartnerOrganisationID { get; set; }
        public int? RiskID { get; set; }
        public string ReportJson { get; set; }

        public virtual Directorate Directorate { get; set; }
        public virtual PartnerOrganisation PartnerOrganisation { get; set; }
        public virtual Project Project { get; set; }
        public virtual CorporateRisk CorporateRisk { get; set; }
        public virtual FinancialRisk FinancialRisk { get; set; }
        public virtual User SignOffUser { get; set; }
        public virtual ICollection<BenefitUpdate> BenefitUpdates { get; set; }
        public virtual ICollection<CommitmentUpdate> CommitmentUpdates { get; set; }
        public virtual ICollection<CorporateRiskMitigationActionUpdate> CorporateRiskMitigationActionUpdates { get; set; }
        public virtual ICollection<CorporateRiskUpdate> CorporateRiskUpdates { get; set; }
        public virtual ICollection<DependencyUpdate> DependencyUpdates { get; set; }
        public virtual ICollection<DirectorateUpdate> DirectorateUpdates { get; set; }
        public virtual ICollection<FinancialRiskMitigationActionUpdate> FinancialRiskMitigationActionUpdates { get; set; }
        public virtual ICollection<FinancialRiskUpdate> FinancialRiskUpdates { get; set; }
        public virtual ICollection<KeyWorkAreaUpdate> KeyWorkAreaUpdates { get; set; }
        public virtual ICollection<MetricUpdate> MetricUpdates { get; set; }
        public virtual ICollection<MilestoneUpdate> MilestoneUpdates { get; set; }
        public virtual ICollection<PartnerOrganisationRiskMitigationActionUpdate> PartnerOrganisationRiskMitigationActionUpdates { get; set; }
        public virtual ICollection<PartnerOrganisationRiskUpdate> PartnerOrganisationRiskUpdates { get; set; }
        public virtual ICollection<PartnerOrganisationUpdate> PartnerOrganisationUpdates { get; set; }
        public virtual ICollection<ProjectUpdate> ProjectUpdates { get; set; }
        public virtual ICollection<WorkStreamUpdate> WorkStreamUpdates { get; set; }
    }
}
