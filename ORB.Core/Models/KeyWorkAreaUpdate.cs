using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class KeyWorkAreaUpdate : EntityUpdate
    {
        public int KeyWorkAreaID { get; set; }
        public int? RagOptionID { get; set; }
        public string Comment { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }

        public virtual KeyWorkArea KeyWorkArea { get; set; }
        public virtual RagOption RagOption { get; set; }
    }
}
