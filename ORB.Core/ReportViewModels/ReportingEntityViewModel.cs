using System;

namespace ORB.Core.ReportViewModels
{
    public class ReportingEntityViewModel : EntityWithStatusViewModel
    {
        public string Description { get; set; }
        public byte? ReportingFrequency { get; set; }
        public byte? ReportingDueDay { get; set; }
        public DateTime? ReportingStartDate { get; set; }
    }
}
