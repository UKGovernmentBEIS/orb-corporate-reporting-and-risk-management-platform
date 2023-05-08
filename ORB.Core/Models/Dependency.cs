using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class Dependency : ReportingSubEntity
    {
        public Dependency()
        {
            DependencyUpdates = new HashSet<DependencyUpdate>();
        }

        public int ProjectID { get; set; }
        public string ThirdParty { get; set; }
        public int? RagOptionID { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }

        public virtual Project Project { get; set; }
        public virtual RagOption RagOption { get; set; }
        public virtual ICollection<DependencyUpdate> DependencyUpdates { get; set; }
    }
}
