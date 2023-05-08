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
    public class GroupService : EntityWithStatusService<Group>, IEntityService<Group>
    {
        public GroupService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.Groups, new GroupValidator(unitOfWork)) { }

        protected override void BeforeClose(Group group)
        {
            var now = DateTime.UtcNow;

            // Close group children
            foreach (var directorate in _unitOfWork.Directorates.Entities.Where(d => d.GroupID == group.ID && d.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(directorate, now);
                CloseDirectorateEntities(directorate, now);
            }
        }

        private void CloseDirectorateEntities(Directorate directorate, DateTime closedDate)
        {
            // Close directorate children
            foreach (var commitment in _unitOfWork.Commitments.Entities.Where(c => c.DirectorateID == directorate.ID && c.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(commitment, closedDate);
            }

            foreach (var keyWorkArea in _unitOfWork.KeyWorkAreas.Entities.Where(k => k.DirectorateID == directorate.ID && k.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(keyWorkArea, closedDate);

                foreach (var milestone in _unitOfWork.Milestones.Entities.Where(m => m.KeyWorkAreaID == keyWorkArea.ID && m.EntityStatusID == (int)EntityStatuses.Open))
                {
                    CloseEntityWithStatus(milestone, closedDate);
                }
            }

            foreach (var metric in _unitOfWork.Metrics.Entities.Where(m => m.DirectorateID == directorate.ID && m.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(metric, closedDate);
            }

            foreach (var risk in _unitOfWork.CorporateRisks.Entities.Where(r => r.DirectorateID == directorate.ID && r.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(risk, closedDate);

                foreach (var riskMitigationAction in _unitOfWork.CorporateRiskMitigationActions.Entities.Where(a => a.RiskID == risk.ID && a.EntityStatusID == (int)EntityStatuses.Open))
                {
                    CloseEntityWithStatus(riskMitigationAction, closedDate);
                }
            }
        }
    }
}
