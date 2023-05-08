using FluentValidation;
using ORB.Core.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace ORB.Services.Validations
{
    public class WorkStreamUpdateValidator : AbstractValidator<WorkStreamUpdate>
    {
        public WorkStreamUpdateValidator() {
            RuleFor(wu => wu.WorkStreamID).NotNull();
            RuleFor(wu => wu.RagOptionID).NotNull().RagMustBeValid();
            RuleFor(wu => wu.Comment).NotEmpty().MaximumLength(500);
            RuleFor(wu => wu.UpdatePeriod).NotNull();
        }
    }
}
