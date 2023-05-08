using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class UserRoleValidator : AbstractValidator<UserRole>
    {
        private readonly IUnitOfWork _unitOfWork;

        public UserRoleValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(u => u.UserID).NotNull()
                .Must(userId => _unitOfWork.Users.Entities.Any(u => u.ID == userId))
                .WithMessage("UserID must be a valid user ID");
            RuleFor(u => u.RoleID).NotNull()
                .Must(roleId => _unitOfWork.Roles.Entities.Any(r => r.ID == roleId))
                .WithMessage("RoleID must be a valid role ID")
                .Must((userRole, roleId) => !_unitOfWork.UserRoles.Entities.Any(ur => ur.UserID == userRole.UserID && ur.RoleID == roleId && ur.ID != userRole.ID))
                .WithMessage("Role is already assigned to the user");
        }
    }
}
