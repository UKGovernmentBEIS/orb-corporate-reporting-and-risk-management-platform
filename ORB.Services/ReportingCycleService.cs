using Microsoft.EntityFrameworkCore;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ORB.Services
{
    public static class ReportingCycleService
    {
        public static void CopyReportingCycle(ReportingEntity fromEntity, ReportingEntity toEntity)
        {
            toEntity.ReportingFrequency = fromEntity.ReportingFrequency;
            toEntity.ReportingDueDay = fromEntity.ReportingDueDay;
            toEntity.ReportingStartDate = fromEntity.ReportingStartDate;
        }

        public static DateTime NextReportDue(ReportingEntity entity, DateTime currentDate)
        {
            if (entity.ReportingFrequency == null)
            {
                throw new Exception("Reporting entity does not have a valid reporting frequency");
            }
            return NextReportDue((ReportingFrequencies)entity.ReportingFrequency, (ReportingDueDays?)entity.ReportingDueDay, entity.ReportingStartDate, currentDate);
        }

        public static DateTime NextReportDue(ReportingFrequencies frequency, ReportingDueDays? dueDay, DateTime? startDate, DateTime currentDate)
        {
            if (frequency == ReportingFrequencies.Daily)
            {
                return currentDate.Date.AddDays(1).AddSeconds(-1);
            }

            if (frequency == ReportingFrequencies.Weekly)
            {
                return currentDate.Date.AddDays(((byte)dueDay - (byte)currentDate.DayOfWeek + 7) % 7);
            }

            if (frequency == ReportingFrequencies.Fortnightly)
            {
                if (startDate > currentDate)
                {
                    return (DateTime)startDate;
                }
                var reportDayThisWeek = currentDate.Date.AddDays((byte)dueDay - (byte)currentDate.DayOfWeek);
                var daysBetweenDates = reportDayThisWeek.Subtract(((DateTime)startDate).Date).Days;
                if (daysBetweenDates % 14 != 0)
                {
                    return reportDayThisWeek.AddDays(7);
                }

                return reportDayThisWeek < currentDate.Date ? reportDayThisWeek.AddDays(14) : reportDayThisWeek;
            }

            if (frequency == ReportingFrequencies.Monthly)
            {
                if (dueDay == ReportingDueDays.LastDay)
                {
                    var lastDayInCurrentMonth = new DateTime(currentDate.Year, currentDate.Month, 1, 0, 0, 0, currentDate.Kind).AddMonths(1).AddDays(-1);
                    if (currentDate.Date <= lastDayInCurrentMonth.Date) { return lastDayInCurrentMonth; }
                    return new DateTime(currentDate.Year, currentDate.Month, 1, 0, 0, 0, currentDate.Kind).AddMonths(2).AddDays(-1);
                }

                if (dueDay == ReportingDueDays.DayBeforeLast)
                {
                    var dayBeforeLastInCurrentMonth = new DateTime(currentDate.Year, currentDate.Month, 1, 0, 0, 0, currentDate.Kind).AddMonths(1).AddDays(-2);
                    if (currentDate.Date <= dayBeforeLastInCurrentMonth.Date) { return dayBeforeLastInCurrentMonth; }
                    return new DateTime(currentDate.Year, currentDate.Month, 1, 0, 0, 0, currentDate.Kind).AddMonths(2).AddDays(-2);
                }

                var dueDateInCurrentMonth = new DateTime(currentDate.Year, currentDate.Month, (int)dueDay, 0, 0, 0, currentDate.Kind);
                if (currentDate.Date <= dueDateInCurrentMonth.Date)
                {
                    return dueDateInCurrentMonth;
                }

                return dueDateInCurrentMonth.AddMonths(1);
            }

            if (frequency == ReportingFrequencies.MonthlyWeekday)
            {
                var instanceInMonth = int.Parse(((byte)dueDay).ToString()[1].ToString());
                var dayOfWeek = (DayOfWeek)int.Parse(((byte)dueDay).ToString()[2].ToString());
                var dueDateInCurrentMonth = instanceInMonth > 0 && instanceInMonth < 5 ?
                                   currentDate.FirstDayOfWeekInMonth(dayOfWeek).AddDays((instanceInMonth - 1) * 7) :
                                         currentDate.AddMonths(1).FirstDayOfWeekInMonth(dayOfWeek).AddDays(-7);
                if (currentDate.Date <= dueDateInCurrentMonth.Date)
                {
                    return dueDateInCurrentMonth;
                }

                return instanceInMonth > 0 && instanceInMonth < 5 ?
                                currentDate.AddMonths(1).FirstDayOfWeekInMonth(dayOfWeek).AddDays((instanceInMonth - 1) * 7) :
                                    currentDate.AddMonths(2).FirstDayOfWeekInMonth(dayOfWeek).AddDays(-7);
            }

            if (frequency == ReportingFrequencies.Quarterly)
            {
                var q = (DateTime)startDate;

                if (dueDay == ReportingDueDays.LastDay)
                {
                    while (q.AddMonths(1).AddDays(-1) < currentDate.Date)
                    {
                        q = q.AddMonths(3);
                    }

                    return q.AddMonths(1).AddDays(-1);
                }

                if (dueDay == ReportingDueDays.DayBeforeLast)
                {
                    while (q.AddMonths(1).AddDays(-2) < currentDate.Date)
                    {
                        q = q.AddMonths(3);
                    }

                    return q.AddMonths(1).AddDays(-2);
                }

                while (new DateTime(q.Year, q.Month, (int)dueDay, 0, 0, 0, currentDate.Kind) < currentDate.Date)
                {
                    q = q.AddMonths(3);
                }

                return new DateTime(q.Year, q.Month, (int)dueDay, 0, 0, 0, currentDate.Kind);
            }

            if (frequency == ReportingFrequencies.Biannually)
            {
                var q = (DateTime)startDate;

                if (dueDay == ReportingDueDays.LastDay)
                {
                    while (q.AddMonths(1).AddDays(-1) < currentDate.Date)
                    {
                        q = q.AddMonths(6);
                    }

                    return q.AddMonths(1).AddDays(-1);
                }

                if (dueDay == ReportingDueDays.DayBeforeLast)
                {
                    while (q.AddMonths(1).AddDays(-2) < currentDate.Date)
                    {
                        q = q.AddMonths(6);
                    }

                    return q.AddMonths(1).AddDays(-2);
                }

                while (new DateTime(q.Year, q.Month, (int)dueDay, 0, 0, 0, currentDate.Kind) < currentDate.Date)
                {
                    q = q.AddMonths(6);
                }

                return new DateTime(q.Year, q.Month, (int)dueDay, 0, 0, 0, currentDate.Kind);
            }

            if (frequency == ReportingFrequencies.Annually)
            {
                var q = (DateTime)startDate;

                if (dueDay == ReportingDueDays.LastDay)
                {
                    while (q.AddMonths(1).AddDays(-1) < currentDate.Date)
                    {
                        q = q.AddYears(1);
                    }

                    return q.AddMonths(1).AddDays(-1);
                }

                if (dueDay == ReportingDueDays.DayBeforeLast)
                {
                    while (q.AddMonths(1).AddDays(-2) < currentDate.Date)
                    {
                        q = q.AddYears(1);
                    }

                    return q.AddMonths(1).AddDays(-2);
                }

                while (new DateTime(q.Year, q.Month, (int)dueDay, 0, 0, 0, currentDate.Kind) < currentDate.Date)
                {
                    q = q.AddYears(1);
                }

                return new DateTime(q.Year, q.Month, (int)dueDay, 0, 0, 0, currentDate.Kind);
            }

            throw new Exception("Reporting entity does not have a valid reporting frequency");
        }

        public static DateTime PreviousReportDue(ReportingEntity entity, DateTime currentDate)
        {
            if (entity.ReportingFrequency == (byte)ReportingFrequencies.Daily)
            {
                return NextReportDue(entity, currentDate).AddDays(-1);
            }

            if (entity.ReportingFrequency == (byte)ReportingFrequencies.Weekly)
            {
                return NextReportDue(entity, currentDate).AddDays(-7);
            }

            if (entity.ReportingFrequency == (byte)ReportingFrequencies.Fortnightly)
            {
                return NextReportDue(entity, currentDate).AddDays(-14);
            }

            if (entity.ReportingFrequency == (byte)ReportingFrequencies.Monthly)
            {
                if (entity.ReportingDueDay == (byte)ReportingDueDays.LastDay)
                {
                    return new DateTime(currentDate.Year, currentDate.Month, 1, 0, 0, 0, currentDate.Kind).AddDays(-1);
                }

                if (entity.ReportingDueDay == (byte)ReportingDueDays.DayBeforeLast)
                {
                    var dayBeforeLastInCurrentMonth = new DateTime(currentDate.Year, currentDate.Month, 1, 0, 0, 0, currentDate.Kind).AddMonths(1).AddDays(-2);
                    if (currentDate.Date > dayBeforeLastInCurrentMonth) { return dayBeforeLastInCurrentMonth; }
                    return new DateTime(currentDate.Year, currentDate.Month, 1, 0, 0, 0, currentDate.Kind).AddDays(-2);
                }

                var dueDateInCurrentMonth = new DateTime(currentDate.Year, currentDate.Month, (int)entity.ReportingDueDay, 0, 0, 0, currentDate.Kind);
                if (currentDate.Date > dueDateInCurrentMonth.Date)
                {
                    return dueDateInCurrentMonth;
                }

                return dueDateInCurrentMonth.AddMonths(-1);
            }

            if (entity.ReportingFrequency == (byte)ReportingFrequencies.MonthlyWeekday)
            {
                var instanceInMonth = int.Parse(entity.ReportingDueDay.ToString()[1].ToString());
                var dayOfWeek = (DayOfWeek)int.Parse(entity.ReportingDueDay.ToString()[2].ToString());
                var dueDateInCurrentMonth = instanceInMonth > 0 && instanceInMonth < 5 ?
                                  currentDate.FirstDayOfWeekInMonth(dayOfWeek).AddDays((instanceInMonth - 1) * 7) :
                                        currentDate.AddMonths(1).FirstDayOfWeekInMonth(dayOfWeek).AddDays(-7);

                if (currentDate.Date > dueDateInCurrentMonth.Date)
                {
                    return dueDateInCurrentMonth;
                }

                return instanceInMonth > 0 && instanceInMonth < 5 ?
                               currentDate.AddMonths(-1).FirstDayOfWeekInMonth(dayOfWeek).AddDays((instanceInMonth - 1) * 7) :
                                   currentDate.FirstDayOfWeekInMonth(dayOfWeek).AddDays(-7);
            }

            if (entity.ReportingFrequency == (byte)ReportingFrequencies.Quarterly)
            {
                var q = (DateTime)entity.ReportingStartDate;

                if (entity.ReportingDueDay == (byte)ReportingDueDays.LastDay)
                {
                    while (q.AddMonths(1).AddDays(-1) < currentDate.Date)
                    {
                        q = q.AddMonths(3);
                    }

                    return q.AddMonths(-3).AddMonths(1).AddDays(-1);
                }

                if (entity.ReportingDueDay == (byte)ReportingDueDays.DayBeforeLast)
                {
                    while (q.AddMonths(1).AddDays(-2) < currentDate.Date)
                    {
                        q = q.AddMonths(3);
                    }

                    return q.AddMonths(-3).AddMonths(1).AddDays(-2);
                }

                return NextReportDue(entity, currentDate).AddMonths(-3);
            }

            if (entity.ReportingFrequency == (byte)ReportingFrequencies.Biannually)
            {
                var q = (DateTime)entity.ReportingStartDate;

                if (entity.ReportingDueDay == (byte)ReportingDueDays.LastDay)
                {
                    while (q.AddMonths(1).AddDays(-1) < currentDate.Date)
                    {
                        q = q.AddMonths(6);
                    }

                    return q.AddMonths(-6).AddMonths(1).AddDays(-1);
                }

                if (entity.ReportingDueDay == (byte)ReportingDueDays.DayBeforeLast)
                {
                    while (q.AddMonths(1).AddDays(-2) < currentDate.Date)
                    {
                        q = q.AddMonths(6);
                    }

                    return q.AddMonths(-6).AddMonths(1).AddDays(-2);
                }

                return NextReportDue(entity, currentDate).AddMonths(-6);
            }

            if (entity.ReportingFrequency == (byte)ReportingFrequencies.Annually)
            {
                var q = (DateTime)entity.ReportingStartDate;

                if (entity.ReportingDueDay == (byte)ReportingDueDays.LastDay)
                {
                    while (q.AddMonths(1).AddDays(-1) < currentDate.Date)
                    {
                        q = q.AddYears(1);
                    }

                    return q.AddYears(-1).AddMonths(1).AddDays(-1);
                }

                if (entity.ReportingDueDay == (byte)ReportingDueDays.DayBeforeLast)
                {
                    while (q.AddMonths(1).AddDays(-2) < currentDate.Date)
                    {
                        q = q.AddYears(1);
                    }

                    return q.AddYears(-1).AddMonths(1).AddDays(-2);
                }

                return NextReportDue(entity, currentDate).AddYears(-1);
            }

            throw new Exception("Reporting entity does not have a valid reporting frequency");
        }

        public static IReportPeriod ReportPeriodDates(ReportingEntity entity, DateTime currentDate, Period period = Period.Current)
        {
            var periodEnd = NextReportDue(entity, currentDate);
            var periodStart = PreviousReportDue(entity, currentDate).AddDays(1);

            if (period == Period.Previous)
            {
                periodEnd = periodStart.AddDays(-1);
                periodStart = PreviousReportDue(entity, periodStart.AddDays(-1)).AddDays(1);
            }

            return new ReportPeriod { Start = periodStart, End = periodEnd };
        }

        private static byte MonthlyDueDay(DateTime date)
        {
            byte dueDay;
            int daysInMonth = DateTime.DaysInMonth(date.Year, date.Month);

            if (date.Day == daysInMonth)
            {
                dueDay = (byte)ReportingDueDays.LastDay;
            }
            else if (date.Day == daysInMonth - 1)
            {
                dueDay = (byte)ReportingDueDays.DayBeforeLast;
            }
            else
            {
                dueDay = (byte)date.Day;
            }

            return dueDay;
        }


        private static ReportingDueDays MonthlyWeekdayDueDay(DateTime date)
        {
            var dueDays = new[]
            {
                ReportingDueDays.FirstSunday, ReportingDueDays.SecondSunday, ReportingDueDays.ThirdSunday,
                ReportingDueDays.FourthSunday, ReportingDueDays.LastSunday, ReportingDueDays.FirstMonday,
                ReportingDueDays.SecondMonday, ReportingDueDays.ThirdMonday, ReportingDueDays.FourthMonday,
                ReportingDueDays.LastMonday, ReportingDueDays.FirstTuesday, ReportingDueDays.SecondTuesday,
                ReportingDueDays.ThirdTuesday, ReportingDueDays.FourthTuesday, ReportingDueDays.LastTuesday,
                ReportingDueDays.FirstWednesday, ReportingDueDays.SecondWednesday, ReportingDueDays.ThirdWednesday,
                ReportingDueDays.FourthWednesday, ReportingDueDays.LastWednesday, ReportingDueDays.FirstThursday,
                ReportingDueDays.SecondThursday, ReportingDueDays.ThirdThursday, ReportingDueDays.FourthThursday,
                ReportingDueDays.LastThursday, ReportingDueDays.FirstFriday, ReportingDueDays.SecondFriday,
                ReportingDueDays.ThirdFriday, ReportingDueDays.FourthFriday, ReportingDueDays.LastFriday,
                ReportingDueDays.FirstSaturday, ReportingDueDays.SecondSaturday, ReportingDueDays.ThirdSaturday,
                ReportingDueDays.FourthSaturday, ReportingDueDays.LastSaturday
            };

            var index = ((int)date.DayOfWeek * 5) + (date.Day / 7);
            if (date.DayOfWeek != DayOfWeek.Sunday && date.Day <= index)
            {
                index -= 1;
            }

            if (index >= dueDays.Length || index < 0)
            {
                throw new Exception("DateTime is invalid");
            }

            return dueDays[index];
        }


        private static bool IsLastDayOfWeekInMonth(DateTime date)
        {
            var lastDay = new DateTime(date.Year, date.Month, 1).AddMonths(1).AddDays(-1);
            var lastDayOfWeek = lastDay.DayOfWeek;

            var diff = date.DayOfWeek - lastDayOfWeek;

            if (diff > 0) diff -= 7;

            return lastDay.AddDays(diff) == date;
        }

        public static IReportingCycle WeeklyReportingCycleDue(DateTime date)
        {
            return new ReportingCycle
            {
                ReportingFrequency = (byte)ReportingFrequencies.Weekly,
                ReportingDueDay = (byte)date.DayOfWeek
            };
        }

        public static IReportingCycle FortnightlyReportingCycleDue(DateTime date)
        {
            return new ReportingCycle
            {
                ReportingFrequency = (byte)ReportingFrequencies.Fortnightly,
                ReportingDueDay = (byte)date.DayOfWeek,
                ReportingStartDate = new DateTime(date.Year, date.Month, date.Day, 0, 0, 0, DateTimeKind.Utc)
            };
        }

        public static IReportingCycle MonthlyReportingCycleDue(DateTime date)
        {
            return new ReportingCycle
            {
                ReportingFrequency = (byte)ReportingFrequencies.Monthly,
                ReportingDueDay = MonthlyDueDay(date)
            };
        }

        public static IReportingCycle MonthlyWeekdayReportingCycleDue(DateTime date)
        {
            return new ReportingCycle
            {
                ReportingFrequency = (byte)ReportingFrequencies.MonthlyWeekday,
                ReportingDueDay = (byte)MonthlyWeekdayDueDay(date)
            };
        }

        public static IReportingCycle MonthlyWeekday2ReportingCycleDue(DateTime date)
        {
            var monthWeekdayOccurence = MonthlyWeekdayDueDay(date);
            if (IsLastDayOfWeekInMonth(date)
                && monthWeekdayOccurence >= ReportingDueDays.FourthSunday
                && monthWeekdayOccurence <= ReportingDueDays.FourthSaturday)
            {
                byte reportingDueDay = GetReportingDueDayForLastDayOfWeekInMonth(date);
                return new ReportingCycle
                {
                    ReportingFrequency = (byte)ReportingFrequencies.MonthlyWeekday,
                    ReportingDueDay = reportingDueDay
                };
            }
            return null;
        }

        private static byte GetReportingDueDayForLastDayOfWeekInMonth(DateTime date)
        {
            switch (date.DayOfWeek)
            {
                case DayOfWeek.Sunday:
                    return (byte)ReportingDueDays.LastSunday;
                case DayOfWeek.Monday:
                    return (byte)ReportingDueDays.LastMonday;
                case DayOfWeek.Tuesday:
                    return (byte)ReportingDueDays.LastTuesday;
                case DayOfWeek.Wednesday:
                    return (byte)ReportingDueDays.LastWednesday;
                case DayOfWeek.Thursday:
                    return (byte)ReportingDueDays.LastThursday;
                case DayOfWeek.Friday:
                    return (byte)ReportingDueDays.LastFriday;
                case DayOfWeek.Saturday:
                    return (byte)ReportingDueDays.LastSaturday;
                default:
                    throw new ArgumentException($"Invalid day of week: {date.DayOfWeek}");
            }
        }

        public static IReportingCycle QuarterlyReportingCycleDue(DateTime date)
        {
            var quarterlyStartDate = date.AddMonths(-((date.Month - 1) % 3)).Date;
            return new ReportingCycle
            {
                ReportingFrequency = (byte)ReportingFrequencies.Quarterly,
                ReportingDueDay = MonthlyDueDay(date),
                ReportingStartDate = new DateTime(quarterlyStartDate.Year, quarterlyStartDate.Month, 1, 0, 0, 0, DateTimeKind.Utc)
            };
        }


        public static IReportingCycle BiannuallyReportingCycleDue(DateTime date)
        {
            return new ReportingCycle
            {
                ReportingFrequency = (byte)ReportingFrequencies.Biannually,
                ReportingDueDay = MonthlyDueDay(date),
                ReportingStartDate = date.Month <= 6
                    ? new DateTime(date.Year, date.Month, 1, 0, 0, 0, DateTimeKind.Utc)
                    : new DateTime(date.Year, date.Month - 6, 1, 0, 0, 0, DateTimeKind.Utc)
            };
        }

        public static IReportingCycle AnnuallyReportingCycleDue(DateTime date)
        {
            return new ReportingCycle
            {
                ReportingFrequency = (byte)ReportingFrequencies.Annually,
                ReportingDueDay = MonthlyDueDay(date),
                ReportingStartDate = new DateTime(date.Year, date.Month, 1, 0, 0, 0, DateTimeKind.Utc)
            };
        }
    }
}