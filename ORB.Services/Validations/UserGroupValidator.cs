using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class UserGroupValidator : AbstractValidator<UserGroup>
    {
        private readonly IUnitOfWork _unitOfWork;

        public UserGroupValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(ug => ug.UserID).NotNull()
                .Must(userId => _unitOfWork.Users.Entities.Any(u => u.ID == userId))
                .WithMessage("UserID must be a valid user ID");
            RuleFor(ug => ug.GroupID).NotNull()
                .Must(groupId => _unitOfWork.Groups.Entities.Any(g => g.ID == groupId))
                .WithMessage("GroupID must be a valid group ID")
                .Must((userGroup, groupId) => !_unitOfWork.UserGroups.Entities.Any(ug => ug.UserID == userGroup.UserID && ug.GroupID == groupId && ug.ID != userGroup.ID))
                .WithMessage("Group is already assigned to the user");
        }
    }
}
