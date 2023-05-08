using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class BenefitValidator : ReportingEntityValidator<Benefit>
    {
        private readonly IUnitOfWork _unitOfWork;

        public BenefitValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(b => b.Title).NotEmpty().MaximumLength(255);
            RuleFor(b => b.ProjectID).NotEmpty()
                .Must(projectId => _unitOfWork.Projects.Entities.Any(p => p.ID == projectId))
                .WithMessage("ProjectID must be a valid project");
            RuleFor(b => b.BenefitTypeID)
                .Must(typeId => typeId == null || _unitOfWork.BenefitTypes.Entities.Any(bt => bt.ID == typeId))
                .WithMessage("BenefitTypeID must be a valid benefit type");
            RuleFor(b => b.MeasurementUnitID)
                .Must(unitId => unitId == null || _unitOfWork.MeasurementUnits.Entities.Any(mu => mu.ID == unitId))
                .WithMessage("MeasurementUnitID must be a valid measurement unit");
            RuleFor(b => b.LeadUserID)
                .Must((benefit, userId) => userId == null || _unitOfWork.UserProjects.Entities.Any(up => up.ProjectID == benefit.ProjectID && up.UserID == userId))
                .WithMessage("LeadUserID must be a valid user assigned to the benefit's project");
            RuleFor(b => b.RagOptionID)
                .Must(ragId => ragId == null || _unitOfWork.RagOptions.Entities.Any(ro => ro.ID == ragId))
                .WithMessage("RagOptionID must be a valid RAG option");
            RuleFor(b => b.Description).MaximumLength(500);
        }
    }
}
