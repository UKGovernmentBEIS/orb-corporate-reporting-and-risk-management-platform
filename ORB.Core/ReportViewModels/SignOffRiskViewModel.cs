using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class SignOffCorporateRiskViewModel
    {
        public CorporateRiskViewModel Risk { get; set; }
        public ICollection<CorporateRiskMitigationActionViewModel> RiskMitigationActions { get; set; }
    }

    public class SignOffCorporateRiskDto : SignOffDto // Can't get OData to return complex object from $expand...
    {
        public string Risk { get; set; }
        public string RiskMitigationActions { get; set; }
    }
}