using System;
using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class RiskGroupViewModel : EntityWithStatusViewModel
    {
        public int? DirectorGeneralUserID { get; set; }
        public int? RiskChampionDeputyDirectorUserID { get; set; }
        public int? BusinessPartnerUserID { get; set; }
    }
}
