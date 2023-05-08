using FluentValidation;
using ORB.Core.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace ORB.Services.Validations
{
    public class ProjectUpdateValidator : AbstractValidator<ProjectUpdate>
    {
        public ProjectUpdateValidator()
        {
            RuleFor(pu => pu.BenefitsComment).MaximumLength(500);
            RuleFor(pu => pu.BenefitsRagOptionID).RagMustBeValid();
            RuleFor(pu => pu.Escalations).MaximumLength(500);
            RuleFor(pu => pu.FinanceComment).MaximumLength(500);
            RuleFor(pu => pu.FinanceRagOptionID).RagMustBeValid();
            RuleFor(pu => pu.FutureActions).MaximumLength(500);
            RuleFor(pu => pu.MilestonesComment).MaximumLength(500);
            RuleFor(pu => pu.MilestonesRagOptionID).RagMustBeValid();
            RuleFor(pu => pu.OverallRagOptionID).RagMustBeValid();
            RuleFor(pu => pu.PeopleComment).MaximumLength(500);
            RuleFor(pu => pu.PeopleRagOptionID).RagMustBeValid();
            RuleFor(pu => pu.ProgressUpdate).MaximumLength(500);
            RuleFor(pu => pu.ProjectID).NotNull();
            RuleFor(pu => pu.UpdatePeriod).NotNull();
        }
    }
}
