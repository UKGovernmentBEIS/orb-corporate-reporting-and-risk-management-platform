using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Collections.Generic;
using System.Text;
using dd = ORB.Core.ReportingDueDays;

namespace ORB.Services.Validations
{
    public abstract class ReportingEntityValidator<T> : AbstractValidator<T> where T : ReportingEntity
    {
        protected ReportingEntityValidator()
        {
            RuleFor(re => re.ReportingFrequency).NotEmpty().InclusiveBetween((byte)ReportingFrequencies.Monthly, (byte)ReportingFrequencies.MonthlyWeekday);
            RuleFor(re => (dd?)re.ReportingDueDay).IsInEnum()
                .Must((entity, dueDay) =>
                    entity.ReportingFrequency != null && dueDay != null && (ReportingFrequencies)entity.ReportingFrequency switch
                    {
                        ReportingFrequencies.Daily => dueDay == null,
                        ReportingFrequencies.Weekly => dueDay >= 0 && (byte)dueDay < 7,
                        ReportingFrequencies.Fortnightly => dueDay >= 0 && (byte)dueDay < 7,
                        ReportingFrequencies.Monthly => (dueDay > 0 && (byte)dueDay < 29) || (dd)dueDay == dd.LastDay || (dd)dueDay == dd.DayBeforeLast,
                        ReportingFrequencies.MonthlyWeekday => (byte)dueDay > 100,
                        _ => (dueDay > 0 && (byte)dueDay < 32) || (dd)dueDay == dd.LastDay || (dd)dueDay == dd.DayBeforeLast
                    }
                )
                .WithMessage("A valid reporting due day must be selected for the selected reporting frequency.");
            RuleFor(re => re.ReportingStartDate)
                .Must((entity, startDate) =>
                   entity.ReportingFrequency != null && (ReportingFrequencies)entity.ReportingFrequency switch
                   {
                       ReportingFrequencies.Daily => startDate == null,
                       ReportingFrequencies.Weekly => startDate == null,
                       ReportingFrequencies.Fortnightly => startDate != null && entity.ReportingDueDay >= 0 && entity.ReportingDueDay < 7 && startDate.Value.DayOfWeek == (DayOfWeek)entity.ReportingDueDay,
                       ReportingFrequencies.Monthly => startDate == null,
                       ReportingFrequencies.MonthlyWeekday => startDate == null,
                       _ => startDate != null
                   }
                )
                .WithMessage("A valid reporting start date must be selected for the selected reporting frequency");
        }
    }
}
