using System;
using System.Collections.Generic;
using System.Linq;
using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public class PartnerOrganisationProjectMilestoneViewModel : ReportingEntityViewModel
    {
        public string MilestoneCode { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public int? MilestoneTypeID { get; set; }
        public int? LeadUserID { get; set; }
        public int? RagOptionID { get; set; }
        public int? WorkStreamID { get; set; }
        public int? ModifiedByUserID { get; set; }
        public DateTime? StartDate { get; set; }

        public virtual UserViewModel LeadUser { get; set; }
    }
}