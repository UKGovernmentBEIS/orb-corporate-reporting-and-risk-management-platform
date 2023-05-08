using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ORB.Core.ReportViewModels
{
    public class FinancialRiskMitigationActionViewModel : RiskMitigationActionViewModel
    {
        public ICollection<FinancialRiskMitigationActionUpdateViewModel> FinancialRiskMitigationActionUpdates { get; set; }
    }
}
