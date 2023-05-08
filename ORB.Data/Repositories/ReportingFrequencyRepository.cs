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
    public class ReportingFrequencyRepository : OrbRepository<ReportingFrequency>, IEntityRepository<ReportingFrequency>
    {
        public ReportingFrequencyRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<ReportingFrequency> Entities
        {
            get
            {
                return OrbContext.ReportingFrequencies;
            }
        }

        public async Task<ReportingFrequency> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
            }
            return null;
        }

        public ReportingFrequency Add(ReportingFrequency reportingFrequency)
        {
            // Do not allow add. Development work required.
            return null;
        }

        public ReportingFrequency Remove(ReportingFrequency ragOption)
        {
            // Do not allow delete.
            return null;
        }
    }
}