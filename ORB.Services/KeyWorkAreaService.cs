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
    public class KeyWorkAreaService : EntityWithStatusService<KeyWorkArea>, IEntityService<KeyWorkArea>
    {
        private int _directorateBeforePatch;

        public KeyWorkAreaService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.KeyWorkAreas) { }

        protected override void BeforeAdd(KeyWorkArea keyWorkArea)
        {
            base.BeforeAdd(keyWorkArea);

            SetReportingCycle(keyWorkArea);
        }

        protected override void BeforePatch(KeyWorkArea entity)
        {
            base.BeforePatch(entity);

            _directorateBeforePatch = entity.DirectorateID;
        }

        protected override void AfterPatch(KeyWorkArea entity)
        {
            base.AfterPatch(entity);

            if (entity.DirectorateID != _directorateBeforePatch)
            {
                SetReportingCycle(entity);
                SetReportingCycleOnMilestones(entity);
            }
        }

        protected override void BeforeRemove(KeyWorkArea keyWorkArea)
        {
            _unitOfWork.Attributes.RemoveRange(_unitOfWork.Attributes.Entities.Where(a => a.KeyWorkAreaID == keyWorkArea.ID));
            _unitOfWork.Contributors.RemoveRange(_unitOfWork.Contributors.Entities.Where(c => c.KeyWorkAreaID == keyWorkArea.ID));
        }

        private void SetReportingCycle(KeyWorkArea keyWorkArea)
        {
            var directorate = _unitOfWork.Directorates.Find(keyWorkArea.DirectorateID);
            if (directorate != null)
            {
                ReportingCycleService.CopyReportingCycle(directorate, keyWorkArea);
            }
        }

        private void SetReportingCycleOnMilestones(KeyWorkArea keyWorkArea)
        {
            foreach (var milestone in _unitOfWork.Milestones.Entities.Where(m => m.KeyWorkAreaID == keyWorkArea.ID))
            {
                ReportingCycleService.CopyReportingCycle(keyWorkArea, milestone);
            }
        }
    }
}
