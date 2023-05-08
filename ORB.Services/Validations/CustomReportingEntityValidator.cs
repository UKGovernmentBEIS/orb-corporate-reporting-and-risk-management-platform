using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ORB.Services.Validations
{
    public class CustomReportingEntityValidator : AbstractValidator<CustomReportingEntity>
    {
        private readonly IUnitOfWork _unitOfWork;

        public CustomReportingEntityValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;

            RuleFor(e => e.Title).NotEmpty().MaximumLength(255);
            RuleFor(e => e.ReportingEntityTypeID).NotEmpty()
                .Must(typeId => _unitOfWork.ReportingEntityTypes.Entities.Any(t => t.ID == typeId))
                .WithMessage("ReportingEntityTypeID must be a valid reporting entity type");
            RuleFor(e => e.DirectorateID)
                .Must((entity, directorateId) => ValidDirectorateForType(entity, directorateId, _unitOfWork))
                .WithMessage("DirectorateID must be a valid directorate or null when belonging to another report type");
            RuleFor(e => e.ProjectID)
                .Must((entity, projectId) => ValidProjectForType(entity, projectId, _unitOfWork))
                .WithMessage("ProjectID must be a valid project or null when belonging to another report type");
            RuleFor(e => e.PartnerOrganisationID)
                .Must((entity, partnerOrganisationId) => ValidPartnerOrganisationForType(entity, partnerOrganisationId, _unitOfWork))
                .WithMessage("PartnerOrganisationID must be a valid partner organisation or null when belonging to another report type");
            RuleFor(e => e.LeadUserID)
               .Must((entity, userId) => userId == null || _unitOfWork.Users.Entities.Any(u => u.ID == userId))
               .WithMessage("LeadUserID must be a valid user");
            RuleFor(e => e.Properties)
                .Must((entity, properties) => ValidProperties(entity, properties, _unitOfWork))
                .WithMessage("One or more dynamic properties is invalid");
        }

        private static bool ValidDirectorateForType(CustomReportingEntity entity, int? directorateId, IUnitOfWork unitOfWork)
        {
            var type = unitOfWork.ReportingEntityTypes.Find(entity.ReportingEntityTypeID);
            if (type != null && type.ReportTypeID == (int)ReportTypes.Directorate)
            {
                if (directorateId == null)
                {
                    return false;
                }
                return unitOfWork.Directorates.Entities.Any(d => d.ID == directorateId);
            }
            else
            {
                return directorateId == null;
            }
        }

        private static bool ValidProjectForType(CustomReportingEntity entity, int? projectId, IUnitOfWork unitOfWork)
        {
            var type = unitOfWork.ReportingEntityTypes.Find(entity.ReportingEntityTypeID);
            if (type != null && type.ReportTypeID == (int)ReportTypes.Project)
            {
                if (projectId == null)
                {
                    return false;
                }
                return unitOfWork.Projects.Entities.Any(d => d.ID == projectId);
            }
            else
            {
                return projectId == null;
            }
        }

        private static bool ValidPartnerOrganisationForType(CustomReportingEntity entity, int? partnerOrganisationId, IUnitOfWork unitOfWork)
        {
            var type = unitOfWork.ReportingEntityTypes.Find(entity.ReportingEntityTypeID);
            if (type != null && type.ReportTypeID == (int)ReportTypes.PartnerOrganistion)
            {
                if (partnerOrganisationId == null)
                {
                    return false;
                }
                return unitOfWork.PartnerOrganisations.Entities.Any(d => d.ID == partnerOrganisationId);
            }
            else
            {
                return partnerOrganisationId == null;
            }
        }

        private static bool ValidProperties(CustomReportingEntity entity, IDictionary<string, object> properties, IUnitOfWork unitOfWork)
        {
            var type = unitOfWork.ReportingEntityTypes.Find(entity.ReportingEntityTypeID);
            if (type != null)
            {
                foreach (var field in type.CustomFields)
                {
                    if (field.Required == true)
                    {
                        switch ((FieldTypes)field.Type)
                        {
                            case FieldTypes.SingleLineOfText:
                            case FieldTypes.MultipleLinesOfText:
                                if (string.IsNullOrWhiteSpace(properties.FirstOrDefault(p => p.Key == field.FieldName).Value as string))
                                {
                                    return false;
                                }
                                break;
                            case FieldTypes.Lookup:
                            case FieldTypes.Number:
                                if (properties.FirstOrDefault(p => p.Key == field.FieldName).Value == null)
                                {
                                    return false;
                                }
                                break;
                            case FieldTypes.Person:
                                if (field.MultiSelect == true)
                                {
                                    var userIds = properties.FirstOrDefault(p => p.Key == field.FieldName).Value as ICollection<int>;
                                    return userIds != null && userIds.Count > 0;
                                }
                                else if (properties.FirstOrDefault(p => p.Key == field.FieldName).Value == null)
                                {
                                    return false;
                                }
                                break;
                            case FieldTypes.Choice:
                                if (field.MultiSelect == true)
                                {
                                    var choices = properties.FirstOrDefault(p => p.Key == field.FieldName).Value as ICollection<string>;
                                    return choices != null && choices.Count > 0;
                                }
                                else if (properties.FirstOrDefault(p => p.Key == field.FieldName).Value == null)
                                {
                                    return false;
                                }
                                break;
                        }
                    }
                }
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
