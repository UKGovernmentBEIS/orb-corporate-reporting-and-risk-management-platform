using ORB.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ORB.Core.ReportViewModels
{
    public class EntityWithStatusViewModel : EntityWithEditorViewModel
    {
        public int? EntityStatusID { get; set; }
        public DateTime? EntityStatusDate { get; set; }

        public EntityStatusViewModel EntityStatus { get; set; }
    }
}