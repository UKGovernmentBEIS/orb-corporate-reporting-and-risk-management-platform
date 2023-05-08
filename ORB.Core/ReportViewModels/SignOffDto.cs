using System;
using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class SignOffDto
    {
        public DateTime? LastApproved { get; set; }
        public string LastApprovedBy { get; set; }
        public bool? ChangedSinceApproval { get; set; }
    }
}