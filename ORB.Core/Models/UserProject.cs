using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class UserProject : EntityWithEditor
    {
        public int UserID { get; set; }
        public int ProjectID { get; set; }
        public bool IsAdmin { get; set; } 
        public bool IsRiskAdmin { get; set; }

        public virtual Project Project { get; set; }
        public virtual User User { get; set; }
    }
}
