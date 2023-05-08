using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class BaseUserGroup : EntityWithEditor
    {
        public int UserID { get; set; }
        public int GroupID { get; set; }
        public bool IsRiskAdmin { get; set; }

        public virtual User User { get; set; }
        public virtual Group Group { get; set; }
    }
}
