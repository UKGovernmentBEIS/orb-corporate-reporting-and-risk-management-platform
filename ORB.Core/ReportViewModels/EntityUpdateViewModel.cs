using ORB.Core.Models;
using System;

namespace ORB.Core.ReportViewModels
{
    public abstract class EntityUpdateViewModel : Entity
    {
        public DateTime UpdateDate { get; set; }
        public int UpdateUserID { get; set; }

        public UserViewModel UpdateUser { get; set; }
    }
}
