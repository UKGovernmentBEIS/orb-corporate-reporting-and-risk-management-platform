using ORB.Core.ReportViewModels;
using System;
using System.Text;
using System.Threading.Tasks;

namespace ORB.Core.Services
{
    public interface IReportBuilderService
    {
        Task<SignOffDirectorateViewModel> BuildDirectorateReport(int directorateId, DateTime reportPeriod);
        Task<SignOffProjectViewModel> BuildProjectReport(int projectId, DateTime reportPeriod);
        Task<SignOffPartnerOrganisationViewModel> BuildPartnerOrganisationReport(int partnerOrganisationId, DateTime reportPeriod);
        Task<SignOffCorporateRiskViewModel> BuildRiskReport(int riskId, DateTime reportPeriod);
        Task<SignOffFinancialRiskViewModel> BuildFinancialRiskReport(int riskId, DateTime reportPeriod);
        bool? DirectorateReportsAreIdentical(SignOffDirectorateViewModel report1, SignOffDirectorateViewModel report2);
        bool? ProjectReportsAreIdentical(SignOffProjectViewModel report1, SignOffProjectViewModel report2);
        bool? PartnerOrganisationReportsAreIdentical(SignOffPartnerOrganisationViewModel report1, SignOffPartnerOrganisationViewModel report2);
        bool? RiskReportsAreIdentical(SignOffCorporateRiskViewModel report1, SignOffCorporateRiskViewModel report2);
        bool? FinancialRiskReportsAreIdentical(SignOffFinancialRiskViewModel report1, SignOffFinancialRiskViewModel report2);
    }
}
