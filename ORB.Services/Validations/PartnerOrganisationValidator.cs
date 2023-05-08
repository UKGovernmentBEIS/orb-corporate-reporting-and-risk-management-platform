using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class PartnerOrganisationValidator : ReportingEntityValidator<PartnerOrganisation>
    {
        private readonly IUnitOfWork _unitOfWork;

        public PartnerOrganisationValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(p => p.Title).NotEmpty().MaximumLength(255);
            RuleFor(p => p.DirectorateID)
                .Must(directorateId => directorateId == null || _unitOfWork.Directorates.Entities.Any(d => d.ID == directorateId))
                .WithMessage("DirectorateID must be a valid directorate ID");
            RuleFor(p => p.LeadPolicySponsorUserID)
                .Must(leadPolicySponsorUserID => leadPolicySponsorUserID == null || _unitOfWork.Users.Entities.Any(u => u.ID == leadPolicySponsorUserID))
                .WithMessage("LeadPolicySponsorUserID must be a valid user ID");
            RuleFor(p => p.ReportAuthorUserID)
                .Must(reportAuthorUserID => reportAuthorUserID == null || _unitOfWork.Users.Entities.Any(u => u.ID == reportAuthorUserID))
                .WithMessage("ReportAuthorUserID must be a valid user ID");
            RuleFor(p => p.Objectives).MaximumLength(10000);
            RuleFor(p => p.Description).MaximumLength(500);
        }
    }
}
