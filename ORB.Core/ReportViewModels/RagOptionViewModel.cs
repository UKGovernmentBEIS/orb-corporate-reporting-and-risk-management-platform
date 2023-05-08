using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public class RagOptionViewModel
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string ReportName { get; set; }
        public int? Score { get; set; }
    }
}