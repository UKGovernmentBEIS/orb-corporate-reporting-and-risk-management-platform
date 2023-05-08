using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ORB.Core.ReportViewModels
{
    public class CorporateRiskMitigationActionViewModel : RiskMitigationActionViewModel
    {
        public ICollection<RiskMitigationActionUpdateViewModel> RiskMitigationActionUpdates { get; set; }
    }
}
