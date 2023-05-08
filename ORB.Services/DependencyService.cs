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
    public class DependencyService : EntityWithStatusService<Dependency>, IEntityService<Dependency>
    {
        private int _projectBeforePatch;

        public DependencyService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.Dependencies, new DependencyValidator(unitOfWork)) { }

        protected override void BeforeAdd(Dependency entity)
        {
            base.BeforeAdd(entity);

            SetReportingCycle(entity);
        }

        protected override void BeforePatch(Dependency entity)
        {
            base.BeforePatch(entity);

            _projectBeforePatch = entity.ProjectID;
        }

        protected override void AfterPatch(Dependency entity)
        {
            base.AfterPatch(entity);

            if (_projectBeforePatch == entity.ProjectID)
            {
                SetReportingCycle(entity);
            }
        }

        protected override void BeforeRemove(Dependency dependency)
        {
            _unitOfWork.Attributes.RemoveRange(_unitOfWork.Attributes.Entities.Where(a => a.DependencyID == dependency.ID));
            _unitOfWork.Contributors.RemoveRange(_unitOfWork.Contributors.Entities.Where(c => c.DependencyID == dependency.ID));
        }

        private void SetReportingCycle(Dependency dependency)
        {
            var project = _unitOfWork.Projects.Find(dependency.ProjectID);
            if (project != null)
            {
                ReportingCycleService.CopyReportingCycle(project, dependency);
            }
        }
    }
}
