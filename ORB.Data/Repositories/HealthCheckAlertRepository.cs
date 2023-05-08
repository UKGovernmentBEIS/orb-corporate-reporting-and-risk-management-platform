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
    public class HealthCheckAlertRepository : EntityRepository<HealthCheckAlert>, IEntityRepository<HealthCheckAlert>
    {
        public HealthCheckAlertRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options) : base(user, context, options)
        {
        }

        public override IQueryable<HealthCheckAlert> Entities
        {
            get
            {
                return OrbContext.HealthCheckAlerts;
            }
        }

        public HealthCheckAlert Add(HealthCheckAlert entity)
        {
            throw new NotImplementedException();
        }

        public Task<HealthCheckAlert> Edit(int keyValue)
        {
            throw new NotImplementedException();
        }

        public HealthCheckAlert Remove(HealthCheckAlert entity)
        {
            throw new NotImplementedException();
        }
    }
}
