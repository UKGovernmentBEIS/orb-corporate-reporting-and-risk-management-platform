using ORB.Core;
using ORB.Core.Models;
using ORB.Services;
using System;
using Xunit;

namespace ORB.Services.Tests
{
    public class ReportingCycleService_NextReportDue
    {
        private static readonly DateTime _22Jan2021 = UtcDate(2021, 1, 22, 13, 4, 54);

        private static DateTime UtcDate(int year, int month, int date)
        {
            return UtcDate(year, month, date, 0, 0, 0);
        }

        private static DateTime UtcDate(int year, int month, int date, int hour, int minute, int second)
        {
            return new DateTime(year, month, date, hour, minute, second, DateTimeKind.Utc);
        }

        private static ReportingEntity SampleEntity(ReportingFrequencies frequency)
        {
            return new Benefit
            {
                ID = 23,
                Title = "Test reporting entity",
                ReportingFrequency = (byte)frequency
            };
        }

        private static ReportingEntity SampleEntity(ReportingFrequencies frequency, byte dueDay)
        {
            var b = SampleEntity(frequency);
            b.ReportingDueDay = dueDay;
            return b;
        }

        private static ReportingEntity SampleEntity(ReportingFrequencies frequency, byte dueDay, DateTime startDate)
        {
            var b = SampleEntity(frequency);
            b.ReportingDueDay = dueDay;
            b.ReportingStartDate = startDate;
            return b;
        }

