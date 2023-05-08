using FluentValidation;
using ORB.Core.Models;

namespace ORB.Services.Validations
{
    public class RiskValidator<T> : ReportingEntityValidator<T> where T : Risk
    {
        public RiskValidator() : base()
        {
            RuleFor(r => r.Title).NotEmpty().MaximumLength(255);
        }
    }
}
