using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class RiskRegister : Entity
    {
        public RiskRegister()
        {
            RiskUpdates = new HashSet<RiskUpdate>();
            RiskUpdatesEscalateTo = new HashSet<RiskUpdate>();
            CorporateRisks = new HashSet<CorporateRisk>();
        }

        public string RiskCodePrefix { get; set; }

        public virtual ICollection<RiskUpdate> RiskUpdates { get; set; }
        public virtual ICollection<RiskUpdate> RiskUpdatesEscalateTo { get; set; }
        public virtual ICollection<CorporateRisk> CorporateRisks { get; set; }
    }
}
