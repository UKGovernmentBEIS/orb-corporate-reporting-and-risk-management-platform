using System.Collections.Generic;
using ORB.Core.Models;

namespace ORB.Core.Repositories
{
    public interface IPartnerOrganisationRiskRiskTypeRepository : IEntityRepository<PartnerOrganisationRiskRiskType>
    {
        void RemoveRange(IEnumerable<PartnerOrganisationRiskRiskType> partnerOrganisationRiskRiskTypes);
    }
}