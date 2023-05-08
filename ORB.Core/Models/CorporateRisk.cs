using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class CorporateRisk : Risk
    {
        public CorporateRisk() : base()
        {
            ChildRisks = new HashSet<CorporateRisk>();
            RiskRiskTypes = new HashSet<RiskRiskType>();
            RiskMitigationActions = new HashSet<CorporateRiskMitigationAction>();
            CorporateRiskRiskMitigationActions = new HashSet<CorporateRiskRiskMitigationAction>();
            RiskUpdates = new HashSet<CorporateRiskUpdate>();
        }

        public int? DepartmentalObjectiveID { get; set; }

        public virtual DepartmentalObjective DepartmentalObjective { get; set; }
        public virtual CorporateRisk LinkedRisk { get; set; }
        public virtual ICollection<CorporateRisk> ChildRisks { get; set; }
        public virtual ICollection<RiskRiskType> RiskRiskTypes { get; set; }
        public virtual ICollection<CorporateRiskMitigationAction> RiskMitigationActions { get; set; }
        public virtual ICollection<CorporateRiskRiskMitigationAction> CorporateRiskRiskMitigationActions { get; set; }
        public virtual ICollection<CorporateRiskUpdate> RiskUpdates { get; set; }
    }
}
