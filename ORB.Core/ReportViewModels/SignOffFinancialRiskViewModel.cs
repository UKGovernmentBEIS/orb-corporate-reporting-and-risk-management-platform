using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class SignOffFinancialRiskViewModel
    {
        public FinancialRiskViewModel FinancialRisk { get; set; }
        public ICollection<FinancialRiskMitigationActionViewModel> FinancialRiskMitigationActions { get; set; }
    }

    public class SignOffFinancialRiskDto : SignOffDto // Can't get OData to return complex object from $expand...
    {
        public string FinancialRisk { get; set; }
        public string FinancialRiskMitigationActions { get; set; }
    }
}