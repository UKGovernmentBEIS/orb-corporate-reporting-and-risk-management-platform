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

    public class CommitmentRepository : EntityRepository<Commitment>, IEntityRepository<Commitment>
    {
        public CommitmentRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<Commitment> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all Commitments
                    return OrbContext.Commitments;
                }
                else
                {
                    return from c in OrbContext.Commitments
                           from ud in c.Directorate.UserDirectorates
                           where ud.User.Username == Username
                           select c;
                }
            }
        }

        public async Task<Commitment> Edit(int keyValue)
        {
            var commitment = await Entities.Include(c => c.Directorate).SingleOrDefaultAsync(m => m.ID == keyValue);

            if (ApiUserIsAdmin || (commitment != null && (
                ApiUserAdminDirectorates.Contains(commitment.DirectorateID)
                || commitment.Directorate.DirectorUserID == ApiUser.ID
                || commitment.Directorate.ReportApproverUserID == ApiUser.ID
                )))
            {
                return commitment;
            }
            return null;
        }

        public Commitment Add(Commitment commitment)
        {
            if (ApiUserIsAdmin || ApiUserAdminDirectorates.Contains(commitment.DirectorateID))
            {
                OrbContext.Commitments.Add(commitment);
                return commitment;
            }
            return null;
        }

        public Commitment Remove(Commitment commitment)
        {
            if (ApiUserIsAdmin || ApiUserAdminDirectorates.Contains(commitment.DirectorateID))
            {
                OrbContext.Commitments.Remove(commitment);
                return commitment;
            }
            return null;
        }
    }
}