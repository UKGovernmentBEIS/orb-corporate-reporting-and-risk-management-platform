using ORB.Core.Models;
using System.Collections.Generic;

namespace ORB.Core.Services
{
    public interface IUserService : IEntityService<User>
    {
        string FirstRequest();
        User GetUserPermissions(string username);
        IEnumerable<User> AuthorUsersInProject(Project project);
        IEnumerable<User> AuthorUsersInDirectorate(Directorate directorate);
        IEnumerable<User> AuthorUsersInPartnerOrganisation(PartnerOrganisation partnerOrganisation);
        IEnumerable<User> AuthorUsersInBenefit(Benefit benefit);
        IEnumerable<User> AuthorUsersInMetric(Metric metric);
        IEnumerable<User> AuthorUsersInFinancialRisk(FinancialRisk risk);
        IEnumerable<User> ApproverUsersInProject(Project project);
        IEnumerable<User> ApproverUsersInDirectorate(Directorate directorate);
        IEnumerable<User> ApproverUsersInPartnerOrganisation(PartnerOrganisation partnerOrganisation);
        IEnumerable<User> ApproverUsersInFinancialRisk(FinancialRisk risk);
    }
}