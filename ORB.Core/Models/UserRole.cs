using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class UserRole : EntityWithEditor
    {
        public int UserID { get; set; }
        public int RoleID { get; set; }

        public virtual Role Role { get; set; }
        public virtual User User { get; set; }
    }
}
