using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ORB.Core.ReportViewModels
{
    public class CorporateRiskViewModel : RiskViewModel
    {
        public ICollection<RiskUpdateViewModel> RiskUpdates { get; set; }
        public ICollection<RiskRiskTypeViewModel> RiskRiskTypes { get; set; }
    }
}