using System.ComponentModel.DataAnnotations.Schema;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class RagOption : ObjectWithId
    {
        public RagOption()
        {
            BenefitUpdates = new HashSet<BenefitUpdate>();
            Benefits = new HashSet<Benefit>();
            CommitmentUpdates = new HashSet<CommitmentUpdate>();
            Commitments = new HashSet<Commitment>();
            CorporateRiskMitigationActionUpdates = new HashSet<CorporateRiskMitigationActionUpdate>();
            CorporateRisks = new HashSet<CorporateRisk>();
            CorporateRiskUpdates = new HashSet<CorporateRiskUpdate>();
            Dependencies = new HashSet<Dependency>();
            DependencyUpdates = new HashSet<DependencyUpdate>();
            DirectorateUpdateFinanceRagOptions = new HashSet<DirectorateUpdate>();
            DirectorateUpdateMetricsRagOptions = new HashSet<DirectorateUpdate>();
            DirectorateUpdateMilestonesRagOptions = new HashSet<DirectorateUpdate>();
            DirectorateUpdateOverallRagOptions = new HashSet<DirectorateUpdate>();
            DirectorateUpdatePeopleRagOptions = new HashSet<DirectorateUpdate>();
            FinancialRiskMitigationActionUpdates = new HashSet<FinancialRiskMitigationActionUpdate>();
            FinancialRisks = new HashSet<FinancialRisk>();
            FinancialRiskUpdates = new HashSet<FinancialRiskUpdate>();
            KeyWorkAreaUpdates = new HashSet<KeyWorkAreaUpdate>();
            KeyWorkAreas = new HashSet<KeyWorkArea>();
            MetricUpdates = new HashSet<MetricUpdate>();
            Metrics = new HashSet<Metric>();
            MilestoneUpdates = new HashSet<MilestoneUpdate>();
            Milestones = new HashSet<Milestone>();
            PartnerOrganisationRiskMitigationActionUpdates = new HashSet<PartnerOrganisationRiskMitigationActionUpdate>();
            PartnerOrganisationRiskUpdateBeisRagOptions = new HashSet<PartnerOrganisationRiskUpdate>();
            PartnerOrganisationRiskUpdateRagOptions = new HashSet<PartnerOrganisationRiskUpdate>();
            PartnerOrganisationRisks = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisationUpdateFinanceRagOptions = new HashSet<PartnerOrganisationUpdate>();
            PartnerOrganisationUpdateKpiragOptions = new HashSet<PartnerOrganisationUpdate>();
            PartnerOrganisationUpdateMilestonesRagOptions = new HashSet<PartnerOrganisationUpdate>();
            PartnerOrganisationUpdateOverallRagOptions = new HashSet<PartnerOrganisationUpdate>();
            PartnerOrganisationUpdatePeopleRagOptions = new HashSet<PartnerOrganisationUpdate>();
            ProjectUpdateBenefitsRagOptions = new HashSet<ProjectUpdate>();
            ProjectUpdateFinanceRagOptions = new HashSet<ProjectUpdate>();
            ProjectUpdateMilestonesRagOptions = new HashSet<ProjectUpdate>();
            ProjectUpdateOverallRagOptions = new HashSet<ProjectUpdate>();
            ProjectUpdatePeopleRagOptions = new HashSet<ProjectUpdate>();
            RagOptionsMappings = new HashSet<RagOptionsMapping>();
            WorkStreamUpdates = new HashSet<WorkStreamUpdate>();
            WorkStreams = new HashSet<WorkStream>();
        }

        public string Name { get; set; }
        public string ReportName { get; set; }
        public int? Score { get; set; }

        public virtual ICollection<BenefitUpdate> BenefitUpdates { get; set; }
        public virtual ICollection<Benefit> Benefits { get; set; }
        public virtual ICollection<CommitmentUpdate> CommitmentUpdates { get; set; }
        public virtual ICollection<Commitment> Commitments { get; set; }
        public virtual ICollection<CorporateRiskMitigationActionUpdate> CorporateRiskMitigationActionUpdates { get; set; }
        public virtual ICollection<CorporateRisk> CorporateRisks { get; set; }
        public virtual ICollection<CorporateRiskUpdate> CorporateRiskUpdates { get; set; }
        public virtual ICollection<Dependency> Dependencies { get; set; }
        public virtual ICollection<DependencyUpdate> DependencyUpdates { get; set; }
        [InverseProperty("FinanceRagOption")]
        public virtual ICollection<DirectorateUpdate> DirectorateUpdateFinanceRagOptions { get; set; }
        [InverseProperty("MetricsRagOption")]
        public virtual ICollection<DirectorateUpdate> DirectorateUpdateMetricsRagOptions { get; set; }
        [InverseProperty("MilestonesRagOption")]
        public virtual ICollection<DirectorateUpdate> DirectorateUpdateMilestonesRagOptions { get; set; }
        [InverseProperty("OverallRagOption")]
        public virtual ICollection<DirectorateUpdate> DirectorateUpdateOverallRagOptions { get; set; }
        [InverseProperty("PeopleRagOption")]
        public virtual ICollection<DirectorateUpdate> DirectorateUpdatePeopleRagOptions { get; set; }
        public virtual ICollection<FinancialRiskMitigationActionUpdate> FinancialRiskMitigationActionUpdates { get; set; }
        public virtual ICollection<FinancialRisk> FinancialRisks { get; set; }
        public virtual ICollection<FinancialRiskUpdate> FinancialRiskUpdates { get; set; }
        public virtual ICollection<KeyWorkAreaUpdate> KeyWorkAreaUpdates { get; set; }
        public virtual ICollection<KeyWorkArea> KeyWorkAreas { get; set; }
        public virtual ICollection<MetricUpdate> MetricUpdates { get; set; }
        public virtual ICollection<Metric> Metrics { get; set; }
        public virtual ICollection<MilestoneUpdate> MilestoneUpdates { get; set; }
        public virtual ICollection<Milestone> Milestones { get; set; }
        public virtual ICollection<PartnerOrganisationRiskMitigationActionUpdate> PartnerOrganisationRiskMitigationActionUpdates { get; set; }
        [InverseProperty("BeisRagOption")]
        public virtual ICollection<PartnerOrganisationRiskUpdate> PartnerOrganisationRiskUpdateBeisRagOptions { get; set; }
        [InverseProperty("RagOption")]
        public virtual ICollection<PartnerOrganisationRiskUpdate> PartnerOrganisationRiskUpdateRagOptions { get; set; }
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRisks { get; set; }
        [InverseProperty("FinanceRagOption")]
        public virtual ICollection<PartnerOrganisationUpdate> PartnerOrganisationUpdateFinanceRagOptions { get; set; }
        [InverseProperty("KpiragOption")]
        public virtual ICollection<PartnerOrganisationUpdate> PartnerOrganisationUpdateKpiragOptions { get; set; }
        [InverseProperty("MilestonesRagOption")]
        public virtual ICollection<PartnerOrganisationUpdate> PartnerOrganisationUpdateMilestonesRagOptions { get; set; }
        [InverseProperty("OverallRagOption")]
        public virtual ICollection<PartnerOrganisationUpdate> PartnerOrganisationUpdateOverallRagOptions { get; set; }
        [InverseProperty("PeopleRagOption")]
        public virtual ICollection<PartnerOrganisationUpdate> PartnerOrganisationUpdatePeopleRagOptions { get; set; }
        [InverseProperty("BenefitsRagOption")]
        public virtual ICollection<ProjectUpdate> ProjectUpdateBenefitsRagOptions { get; set; }
        [InverseProperty("FinanceRagOption")]
        public virtual ICollection<ProjectUpdate> ProjectUpdateFinanceRagOptions { get; set; }
        [InverseProperty("MilestonesRagOption")]
        public virtual ICollection<ProjectUpdate> ProjectUpdateMilestonesRagOptions { get; set; }
        [InverseProperty("OverallRagOption")]
        public virtual ICollection<ProjectUpdate> ProjectUpdateOverallRagOptions { get; set; }
        [InverseProperty("PeopleRagOption")]
        public virtual ICollection<ProjectUpdate> ProjectUpdatePeopleRagOptions { get; set; }
        public virtual ICollection<RagOptionsMapping> RagOptionsMappings { get; set; }
        public virtual ICollection<WorkStreamUpdate> WorkStreamUpdates { get; set; }
        public virtual ICollection<WorkStream> WorkStreams { get; set; }
    }
}
