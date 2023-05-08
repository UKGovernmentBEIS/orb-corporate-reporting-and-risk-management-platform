using FluentValidation;
using Microsoft.AspNet.OData;
using Microsoft.EntityFrameworkCore;
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
    public class BenefitService : ReportingEntityService<Benefit>, IBenefitService
    {
        private byte? _reportingFrequencyBeforePatch;
        private byte? _reportingDueDayBeforePatch;
        private DateTime? _reportingStartDateBeforePatch;
        private DateTime _nextReportDueBeforePatch;

        public BenefitService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.Benefits, new BenefitValidator(unitOfWork)) { }

        protected override void BeforePatch(Benefit entity)
        {
            base.BeforePatch(entity);

            _reportingFrequencyBeforePatch = entity.ReportingFrequency;
            _reportingDueDayBeforePatch = entity.ReportingDueDay;
            _reportingStartDateBeforePatch = entity.ReportingStartDate;
            _nextReportDueBeforePatch = ReportingCycleService.NextReportDue(entity, DateTime.UtcNow);
        }

        protected override void AfterPatch(Benefit benefit)
        {
            base.AfterPatch(benefit);

            if (_reportingFrequencyBeforePatch != benefit.ReportingFrequency
                || _reportingDueDayBeforePatch != benefit.ReportingDueDay
                || _reportingStartDateBeforePatch != benefit.ReportingStartDate)
            {
                ChangeUpdateReportDates(benefit);
            }
        }

        protected override void BeforeRemove(Benefit benefit)
        {
            _unitOfWork.Attributes.RemoveRange(_unitOfWork.Attributes.Entities.Where(a => a.BenefitID == benefit.ID));
            _unitOfWork.Contributors.RemoveRange(_unitOfWork.Contributors.Entities.Where(c => c.BenefitID == benefit.ID));
        }

        private void ChangeUpdateReportDates(Benefit benefit)
        {
            var newNextReportDueDate = ReportingCycleService.NextReportDue(benefit, DateTime.UtcNow);

            foreach (var update in _unitOfWork.BenefitUpdates.Entities.Where(u => u.BenefitID == benefit.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
            {
                update.UpdatePeriod = newNextReportDueDate;
            }
        }

        public ICollection<Benefit> BenefitsDueInProjectPeriod(int projectId, Period period)
        {
            var project = _unitOfWork.Projects.Find(projectId);
            if (project != null)
            {
                var dates = ReportingCycleService.ReportPeriodDates(project, DateTime.UtcNow, period);

                return _repository.Entities
                    .Include(b => b.LeadUser)
                    .Include(b => b.MeasurementUnit)
                    .Include(b => b.Attributes).ThenInclude(a => a.AttributeType)
                    .Include(b => b.BenefitType)
                    .Where(b => b.ProjectID == projectId && b.EntityStatusID == (int)EntityStatuses.Open)
                    .Where(b => ReportingCycleService.NextReportDue(b, dates.Start) <= dates.End).ToList();
            }
            return new Collection<Benefit>();
        }

        public ICollection<Benefit> BenefitsDueInProjectPeriod(int projectId, DateTime fromDate, DateTime toDate)
        {
            var project = _unitOfWork.Projects.Find(projectId);
            if (project != null)
            {
                return _repository.Entities
                    .Include(b => b.LeadUser)
                    .Include(b => b.MeasurementUnit)
                    .Include(b => b.Attributes).ThenInclude(a => a.AttributeType)
                    .Include(b => b.BenefitType)
                    .Where(b => b.ProjectID == projectId && b.EntityStatusID == (int)EntityStatuses.Open)
                    .Where(b => ReportingCycleService.NextReportDue(b, fromDate) <= toDate).ToList();
            }
            return new Collection<Benefit>();
        }
    }
}
