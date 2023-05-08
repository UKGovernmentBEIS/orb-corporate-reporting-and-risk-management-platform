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

namespace ORB.Data.Repositories
{
    public abstract class OrbRepository<TEntity> : Repository<TEntity>, IOrbRepository<TEntity> where TEntity : ObjectWithId
    {
        protected User _user;

        protected OrbRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public abstract IQueryable<TEntity> Entities { get; }

        public TEntity Find(int id)
        {
            return Entities.SingleOrDefault(e => e.ID == id);
        }

        protected OrbContext OrbContext
        {
            get { return _db as OrbContext; }
        }

        public User ApiUser
        {
            get
            {
                if (_user != null)
                {
                    return _user;
                }
                else
                {
                    if (ApiUserIsClientService)
                    {
                        return _user = new User() { Username = Username };
                    }

                    var user = OrbContext.Users
                        .Include(u => u.UserRoles)
                        .Include(u => u.UserGroups)
                        .Include(u => u.UserDirectorates)
                        .Include(u => u.UserPartnerOrganisations)
                        .Include(u => u.UserProjects)
                        .Include(u => u.FinancialRiskUserGroups)
                        .OrderBy(u => u.ID)
                        .AsSplitQuery()
                        .SingleOrDefault(u => u.Username == Username);

                    if (user == null)
                    {
                        var msg = $"Cannot find user record for username {Username}.";
                        var ex = new AuthorizationException(msg);
                        throw ex;
                    }
                    else
                    {
                        return _user = user;
                    }
                }
            }
        }

        protected bool ApiUserIsAdmin
        {
            get
            {
                return ApiUserIsClientService || ApiUser.UserRoles.Any(ur => ur.RoleID == (int)AdminRoles.SystemAdmin);
            }
        }

        protected bool ApiUserIsClientService
        {
            get
            {
                return false;
            }
        }

        protected bool ApiUserIsDepartmentRiskManager
        {
            get
            {
                return ApiUserIsClientService || ApiUser.UserRoles.Any(ur => ur.RoleID == (int)AdminRoles.RiskAdmin);
            }
        }

        protected bool ApiUserIsFinancialRiskManager
        {
            get
            {
                return ApiUser.UserRoles.Any(ur => ur.RoleID == (int)AdminRoles.FinancialRiskAdmin);
            }
        }

        protected bool ApiUserIsDepartmentalPartnerOrgAdmin
        {
            get
            {
                return ApiUserIsClientService || ApiUser.UserRoles.Any(ur => ur.RoleID == (int)AdminRoles.PartnerOrganisationAdmin);
            }
        }

        protected bool ApiUserIsCustomSectionsAdmin
        {
            get
            {
                return ApiUser.UserRoles.Any(ur => ur.RoleID == (int)AdminRoles.CustomSectionsAdmin);
            }
        }

        protected IEnumerable<int> ApiUserAdminGroups
        {
            get
            {
                return ApiUser.UserGroups.Select(ud => ud.GroupID);
            }
        }

        protected IEnumerable<int> ApiUserAdminGroupRisks
        {
            get
            {
                return ApiUser.UserGroups.Where(ug => ug.IsRiskAdmin).Select(ud => ud.GroupID);
            }
        }

        protected IEnumerable<int> ApiUserAdminDirectorates
        {
            get
            {
                return ApiUser.UserDirectorates.Where(ud => ud.IsAdmin).Select(ud => ud.DirectorateID);
            }
        }

        protected IEnumerable<int> ApiUserAdminPartnerOrganisations
        {
            get
            {
                return ApiUser.UserPartnerOrganisations.Where(ud => ud.IsAdmin).Select(ud => ud.PartnerOrganisationID);
            }
        }

        protected IEnumerable<int> ApiUserAdminDirectorateRisks
        {
            get
            {
                return ApiUser.UserDirectorates.Where(ud => ud.IsRiskAdmin).Select(ud => ud.DirectorateID);
            }
        }

        protected IEnumerable<int> ApiUserAdminProjects
        {
            get
            {
                return ApiUser.UserProjects.Where(up => up.IsAdmin).Select(up => up.ProjectID);
            }
        }

        protected IEnumerable<int> ApiUserAdminProjectRisks
        {
            get
            {
                return ApiUser.UserProjects.Where(up => up.IsRiskAdmin).Select(up => up.ProjectID);
            }
        }

        protected IEnumerable<int> ApiUserDirectorates
        {
            get
            {
                return ApiUser.UserDirectorates.Select(ud => ud.DirectorateID);
            }
        }

        protected IEnumerable<int> ApiUserProjects
        {
            get
            {
                return ApiUser.UserProjects.Select(up => up.ProjectID);
            }
        }

        protected IEnumerable<int> ApiUserPartnerOrganisations
        {
            get
            {
                return ApiUser.UserPartnerOrganisations.Select(up => up.PartnerOrganisationID);
            }
        }

        protected IEnumerable<int> ApiUserFinancialRiskGroups
        {
            get
            {
                return ApiUser.FinancialRiskUserGroups.Select(ud => ud.GroupID);
            }
        }
    }
}