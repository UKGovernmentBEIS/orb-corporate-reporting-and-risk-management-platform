using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class Group : EntityWithStatus
    {
        public Group()
        {
            Directorates = new HashSet<Directorate>();
            UserGroups = new HashSet<UserGroup>();
            CorporateRisks = new HashSet<CorporateRisk>();
            FinancialRisks = new HashSet<FinancialRisk>();
            FinancialRiskUserGroups = new HashSet<FinancialRiskUserGroup>();
        }

        public int? DirectorGeneralUserID { get; set; }
        public int? RiskChampionDeputyDirectorUserID { get; set; }
        public int? BusinessPartnerUserID { get; set; }

        public virtual User BusinessPartnerUser { get; set; }
        public virtual User DirectorGeneralUser { get; set; }
        public virtual User RiskChampionDeputyDirectorUser { get; set; }
        public virtual ICollection<Directorate> Directorates { get; set; }
        public virtual ICollection<UserGroup> UserGroups { get; set; }
        public virtual ICollection<CorporateRisk> CorporateRisks { get; set; }
        public virtual ICollection<FinancialRisk> FinancialRisks { get; set; }
        public virtual ICollection<FinancialRiskUserGroup> FinancialRiskUserGroups { get; set; }
    }
}
