using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class Directorate : ReportingEntity
    {
        public Directorate()
        {
            Commitments = new HashSet<Commitment>();
            CorporateRisks = new HashSet<CorporateRisk>();
            DirectorateUpdates = new HashSet<DirectorateUpdate>();
            FinancialRisks = new HashSet<FinancialRisk>();
            KeyWorkAreas = new HashSet<KeyWorkArea>();
            Metrics = new HashSet<Metric>();
            PartnerOrganisations = new HashSet<PartnerOrganisation>();
            Projects = new HashSet<Project>();
            ReportingEntities = new HashSet<CustomReportingEntity>();
            SignOffs = new HashSet<SignOff>();
            UserDirectorates = new HashSet<UserDirectorate>();
        }

        public int GroupID { get; set; }
        public int? DirectorUserID { get; set; }
        public string Objectives { get; set; }
        public int? ReportApproverUserID { get; set; }
        public int? ReportingLeadUserID { get; set; }

        public virtual User DirectorUser { get; set; }
        public virtual Group Group { get; set; }
        public virtual User ReportApproverUser { get; set; }
        public virtual User ReportingLeadUser { get; set; }
        public virtual ICollection<Commitment> Commitments { get; set; }
        public virtual ICollection<CorporateRisk> CorporateRisks { get; set; }
        public virtual ICollection<DirectorateUpdate> DirectorateUpdates { get; set; }
        public virtual ICollection<FinancialRisk> FinancialRisks { get; set; }
        public virtual ICollection<KeyWorkArea> KeyWorkAreas { get; set; }
        public virtual ICollection<Metric> Metrics { get; set; }
        public virtual ICollection<PartnerOrganisation> PartnerOrganisations { get; set; }
        public virtual ICollection<Project> Projects { get; set; }
        public virtual ICollection<CustomReportingEntity> ReportingEntities { get; set; }
        public virtual ICollection<SignOff> SignOffs { get; set; }
        public virtual ICollection<UserDirectorate> UserDirectorates { get; set; }
    }
}
