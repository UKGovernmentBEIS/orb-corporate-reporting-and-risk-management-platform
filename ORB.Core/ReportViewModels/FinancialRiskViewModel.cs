using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ORB.Core.ReportViewModels
{
    public class FinancialRiskViewModel : RiskViewModel
    {
        public bool? OwnedByDgOffice { get; set; }
        public bool? OwnedByMultipleGroups { get; set; }
        public string StaffNonStaffSpend { get; set; }
        public ICollection<string> FundingClassification { get; set; }
        public ICollection<string> EconomicRingfence { get; set; }
        public ICollection<string> PolicyRingfence { get; set; }
        public string UniformChartOfAccountsID { get; set; }

        public ICollection<FinancialRiskUpdateViewModel> FinancialRiskUpdates { get; set; }
    }
}