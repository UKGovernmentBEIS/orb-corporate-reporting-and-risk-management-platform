using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Threading.Tasks;

namespace ORB.Data.Repositories
{
    public class ContributorRepository : EntityRepository<Contributor>, IContributorRepository
    {
        public ContributorRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<Contributor> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all Contributors
                    return OrbContext.Contributors;
                }
                else
                {
                    // Department Risk Admins can see Contributors for all Risks and Risk Mitigation Actions
                    return (from c in OrbContext.Contributors
                            from ur in OrbContext.UserRoles
                            where ur.RoleID == (int)AdminRoles.RiskAdmin && (c.RiskID != null || c.RiskMitigationActionID != null)
                            select c)
                     // Group Risk Admins can see Contributors for all Risks linked to Directorates within their Groups
                     .Union(from c in OrbContext.Contributors
                            from ug in c.CorporateRisk.Directorate.Group.UserGroups
                            where ug.User.Username == Username && ug.IsRiskAdmin
                            select c)
                     // Group Risk Admins can see Contributors for all Risk Mitigation Actions linked to Directorates within their Groups
                     .Union(from c in OrbContext.Contributors
                            from ug in c.CorporateRiskMitigationAction.Risk.Directorate.Group.UserGroups
                            from rrma in c.CorporateRiskMitigationAction.CorporateRiskRiskMitigationActions
                            from rrmaug in rrma.Risk.Directorate.Group.UserGroups
                            where (ug.User.Username == Username || rrmaug.User.Username == Username) && ug.IsRiskAdmin
                            select c)
                     // Directorate Risk Admins can see Contributors for all Risks linked to their Directorates
                     .Union(from c in OrbContext.Contributors
                            from ud in c.CorporateRisk.Directorate.UserDirectorates
                            where ud.User.Username == Username && ud.IsRiskAdmin
                            select c)
                     // Directorate Risk Admins can see Contributors for all Risk Mitigation Actions linked to their Directorates
                     .Union(from c in OrbContext.Contributors
                            from ud in c.CorporateRiskMitigationAction.Risk.Directorate.UserDirectorates
                            from rrma in c.CorporateRiskMitigationAction.CorporateRiskRiskMitigationActions
                            from rrmaud in rrma.Risk.Directorate.UserDirectorates
                            where (ud.User.Username == Username || rrmaud.User.Username == Username) && ud.IsRiskAdmin
                            select c)
                        // Partner Organisation Risks
                        .Union(from c in OrbContext.Contributors
                               from upo in c.PartnerOrganisationRisk.PartnerOrganisation.UserPartnerOrganisations
                               where upo.User.Username == Username
                               select c)
                        // Directorates
                        .Union(from c in OrbContext.Contributors
                               from ud in c.Directorate.UserDirectorates
                               where ud.User.Username == Username
                               select c)
                         // Key Work Areas
                         .Union(from c in OrbContext.Contributors
                                from ud in c.KeyWorkArea.Directorate.UserDirectorates
                                where ud.User.Username == Username
                                select c)
                         // Metrics
                         .Union(from c in OrbContext.Contributors
                                from ud in c.Metric.Directorate.UserDirectorates
                                where ud.User.Username == Username
                                select c)
                         // Commitments
                         .Union(from c in OrbContext.Contributors
                                from ud in c.Commitment.Directorate.UserDirectorates
                                where ud.User.Username == Username
                                select c)
                         // Milestones(KeyWorkAreas)
                         .Union(from c in OrbContext.Contributors
                                from ud in c.Milestone.KeyWorkArea.Directorate.UserDirectorates
                                where ud.User.Username == Username
                                select c)
                        // Projects
                        .Union(from c in OrbContext.Contributors
                               from up in c.Project.UserProjects
                               where up.User.Username == Username
                               select c)
                        // Workstreams
                        .Union(from c in OrbContext.Contributors
                               from up in c.WorkStream.Project.UserProjects
                               where up.User.Username == Username
                               select c)
                        // Benefits
                        .Union(from c in OrbContext.Contributors
                               from up in c.Benefit.Project.UserProjects
                               where up.User.Username == Username
                               select c)
                        // Dependencies
                        .Union(from c in OrbContext.Contributors
                               from up in c.Dependency.Project.UserProjects
                               where up.User.Username == Username
                               select c)
                        // Milestones(Workstream)
                        .Union(from c in OrbContext.Contributors
                               from up in c.Milestone.WorkStream.Project.UserProjects
                               where up.User.Username == Username
                               select c)
                        // Partner Organisations
                        .Union(from c in OrbContext.Contributors
                               from upo in c.PartnerOrganisation.UserPartnerOrganisations
                               where upo.User.Username == Username
                               select c)
                        // Milestones (Partner Organisations)
                        .Union(from c in OrbContext.Contributors
                               from upo in c.Milestone.PartnerOrganisation.UserPartnerOrganisations
                               where upo.User.Username == Username
                               select c)
                        // Departmental PO Admins can see all Contributors for PO entities
                        .Union(from c in OrbContext.Contributors
                               where c.Milestone.PartnerOrganisationID != null && ApiUserIsDepartmentalPartnerOrgAdmin
                               select c)
                        .Union(from c in OrbContext.Contributors
                               where c.PartnerOrganisationID != null && ApiUserIsDepartmentalPartnerOrgAdmin
                               select c)
                        .Union(from c in OrbContext.Contributors
                               where c.PartnerOrganisationRiskID != null && ApiUserIsDepartmentalPartnerOrgAdmin
                               select c)
                        .Union(from c in OrbContext.Contributors
                               where c.PartnerOrganisationRiskMitigationActionID != null && ApiUserIsDepartmentalPartnerOrgAdmin
                               select c)
                        // Custom reporting entities (Directorate)
                        .Union(from c in OrbContext.Contributors
                               from ud in c.ReportingEntity.Directorate.UserDirectorates
                               where ud.User.Username == Username
                               select c)
                        // Custom reporting entities (Project)
                        .Union(from c in OrbContext.Contributors
                               from up in c.ReportingEntity.Project.UserProjects
                               where up.User.Username == Username
                               select c)
                        // Custom reporting entities (Partner Organisations)
                        .Union(from c in OrbContext.Contributors
                               from upo in c.ReportingEntity.PartnerOrganisation.UserPartnerOrganisations
                               where upo.User.Username == Username
                               select c);
                }
            }
        }

        public async Task<Contributor> Edit(int keyValue)
        {
            return await Entities.SingleOrDefaultAsync(c => c.ID == keyValue);
        }

        public Contributor Add(Contributor contributor)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.Contributors.Add(contributor);
                return contributor;
            }

            // Directorate entities
            if (contributor.DirectorateID != null && ApiUserAdminDirectorates.Contains((int)contributor.DirectorateID))
            {
                OrbContext.Contributors.Add(contributor);
                return contributor;
            }
            if (contributor.KeyWorkAreaID != null)
            {
                var kwa = OrbContext.KeyWorkAreas.Find(contributor.KeyWorkAreaID);
                if (kwa != null && (ApiUserAdminDirectorates.Contains(kwa.DirectorateID) || ApiUser.ID == kwa.LeadUserID))
                {
                    OrbContext.Contributors.Add(contributor);
                    return contributor;
                }
            }
            if (contributor.MetricID != null)
            {
                var m = OrbContext.Metrics.Find(contributor.MetricID);
                if (m != null && (ApiUserAdminDirectorates.Contains(m.DirectorateID) || ApiUser.ID == m.LeadUserID))
                {
                    OrbContext.Contributors.Add(contributor);
                    return contributor;
                }
            }
            if (contributor.CommitmentID != null)
            {
                var c = OrbContext.Commitments.Find(contributor.CommitmentID);
                if (c != null && (ApiUserAdminDirectorates.Contains(c.DirectorateID) || ApiUser.ID == c.LeadUserID))
                {
                    OrbContext.Contributors.Add(contributor);
                    return contributor;
                }
            }

            // Project entities
            if (contributor.ProjectID != null && ApiUserAdminProjects.Contains((int)contributor.ProjectID))
            {
                OrbContext.Contributors.Add(contributor);
                return contributor;
            }
            if (contributor.WorkStreamID != null)
            {
                var ws = OrbContext.WorkStreams.Find(contributor.WorkStreamID);
                if (ws != null && (ApiUserAdminProjects.Contains(ws.ProjectID) || ApiUser.ID == ws.LeadUserID))
                {
                    OrbContext.Contributors.Add(contributor);
                    return contributor;
                }
            }
            if (contributor.BenefitID != null)
            {
                var b = OrbContext.Benefits.Find(contributor.BenefitID);
                if (b != null && (ApiUserAdminProjects.Contains(b.ProjectID) || ApiUser.ID == b.LeadUserID))
                {
                    OrbContext.Contributors.Add(contributor);
                    return contributor;
                }
            }
            if (contributor.DependencyID != null)
            {
                var d = OrbContext.Dependencies.Find(contributor.DependencyID);
                if (d != null && (ApiUserAdminProjects.Contains(d.ProjectID) || ApiUser.ID == d.LeadUserID))
                {
                    OrbContext.Contributors.Add(contributor);
                    return contributor;
                }
            }

            if (contributor.MilestoneID != null)
            {
                var m = OrbContext.Milestones.Include(m => m.KeyWorkArea).Include(m => m.WorkStream).SingleOrDefault(k => k.ID == contributor.MilestoneID);
                if (m != null && ((m.KeyWorkArea != null && ApiUserAdminDirectorates.Contains(m.KeyWorkArea.DirectorateID))
                        || (m.WorkStream != null && ApiUserAdminProjects.Contains(m.WorkStream.ProjectID))
                        || (m.PartnerOrganisationID != null && ApiUserAdminPartnerOrganisations.Contains((int)m.PartnerOrganisationID))
                        || ApiUser.ID == m.LeadUserID))
                {
                    OrbContext.Contributors.Add(contributor);
                    return contributor;
                }
            }

            // Partner organisation entities
            if (contributor.PartnerOrganisationID != null)
            {
                var po = OrbContext.PartnerOrganisations.Find(contributor.PartnerOrganisationID);
                if (po != null && (ApiUserIsDepartmentalPartnerOrgAdmin || ApiUserAdminPartnerOrganisations.Contains(po.ID) || ApiUser.ID == po.LeadPolicySponsorUserID))
                {
                    OrbContext.Contributors.Add(contributor);
                    return contributor;
                }
            }

            if (contributor.PartnerOrganisationRiskID != null)
            {
                var po = OrbContext.PartnerOrganisationRisks.Find(contributor.PartnerOrganisationRiskID);
                if (po != null && (ApiUserIsDepartmentalPartnerOrgAdmin || ApiUserAdminPartnerOrganisations.Contains(po.PartnerOrganisationID) || ApiUser.ID == po.RiskOwnerUserID || ApiUser.ID == po.BeisRiskOwnerUserID))
                {
                    OrbContext.Contributors.Add(contributor);
                    return contributor;
                }
            }

            if (contributor.PartnerOrganisationRiskMitigationActionID != null)
            {
                var po = OrbContext.PartnerOrganisationRiskMitigationActions
                    .Include(a => a.PartnerOrganisationRisk)
                    .SingleOrDefault(porma => porma.ID == contributor.PartnerOrganisationRiskMitigationActionID);

                if (po != null && (ApiUserIsDepartmentalPartnerOrgAdmin || ApiUserAdminPartnerOrganisations.Contains(po.PartnerOrganisationRisk.PartnerOrganisationID) || ApiUser.ID == po.OwnerUserID))
                {
                    OrbContext.Contributors.Add(contributor);
                    return contributor;
                }
            }

            // Risk entities
            if (contributor.RiskID != null)
            {
                if (CanRemoveRiskContributor((int)contributor.RiskID))
                {
                    OrbContext.Contributors.Add(contributor);
                    return contributor;
                }
            }

            if (contributor.RiskMitigationActionID != null)
            {
                var corporateRiskMitigationAction = OrbContext.CorporateRiskMitigationActions
                    .Include(rma => rma.CorporateRiskRiskMitigationActions).SingleOrDefault(rma => rma.ID == contributor.RiskMitigationActionID);
                var financialRiskMitigationAction = OrbContext.FinancialRiskMitigationActions
                    .Include(rma => rma.FinancialRiskRiskMitigationActions).SingleOrDefault(rma => rma.ID == contributor.RiskMitigationActionID);

                if (corporateRiskMitigationAction != null)
                {
                    if (CanRemoveRiskContributor(corporateRiskMitigationAction.RiskID))
                    {
                        OrbContext.Contributors.Add(contributor);
                        return contributor;
                    }

                    foreach (var rrma in corporateRiskMitigationAction.CorporateRiskRiskMitigationActions)
                    {
                        if (CanRemoveRiskContributor(rrma.RiskID))
                        {
                            OrbContext.Contributors.Add(contributor);
                            return contributor;
                        }
                    }
                }
                if (financialRiskMitigationAction != null)
                {
                    if (CanRemoveRiskContributor(financialRiskMitigationAction.RiskID))
                    {
                        OrbContext.Contributors.Add(contributor);
                        return contributor;
                    }

                    foreach (var rrma in financialRiskMitigationAction.FinancialRiskRiskMitigationActions)
                    {
                        if (CanRemoveRiskContributor(rrma.RiskID))
                        {
                            OrbContext.Contributors.Add(contributor);
                            return contributor;
                        }
                    }
                }
            }

            // Custom reporting entities
            if (contributor.ReportingEntityID != null)
            {
                var re = OrbContext.ReportingEntities.Find(contributor.ReportingEntityID);
                if (re != null && (
                    (re.DirectorateID != null && ApiUserAdminDirectorates.Contains((int)re.DirectorateID))
                    || (re.ProjectID != null && ApiUserAdminProjects.Contains((int)re.ProjectID))
                    || (re.PartnerOrganisationID != null && ApiUserAdminPartnerOrganisations.Contains((int)re.PartnerOrganisationID))
                    || ApiUser.ID == re.LeadUserID))
                {
                    OrbContext.Contributors.Add(contributor);
                    return contributor;
                }
            }

            return null;
        }

        private bool CanRemoveRiskContributor(int riskId)
        {
            var corpRisk = OrbContext.CorporateRisks.Include(r => r.Directorate).SingleOrDefault(r => r.ID == riskId);
            var finRisk = OrbContext.FinancialRisks.SingleOrDefault(r => r.ID == riskId);
            if (corpRisk != null)
            {
                if (ApiUserIsDepartmentRiskManager)
                {
                    return true;
                }
                else if (ApiUserAdminGroupRisks.Contains(corpRisk.Directorate.GroupID))
                {
                    return true;
                }
                else if (ApiUserAdminDirectorateRisks.Contains((int)corpRisk.DirectorateID))
                {
                    return true;
                }
            }
            else if (finRisk != null)
            {
                if (ApiUserIsFinancialRiskManager)
                {
                    return true;
                }
                else if (ApiUserFinancialRiskGroups.Contains((int)finRisk.GroupID))
                {
                    return true;
                }
            }

            return false;
        }

        public Contributor Remove(Contributor contributor)
        {
            var cont = OrbContext.Contributors
                .Include(c => c.KeyWorkArea)
                .Include(c => c.Metric)
                .Include(c => c.Commitment)
                .Include(c => c.Milestone).ThenInclude(m => m.KeyWorkArea)
                .Include(c => c.Milestone).ThenInclude(m => m.WorkStream)
                .Include(c => c.WorkStream)
                .Include(c => c.Benefit)
                .Include(c => c.Dependency)
                .Include(c => c.CorporateRiskMitigationAction)
                .Include(c => c.FinancialRiskMitigationAction)
                .Include(c => c.PartnerOrganisation)
                .Include(c => c.PartnerOrganisationRisk)
                .Include(c => c.PartnerOrganisationRiskMitigationAction).ThenInclude(a => a.PartnerOrganisationRisk)
                .Include(c => c.ReportingEntity)
                .AsSplitQuery()
                .SingleOrDefault(c => c.ID == contributor.ID);

            if(cont != null)
            {
                if (ApiUserIsAdmin
            || (cont.DirectorateID != null && ApiUserAdminDirectorates.Contains((int)cont.DirectorateID))
            || (cont.KeyWorkAreaID != null && ApiUserAdminDirectorates.Contains(cont.KeyWorkArea.DirectorateID))
            || (cont.MetricID != null && ApiUserAdminDirectorates.Contains(cont.Metric.DirectorateID))
            || (cont.CommitmentID != null && ApiUserAdminDirectorates.Contains(cont.Commitment.DirectorateID))
            || (cont.MilestoneID != null && cont.Milestone.KeyWorkArea != null && ApiUserAdminDirectorates.Contains(cont.Milestone.KeyWorkArea.DirectorateID))
            || (cont.MilestoneID != null && cont.Milestone.WorkStream != null && ApiUserAdminProjects.Contains(cont.Milestone.WorkStream.ProjectID))
            || (cont.ProjectID != null && ApiUserAdminProjects.Contains((int)cont.ProjectID))
            || (cont.WorkStreamID != null && ApiUserAdminProjects.Contains(cont.WorkStream.ProjectID))
            || (cont.BenefitID != null && ApiUserAdminProjects.Contains(cont.Benefit.ProjectID))
            || (cont.DependencyID != null && ApiUserAdminProjects.Contains(cont.Dependency.ProjectID))
            || (cont.RiskID != null && CanRemoveRiskContributor((int)cont.RiskID))
            || (cont.CorporateRiskMitigationAction != null && CanRemoveRiskContributor(cont.CorporateRiskMitigationAction.RiskID))
            || (cont.FinancialRiskMitigationAction != null && CanRemoveRiskContributor(cont.FinancialRiskMitigationAction.RiskID))
            || (cont.PartnerOrganisationID != null && (ApiUserIsDepartmentalPartnerOrgAdmin || ApiUserAdminPartnerOrganisations.Contains(cont.PartnerOrganisation.ID)))
            || (cont.PartnerOrganisationRiskID != null && (ApiUserIsDepartmentalPartnerOrgAdmin || ApiUserAdminPartnerOrganisations.Contains(cont.PartnerOrganisationRisk.PartnerOrganisationID)))
            || (cont.PartnerOrganisationRiskMitigationActionID != null && (ApiUserIsDepartmentalPartnerOrgAdmin || ApiUserAdminPartnerOrganisations.Contains(cont.PartnerOrganisationRiskMitigationAction.PartnerOrganisationRisk.PartnerOrganisationID)))
            || (cont.ReportingEntityID != null && cont.ReportingEntity.DirectorateID != null && ApiUserAdminDirectorates.Contains((int)cont.ReportingEntity.DirectorateID))
            || (cont.ReportingEntityID != null && cont.ReportingEntity.ProjectID != null && ApiUserAdminProjects.Contains((int)cont.ReportingEntity.ProjectID))
            || (cont.ReportingEntityID != null && cont.ReportingEntity.PartnerOrganisationID != null && (ApiUserIsDepartmentalPartnerOrgAdmin || ApiUserAdminPartnerOrganisations.Contains((int)cont.ReportingEntity.PartnerOrganisationID))))
                {
                    OrbContext.Contributors.Remove(contributor);
                    return contributor;
                }
            }



            return null;
        }

        public void RemoveRange(IEnumerable<Contributor> contributors)
        {
            OrbContext.Contributors.RemoveRange(contributors);
        }
    }
}