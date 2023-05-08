using System;
using System.Collections.Generic;
using System.Linq;
using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public class DirectorateMilestoneViewModel : MilestoneViewModel
    {
        public int KeyWorkAreaID { get; set; }

        public Entity KeyWorkArea { get; set; }
    }
}
