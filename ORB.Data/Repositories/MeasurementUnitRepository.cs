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
    public class MeasurementUnitRepository : EntityRepository<MeasurementUnit>, IEntityRepository<MeasurementUnit>
    {
        public MeasurementUnitRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public IQueryable<MeasurementUnit> MeasurementUnits { get { return Entities; } }

        public override IQueryable<MeasurementUnit> Entities
        {
            get
            {
                return OrbContext.MeasurementUnits;
            }
        }

        public async Task<MeasurementUnit> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
            }
            return null;
        }

        public MeasurementUnit Add(MeasurementUnit measurementUnit)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.MeasurementUnits.Add(measurementUnit);
                return measurementUnit;
            }
            return null;
        }

        public MeasurementUnit Remove(MeasurementUnit measurementUnit)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.MeasurementUnits.Remove(measurementUnit);
                return measurementUnit;
            }
            return null;
        }
    }
}