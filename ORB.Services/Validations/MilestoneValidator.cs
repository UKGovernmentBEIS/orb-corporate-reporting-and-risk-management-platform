using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class MilestoneValidator : AbstractValidator<Milestone>
    {
        protected readonly IUnitOfWork _unitOfWork;
        public MilestoneValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(m => m.Title).NotEmpty().MaximumLength(255);
            RuleFor(m => m.MilestoneCode).MaximumLength(255);
            RuleFor(m => m.MilestoneTypeID).NotNull()
                .Must(typeId => typeId == (int)MilestoneTypes.Directorate).When(m => m.KeyWorkAreaID != null)
                .Must(typeId => typeId == (int)MilestoneTypes.Project).When(m => m.WorkStreamID != null)
                .Must(typeId => typeId == (int)MilestoneTypes.PartnerOrganisation).When(m => m.PartnerOrganisationID != null)
                .WithMessage("MilestoneTypeID must match the supplied parent entity type");
            RuleFor(m => m.LeadUserID)
                .Must((milestone, userId) =>
                {
                    int? projectId = null, directorateId = null;
                    if (milestone.WorkStreamID != null)
                    {
                        var workStream = _unitOfWork.WorkStreams.Find((int)milestone.WorkStreamID);
                        if (workStream != null) {
                            projectId = workStream.ProjectID;
                        }
                    }
                    if (milestone.KeyWorkAreaID != null)
                    {
                        var keyWorkArea = _unitOfWork.KeyWorkAreas.Find((int)milestone.KeyWorkAreaID);
                        if (keyWorkArea != null)
                        {
                            directorateId = keyWorkArea.DirectorateID;
                        }
                    }

                    return userId == null
                    || (projectId != null && _unitOfWork.UserProjects.Entities.Any(up => up.ProjectID == projectId && up.UserID == userId))
                    || (directorateId != null && _unitOfWork.UserDirectorates.Entities.Any(ud => ud.DirectorateID == directorateId && ud.UserID == userId))
                    || _unitOfWork.UserPartnerOrganisations.Entities.Any(upo => upo.PartnerOrganisationID == milestone.PartnerOrganisationID && upo.UserID == userId);
                }
                )
                .WithMessage("Lead user must be a valid user assigned to the milestone's directorate/project/partner organisation");
            RuleFor(m => m.RagOptionID).RagMustBeValid();
            RuleFor(m => m.KeyWorkAreaID).NotNull().When(m => m.PartnerOrganisationID == null && m.WorkStreamID == null);
            RuleFor(m => m.PartnerOrganisationID).NotNull().When(m => m.KeyWorkAreaID == null && m.WorkStreamID == null);
            RuleFor(m => m.WorkStreamID).NotNull().When(m => m.KeyWorkAreaID == null && m.PartnerOrganisationID == null);
            RuleFor(m => m.Description).MaximumLength(500);
        }
    }
}
