using FluentValidation;
using Microsoft.AspNet.OData;
using Microsoft.EntityFrameworkCore;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using ORB.Core.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public abstract class ReportingEntityService<TEntity> : EntityWithStatusService<TEntity>, IReportingEntityService<TEntity> where TEntity : ReportingEntity
    {
        protected ReportingEntityService(IUnitOfWork unitOfWork, IEntityRepository<TEntity> repository)
            : base(unitOfWork, repository) { }

        protected ReportingEntityService(IUnitOfWork unitOfWork, IEntityRepository<TEntity> repository, AbstractValidator<TEntity> validator)
            : base(unitOfWork, repository, validator) { }

        public ICollection<TEntity> EntitiesWithReportingCycle(IReportingCycle reportingCycle)
        {
            var entities = _repository.Entities.Where(re => re.EntityStatusID == (int)EntityStatuses.Open);

            if (reportingCycle.ReportingFrequency == (int)ReportingFrequencies.Weekly
                || reportingCycle.ReportingFrequency == (int)ReportingFrequencies.Monthly
                || reportingCycle.ReportingFrequency == (int)ReportingFrequencies.MonthlyWeekday)
            {
                entities = entities.Where(re => re.ReportingFrequency == reportingCycle.ReportingFrequency && re.ReportingDueDay == reportingCycle.ReportingDueDay);
            }

            if (reportingCycle.ReportingFrequency == (int)ReportingFrequencies.Fortnightly)
            {
                entities = entities.Where(re => re.ReportingFrequency == reportingCycle.ReportingFrequency && re.ReportingDueDay == reportingCycle.ReportingDueDay && EF.Functions.DateDiffDay((DateTime)reportingCycle.ReportingStartDate, (DateTime)re.ReportingStartDate) / 7 % 2 == 0);
            }

            if (reportingCycle.ReportingFrequency == (int)ReportingFrequencies.Quarterly
                || reportingCycle.ReportingFrequency == (int)ReportingFrequencies.Biannually
                || reportingCycle.ReportingFrequency == (int)ReportingFrequencies.Annually)
            {
                entities = entities.Where(re => re.ReportingFrequency == reportingCycle.ReportingFrequency && re.ReportingDueDay == reportingCycle.ReportingDueDay && ((DateTime)re.ReportingStartDate).Month == ((DateTime)reportingCycle.ReportingStartDate).Month);
            }

            return entities.ToList();
        }

        public ICollection<TEntity> EntitiesWithReportingCycle2(IReportingCycle reportingCycle, out int totalEntities, out int totalWithFilter, out string repType)
        {

            totalEntities = 0;
            totalWithFilter = 0;
            repType = "";

            var entities = _repository.Entities.Where(re => re.EntityStatusID == (int)EntityStatuses.Open);
            totalEntities = entities.Count();
            repType = _repository.GetType().ToString();

            if (reportingCycle.ReportingFrequency == (int)ReportingFrequencies.Weekly
                || reportingCycle.ReportingFrequency == (int)ReportingFrequencies.Monthly
                || reportingCycle.ReportingFrequency == (int)ReportingFrequencies.MonthlyWeekday)
            {
                entities = entities.Where(re => re.ReportingFrequency == reportingCycle.ReportingFrequency && re.ReportingDueDay == reportingCycle.ReportingDueDay);
                totalWithFilter = entities.Count();
            }

            if (reportingCycle.ReportingFrequency == (int)ReportingFrequencies.Fortnightly)
            {
                entities = entities.Where(re => re.ReportingFrequency == reportingCycle.ReportingFrequency && re.ReportingDueDay == reportingCycle.ReportingDueDay && EF.Functions.DateDiffDay((DateTime)reportingCycle.ReportingStartDate, (DateTime)re.ReportingStartDate) / 7 % 2 == 0);
            }

            if (reportingCycle.ReportingFrequency == (int)ReportingFrequencies.Quarterly
                || reportingCycle.ReportingFrequency == (int)ReportingFrequencies.Biannually
                || reportingCycle.ReportingFrequency == (int)ReportingFrequencies.Annually)
            {
                entities = entities.Where(re => re.ReportingFrequency == reportingCycle.ReportingFrequency && re.ReportingDueDay == reportingCycle.ReportingDueDay && ((DateTime)re.ReportingStartDate).Month == ((DateTime)reportingCycle.ReportingStartDate).Month);
            }

            return entities.ToList();
        }

    }
}
