using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services.Validations;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class CustomReportingEntityService : ReportingEntityService<CustomReportingEntity>, IReportingEntityService<CustomReportingEntity>
    {
        private int? _directorateBeforePatch;
        private int? _projectBeforePatch;
        private int? _partnerOrganisationBeforePatch;

        public CustomReportingEntityService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.ReportingEntities, new CustomReportingEntityValidator(unitOfWork)) { }

        protected override void BeforeAdd(CustomReportingEntity entity)
        {
            base.BeforeAdd(entity);

            SetReportingCycle(entity);
        }

        protected override void BeforePatch(CustomReportingEntity entity)
        {
            base.BeforePatch(entity);

            _directorateBeforePatch = entity.DirectorateID;
            _projectBeforePatch = entity.ProjectID;
            _partnerOrganisationBeforePatch = entity.PartnerOrganisationID;
        }

        protected override void AfterPatch(CustomReportingEntity entity)
        {
            base.AfterPatch(entity);

            if (entity.DirectorateID != _directorateBeforePatch || entity.ProjectID != _projectBeforePatch || entity.PartnerOrganisationID != _partnerOrganisationBeforePatch)
            {
                SetReportingCycle(entity);
            }
        }

        protected override void BeforeRemove(CustomReportingEntity entity)
        {
            base.BeforeRemove(entity);

            _unitOfWork.Attributes.RemoveRange(_unitOfWork.Attributes.Entities.Where(a => a.ReportingEntityID == entity.ID));
            _unitOfWork.Contributors.RemoveRange(_unitOfWork.Contributors.Entities.Where(c => c.ReportingEntityID == entity.ID));
        }

        private void SetReportingCycle(CustomReportingEntity entity)
        {
            if (entity.DirectorateID != null)
            {
                var directorate = _unitOfWork.Directorates.Find((int)entity.DirectorateID);
                if (directorate != null)
                {
                    ReportingCycleService.CopyReportingCycle(directorate, entity);
                }
            }

            if (entity.ProjectID != null)
            {
                var project = _unitOfWork.Projects.Find((int)entity.ProjectID);
                if (project != null)
                {
                    ReportingCycleService.CopyReportingCycle(project, entity);
                }
            }

            if (entity.PartnerOrganisationID != null)
            {
                var partnerOrg = _unitOfWork.PartnerOrganisations.Find((int)entity.PartnerOrganisationID);
                if (partnerOrg != null)
                {
                    ReportingCycleService.CopyReportingCycle(partnerOrg, entity);
                }
            }
        }
    }
}
