using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class WorkStreamValidator : AbstractValidator<WorkStream>
    {
        private readonly IUnitOfWork _unitOfWork;
        public WorkStreamValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(w => w.Title).NotEmpty().MaximumLength(255);
            RuleFor(w => w.WorkStreamCode).MaximumLength(255);
            RuleFor(w => w.ProjectID).NotNull()
                .Must(projectId => unitOfWork.Projects.Entities.Any(p => p.ID == projectId))
                .WithMessage("ProjectID must be a valid project");
            RuleFor(w => w.LeadUserID)
                .Must((workStream, userId) => userId == null || _unitOfWork.UserProjects.Entities.Any(up => up.ProjectID == workStream.ProjectID && up.UserID == userId))
                .WithMessage("Lead user must be a valid user assigned to the work stream's project");
            RuleFor(w => w.RagOptionID).RagMustBeValid();
        }
    }
}
