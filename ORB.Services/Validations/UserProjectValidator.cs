using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class UserProjectValidator : AbstractValidator<UserProject>
    {
        private readonly IUnitOfWork _unitOfWork;

        public UserProjectValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(up => up.UserID).NotNull()
                .Must(userId => _unitOfWork.Users.Entities.Any(u => u.ID == userId))
                .WithMessage("UserID must be a valid user ID");
            RuleFor(up => up.ProjectID).NotNull()
                .Must(projectId => _unitOfWork.Projects.Entities.Any(p => p.ID == projectId))
                .WithMessage("ProjectID must be a valid project ID")
                .Must((userProject, projectId) => !_unitOfWork.UserProjects.Entities.Any(up => up.UserID == userProject.UserID && up.ProjectID == projectId && up.ID != userProject.ID))
                .WithMessage("Project is already assigned to the user");
        }
    }
}
