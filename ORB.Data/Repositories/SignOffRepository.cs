using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using System.Linq;
using System.Security.Principal;
using System.Threading.Tasks;

namespace ORB.Data.Repositories
{
    public class SignOffRepository : EntityUpdateRepository<SignOff>, ISignOffRepository
    {
        private readonly IEntityRepository<CorporateRisk> _corporateRiskRepository;
        private readonly IEntityRepository<FinancialRisk> _financialRiskRepository;

        public SignOffRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options, IEntityRepository<CorporateRisk> corporateRiskRepository, IEntityRepository<FinancialRisk> financialRiskRepository)
        : base(user, context, options)
        {
            _corporateRiskRepository = corporateRiskRepository;
            _financialRiskRepository = financialRiskRepository;
        }

        public override IQueryable<SignOff> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all Sign-Offs
                    return OrbContext.SignOffs;
                }
                else
                {
                    // Sign-Offs for Directorates to which the user is linked
                    var directorateSignOffs = from so in OrbContext.SignOffs
                                              from ud in so.Directorate.UserDirectorates
                                              where ud.User.Username == Username
                                              select so;

                    // Sign-Offs for Projects to which the user is linked
                    var projectSignOffs = from so in OrbContext.SignOffs
                                          from up in so.Project.UserProjects
                                          where up.User.Username == Username
                                          select so;

                    // Sign-Offs for Partner Organisations to which the user is linked
                    var partnerOrgSignOffs = from so in OrbContext.SignOffs
                                             from upo in so.PartnerOrganisation.UserPartnerOrganisations
                                             where upo.User.Username == Username
                                             select so;

                    // All Sign-Offs for Partner Organisations if user is partner org admin
                    var adminPartnerOrgSignOffs = from so in OrbContext.SignOffs
                                                  where so.PartnerOrganisationID != null && ApiUserIsDepartmentalPartnerOrgAdmin
                                                  select so;

                    // Sign-Offs for Risks
                    var corporateRiskSignOffs = from r in _corporateRiskRepository.Entities
                                                from so in r.SignOffs
                                                select so;

                    var financialRiskSignOffs = from r in _financialRiskRepository.Entities
                                                from so in r.SignOffs
                                                select so;

                    var groupSignOffs = (from s in OrbContext.SignOffs
                                         from ug in s.Directorate.Group.UserGroups
                                         where ug.User.Username == Username
                                         select s)
                                    .Union(from s in OrbContext.SignOffs
                                           from ug in s.Project.Directorate.Group.UserGroups
                                           where ug.User.Username == Username
                                           select s)
                                    .Union(from s in OrbContext.SignOffs
                                           from ug in s.PartnerOrganisation.Directorate.Group.UserGroups
                                           where ug.User.Username == Username
                                           select s);

                    return directorateSignOffs
                        .Union(projectSignOffs)
                        .Union(partnerOrgSignOffs)
                        .Union(corporateRiskSignOffs)
                        .Union(financialRiskSignOffs)
                        .Union(adminPartnerOrgSignOffs)
                        .Union(groupSignOffs);
                }
            }
        }

        public SignOff Add(SignOff signOff)
        {
            if (signOff.DirectorateID != null)
            {
                var directorate = OrbContext.Directorates.Find(signOff.DirectorateID);
                if (directorate != null && (ApiUserIsAdmin || directorate.DirectorUserID == ApiUser.ID || directorate.ReportApproverUserID == ApiUser.ID))
                {
                    OrbContext.SignOffs.Add(signOff);
                    return signOff;
                }
            }
            if (signOff.ProjectID != null)
            {
                var project = OrbContext.Projects.Find(signOff.ProjectID);
                if (project != null && (ApiUserIsAdmin || project.SeniorResponsibleOwnerUserID == ApiUser.ID || project.ReportApproverUserID == ApiUser.ID))
                {
                    OrbContext.SignOffs.Add(signOff);
                    return signOff;
                }
            }
            if (signOff.PartnerOrganisationID != null)
            {
                var partnerOrganisation = OrbContext.PartnerOrganisations.Find(signOff.PartnerOrganisationID);
                if (partnerOrganisation != null && (ApiUserIsAdmin || ApiUserIsDepartmentalPartnerOrgAdmin || partnerOrganisation.LeadPolicySponsorUserID == ApiUser.ID || partnerOrganisation.ReportAuthorUserID == ApiUser.ID))
                {
                    OrbContext.SignOffs.Add(signOff);
                    return signOff;
                }
            }
            if (signOff.RiskID != null)
            {
                var risk = OrbContext.CorporateRisks.SingleOrDefault(r => r.ID == signOff.RiskID);
                var financialRisk = OrbContext.FinancialRisks.SingleOrDefault(r => r.ID == signOff.RiskID);
                if (risk != null)
                {
                    if (ApiUserIsDepartmentRiskManager)
                    {
                        OrbContext.SignOffs.Add(signOff);
                        return signOff;
                    }

                    if (risk.IsProjectRisk == true) // Project risk
                    {
                        if (risk.RiskOwnerUserID == ApiUser.ID || risk.ReportApproverUserID == ApiUser.ID)
                        {
                            OrbContext.SignOffs.Add(signOff);
                            return signOff;
                        }
                    }

                    if (risk.RiskRegisterID == (int)RiskRegisters.Departmental) // Departmental
                    {
                        if (risk.RiskOwnerUserID == ApiUser.ID || risk.ReportApproverUserID == ApiUser.ID)
                        {
                            OrbContext.SignOffs.Add(signOff);
                            return signOff;
                        }
                    }

                    if (risk.RiskRegisterID == (int)RiskRegisters.Group) // Group
                    {
                        if (risk.RiskOwnerUserID == ApiUser.ID || risk.ReportApproverUserID == ApiUser.ID)
                        {
                            OrbContext.SignOffs.Add(signOff);
                            return signOff;
                        }
                    }

                    if (risk.RiskRegisterID == (int)RiskRegisters.Directorate) // Directorate
                    {
                        if (risk.RiskOwnerUserID == ApiUser.ID || risk.ReportApproverUserID == ApiUser.ID)
                        {
                            OrbContext.SignOffs.Add(signOff);
                            return signOff;
                        }
                    }
                }
                else if (financialRisk != null)
                {
                    if (ApiUserIsFinancialRiskManager || financialRisk.RiskOwnerUserID == ApiUser.ID || financialRisk.ReportApproverUserID == ApiUser.ID)
                    {
                        OrbContext.SignOffs.Add(signOff);
                        return signOff;
                    }
                }
            }
            return null;
        }

        public SignOff Remove(SignOff user)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.SignOffs.Remove(user);
                return user;
            }
            return null;
        }
    }
}