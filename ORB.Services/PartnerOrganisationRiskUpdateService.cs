using Microsoft.AspNet.OData;
using Microsoft.EntityFrameworkCore;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services.Validations;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class PartnerOrganisationRiskUpdateService : EntityUpdateService<PartnerOrganisationRiskUpdate>, IEntityUpdateService<PartnerOrganisationRiskUpdate>
    {
        public PartnerOrganisationRiskUpdateService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.PartnerOrganisationRiskUpdates) { }

        protected override void BeforeAdd(PartnerOrganisationRiskUpdate riskUpdate)
        {
            base.BeforeAdd(riskUpdate);

            // Set read-only details
            riskUpdate.IsCurrent = true;
            
            var lastApprovals = _repository.Entities.Where(ru => ru.IsCurrent == true && ru.UpdatePeriod == riskUpdate.UpdatePeriod && ru.PartnerOrganisationRiskID == riskUpdate.PartnerOrganisationRiskID);
            foreach (var l in lastApprovals) l.IsCurrent = false;
        }
    }
}
