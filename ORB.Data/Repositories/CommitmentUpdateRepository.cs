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
    public class CommitmentUpdateRepository : EntityUpdateRepository<CommitmentUpdate>, IEntityUpdateRepository<CommitmentUpdate>
    {
        public CommitmentUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<CommitmentUpdate> Entities
        {
            get
            {
                var userId = ApiUser.ID;
                return (from c in OrbContext.CommitmentUpdates
                        join ud in OrbContext.UserDirectorates on c.Commitment.DirectorateID equals ud.DirectorateID into uds
                        from ud in uds.DefaultIfEmpty()
                        join con in OrbContext.Contributors on c.CommitmentID equals con.CommitmentID into cs
                        from con in cs.DefaultIfEmpty()
                        from ur in OrbContext.UserRoles
                        where ud.UserID == userId || con.ContributorUserID == userId || (ur.RoleID == (int)AdminRoles.SystemAdmin && ur.UserID == userId)
                        select c).Distinct();
            }
        }

        public CommitmentUpdate Add(CommitmentUpdate commitmentUpdate)
        {
            var userId = ApiUser.ID;

            var commitment = OrbContext.Commitments.Include(c => c.Contributors).Include(c => c.Directorate).SingleOrDefault(c => c.ID == commitmentUpdate.CommitmentID);
            if (commitment != null && (ApiUserIsAdmin
                || ApiUserAdminDirectorates.Contains(commitment.DirectorateID)
                || commitment.Contributors.Select(c => c.ContributorUserID).Contains(userId)
                || userId == commitment.Directorate.DirectorUserID
                || userId == commitment.Directorate.ReportApproverUserID
                || userId == commitment.LeadUserID))
            {
                OrbContext.CommitmentUpdates.Add(commitmentUpdate);
                return commitmentUpdate;
            }
            return null;
        }
    }
}