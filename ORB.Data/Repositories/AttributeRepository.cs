using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using models = ORB.Core.Models;
using ORB.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Threading.Tasks;

namespace ORB.Data.Repositories
{
    public class AttributeRepository : EntityRepository<models.Attribute>, IAttributeRepository
    {
        public AttributeRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
         : base(user, context, options) { }

        public override IQueryable<models.Attribute> Entities
        {
            get
            {
                
                return (
                        from a in OrbContext.Attributes
                        where OrbContext.UserRoles.Any(ur => ur.User.Username == Username && ur.RoleID == (int)AdminRoles.SystemAdmin)
                        || a.KeyWorkArea.Directorate.UserDirectorates.Any(ud => ud.User.Username == Username)
                        || a.Metric.Directorate.UserDirectorates.Any(ud => ud.User.Username == Username)
                        || a.Commitment.Directorate.UserDirectorates.Any(ud => ud.User.Username == Username)
                        || a.Milestone.KeyWorkArea.Directorate.UserDirectorates.Any(ud => ud.User.Username == Username)
                        || a.WorkStream.Project.UserProjects.Any(up => up.User.Username == Username)
                        || a.Benefit.Project.UserProjects.Any(up => up.User.Username == Username)
                        || a.Dependency.Project.UserProjects.Any(up => up.User.Username == Username)
                        || a.Milestone.WorkStream.Project.UserProjects.Any(up => up.User.Username == Username)
                        || a.Milestone.PartnerOrganisation.UserPartnerOrganisations.Any(upo => upo.User.Username == Username)
                        || a.Directorate.UserDirectorates.Any(ud => ud.User.Username == Username)
                        || a.Project.UserProjects.Any(up => up.User.Username == Username)
                        || a.ReportingEntity.Directorate.UserDirectorates.Any(ud => ud.User.Username == Username)
                        || a.ReportingEntity.Project.UserProjects.Any(up => up.User.Username == Username)
                        || a.ReportingEntity.PartnerOrganisation.UserPartnerOrganisations.Any(upo => upo.User.Username == Username)
                        select a
                    );
                
            }
        }

        public async Task<models.Attribute> Edit(int keyValue)
        {
            return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
        }

        public models.Attribute Add(models.Attribute attribute)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.Attributes.Add(attribute);
                return attribute;
            }

