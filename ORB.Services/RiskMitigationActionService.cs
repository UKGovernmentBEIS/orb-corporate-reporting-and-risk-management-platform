using Microsoft.AspNet.OData;
using Microsoft.EntityFrameworkCore;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using ORB.Core.Services;
using ORB.Services.Validations;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class RiskMitigationActionService<TEntity> : EntityWithStatusService<TEntity>, IEntityService<TEntity> where TEntity : RiskMitigationAction
    {
        private int _riskBeforePatch;

        public RiskMitigationActionService(IUnitOfWork unitOfWork, IEntityRepository<TEntity> repository, RiskMitigationActionValidator<TEntity> validator) : base(unitOfWork, repository, validator) { }

        protected override void BeforeAdd(TEntity entity)
        {
            base.BeforeAdd(entity);

            SetRiskMitigationActionSequentialId(entity);
            SetReportingCycle(entity);
        }

        protected override void BeforePatch(TEntity entity)
        {
            base.BeforePatch(entity);

            _riskBeforePatch = entity.RiskID;
        }

        protected override void AfterPatch(TEntity entity)
        {
            base.AfterPatch(entity);

            if (_riskBeforePatch != entity.RiskID)
            {
                SetReportingCycle(entity);
            }
        }

        protected override void BeforeRemove(TEntity entity)
        {
            _unitOfWork.Contributors.RemoveRange(_unitOfWork.Contributors.Entities.Where(c => c.RiskMitigationActionID == entity.ID));
            _unitOfWork.CorporateRiskRiskMitigationActions.RemoveRange(_unitOfWork.CorporateRiskRiskMitigationActions.Entities.Where(c => c.RiskMitigationActionID == entity.ID));
        }

        private void SetRiskMitigationActionSequentialId(TEntity rma)
        {
            var lastRiskAction = _repository.Entities.OrderByDescending(a => a.ID).FirstOrDefault(a => a.RiskID == rma.RiskID);
            if (lastRiskAction != null)
            {
                rma.RiskMitigationActionCode = lastRiskAction.RiskMitigationActionCode + 1;
            }
            else
            {
                rma.RiskMitigationActionCode = 1;
            }
        }

        protected virtual void SetReportingCycle(TEntity rma) { }
    }
}
