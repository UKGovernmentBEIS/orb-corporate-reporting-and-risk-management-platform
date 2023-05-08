using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class SignOffPartnerOrganisationViewModel
    {
        public PartnerOrganisationViewModel PartnerOrganisation { get; set; }
        public ICollection<PartnerOrganisationMilestoneViewModel> Milestones { get; set; }
        public ICollection<PartnerOrganisationRiskMitigationActionViewModel> PartnerOrganisationRiskMitigationActions { get; set; }
        public ICollection<PartnerOrganisationRiskViewModel> PartnerOrganisationRisks { get; set; }
        public ICollection<CustomReportingEntityTypeViewModel> ReportingEntityTypes { get; set; }
    }

    public class SignOffPartnerOrganisationDto : SignOffDto
    {
        public string PartnerOrganisation { get; set; }
        public string Milestones { get; set; }
        public string PartnerOrganisationRiskMitigationActions { get; set; }
        public string PartnerOrganisationRisks { get; set; }
        public string ReportingEntityTypes { get; set; }
    }
}
