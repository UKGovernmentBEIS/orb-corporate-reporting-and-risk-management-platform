using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class MetricValidator : ReportingEntityValidator<Metric>
    {
        public MetricValidator() { }
    }
}
