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
    public class MetricRepository : EntityRepository<Metric>, IEntityRepository<Metric>
    {
        public MetricRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<Metric> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all Metrics
                    return OrbContext.Metrics;
                }
                else
                {
                    return from m in OrbContext.Metrics
                           from ud in m.Directorate.UserDirectorates
                           where ud.User.Username == Username
                           select m;
                }
            }
        }

        public async Task<Metric> Edit(int keyValue)
        {
            var metric = await Entities.Include(m => m.Directorate).SingleOrDefaultAsync(m => m.ID == keyValue);

            if (ApiUserIsAdmin || (metric != null && (
                ApiUserAdminDirectorates.Contains(metric.DirectorateID)
                || metric.Directorate.DirectorUserID == ApiUser.ID
                || metric.Directorate.ReportApproverUserID == ApiUser.ID
                )))
            {
                return metric;
            }
            return null;
        }

        public Metric Add(Metric metric)
        {
            if (ApiUserIsAdmin || ApiUserAdminDirectorates.Contains(metric.DirectorateID))
            {
                OrbContext.Metrics.Add(metric);
                return metric;
            }
            return null;
        }

        public Metric Remove(Metric metric)
        {
            if (ApiUserIsAdmin || ApiUserAdminDirectorates.Contains(metric.DirectorateID))
            {
                OrbContext.Metrics.Remove(metric);
                return metric;
            }
            return null;
        }
    }
}