using FluentValidation;
using ORB.Core.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace ORB.Services.Validations
{
    public class BenefitUpdateValidator : AbstractValidator<BenefitUpdate>
    {
        public BenefitUpdateValidator() {
            RuleFor(bu => bu.BenefitID).NotNull();
            RuleFor(bu => bu.RagOptionID).NotNull().RagMustBeValid();
            RuleFor(bu => bu.Comment).NotEmpty().MaximumLength(500);
            RuleFor(bu => bu.CurrentPerformance).NotNull().ScalePrecision(4, 18);
            RuleFor(bu => bu.UpdatePeriod).NotNull();
        }
    }
}
