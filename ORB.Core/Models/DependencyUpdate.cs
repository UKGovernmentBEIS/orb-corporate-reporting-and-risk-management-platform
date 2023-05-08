using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class DependencyUpdate : EntityUpdate
    {
        public int DependencyID { get; set; }
        public int? RagOptionID { get; set; }
        public string Comment { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }

        public virtual Dependency Dependency { get; set; }
        public virtual RagOption RagOption { get; set; }
    }
}
