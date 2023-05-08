using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public abstract class ContributorViewModel : Entity
    {
        public int ContributorUserID { get; set; }
        public bool? IsReadOnly { get; set; }

        public UserViewModel ContributorUser { get; set; }
    }
}
