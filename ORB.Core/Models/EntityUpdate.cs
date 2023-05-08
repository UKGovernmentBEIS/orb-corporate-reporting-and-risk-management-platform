using System;

namespace ORB.Core.Models
{
    public abstract class EntityUpdate : Entity
    {
        public DateTime? UpdateDate { get; set; }
        public int? UpdateUserID { get; set; }
        public int? SignOffID { get; set; }

        public virtual User UpdateUser { get; set; }
        public virtual SignOff SignOff { get; set; }
    }
}
