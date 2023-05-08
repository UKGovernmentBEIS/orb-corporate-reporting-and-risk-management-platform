using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class Role : Entity
    {
        public Role()
        {
            UserRoles = new HashSet<UserRole>();
        }

        public virtual ICollection<UserRole> UserRoles { get; set; }
    }
}
