using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class UserDirectorate : EntityWithEditor
    {
        public int UserID { get; set; }
        public int DirectorateID { get; set; }
        public bool IsAdmin { get; set; }
        public bool IsRiskAdmin { get; set; }

        public virtual Directorate Directorate { get; set; }
        public virtual User User { get; set; }
    }
}
