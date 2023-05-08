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
    public class MilestoneService : EntityWithStatusService<Milestone>, IEntityService<Milestone>
    {
        private int? _keyWorkAreaBeforePatch;
        private int? _workStreamBeforePatch;
        private int? _partnerOrganisationBeforePatch;

        public MilestoneService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.Milestones, new MilestoneValidator(unitOfWork)) { }

        protected override void BeforeAdd(Milestone entity)
        {
            base.BeforeAdd(entity);

            SetReportingCycle(entity);
        }

        protected override void BeforePatch(Milestone entity)
        {
            base.BeforePatch(entity);

            _keyWorkAreaBeforePatch = entity.KeyWorkAreaID;
            _workStreamBeforePatch = entity.WorkStreamID;
            _partnerOrganisationBeforePatch = entity.PartnerOrganisationID;
        }

        protected override void AfterPatch(Milestone entity)
        {
            base.AfterPatch(entity);

            if (_keyWorkAreaBeforePatch != entity.KeyWorkAreaID || _workStreamBeforePatch != entity.WorkStreamID || _partnerOrganisationBeforePatch != entity.PartnerOrganisationID)
            {
                SetReportingCycle(entity);
            }
        }

        protected override void BeforeRemove(Milestone milestone)
        {
            _unitOfWork.Attributes.RemoveRange(_unitOfWork.Attributes.Entities.Where(a => a.MilestoneID == milestone.ID));
            _unitOfWork.Contributors.RemoveRange(_unitOfWork.Contributors.Entities.Where(c => c.MilestoneID == milestone.ID));
        }

        private void SetReportingCycle(Milestone milestone)
        {
            if (milestone.KeyWorkAreaID != null)
            {
                var keyWorkArea = _unitOfWork.KeyWorkAreas.Find((int)milestone.KeyWorkAreaID);
                if (keyWorkArea != null)
                {
                    ReportingCycleService.CopyReportingCycle(keyWorkArea, milestone);
                }
            }
            else if (milestone.WorkStreamID != null)
            {
                var workStream = _unitOfWork.WorkStreams.Find((int)milestone.WorkStreamID);
                if (workStream != null)
                {
                    ReportingCycleService.CopyReportingCycle(workStream, milestone);
                }
            }
            else if (milestone.PartnerOrganisationID != null)
            {
                var partnerOrg = _unitOfWork.PartnerOrganisations.Find((int)milestone.PartnerOrganisationID);
                if (partnerOrg != null)
                {
                    ReportingCycleService.CopyReportingCycle(partnerOrg, milestone);
                }
            }
        }
    }
}