            if (ApiUserIsDepartmentRiskManager)
            {
                var corpRisk = OrbContext.CorporateRisks.Find(attribute.RiskID);
                if (corpRisk != null)
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }
            }

            if (ApiUserIsDepartmentalPartnerOrgAdmin)
            {
                var partnerOrgRisk = OrbContext.PartnerOrganisationRisks.Find(attribute.PartnerOrganisationRiskID);
                if (partnerOrgRisk != null)
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }
            }

            if (ApiUserIsFinancialRiskManager)
            {
                var financialRisk = OrbContext.FinancialRisks.Find(attribute.RiskID);
                if (financialRisk != null)
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }
            }

            // Directorate entities
            if (attribute.DirectorateID != null)
            {
                var directorate = OrbContext.Directorates.Find(attribute.DirectorateID);
                if (directorate != null && (ApiUserAdminDirectorates.Contains(directorate.ID) || ApiUser.ID == directorate.DirectorUserID))
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }
            }
            if (attribute.KeyWorkAreaID != null)
            {
                var kwa = OrbContext.KeyWorkAreas.Find(attribute.KeyWorkAreaID);
                if (kwa != null && (ApiUserAdminDirectorates.Contains(kwa.DirectorateID) || ApiUser.ID == kwa.LeadUserID))
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }
            }
            if (attribute.MetricID != null)
            {
                var m = OrbContext.Metrics.Find(attribute.MetricID);
                if (m != null && (ApiUserAdminDirectorates.Contains(m.DirectorateID) || ApiUser.ID == m.LeadUserID))
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }
            }
            if (attribute.CommitmentID != null)
            {
                var c = OrbContext.Commitments.Find(attribute.CommitmentID);
                if (c != null && (ApiUserAdminDirectorates.Contains(c.DirectorateID) || ApiUser.ID == c.LeadUserID))
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }
            }

            // Project entities
            if (attribute.ProjectID != null)
            {
                var project = OrbContext.Projects.Find(attribute.ProjectID);
                if (project != null && (ApiUserAdminProjects.Contains(project.ID)
                || ApiUser.ID == project.SeniorResponsibleOwnerUserID
                || ApiUser.ID == project.ReportApproverUserID
                || ApiUser.ID == project.ProjectManagerUserID
                || ApiUser.ID == project.ReportingLeadUserID))
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }
            }
            if (attribute.WorkStreamID != null)
            {
                var ws = OrbContext.WorkStreams.Find(attribute.WorkStreamID);
                if (ws != null && (ApiUserAdminProjects.Contains(ws.ProjectID) || ApiUser.ID == ws.LeadUserID))
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }
            }
            if (attribute.BenefitID != null)
            {
                var b = OrbContext.Benefits.Find(attribute.BenefitID);
                if (b != null && (ApiUserAdminProjects.Contains(b.ProjectID) || ApiUser.ID == b.LeadUserID))
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }
            }
            if (attribute.DependencyID != null)
            {
                var d = OrbContext.Dependencies.Find(attribute.DependencyID);
                if (d != null && (ApiUserAdminProjects.Contains(d.ProjectID) || ApiUser.ID == d.LeadUserID))
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }
            }

            // Milestones (can be linked to Projects (via Work Streams) or Directorates (via Key Work Areas)) or Partner Organisations
            if (attribute.MilestoneID != null)
            {
                var m = OrbContext.Milestones
                    .Include(m => m.WorkStream)
                    .Include(m => m.KeyWorkArea)
                    .SingleOrDefault(m => m.ID == attribute.MilestoneID);

                if (m != null && ((m.WorkStream != null && ApiUserAdminProjects.Contains(m.WorkStream.ProjectID))
                    || (m.KeyWorkArea != null && ApiUserAdminDirectorates.Contains(m.KeyWorkArea.DirectorateID))
                    || (m.PartnerOrganisationID != null && ApiUserPartnerOrganisations.Contains((int)m.PartnerOrganisationID))
                    || ApiUser.ID == m.LeadUserID))
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }
            }

            // Risks
            if (attribute.RiskID != null)
            {
                var r = OrbContext.CorporateRisks.Find(attribute.RiskID);
                if (r != null && (ApiUserAdminDirectorateRisks.Contains((int)r.DirectorateID) || ApiUser.ID == r.RiskOwnerUserID || ApiUser.ID == r.ReportApproverUserID))
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }

                var fr = OrbContext.FinancialRisks.Find(attribute.RiskID);
                if (fr != null && (ApiUserFinancialRiskGroups.Contains((int)fr.GroupID) || ApiUser.ID == fr.RiskOwnerUserID || ApiUser.ID == fr.ReportApproverUserID))
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }
            }

            // Partner org risks
            if (attribute.PartnerOrganisationRiskID != null)
            {
                var r = OrbContext.PartnerOrganisationRisks.Find(attribute.PartnerOrganisationRiskID);
                if (r != null && (ApiUserAdminPartnerOrganisations.Contains(r.PartnerOrganisationID) || ApiUser.ID == r.RiskOwnerUserID || ApiUser.ID == r.BeisRiskOwnerUserID))
                {
                    OrbContext.Attributes.Add(attribute);
                    return attribute;
                }
            }

            // Custom reporting entities
            if (attribute.ReportingEntityID != null)
            {
                var reportingEntity = OrbContext.ReportingEntities.SingleOrDefault(re => re.ID == attribute.ReportingEntityID);
                if (reportingEntity != null)
                {
                    if ((reportingEntity.DirectorateID != null && ApiUserAdminDirectorates.Contains((int)reportingEntity.DirectorateID))
                        || (reportingEntity.ProjectID != null && ApiUserAdminProjects.Contains((int)reportingEntity.ProjectID))
                        || (reportingEntity.PartnerOrganisationID != null && ApiUserAdminPartnerOrganisations.Contains((int)reportingEntity.PartnerOrganisationID)))
                    {
                        OrbContext.Attributes.Add(attribute);
                        return attribute;
                    }
                }


            }

            return null;
        }

        public models.Attribute Remove(models.Attribute attribute)
        {
            if (ApiUserIsAdmin ||
                (attribute.DirectorateID != null && ApiUserAdminDirectorates.Contains((int)attribute.DirectorateID)) ||
                (attribute.ProjectID != null && ApiUserAdminProjects.Contains((int)attribute.ProjectID)) ||
                    (attribute.KeyWorkArea != null && ApiUserAdminDirectorates.Contains(attribute.KeyWorkArea.DirectorateID)) ||
                    (attribute.Metric != null && ApiUserAdminDirectorates.Contains(attribute.Metric.DirectorateID)) ||
                    (attribute.Commitment != null && ApiUserAdminDirectorates.Contains(attribute.Commitment.DirectorateID)) ||
                    (attribute.WorkStream != null && ApiUserAdminProjects.Contains(attribute.WorkStream.ProjectID)) ||
                    (attribute.Benefit != null && ApiUserAdminProjects.Contains(attribute.Benefit.ProjectID)) ||
                    (attribute.Dependency != null && ApiUserAdminProjects.Contains(attribute.Dependency.ProjectID)) ||
                    (attribute.Milestone != null &&
                        (
                            (attribute.Milestone.KeyWorkArea != null && ApiUserAdminDirectorates.Contains(attribute.Milestone.KeyWorkArea.DirectorateID)) ||
                            (attribute.Milestone.WorkStream != null && ApiUserAdminProjects.Contains(attribute.Milestone.WorkStream.ProjectID)) ||
                            (attribute.Milestone.PartnerOrganisationID != null && ApiUserAdminPartnerOrganisations.Contains((int)attribute.Milestone.PartnerOrganisationID))
                        )
                    ) ||
                    (attribute.ReportingEntity != null &&
                    (
                        (attribute.ReportingEntity.DirectorateID != null && ApiUserAdminDirectorates.Contains((int)attribute.ReportingEntity.DirectorateID)) ||
                        (attribute.ReportingEntity.ProjectID != null && ApiUserAdminProjects.Contains((int)attribute.ReportingEntity.ProjectID)) ||
                        (attribute.ReportingEntity.PartnerOrganisationID != null && ApiUserAdminPartnerOrganisations.Contains((int)attribute.ReportingEntity.PartnerOrganisationID))
                    ))
                )
            {
                OrbContext.Attributes.Remove(attribute);
                return attribute;
            }

            return null;
        }

        public void RemoveRange(IEnumerable<models.Attribute> attributes)
        {
            OrbContext.Attributes.RemoveRange(attributes);
        }
    }
}