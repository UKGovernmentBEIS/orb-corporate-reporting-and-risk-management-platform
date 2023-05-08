using FluentValidation;
using ORB.Core.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace ORB.Services.Validations
{
    public class MilestoneUpdateValidator : AbstractValidator<MilestoneUpdate>
    {
        public MilestoneUpdateValidator() {
            RuleFor(mu => mu.MilestoneID).NotNull();
            RuleFor(mu => mu.RagOptionID).NotNull().RagMustBeValid();
            RuleFor(mu => mu.Comment).NotEmpty().MaximumLength(500);
            RuleFor(mu => mu.UpdatePeriod).NotNull();
        }
    }
}
