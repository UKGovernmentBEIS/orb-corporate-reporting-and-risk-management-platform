using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class UserPartnerOrganisationValidator : AbstractValidator<UserPartnerOrganisation>
    {
        private readonly IUnitOfWork _unitOfWork;

        public UserPartnerOrganisationValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(ug => ug.UserID).NotNull()
                .Must(userId => _unitOfWork.Users.Entities.Any(u => u.ID == userId))
                .WithMessage("UserID must be a valid user ID");
            RuleFor(ug => ug.PartnerOrganisationID).NotNull()
                .Must(partnerOrganisationId => _unitOfWork.PartnerOrganisations.Entities.Any(g => g.ID == partnerOrganisationId))
                .WithMessage("PartnerOrganisationID must be a valid partner organisation ID")
                .Must((userPartnerOrganisation, partnerOrganisationId) => !_unitOfWork.UserPartnerOrganisations.Entities.Any(ug => ug.UserID == userPartnerOrganisation.UserID && ug.PartnerOrganisationID == partnerOrganisationId && ug.ID != userPartnerOrganisation.ID))
                .WithMessage("Partner organisation is already assigned to the user");
        }
    }
}
