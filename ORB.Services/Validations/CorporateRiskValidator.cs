using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class CorporateRiskValidator : RiskValidator<CorporateRisk>
    {
        private readonly IUnitOfWork _unitOfWork;

        public CorporateRiskValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(r => r.Title).NotEmpty().MaximumLength(255);
            RuleFor(r => r.RiskCauseDescription).MaximumLength(750);
            RuleFor(r => r.RiskEventDescription).MaximumLength(750);
            RuleFor(r => r.RiskImpactDescription).MaximumLength(750);
            RuleFor(r => r.DirectorateID).NotEmpty()
                .Must(directorateId => _unitOfWork.Directorates.Entities.Any(d => d.ID == directorateId))
                .WithMessage("DirectorateID must be a valid directorate ID");
        }
    }
}
