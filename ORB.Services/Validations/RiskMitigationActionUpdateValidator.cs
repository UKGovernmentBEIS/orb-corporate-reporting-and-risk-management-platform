using FluentValidation;
using ORB.Core.Models;

namespace ORB.Services.Validations
{
    public class RiskMitigationActionUpdateValidator<T> : AbstractValidator<T> where T : RiskMitigationActionUpdate
    {
        public RiskMitigationActionUpdateValidator() : base()
        {
            RuleFor(r => r.Comment).MaximumLength(750);
        }
    }
}
