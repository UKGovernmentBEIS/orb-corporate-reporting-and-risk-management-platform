using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class ReportingField
    {
        public string FieldName { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public int? Type { get; set; }
        public bool? Required { get; set; }
        public int? MaxLength { get; set; }
        public int? LookupList { get; set; }
        public int? Min { get; set; }
        public int? Max { get; set; }
        public bool? MultiSelect { get; set; }
        public string Choices { get; set; }
        public int? ChoiceControl { get; set; }
    }
}