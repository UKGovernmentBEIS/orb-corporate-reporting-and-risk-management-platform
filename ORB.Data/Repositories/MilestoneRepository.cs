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
    public class MilestoneRepository : EntityRepository<Milestone>, IEntityRepository<Milestone>
    {
        public MilestoneRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<Milestone> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Department Reporting Admin users can see all Milestones
                    return OrbContext.Milestones;
                }
                else
                {
                    // Milestones for Directorates
                    var directorateMilestones = from m in OrbContext.Milestones
                                                from ud in m.KeyWorkArea.Directorate.UserDirectorates
                                                where ud.User.Username == Username
                                                select m;

                    // Milestones for Projects
                    var projectMilestones = from m in OrbContext.Milestones
                                            from up in m.WorkStream.Project.UserProjects
                                            where up.User.Username == Username
                                            select m;

                    // Milestones for Partner Organisations - PO Admins can see all PO Milestones
                    var partnerOrganisationMilestones = !ApiUserIsDepartmentalPartnerOrgAdmin ?
                                                        (from m in OrbContext.Milestones
                                                         from upo in m.PartnerOrganisation.UserPartnerOrganisations
                                                         where upo.User.Username == Username
                                                         select m)
                                                         : (from m in OrbContext.Milestones
                                                            where m.PartnerOrganisationID != null
                                                            select m);

                    return directorateMilestones
                        .Union(projectMilestones)
                        .Union(partnerOrganisationMilestones);
                }
            }
        }

        public async Task<Milestone> Edit(int keyValue)
        {
            var milestone = await Entities
                .Include(m => m.WorkStream).ThenInclude(w => w.Project)
                .Include(m => m.KeyWorkArea).ThenInclude(k => k.Directorate)
                .Include(m => m.PartnerOrganisation)
                .SingleOrDefaultAsync(m => m.ID == keyValue);

            if (ApiUserIsAdmin
                || (milestone.WorkStreamID != null &&
                    (ApiUserAdminProjects.Contains(milestone.WorkStream.ProjectID)
                    || milestone.WorkStream.Project.SeniorResponsibleOwnerUserID == ApiUser.ID
                    || milestone.WorkStream.Project.ReportApproverUserID == ApiUser.ID))
                || (milestone.KeyWorkAreaID != null &&
                    (ApiUserAdminDirectorates.Contains(milestone.KeyWorkArea.DirectorateID)
                    || milestone.KeyWorkArea.Directorate.DirectorUserID == ApiUser.ID
                    || milestone.KeyWorkArea.Directorate.ReportApproverUserID == ApiUser.ID))
                || (milestone.PartnerOrganisationID != null &&
                    (ApiUserIsDepartmentalPartnerOrgAdmin
                    || ApiUserAdminPartnerOrganisations.Contains(milestone.PartnerOrganisation.ID)
                    || milestone.PartnerOrganisation.ReportAuthorUserID == ApiUser.ID
                    || milestone.PartnerOrganisation.LeadPolicySponsorUserID == ApiUser.ID))
                )
            {
                return milestone;
            }
            return null;
        }

        public Milestone Add(Milestone milestone)
        {
            if (milestone.KeyWorkAreaID != null)
            {
                var kwa = OrbContext.KeyWorkAreas.Find(milestone.KeyWorkAreaID);
                if (kwa != null && (ApiUserIsAdmin || ApiUserAdminDirectorates.Contains(kwa.DirectorateID)))
                {
                    OrbContext.Milestones.Add(milestone);
                    return milestone;
                }
            }
            if (milestone.WorkStreamID != null)
            {
                var ws = OrbContext.WorkStreams.Find(milestone.WorkStreamID);
                if (ws != null && (ApiUserIsAdmin || ApiUserAdminProjects.Contains(ws.ProjectID)))
                {
                    OrbContext.Milestones.Add(milestone);
                    return milestone;
                }
            }
            if (milestone.PartnerOrganisationID != null)
            {
                if (ApiUserIsAdmin || ApiUserIsDepartmentalPartnerOrgAdmin || ApiUserAdminPartnerOrganisations.Contains((int)milestone.PartnerOrganisationID))
                {
                    OrbContext.Milestones.Add(milestone);
                    return milestone;
                }
            }

            return null;
        }

        public Milestone Remove(Milestone milestone)
        {
            if (ApiUserIsAdmin ||
                (milestone.KeyWorkAreaID != null && ApiUserAdminDirectorates.Contains(milestone.KeyWorkArea.DirectorateID)) ||
                (milestone.WorkStreamID != null && ApiUserAdminProjects.Contains(milestone.WorkStream.ProjectID)) ||
                (milestone.PartnerOrganisationID != null && (ApiUserAdminPartnerOrganisations.Contains((int)milestone.PartnerOrganisationID) || ApiUserIsDepartmentalPartnerOrgAdmin)))
            {
                OrbContext.Milestones.Remove(milestone);
                return milestone;
            }
            return null;
        }
    }
}