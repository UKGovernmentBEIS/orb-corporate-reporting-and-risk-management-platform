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

namespace ORB.Services
{
    public class MetricService : ReportingEntityService<Metric>, IMetricService
    {
        private byte? _reportingFrequencyBeforePatch;
        private byte? _reportingDueDayBeforePatch;
        private DateTime? _reportingStartDateBeforePatch;
        private DateTime _nextReportDueBeforePatch;

        public MetricService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.Metrics, new MetricValidator()) { }

        protected override void BeforePatch(Metric entity)
        {
            base.BeforePatch(entity);

            _reportingFrequencyBeforePatch = entity.ReportingFrequency;
            _reportingDueDayBeforePatch = entity.ReportingDueDay;
            _reportingStartDateBeforePatch = entity.ReportingStartDate;
            _nextReportDueBeforePatch = ReportingCycleService.NextReportDue(entity, DateTime.UtcNow);
        }

        protected override void AfterPatch(Metric metric)
        {
            base.AfterPatch(metric);

            if (_reportingFrequencyBeforePatch != metric.ReportingFrequency
                || _reportingDueDayBeforePatch != metric.ReportingDueDay
                || _reportingStartDateBeforePatch != metric.ReportingStartDate)
            {
                ChangeUpdateReportDates(metric);
            }
        }

        protected override void BeforeRemove(Metric metric)
        {
            _unitOfWork.Attributes.RemoveRange(_unitOfWork.Attributes.Entities.Where(a => a.MetricID == metric.ID));
            _unitOfWork.Contributors.RemoveRange(_unitOfWork.Contributors.Entities.Where(c => c.MetricID == metric.ID));
        }

        private void ChangeUpdateReportDates(Metric metric)
        {
            var newNextReportDueDate = ReportingCycleService.NextReportDue(metric, DateTime.UtcNow);

            foreach (var update in _unitOfWork.MetricUpdates.Entities.Where(u => u.MetricID == metric.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
            {
                update.UpdatePeriod = newNextReportDueDate;
            }
        }

        public ICollection<Metric> MetricsDueInDirectoratePeriod(int directorateId, Period period)
        {
            var directorate = _unitOfWork.Directorates.Find(directorateId);
            if (directorate != null)
            {
                var dates = ReportingCycleService.ReportPeriodDates(directorate, DateTime.UtcNow, period);

                return _repository.Entities
                    .Include(m => m.LeadUser)
                    .Include(m => m.MeasurementUnit)
                    .Include(m => m.Attributes).ThenInclude(a => a.AttributeType)
                    .Include(m => m.Contributors)
                    .Where(m => m.DirectorateID == directorateId && m.EntityStatusID == (int)EntityStatuses.Open)
                    .Where(m => ReportingCycleService.NextReportDue(m, dates.Start) <= dates.End).ToList();
            }
            return new Collection<Metric>();
        }

        public ICollection<Metric> MetricsDueInDirectoratePeriod(int directorateId, DateTime fromDate, DateTime toDate)
        {
            var directorate = _unitOfWork.Directorates.Find(directorateId);
            if (directorate != null)
            {
                return _repository.Entities
                    .Where(m => m.DirectorateID == directorateId && m.EntityStatusID == (int)EntityStatuses.Open)
                    .Where(m => ReportingCycleService.NextReportDue(m, fromDate) <= toDate).ToList();
            }
            return new Collection<Metric>();
        }
    }
}
