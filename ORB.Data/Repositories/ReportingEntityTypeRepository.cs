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
    public class ReportingEntityTypeRepository : EntityRepository<CustomReportingEntityType>, IEntityRepository<CustomReportingEntityType>
    {
        public ReportingEntityTypeRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<CustomReportingEntityType> Entities
        {
            get
            {
                return OrbContext.ReportingEntityTypes;
            }
        }

        public async Task<CustomReportingEntityType> Edit(int keyValue)
        {
            if (ApiUserIsCustomSectionsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(r => r.ID == keyValue && keyValue > 0);
            }

            return await Task.FromResult<CustomReportingEntityType>(null);
        }

        public CustomReportingEntityType Add(CustomReportingEntityType reportingEntityType)
        {
            if (ApiUserIsCustomSectionsAdmin)
            {
                OrbContext.ReportingEntityTypes.Add(reportingEntityType);
                return reportingEntityType;
            }

            return null;
        }

        public CustomReportingEntityType Remove(CustomReportingEntityType reportingEntityType)
        {
            if (ApiUserIsCustomSectionsAdmin && reportingEntityType.ID > 0)
            {
                OrbContext.ReportingEntityTypes.Remove(reportingEntityType);
                return reportingEntityType;
            }

            return null;
        }
    }
}