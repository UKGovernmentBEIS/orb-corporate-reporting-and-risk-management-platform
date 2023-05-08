using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class Milestone : ReportingSubEntity
    {
        public Milestone()
        {
            MilestoneUpdates = new HashSet<MilestoneUpdate>();
        }
        
        public string MilestoneCode { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public int? MilestoneTypeID { get; set; }
        public int? RagOptionID { get; set; }
        public int? WorkStreamID { get; set; }
        public int? KeyWorkAreaID { get; set; }
        public int? PartnerOrganisationID { get; set; }
        public DateTime? StartDate { get; set; }

        public virtual KeyWorkArea KeyWorkArea { get; set; }
        public virtual MilestoneType MilestoneType { get; set; }
        public virtual PartnerOrganisation PartnerOrganisation { get; set; }
        public virtual RagOption RagOption { get; set; }
        public virtual WorkStream WorkStream { get; set; }
        public virtual ICollection<MilestoneUpdate> MilestoneUpdates { get; set; }
    }
}
