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
    public class MetricUpdateRepository : EntityUpdateRepository<MetricUpdate>, IEntityUpdateRepository<MetricUpdate>
    {
        public MetricUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<MetricUpdate> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all Metric Updates
                    return OrbContext.MetricUpdates;
                }
                else
                {
                    return (from ud in OrbContext.UserDirectorates
                            where ud.User.Username == Username
                            from m in ud.Directorate.Metrics
                            from mu in m.MetricUpdates
                            select mu);
                }
            }
        }

        public MetricUpdate Add(MetricUpdate metricUpdate)
        {
            var userId = ApiUser.ID;

            var metric = OrbContext.Metrics.Include(m => m.Contributors).Include(m => m.Directorate).SingleOrDefault(m => m.ID == metricUpdate.MetricID);
            if (metric != null && (ApiUserIsAdmin
                || ApiUserAdminDirectorates.Contains(metric.DirectorateID)
                || metric.Contributors.Select(c => c.ContributorUserID).Contains(userId)
                || userId == metric.Directorate.DirectorUserID
                || userId == metric.Directorate.ReportApproverUserID
                || userId == metric.LeadUserID))
            {
                OrbContext.MetricUpdates.Add(metricUpdate);
                return metricUpdate;
            }
            return null;
        }

        public MetricUpdate Remove(MetricUpdate metricUpdate)
        {
            var metric = OrbContext.Metrics.Find(metricUpdate.MetricID);
            if (ApiUserIsAdmin || ApiUserAdminDirectorates.Contains(metric.DirectorateID))
            {
                OrbContext.MetricUpdates.Remove(metricUpdate);
                return metricUpdate;
            }
            return null;
        }
    }
}