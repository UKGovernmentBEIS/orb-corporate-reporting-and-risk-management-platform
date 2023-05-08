using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class CustomReportingEntityTypeValidator : AbstractValidator<CustomReportingEntityType>
    {
        public CustomReportingEntityTypeValidator()
        {
            RuleFor(t => t.Title).NotEmpty().MaximumLength(255);
            RuleFor(t => (ReportTypes?)t.ReportTypeID).NotNull().IsInEnum();
            RuleFor(t => t.UpdateHasRag).Must(AtLeastOneUpdateFormField).WithMessage("At least one update form field must be selected");
            RuleFor(t => t.UpdateHasNarrative).Must(AtLeastOneUpdateFormField).WithMessage("At least one update form field must be selected");
            RuleFor(t => t.UpdateHasDeliveryDates).Must(AtLeastOneUpdateFormField).WithMessage("At least one update form field must be selected");
            RuleFor(t => t.UpdateHasMeasurement).Must(AtLeastOneUpdateFormField).WithMessage("At least one update form field must be selected");
        }

        private static bool AtLeastOneUpdateFormField(CustomReportingEntityType type, bool? updateField)
        {
            return type.UpdateHasRag == true || type.UpdateHasNarrative == true || type.UpdateHasDeliveryDates == true || type.UpdateHasMeasurement == true;
        }
    }
}
