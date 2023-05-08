using System;
using System.Collections.Generic;
using System.Text;

namespace ORB.Core.Models
{
    public class SpendProfile
    {
        public decimal? FinancialYear0 { get; set; }
        public decimal? FinancialYear1 { get; set; }
        public decimal? FinancialYear2 { get; set; }
        public decimal? FinancialYear3 { get; set; }
        public decimal? FinancialYear4 { get; set; }
    }

    public class FinancialRiskMeasurements
    {
        public bool? SpendProfileNotApplicable { get; set; }
        public SpendProfile SpendProfile { get; set; }
    }
}
