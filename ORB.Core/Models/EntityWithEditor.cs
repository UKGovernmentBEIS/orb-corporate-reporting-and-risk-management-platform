using System;

namespace ORB.Core.Models
{
    public abstract class EntityWithEditor : Entity
    {
        public int? ModifiedByUserID { get; set; }

        public virtual User ModifiedByUser { get; set; }
    }
}
