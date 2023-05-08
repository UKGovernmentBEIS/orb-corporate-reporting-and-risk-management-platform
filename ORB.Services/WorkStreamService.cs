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
    public class WorkStreamService : EntityWithStatusService<WorkStream>, IEntityService<WorkStream>
    {
        public WorkStreamService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.WorkStreams, new WorkStreamValidator(unitOfWork)) { }

        protected override void BeforeAdd(WorkStream entity)
        {
            base.BeforeAdd(entity);

            SetReportingCycle(entity);
        }

        protected override void AfterPatch(WorkStream workStream)
        {
            base.AfterPatch(workStream);

            // Reset reporting cycle in case work stream is moved to a different project
            SetReportingCycle(workStream);
        }

        protected override void BeforeRemove(WorkStream workStream)
        {
            _unitOfWork.Attributes.RemoveRange(_unitOfWork.Attributes.Entities.Where(a => a.WorkStreamID == workStream.ID));
            _unitOfWork.Contributors.RemoveRange(_unitOfWork.Contributors.Entities.Where(c => c.WorkStreamID == workStream.ID));
        }

        private void SetReportingCycle(WorkStream workStream)
        {
            var project = _unitOfWork.Projects.Find(workStream.ProjectID);
            if (project != null)
            {
                ReportingCycleService.CopyReportingCycle(project, workStream);
            }
        }
    }
}
