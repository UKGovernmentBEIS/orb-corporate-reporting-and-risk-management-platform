using FluentValidation;
using ORB.Core.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace ORB.Services.Validations
{
    public class DependencyUpdateValidator : AbstractValidator<DependencyUpdate>
    {
        public DependencyUpdateValidator() {
            RuleFor(du => du.DependencyID).NotNull();
            RuleFor(du => du.RagOptionID).NotNull().RagMustBeValid();
            RuleFor(du => du.Comment).NotEmpty().MaximumLength(500);
            RuleFor(du => du.UpdatePeriod).NotNull();
        }
    }
}
