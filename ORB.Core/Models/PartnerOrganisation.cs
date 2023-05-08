using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace ORB.Core.Models
{
    public partial class PartnerOrganisation : ReportingEntity
    {
        public PartnerOrganisation()
        {
            Milestones = new HashSet<Milestone>();
            PartnerOrganisationRisks = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisationUpdates = new HashSet<PartnerOrganisationUpdate>();
            SignOffs = new HashSet<SignOff>();
            UserPartnerOrganisations = new HashSet<UserPartnerOrganisation>();
        }

        public int? DirectorateID { get; set; }
        public int? LeadPolicySponsorUserID { get; set; }
        public int? ReportAuthorUserID { get; set; }
        public string Objectives { get; set; }
        public DateTime? CreatedDate { get; set; }

        public virtual Directorate Directorate { get; set; }
        public virtual User LeadPolicySponsorUser { get; set; }
        public virtual User ReportAuthorUser { get; set; }
        public virtual ICollection<Milestone> Milestones { get; set; }
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRisks { get; set; }
        public virtual ICollection<PartnerOrganisationUpdate> PartnerOrganisationUpdates { get; set; }
        [InverseProperty("PartnerOrganisation")]
        public virtual ICollection<CustomReportingEntity> ReportingEntities { get; set; }
        public virtual ICollection<SignOff> SignOffs { get; set; }
        public virtual ICollection<UserPartnerOrganisation> UserPartnerOrganisations { get; set; }
    }
}
