using FluentValidation;
using ORB.Core.Models;

namespace ORB.Services.Validations
{
    public class RiskUpdateValidator<T> : AbstractValidator<T> where T : RiskUpdate
    {
        public RiskUpdateValidator() : base()
        {
            RuleFor(r => r.Narrative).MaximumLength(750);
        }
    }
}
