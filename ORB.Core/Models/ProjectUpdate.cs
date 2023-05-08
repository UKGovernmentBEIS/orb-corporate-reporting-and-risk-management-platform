using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class ProjectUpdate : EntityUpdate
    {
        public string Comment { get; set; }
        public int? RagOptionID { get; set; }
        public int ProjectID { get; set; }
        public int? OverallRagOptionID { get; set; }
        public int? FinanceRagOptionID { get; set; }
        public string FinanceComment { get; set; }
        public int? PeopleRagOptionID { get; set; }
        public string PeopleComment { get; set; }
        public int? MilestonesRagOptionID { get; set; }
        public string MilestonesComment { get; set; }
        public int? BenefitsRagOptionID { get; set; }
        public string BenefitsComment { get; set; }
        public string ProgressUpdate { get; set; }
        public string FutureActions { get; set; }
        public string Escalations { get; set; }
        public int? ProjectPhaseID { get; set; }
        public int? BusinessCaseTypeID { get; set; }
        public DateTime? BusinessCaseDate { get; set; }
        public decimal? WholeLifeCost { get; set; }
        public decimal? WholeLifeBenefit { get; set; }
        public decimal? NetPresentValue { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }

        public virtual RagOption BenefitsRagOption { get; set; }
        public virtual ProjectBusinessCaseType BusinessCaseType { get; set; }
        public virtual RagOption FinanceRagOption { get; set; }
        public virtual RagOption MilestonesRagOption { get; set; }
        public virtual RagOption OverallRagOption { get; set; }
        public virtual RagOption PeopleRagOption { get; set; }
        public virtual Project Project { get; set; }
        public virtual ProjectPhase ProjectPhase { get; set; }
    }
}
