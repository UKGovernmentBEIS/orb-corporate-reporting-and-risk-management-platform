using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class FinancialRisk : Risk
    {
        public FinancialRisk() : base()
        {
            ChildRisks = new HashSet<FinancialRisk>();
            FinancialRiskMitigationActions = new HashSet<FinancialRiskMitigationAction>();
            FinancialRiskRiskMitigationActions = new HashSet<FinancialRiskRiskMitigationAction>();
            FinancialRiskUpdates = new HashSet<FinancialRiskUpdate>();
        }

        public bool? OwnedByDgOffice { get; set; }
        public bool? OwnedByMultipleGroups { get; set; }
        public string StaffNonStaffSpend { get; set; }
        public ICollection<string> FundingClassification { get; set; }
        public ICollection<string> EconomicRingfence { get; set; }
        public ICollection<string> PolicyRingfence { get; set; }
        public string UniformChartOfAccountsID { get; set; }

        public virtual FinancialRisk LinkedRisk { get; set; }
        public virtual ICollection<FinancialRisk> ChildRisks { get; set; }
        public virtual ICollection<FinancialRiskMitigationAction> FinancialRiskMitigationActions { get; set; }
        public virtual ICollection<FinancialRiskRiskMitigationAction> FinancialRiskRiskMitigationActions { get; set; }
        public virtual ICollection<FinancialRiskUpdate> FinancialRiskUpdates { get; set; }
    }
}
