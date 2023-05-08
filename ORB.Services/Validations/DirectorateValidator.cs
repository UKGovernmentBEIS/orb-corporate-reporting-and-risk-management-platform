using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class DirectorateValidator : ReportingEntityValidator<Directorate>
    {
        private readonly IUnitOfWork _unitOfWork;

        public DirectorateValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(d => d.Title).NotEmpty().MaximumLength(255);
            RuleFor(d => d.GroupID).NotNull()
                .Must(groupId => _unitOfWork.Groups.Entities.Any(u => u.ID == groupId))
                .WithMessage("GroupID must be a valid group ID");
            RuleFor(d => d.DirectorUserID)
                .Must(directorUserID => directorUserID == null || _unitOfWork.Users.Entities.Any(u => u.ID == directorUserID))
                .WithMessage("DirectorUserID must be a valid user ID");
            RuleFor(d => d.Objectives).MaximumLength(10000);
            RuleFor(d => d.ReportApproverUserID)
                .Must(reportApproverUserId => reportApproverUserId == null || _unitOfWork.Users.Entities.Any(u => u.ID == reportApproverUserId))
                .WithMessage("ReportApproverUserID must be a valid user ID");
            RuleFor(d => d.ReportingLeadUserID)
                .Must(reportingLeadUserId => reportingLeadUserId == null || _unitOfWork.Users.Entities.Any(u => u.ID == reportingLeadUserId))
                .WithMessage("ReportingLeadUserID must be a valid user ID");
            RuleFor(d => d.Description).MaximumLength(500);
        }
    }
}
