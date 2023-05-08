using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class DependencyValidator : AbstractValidator<Dependency>
    {
        private readonly IUnitOfWork _unitOfWork;

        public DependencyValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(d => d.Title).NotEmpty().MaximumLength(255);
            RuleFor(d => d.ProjectID).NotNull()
                .Must(projectId => _unitOfWork.Projects.Entities.Any(p => p.ID == projectId))
                .WithMessage("ProjectID must be a valid project");
            RuleFor(d => d.ThirdParty).MaximumLength(255);
            RuleFor(d => d.LeadUserID)
               .Must((dependency, userId) => userId == null || _unitOfWork.UserProjects.Entities.Any(up => up.ProjectID == dependency.ProjectID && up.UserID == userId))
               .WithMessage("Lead user must be a valid user assigned to the dependency's project");
            RuleFor(d => d.RagOptionID).RagMustBeValid();
        }
    }
}
