using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using System;
using System.Linq;
using System.Security.Principal;
using System.Threading.Tasks;

namespace ORB.Data.Repositories
{
    public class MilestoneUpdateRepository : EntityUpdateRepository<MilestoneUpdate>, IEntityUpdateRepository<MilestoneUpdate>
    {
        public MilestoneUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public IQueryable<MilestoneUpdate> MilestoneUpdates { get { return Entities; } }

        public override IQueryable<MilestoneUpdate> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all Milestone Updates
                    return OrbContext.MilestoneUpdates;
                }
                else
                {
                    // Milestone Updates for Directorates linked to the user
                    var directorateMilestoneUpdates = from mu in OrbContext.MilestoneUpdates
                                                      from ud in mu.Milestone.KeyWorkArea.Directorate.UserDirectorates
                                                      where ud.User.Username == Username
                                                      select mu;

                    // Milestone Updates for Projects linked to the user
                    var projectMilestoneUpdates = from mu in OrbContext.MilestoneUpdates
                                                  from up in mu.Milestone.WorkStream.Project.UserProjects
                                                  where up.User.Username == Username
                                                  select mu;

                    // Milestone Updates for Partner Organisations linked to the user  - PO Admins can see all PO Milestone Updates
                    var partnerOrgMilestoneUpdates = !ApiUserIsDepartmentalPartnerOrgAdmin ?
                                                    (from mu in OrbContext.MilestoneUpdates
                                                     from upo in mu.Milestone.PartnerOrganisation.UserPartnerOrganisations
                                                     where upo.User.Username == Username
                                                     select mu)
                                                      : (from mu in OrbContext.MilestoneUpdates
                                                         where mu.Milestone.PartnerOrganisationID != null
                                                         select mu);

                    return directorateMilestoneUpdates
                        .Union(projectMilestoneUpdates)
                        .Union(partnerOrgMilestoneUpdates);
                }
            }
        }

        public MilestoneUpdate Add(MilestoneUpdate milestoneUpdate)
        {
            var userId = ApiUser.ID;

            var ms = OrbContext.Milestones
                .Include(m => m.KeyWorkArea).ThenInclude(k => k.Directorate)
                .Include(m => m.WorkStream).ThenInclude(w => w.Project)
                .Include(m => m.PartnerOrganisation)
                .Include(m => m.Contributors)
                .SingleOrDefault(m => m.ID == milestoneUpdate.MilestoneID);

            if (ms != null && ms.KeyWorkAreaID != null)
            {
                if (ApiUserIsAdmin
                    || ApiUserAdminDirectorates.Contains(ms.KeyWorkArea.DirectorateID)
                    || ms.Contributors.Select(c => c.ContributorUserID).Contains(userId)
                    || userId == ms.KeyWorkArea.Directorate.DirectorUserID
                    || userId == ms.KeyWorkArea.Directorate.ReportApproverUserID
                    || userId == ms.LeadUserID)
                {
                    OrbContext.MilestoneUpdates.Add(milestoneUpdate);
                    return milestoneUpdate;
                }
            }
            if (ms != null && ms.WorkStreamID != null)
            {
                if (ApiUserIsAdmin
                    || ApiUserAdminProjects.Contains(ms.WorkStream.ProjectID)
                    || ms.Contributors.Select(c => c.ContributorUserID).Contains(userId)
                    || userId == ms.WorkStream.Project.SeniorResponsibleOwnerUserID
                    || userId == ms.WorkStream.Project.ReportApproverUserID
                    || userId == ms.LeadUserID)
                {
                    OrbContext.MilestoneUpdates.Add(milestoneUpdate);
                    return milestoneUpdate;
                }
            }
            if (ms != null && ms.PartnerOrganisationID != null)
            {
                if (ApiUserIsAdmin || ApiUserIsDepartmentalPartnerOrgAdmin
                    || ApiUserAdminPartnerOrganisations.Contains((int)ms.PartnerOrganisationID)
                    || ms.Contributors.Select(c => c.ContributorUserID).Contains(userId)
                    || userId == ms.PartnerOrganisation.LeadPolicySponsorUserID
                    || userId == ms.PartnerOrganisation.ReportAuthorUserID
                    || userId == ms.LeadUserID)
                {
                    OrbContext.MilestoneUpdates.Add(milestoneUpdate);
                    return milestoneUpdate;
                }
            }
            return null;
        }
    }
}