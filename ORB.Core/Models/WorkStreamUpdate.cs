using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class WorkStreamUpdate : EntityUpdate
    {
        public int WorkStreamID { get; set; }
        public int? RagOptionID { get; set; }
        public string Comment { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }

        public virtual RagOption RagOption { get; set; }
        public virtual WorkStream WorkStream { get; set; }
    }
}
