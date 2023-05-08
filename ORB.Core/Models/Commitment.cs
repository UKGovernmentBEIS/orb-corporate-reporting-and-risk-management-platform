using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class Commitment : ReportingSubEntity
    {
        public Commitment()
        {
            CommitmentUpdates = new HashSet<CommitmentUpdate>();
        }

        public int DirectorateID { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public int? RagOptionID { get; set; }

        public virtual Directorate Directorate { get; set; }
        public virtual RagOption RagOption { get; set; }
        public virtual ICollection<CommitmentUpdate> CommitmentUpdates { get; set; }
    }
}
