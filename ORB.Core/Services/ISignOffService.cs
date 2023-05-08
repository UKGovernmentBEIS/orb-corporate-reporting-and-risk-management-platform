using ORB.Core.Models;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Core.Services
{
    public interface ISignOffService : IEntityAddService<SignOff>
    {
        Task<SignOff> LastApprovedDirectorateReportForPeriod(int directorateId, DateTime reportPeriod);
        Task<SignOff> LastApprovedProjectReportForPeriod(int projectId, DateTime reportPeriod);
        Task<SignOff> LastApprovedPartnerOrganisationReportForPeriod(int partnerOrganisationId, DateTime reportPeriod);
        Task<SignOff> LastApprovedRiskReportForPeriod(int riskId, DateTime reportPeriod);
        Task<SignOff> LastApprovedFinancialRiskReportForPeriod(int financialRiskId, DateTime reportPeriod);
    }
}