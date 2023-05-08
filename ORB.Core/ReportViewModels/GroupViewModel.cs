using System;
using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class GroupViewModel : EntityWithStatusViewModel
    {
        public int? DirectorGeneralUserID { get; set; }
        public int? RiskChampionDeputyDirectorUserID { get; set; }
        public int? BusinessPartnerUserID { get; set; }

        public UserViewModel BusinessPartnerUser { get; set; }
        public UserViewModel DirectorGeneralUser { get; set; }
        public UserViewModel RiskChampionDeputyDirectorUser { get; set; }
    }
}
