using Microsoft.AspNet.OData;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services.Validations;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class CorporateRiskService : EntityWithStatusService<CorporateRisk>, IEntityService<CorporateRisk>
    {
        private readonly RiskSettings _settings;
        private int _directorateBeforePatch;
        private int? _projectBeforePatch;

        public CorporateRiskService(IUnitOfWork unitOfWork, IOptions<RiskSettings> options) : base(unitOfWork, unitOfWork.CorporateRisks, new CorporateRiskValidator(unitOfWork))
        {
            _settings = options.Value;
        }

        protected override void BeforeAdd(CorporateRisk entity)
        {
            base.BeforeAdd(entity);

            SetReportingCycle(entity);
        }

        protected async override Task AfterAdd(CorporateRisk entity)
        {
            SetRiskCode(entity);
            await _unitOfWork.SaveChanges();
        }

        protected override void BeforePatch(CorporateRisk entity)
        {
            base.BeforePatch(entity);

            _directorateBeforePatch = (int)entity.DirectorateID;
            _projectBeforePatch = entity.ProjectID;
        }

        protected override void AfterPatch(CorporateRisk entity)
        {
            base.AfterPatch(entity);

            SetRiskCode(entity);

            if (_directorateBeforePatch != entity.DirectorateID || _projectBeforePatch != entity.ProjectID)
            {
                SetReportingCycle(entity);
                SetReportingCycleOnActions(entity);
            }
        }

        protected override void BeforeClose(CorporateRisk entity)
        {
            base.BeforeClose(entity);

            CloseRisksRiskMitigationActions(entity);
        }

        protected override void BeforeRemove(CorporateRisk risk)
        {
            _unitOfWork.Attributes.RemoveRange(_unitOfWork.Attributes.Entities.Where(a => a.RiskID == risk.ID));
            _unitOfWork.Contributors.RemoveRange(_unitOfWork.Contributors.Entities.Where(c => c.RiskID == risk.ID));
            _unitOfWork.RiskRiskTypes.RemoveRange(_unitOfWork.RiskRiskTypes.Entities.Where(rrt => rrt.RiskID == risk.ID));
        }

        private void SetRiskCode(CorporateRisk risk)
        {
            if (risk.IsProjectRisk == true && _settings.ProjectRiskPrefix != null)
            {
                risk.RiskCode = $"{_settings.ProjectRiskPrefix}{risk.ID}";
                return;
            }
            if (risk.RiskRegisterID == (int)RiskRegisters.Departmental)
            {
                risk.RiskCode = $"{_unitOfWork.RiskRegisters.Find((int)RiskRegisters.Departmental).RiskCodePrefix}{risk.ID}";
            }
            if (risk.RiskRegisterID == (int)RiskRegisters.Group)
            {
                risk.RiskCode = $"{_unitOfWork.RiskRegisters.Find((int)RiskRegisters.Group).RiskCodePrefix}{risk.ID}";
            }
            if (risk.RiskRegisterID == (int)RiskRegisters.Directorate)
            {
                risk.RiskCode = $"{_unitOfWork.RiskRegisters.Find((int)RiskRegisters.Directorate).RiskCodePrefix}{risk.ID}";
            }
        }

        private void SetReportingCycle(CorporateRisk risk)
        {
            if (risk.IsProjectRisk == true && risk.ProjectID != null)
            {
                var project = _unitOfWork.Projects.Find((int)risk.ProjectID);
                if (project != null)
                {
                    ReportingCycleService.CopyReportingCycle(project, risk);
                }
            }
            else
            {
                var directorate = _unitOfWork.Directorates.Find((int)risk.DirectorateID);
                if (directorate != null)
                {
                    ReportingCycleService.CopyReportingCycle(directorate, risk);
                }
            }
        }

        private void SetReportingCycleOnActions(CorporateRisk risk)
        {
            foreach (var action in _unitOfWork.CorporateRiskMitigationActions.Entities.Where(a => a.RiskID == risk.ID))
            {
                ReportingCycleService.CopyReportingCycle(risk, action);
            }
        }

        private void CloseRisksRiskMitigationActions(CorporateRisk risk)
        {
            var now = DateTime.UtcNow;
            foreach (var action in _unitOfWork.CorporateRiskMitigationActions.Entities.Where(a => a.RiskID == risk.ID && a.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(action, now);
            }
        }
    }
}
