using FluentValidation;
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
    public class CommitmentService : EntityWithStatusService<Commitment>, IEntityService<Commitment>
    {
        private int _directorateBeforePatch;

        public CommitmentService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.Commitments) { }

        protected override void BeforeAdd(Commitment entity)
        {
            base.BeforeAdd(entity);

            SetReportingCycle(entity);
        }

        protected override void BeforePatch(Commitment entity)
        {
            base.BeforePatch(entity);

            _directorateBeforePatch = entity.DirectorateID;
        }

        protected override void AfterPatch(Commitment entity)
        {
            base.AfterPatch(entity);

            if (_directorateBeforePatch != entity.DirectorateID)
            {
                SetReportingCycle(entity);
            }
        }

        protected override void BeforeRemove(Commitment commitment)
        {
            _unitOfWork.Attributes.RemoveRange(_unitOfWork.Attributes.Entities.Where(a => a.CommitmentID == commitment.ID));
            _unitOfWork.Contributors.RemoveRange(_unitOfWork.Contributors.Entities.Where(c => c.CommitmentID == commitment.ID));
        }

        private void SetReportingCycle(Commitment commitment)
        {
            var directorate = _unitOfWork.Directorates.Find(commitment.DirectorateID);
            if (directorate != null)
            {
                ReportingCycleService.CopyReportingCycle(directorate, commitment);
            }
        }
    }
}
