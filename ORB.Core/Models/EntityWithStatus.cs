using System;

namespace ORB.Core.Models
{
    public abstract class EntityWithStatus : EntityWithEditor
    {
        public int? EntityStatusID { get; set; }
        public DateTime? EntityStatusDate { get; set; }

        public virtual EntityStatus EntityStatus { get; set; }
    }
}
