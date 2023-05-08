using ORB.Core;
using ORB.Core.Models;
using ORB.Services;
using System;
using Xunit;

namespace ORB.Services.Tests
{
    public class ReportingCycleService_CopyReportingCycle
    {
        private static ReportingEntity TestEntityParent()
        {
            return new Project
            {
                ID = 23,
                Title = "Test reporting project",
                ReportingFrequency = (byte)ReportingFrequencies.Fortnightly,
                ReportingDueDay = (byte)ReportingDueDays.DayBeforeLast,
                ReportingStartDate = null
            };
        }

        private static ReportingEntity TestEntityChild()
        {
            return new Benefit
            {
                ID = 23,
                Title = "Test reporting entity"
            };
        }

        [Fact]
        public void CopyReportingCycle_InputEntity_ReturnIsEntityWithCopyOfCycle()
        {
            var parent = TestEntityParent();
            var child = TestEntityChild();
            ReportingCycleService.CopyReportingCycle(parent, child);

            Assert.Equal(parent.ReportingFrequency, child.ReportingFrequency);
            Assert.Equal(parent.ReportingDueDay, child.ReportingDueDay);
            Assert.Equal(parent.ReportingStartDate, child.ReportingStartDate);
        }
    }
}
