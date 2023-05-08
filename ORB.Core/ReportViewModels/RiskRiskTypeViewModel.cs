using ORB.Core.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace ORB.Core.ReportViewModels
{
    public class RiskRiskTypeViewModel : Entity
    {
        public int RiskID { get; set; }
        public int RiskTypeID { get; set; }

        public RiskTypeViewModel RiskType { get; set; }
    }
}
