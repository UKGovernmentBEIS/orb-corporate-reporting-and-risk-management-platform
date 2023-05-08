using FluentValidation;
using ORB.Core.Models;

namespace ORB.Services.Validations
{
    public class FinancialRiskValidator : RiskValidator<FinancialRisk>
    {
        public FinancialRiskValidator()
        {
            RuleFor(r => r.Title).NotEmpty().MaximumLength(255);
            RuleFor(r => r.GroupID).NotEmpty().When(r => r.OwnedByMultipleGroups == null || r.OwnedByMultipleGroups == false);
            RuleFor(r => r.DirectorateID).NotEmpty().When(r => r.OwnedByDgOffice == null || r.OwnedByDgOffice == false);
            RuleFor(r => r.RiskOwnerUserID).NotEmpty();
            RuleFor(r => r.StaffNonStaffSpend).NotEmpty();
            RuleFor(r => r.FundingClassification).NotEmpty();
            RuleFor(r => r.EconomicRingfence).NotEmpty();
            RuleFor(r => r.PolicyRingfence).NotEmpty();
            RuleFor(r => r.UniformChartOfAccountsID).NotEmpty();
            RuleFor(r => r.RiskEventDescription).MaximumLength(750);
            RuleFor(r => r.RiskCauseDescription).MaximumLength(750);
            RuleFor(r => r.RiskImpactDescription).MaximumLength(750);
        }
    }
}
