using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class GroupValidator : AbstractValidator<Group>
    {
        private readonly IUnitOfWork _unitOfWork;

        public GroupValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(g => g.Title).NotEmpty().MaximumLength(50);
            RuleFor(g => g.DirectorGeneralUserID)
                .Must(directorGeneralUserID => directorGeneralUserID == null || _unitOfWork.Users.Entities.Any(u => u.ID == directorGeneralUserID))
                .WithMessage("DirectorGeneralUserID must be a valid user ID");
            RuleFor(g => g.RiskChampionDeputyDirectorUserID)
                .Must(riskChampionDeputyDirectorUserID => riskChampionDeputyDirectorUserID == null || _unitOfWork.Users.Entities.Any(u => u.ID == riskChampionDeputyDirectorUserID))
                .WithMessage("RiskChampionDeputyDirectorUserID must be a valid user ID");
            RuleFor(g => g.BusinessPartnerUserID)
                .Must(businessPartnerUserID => businessPartnerUserID == null || _unitOfWork.Users.Entities.Any(u => u.ID == businessPartnerUserID))
                .WithMessage("BusinessPartnerUserID must be a valid user ID");
        }
    }
}
