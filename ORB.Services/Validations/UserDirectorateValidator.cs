using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class UserDirectorateValidator : AbstractValidator<UserDirectorate>
    {
        private readonly IUnitOfWork _unitOfWork;

        public UserDirectorateValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(ud => ud.UserID).NotNull()
                .Must(userId => _unitOfWork.Users.Entities.Any(u => u.ID == userId))
                .WithMessage("UserID must be a valid user ID");
            RuleFor(ud => ud.DirectorateID).NotNull()
                .Must(directorateId => _unitOfWork.Directorates.Entities.Any(d => d.ID == directorateId))
                .WithMessage("DirectorateID must be a valid directorate ID")
                .Must((userDirectorate, directorateId) => !_unitOfWork.UserDirectorates.Entities.Any(ud => ud.UserID == userDirectorate.UserID && ud.DirectorateID == directorateId && ud.ID != userDirectorate.ID))
                .WithMessage("Directorate is already assigned to the user");
        }
    }
}