        [Fact]
        public void NextReportDue_InputIsDaily_ReturnLastSecond()
        {
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Daily), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 22, 23, 59, 59), result);
        }

        [Fact]
        public void NextReportDue_InputIsWeeklyThursday_ReturnNextThursday()
        {
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Weekly, (byte)DayOfWeek.Thursday), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 28), result);
        }

        [Fact]
        public void NextReportDue_InputIsWeeklyToday_ReturnToday()
        {
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Weekly, (byte)DayOfWeek.Friday), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 22), result);
        }

        [Fact]
        public void NextReportDue_InputIsWeeklyNextYear_ReturnNextYear()
        {
            var _28Dec2020 = UtcDate(2020, 12, 28, 4, 27, 41);
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Weekly, (byte)DayOfWeek.Saturday), _28Dec2020);

            Assert.Equal(UtcDate(2021, 1, 2), result);
        }

        [Fact]
        public void NextReportDue_InputIsFortnightlyToday_ReturnToday()
        {
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Fortnightly, (byte)DayOfWeek.Friday, _22Jan2021.Date.AddDays(-14)), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 22), result);
        }

        [Fact]
        public void NextReportDue_InputIsFortnightlyWednesday_ReturnNextWednesday()
        {
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Fortnightly, (byte)DayOfWeek.Wednesday, UtcDate(2021, 1, 13)), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 27), result);
        }

        [Fact]
        public void NextReportDue_InputIsFortnightlyTuesday_ReturnTuesdayWeekAfterNext()
        {
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Fortnightly, (byte)DayOfWeek.Tuesday, UtcDate(2020, 12, 8)), _22Jan2021);

            Assert.Equal(UtcDate(2021, 2, 2), result);
        }

        [Fact]
        public void NextReportDue_InputIsFortnightlyNextYear_ReturnDateNextYear()
        {
            var _26Dec2020 = UtcDate(2020, 12, 26, 4, 27, 41);
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Fortnightly, (byte)DayOfWeek.Wednesday, UtcDate(2020, 10, 14)), _26Dec2020);

            Assert.Equal(UtcDate(2021, 1, 6), result);
        }

        [Fact]
        public void NextReportDue_InputIsFortnightlyFutureStartDate_ReturnStartDate()
        {
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Fortnightly, (byte)DayOfWeek.Tuesday, UtcDate(2021, 2, 16)), _22Jan2021);

            Assert.Equal(UtcDate(2021, 2, 16), result);
        }

        [Fact]
        public void NextReportDue_InputIsMonthlyLastDay_ReturnLastDayOfMonth()
        {
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Monthly, (byte)ReportingDueDays.LastDay), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 31), result);
        }

        [Fact]
        public void NextReportDue_InputIsMonthlyDayBeforeLastDayOnLastDay_ReturnDayBeforeLastNextMonth()
        {
            var _31Jan2021 = UtcDate(2021, 1, 31, 11, 15, 32);
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Monthly, (byte)ReportingDueDays.DayBeforeLast), _31Jan2021);

            Assert.Equal(UtcDate(2021, 2, 27), result);
        }

        [Fact]
        public void NextReportDue_InputIsMonthlyDayBeforeLast_ReturnDayBeforeLastOfMonth()
        {
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Monthly, (byte)ReportingDueDays.DayBeforeLast), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 30), result);
        }

        [Fact]
        public void NextReportDue_InputIsMonthlyFixed_ReturnFixedDayOfMonth()
        {
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Monthly, 14), _22Jan2021);

            Assert.Equal(UtcDate(2021, 2, 14), result);
        }

        [Fact]
        public void NextReportDue_InputIsMonthlyToday_ReturnToday()
        {
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Monthly, 22), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 22), result);
        }

        [Fact]
        public void NextReportDue_InputIsMonthlyFixedNextYear_ReturnFixedDayOfMonthNextYear()
        {
            var _20Dec2020 = UtcDate(2020, 12, 20, 14, 30, 1);
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Monthly, 18), _20Dec2020);

            Assert.Equal(UtcDate(2021, 1, 18), result);
        }

        [Fact]
        public void NextReportDue_InputIsMonthlyWeekdayFirstWednesday_ReturnFirstWednesday()
        {
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.MonthlyWeekday, (byte)ReportingDueDays.FirstWednesday), _22Jan2021);

            Assert.Equal(UtcDate(2021, 2, 3), result);
        }

        [Fact]
        public void NextReportDue_InputIsMonthlyWeekdayFourthFriday_ReturnFourthFriday()
        {
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.MonthlyWeekday, (byte)ReportingDueDays.FourthFriday), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 22), result);
        }

        [Fact]
        public void NextReportDue_InputIsMonthlyWeekdayLastThursday_ReturnLastThursday()
        {
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.MonthlyWeekday, (byte)ReportingDueDays.LastThursday), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 28), result);
        }

        [Fact]
        public void NextReportDue_InputIsMonthlyWeekdayNextYear_ReturnWeekdayNextYear()
        {
            var _22Dec2020 = UtcDate(2020, 12, 22, 14, 30, 1);
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.MonthlyWeekday, (byte)ReportingDueDays.ThirdMonday), _22Dec2020);

            Assert.Equal(UtcDate(2021, 1, 18), result);
        }

        [Fact]
        public void NextReportDue_InputIsQuarterlyToday_ReturnToday()
        {
            var _1Jan2020 = UtcDate(2020, 1, 1);
            var _30Jan2021 = UtcDate(2021, 1, 30, 16, 20, 32);
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Quarterly, (byte)ReportingDueDays.DayBeforeLast, _1Jan2020), _30Jan2021);

            Assert.Equal(UtcDate(2021, 1, 30), result);
        }

        [Fact]
        public void NextReportDue_InputIsQuarterly23Mar_Return23Mar()
        {
            var _1Mar2020 = UtcDate(2020, 3, 1);
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Quarterly, 23, _1Mar2020), _22Jan2021);

            Assert.Equal(UtcDate(2021, 3, 23), result);
        }

        [Fact]
        public void NextReportDue_InputIsQuarterlyLastDayNov_Return30Nov()
        {
            var _1Feb2020 = UtcDate(2020, 2, 1);
            var _2Sep2021 = UtcDate(2021, 9, 2);
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Quarterly, (byte)ReportingDueDays.LastDay, _1Feb2020), _2Sep2021);

            Assert.Equal(UtcDate(2021, 11, 30), result);
        }

        [Fact]
        public void NextReportDue_InputIsQuarterlyEarlyInMonth_ReturnNextQuarter()
        {
            var _1Jan2018 = UtcDate(2018, 1, 1);
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Quarterly, 8, _1Jan2018), _22Jan2021);

            Assert.Equal(UtcDate(2021, 4, 8), result);
        }

        [Fact]
        public void NextReportDue_InputIsBiannuallyToday_ReturnToday()
        {
            var _1May2018 = UtcDate(2018, 5, 1);
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Biannually, 8, _1May2018), _22Jan2021);

            Assert.Equal(UtcDate(2021, 5, 8), result);
        }

        [Fact]
        public void NextReportDue_InputIsBiannuallyNextYear_ReturnNextYear()
        {
            var _1Mar2018 = UtcDate(2018, 3, 1);
            var _12Nov2021 = UtcDate(2021, 11, 12);
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Biannually, (byte)ReportingDueDays.LastDay, _1Mar2018), _12Nov2021);

            Assert.Equal(UtcDate(2022, 3, 31), result);
        }

        [Fact]
        public void NextReportDue_InputIsAnnuallyThisYear_ReturnThisYear()
        {
            var _1Nov2018 = UtcDate(2018, 11, 1);
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Annually, 6, _1Nov2018), _22Jan2021);

            Assert.Equal(UtcDate(2021, 11, 6), result);
        }

        [Fact]
        public void NextReportDue_InputIsAnnuallyNextYear_ReturnNextYear()
        {
            var _1Sep2018 = UtcDate(2018, 9, 1);
            var _12Nov2021 = UtcDate(2021, 11, 12);
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Annually, (byte)ReportingDueDays.LastDay, _1Sep2018), _12Nov2021);

            Assert.Equal(UtcDate(2022, 9, 30), result);
        }

        [Fact]
        public void NextReportDue_InputIsAnnuallyToday_ReturnToday()
        {
            var _1Sep2018 = UtcDate(2018, 9, 1);
            var _30Sep2021 = UtcDate(2021, 9, 30, 14, 34, 2);
            var result = ReportingCycleService.NextReportDue(SampleEntity(ReportingFrequencies.Annually, (byte)ReportingDueDays.DayBeforeLast, _1Sep2018), _30Sep2021);

            Assert.Equal(UtcDate(2022, 9, 29), result);
        }

        [Fact]
        public void NextReportDue_InputIsMissingCycle_ThrowsException()
        {
            var result = Assert.Throws<Exception>(() => ReportingCycleService.NextReportDue(new Metric { ID = 3, Title = "Corrupt entity" }, _22Jan2021));
            Assert.Equal("Reporting entity does not have a valid reporting frequency", result.Message);
        }
    }
}
