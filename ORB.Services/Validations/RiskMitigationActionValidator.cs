using FluentValidation;
using ORB.Core.Models;

namespace ORB.Services.Validations
{
    public class RiskMitigationActionValidator<T> : ReportingEntityValidator<T> where T : RiskMitigationAction
    {
        public RiskMitigationActionValidator() : base()
        {
            RuleFor(r => r.Title).NotEmpty().MaximumLength(255);
            RuleFor(r => r.Description).MaximumLength(750);
            RuleFor(r => r.BaselineDate).NotEmpty().When(r => r.ActionIsOngoing == null || r.ActionIsOngoing == false);
        }
    }
}
