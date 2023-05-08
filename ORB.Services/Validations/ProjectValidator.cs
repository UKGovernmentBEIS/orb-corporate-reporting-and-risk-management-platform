using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class ProjectValidator : ReportingEntityValidator<Project>
    {
        private readonly IUnitOfWork _unitOfWork;

        public ProjectValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(p => p.Title).NotEmpty().MaximumLength(255);
            RuleFor(p => p.DirectorateID).NotNull()
                .Must(directorateId => _unitOfWork.Directorates.Entities.Any(u => u.ID == directorateId))
                .WithMessage("DirectorateID must be a valid directorate ID");
            RuleFor(p => p.Objectives).MaximumLength(10000);
            RuleFor(p => p.SeniorResponsibleOwnerUserID)
                .Must(seniorResponsibleOwnerUserId => seniorResponsibleOwnerUserId == null || _unitOfWork.Users.Entities.Any(u => u.ID == seniorResponsibleOwnerUserId))
                .WithMessage("SeniorResponsibleOwnerUserID must be a valid user ID");
            RuleFor(p => p.ProjectManagerUserID)
                .Must(projectManagerUserId => projectManagerUserId == null || _unitOfWork.Users.Entities.Any(u => u.ID == projectManagerUserId))
                .WithMessage("ProjectManagerUserID must be a valid user ID");
            RuleFor(p => p.ReportApproverUserID)
                .Must(reportApproverUserId => reportApproverUserId == null || _unitOfWork.Users.Entities.Any(u => u.ID == reportApproverUserId))
                .WithMessage("ReportApproverUserID must be a valid user ID");
            RuleFor(p => p.ReportingLeadUserID)
                .Must(reportingLeadUserId => reportingLeadUserId == null || _unitOfWork.Users.Entities.Any(u => u.ID == reportingLeadUserId))
                .WithMessage("ReportingLeadUserID must be a valid user ID");
            RuleFor(p => p.ParentProjectID)
                .Must(parentProjectId => parentProjectId == null || _unitOfWork.Projects.Entities.Any(p => p.ID == parentProjectId))
                .WithMessage("ParentProjectID must be a valid project ID");
            RuleFor(p => p.Description).MaximumLength(500);
            RuleFor(p => p.EndDate)
                .Must((project, endDate) => (project.StartDate == null || endDate == null) || project.StartDate < endDate)
                .WithMessage("If provided, EndDate must be after StartDate");
            RuleFor(p => p.CorporateProjectID)
                 .Must((project, corporateProjectId) =>
                 {
                     if (string.IsNullOrWhiteSpace(corporateProjectId) || corporateProjectId == "Local")
                     {
                         return true;
                     }
                     else if (project.ID == 0)
                     {
                         return !_unitOfWork.Projects.Entities.Any(p => p.CorporateProjectID != null && p.CorporateProjectID.ToLower() == corporateProjectId.ToLower());
                     }
                     else
                     {
                         return !_unitOfWork.Projects.Entities.Any(p => p.CorporateProjectID != null && p.CorporateProjectID.ToLower() == corporateProjectId.ToLower() && p.ID != project.ID);
                     }
                 })
                .WithMessage("A project with the provided CorporateProjectID already exists");
            RuleFor(p => p.IntegrationID).MaximumLength(255);
        }
    }
}
