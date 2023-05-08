using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public class FinancialRiskUpdateViewModel : RiskUpdateViewModel
    {
        public FinancialRiskMeasurements Measurements { get; set; }
    }
}