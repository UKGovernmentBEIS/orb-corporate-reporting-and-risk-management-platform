using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class RiskMitigationActionUpdate : EntityUpdate
    {
        public int? RiskMitigationActionID { get; set; }
        public int? RagOptionID { get; set; }
        public string Comment { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }
        public int? RiskUpdateID { get; set; }

        public virtual RagOption RagOption { get; set; }
    }
}
