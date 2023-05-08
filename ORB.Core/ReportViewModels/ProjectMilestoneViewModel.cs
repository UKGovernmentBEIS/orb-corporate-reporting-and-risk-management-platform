using System;
using System.Collections.Generic;
using System.Linq;
using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public class ProjectMilestoneViewModel : MilestoneViewModel
    {
        public int WorkStreamID { get; set; }

        public Entity WorkStream { get; set; }
    }
}
