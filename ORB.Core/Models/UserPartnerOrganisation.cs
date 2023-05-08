using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class UserPartnerOrganisation : EntityWithEditor
    {
        public int UserID { get; set; }
        public int PartnerOrganisationID { get; set; }
        public bool IsAdmin { get; set; }
        public bool? HideHeadlines { get; set; }
        public bool? HideMilestones { get; set; }
        public bool? HideCustomSections { get; set; }

        public virtual PartnerOrganisation PartnerOrganisation { get; set; }
        public virtual User User { get; set; }
    }
}
