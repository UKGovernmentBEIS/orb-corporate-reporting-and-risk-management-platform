using System;

namespace ORB.Core
{
    public static class DateExtensions
    {
        public static DateTime FirstDayOfWeekInMonth(this DateTime date, DayOfWeek day)
        {
            var firstOfMonth = new DateTime(date.Year, date.Month, 1, 0, 0, 0, date.Kind);
            var offset = day - firstOfMonth.DayOfWeek;
            return firstOfMonth.AddDays(offset < 0 ? offset + 7 : offset);
        }

        public static int GetQuarter(this DateTime date, int startMonth)
        {
            return (date.AddMonths(-(startMonth - 1)).Month + 2) / 3;
        }
    }
}