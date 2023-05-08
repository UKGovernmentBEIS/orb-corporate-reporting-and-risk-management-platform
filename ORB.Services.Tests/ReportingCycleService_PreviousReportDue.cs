using ORB.Core;
using ORB.Core.Models;
using ORB.Services;
using System;
using Xunit;

namespace ORB.Services.Tests
{
    public class ReportingCycleService_PreviousReportDue
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
        public void PreviousReportDue_InputIsDaily_ReturnLastSecondYesterday()
        {
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Daily), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 21, 23, 59, 59), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsWeeklyThursday_ReturnLastThursday()
        {
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Weekly, (byte)DayOfWeek.Thursday), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 21), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsWeeklyToday_ReturnDayLastWeek()
        {
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Weekly, (byte)DayOfWeek.Friday), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 15), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsWeeklyLastYear_ReturnLastYear()
        {
            var _3Jan2021 = UtcDate(2021, 1, 3, 4, 27, 41);
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Weekly, (byte)DayOfWeek.Wednesday), _3Jan2021);

            Assert.Equal(UtcDate(2020, 12, 30), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsFortnightlyToday_ReturnTwoWeeksAgo()
        {
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Fortnightly, (byte)DayOfWeek.Friday, _22Jan2021.Date.AddDays(-14)), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 8), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsFortnightlyWednesday_ReturnWednesdayLastWeek()
        {
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Fortnightly, (byte)DayOfWeek.Wednesday, UtcDate(2021, 1, 13)), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 13), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsFortnightlyTuesday_ReturnLastTuesday()
        {
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Fortnightly, (byte)DayOfWeek.Tuesday, UtcDate(2020, 12, 8)), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 19), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsFortnightlyLastYear_ReturnDateLastYear()
        {
            var _10Jan2021 = UtcDate(2021, 1, 10, 4, 27, 41);
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Fortnightly, (byte)DayOfWeek.Monday, UtcDate(2020, 12, 14)), _10Jan2021);

            Assert.Equal(UtcDate(2020, 12, 28), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsMonthlyLastDay_ReturnLastDayOfLastMonth()
        {
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Monthly, (byte)ReportingDueDays.LastDay), _22Jan2021);

            Assert.Equal(UtcDate(2020, 12, 31), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsMonthlyDayBeforeLastDayOnLastDay_ReturnDayBeforeLastThisMonth()
        {
            var _31Jan2021 = UtcDate(2021, 1, 31, 11, 15, 32);
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Monthly, (byte)ReportingDueDays.DayBeforeLast), _31Jan2021);

            Assert.Equal(UtcDate(2021, 1, 30), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsMonthlyDayBeforeLast_ReturnDayBeforeLastOfMonth()
        {
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Monthly, (byte)ReportingDueDays.DayBeforeLast), _22Jan2021);

            Assert.Equal(UtcDate(2020, 12, 30), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsMonthlyFixed_ReturnFixedDayOfMonth()
        {
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Monthly, 14), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 14), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsMonthlyToday_ReturnTodayLastMonth()
        {
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Monthly, 22), _22Jan2021);

            Assert.Equal(UtcDate(2020, 12, 22), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsMonthlyFixedLastYear_ReturnFixedDayOfMonthLastYear()
        {
            var _13Jan2021 = UtcDate(2021, 1, 13, 14, 30, 1);
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Monthly, 18), _13Jan2021);

            Assert.Equal(UtcDate(2020, 12, 18), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsMonthlyWeekdayFirstWednesday_ReturnFirstWednesdayThisMonth()
        {
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.MonthlyWeekday, (byte)ReportingDueDays.FirstWednesday), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 6), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsMonthlyWeekdayFourthFriday_ReturnFourthFriday()
        {
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.MonthlyWeekday, (byte)ReportingDueDays.FourthFriday), _22Jan2021);

            Assert.Equal(UtcDate(2020, 12, 25), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsMonthlyWeekdayLastThursday_ReturnLastThursday()
        {
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.MonthlyWeekday, (byte)ReportingDueDays.LastThursday), _22Jan2021);

            Assert.Equal(UtcDate(2020, 12, 31), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsMonthlyWeekdayLastYear_ReturnWeekdayLastYear()
        {
            var _13Jan2021 = UtcDate(2021, 1, 13, 14, 30, 1);
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.MonthlyWeekday, (byte)ReportingDueDays.ThirdMonday), _13Jan2021);

            Assert.Equal(UtcDate(2020, 12, 21), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsQuarterlyToday_ReturnTodayLastQuarter()
        {
            var _1Jan2020 = UtcDate(2020, 1, 1);
            var _30Jan2021 = UtcDate(2021, 1, 30, 16, 20, 32);
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Quarterly, (byte)ReportingDueDays.DayBeforeLast, _1Jan2020), _30Jan2021);

            Assert.Equal(UtcDate(2020, 10, 30, 0, 0, 0), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsQuarterly23Mar_Return23Dec()
        {
            var _1Mar2020 = UtcDate(2020, 3, 1);
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Quarterly, 23, _1Mar2020), _22Jan2021);

            Assert.Equal(UtcDate(2020, 12, 23), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsQuarterlyLastDayNov_Return31Aug()
        {
            var _1Feb2020 = UtcDate(2020, 2, 1);
            var _2Sep2021 = UtcDate(2021, 9, 2);
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Quarterly, (byte)ReportingDueDays.LastDay, _1Feb2020), _2Sep2021);

            Assert.Equal(UtcDate(2021, 8, 31), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsQuarterlyEarlyInMonth_ReturnLastQuarter()
        {
            var _1Jan2018 = UtcDate(2018, 1, 1);
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Quarterly, 8, _1Jan2018), _22Jan2021);

            Assert.Equal(UtcDate(2021, 1, 8), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsBiannuallyFixedDate_ReturnDateSixMonthsAgo()
        {
            var _1May2018 = UtcDate(2018, 5, 1);
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Biannually, 8, _1May2018), _22Jan2021);

            Assert.Equal(UtcDate(2020, 11, 8), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsBiannuallyLastYear_ReturnLastYear()
        {
            var _1Mar2018 = UtcDate(2018, 3, 1);
            var _12Feb2021 = UtcDate(2021, 2, 12);
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Biannually, (byte)ReportingDueDays.LastDay, _1Mar2018), _12Feb2021);

            Assert.Equal(UtcDate(2020, 9, 30), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsAnnuallyThisYear_ReturnLastYear()
        {
            var _1Nov2018 = UtcDate(2018, 11, 1);
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Annually, 6, _1Nov2018), _22Jan2021);

            Assert.Equal(UtcDate(2020, 11, 6), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsAnnuallyNextYear_ReturnThisYear()
        {
            var _1Sep2018 = UtcDate(2018, 9, 1);
            var _12Nov2021 = UtcDate(2021, 11, 12);
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Annually, (byte)ReportingDueDays.LastDay, _1Sep2018), _12Nov2021);

            Assert.Equal(UtcDate(2021, 9, 30), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsAnnuallyToday_ReturnTodayLastYear()
        {
            var _1Sep2018 = UtcDate(2018, 9, 1);
            var _30Sep2021 = UtcDate(2021, 9, 30, 14, 34, 2);
            var result = ReportingCycleService.PreviousReportDue(SampleEntity(ReportingFrequencies.Annually, (byte)ReportingDueDays.DayBeforeLast, _1Sep2018), _30Sep2021);

            Assert.Equal(UtcDate(2021, 9, 29), result);
        }

        [Fact]
        public void PreviousReportDue_InputIsMissingCycle_ThrowsException()
        {
            var result = Assert.Throws<Exception>(() => ReportingCycleService.PreviousReportDue(new Metric { ID = 3, Title = "Corrupt entity" }, _22Jan2021));
            Assert.Equal("Reporting entity does not have a valid reporting frequency", result.Message);
        }
    }
}
