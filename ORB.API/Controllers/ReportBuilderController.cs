using Microsoft.AspNet.OData;
using Microsoft.AspNet.OData.Routing;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using ORB.Core.Services;
using ORB.Core.ReportViewModels;
using System;
using System.Text.Json;
using System.Threading.Tasks;

namespace ORB.API.Controllers
{
    [Authorize]
    public class ReportBuilderController : ODataController
    {
        private readonly ILogger<ReportBuilderController> _logger;
        private readonly IReportBuilderService _reportBuilderService;
        private readonly ISignOffService _signOffService;

        public ReportBuilderController(ILogger<ReportBuilderController> logger, IReportBuilderService reportBuilderService, ISignOffService signOffService)
        {
            _logger = logger;
            _reportBuilderService = reportBuilderService;
            _signOffService = signOffService;
        }

        // GET: odata/BuildDirectorateReport(DirectorateID=5,ReportPeriod=2021-01-12)
        [HttpGet]
        [EnableQuery]
        [ODataRoute("BuildDirectorateReport(DirectorateID={directorateId},ReportPeriod={reportPeriod})")]
        public async Task<SignOffDirectorateDto> BuildDirectorateReport([FromODataUri] int directorateId, [FromODataUri] DateTime reportPeriod)
        {
            try
            {
                var report = await _reportBuilderService.BuildDirectorateReport(directorateId, reportPeriod);
                var lastSignOff = await _signOffService.LastApprovedDirectorateReportForPeriod(directorateId, reportPeriod);
                var lastApprovedReport = lastSignOff != null ? JsonSerializer.Deserialize<SignOffDirectorateViewModel>(lastSignOff.ReportJson) : null;

                return new SignOffDirectorateDto // Convert objects to string to workaround OData $expand not working
                {
                    LastApproved = lastSignOff?.SignOffDate,
                    LastApprovedBy = lastSignOff?.SignOffUser?.Title,
                    ChangedSinceApproval = !_reportBuilderService.DirectorateReportsAreIdentical(report, lastApprovedReport),
                    Directorate = JsonSerializer.Serialize(report.Directorate),
                    Commitments = JsonSerializer.Serialize(report.Commitments),
                    KeyWorkAreas = JsonSerializer.Serialize(report.KeyWorkAreas),
                    Metrics = JsonSerializer.Serialize(report.Metrics),
                    Milestones = JsonSerializer.Serialize(report.Milestones),
                    Projects = JsonSerializer.Serialize(report.Projects),
                    ReportingEntityTypes = JsonSerializer.Serialize(report.ReportingEntityTypes)
                };
            }
            catch (Exception ex)
            {
                _logger.LogError("Error building directorate report", ex);
                throw;
            }
        }

        // GET: odata/BuildPartnerOrganisationReport(PartnerOrganisationID=5,ReportPeriod=2021-01-12)
        [HttpGet]
        [EnableQuery]
        [ODataRoute("BuildPartnerOrganisationReport(PartnerOrganisationID={partnerOrganisationId},ReportPeriod={reportPeriod})")]
        public async Task<SignOffPartnerOrganisationDto> BuildPartnerOrganisationReport([FromODataUri] int partnerOrganisationId, [FromODataUri] DateTime reportPeriod)
        {
            try
            {
                var report = await _reportBuilderService.BuildPartnerOrganisationReport(partnerOrganisationId, reportPeriod);
                var lastSignOff = await _signOffService.LastApprovedPartnerOrganisationReportForPeriod(partnerOrganisationId, reportPeriod);
                var lastApprovedReport = lastSignOff != null ? JsonSerializer.Deserialize<SignOffPartnerOrganisationViewModel>(lastSignOff.ReportJson) : null;

                return new SignOffPartnerOrganisationDto // Convert objects to string to workaround OData $expand not working
                {
                    LastApproved = lastSignOff?.SignOffDate,
                    LastApprovedBy = lastSignOff?.SignOffUser?.Title,
                    ChangedSinceApproval = !_reportBuilderService.PartnerOrganisationReportsAreIdentical(report, lastApprovedReport),
                    PartnerOrganisation = JsonSerializer.Serialize(report.PartnerOrganisation),
                    Milestones = JsonSerializer.Serialize(report.Milestones),
                    PartnerOrganisationRiskMitigationActions = JsonSerializer.Serialize(report.PartnerOrganisationRiskMitigationActions),
                    PartnerOrganisationRisks = JsonSerializer.Serialize(report.PartnerOrganisationRisks),
                    ReportingEntityTypes = JsonSerializer.Serialize(report.ReportingEntityTypes)
                };
            }
            catch (Exception ex)
            {
                _logger.LogError("Error building partner organisation report", ex);
                throw;
            }
        }

        // GET: odata/BuildProjectReport(ProjectID=5,ReportPeriod=2021-01-12)
        [HttpGet]
        [EnableQuery]
        [ODataRoute("BuildProjectReport(ProjectID={projectId},ReportPeriod={reportPeriod})")]
        public async Task<SignOffProjectDto> BuildProjectReport([FromODataUri] int projectId, [FromODataUri] DateTime reportPeriod)
        {
            try
            {
                var report = await _reportBuilderService.BuildProjectReport(projectId, reportPeriod);
                var lastSignOff = await _signOffService.LastApprovedProjectReportForPeriod(projectId, reportPeriod);
                var lastApprovedReport = lastSignOff != null ? JsonSerializer.Deserialize<SignOffProjectViewModel>(lastSignOff.ReportJson) : null;

                return new SignOffProjectDto // Convert objects to string to workaround OData $expand not working
                {
                    LastApproved = lastSignOff?.SignOffDate,
                    LastApprovedBy = lastSignOff?.SignOffUser?.Title,
                    ChangedSinceApproval = !_reportBuilderService.ProjectReportsAreIdentical(report, lastApprovedReport),
                    Project = JsonSerializer.Serialize(report.Project),
                    Dependencies = JsonSerializer.Serialize(report.Dependencies),
                    WorkStreams = JsonSerializer.Serialize(report.WorkStreams),
                    Benefits = JsonSerializer.Serialize(report.Benefits),
                    Milestones = JsonSerializer.Serialize(report.Milestones),
                    Projects = JsonSerializer.Serialize(report.Projects),
                    ReportingEntityTypes = JsonSerializer.Serialize(report.ReportingEntityTypes)
                };
            }
            catch (Exception ex)
            {
                _logger.LogError("Error building project report", ex);
                throw;
            }
        }

        // GET: odata/BuildRiskReport(RiskID=5,ReportPeriod=2021-01-12)
        [HttpGet]
        [EnableQuery]
        [ODataRoute("BuildRiskReport(RiskID={riskId},ReportPeriod={reportPeriod})")]
        public async Task<SignOffCorporateRiskDto> BuildRiskReport([FromODataUri] int riskId, [FromODataUri] DateTime reportPeriod)
        {
            try
            {
                var report = await _reportBuilderService.BuildRiskReport(riskId, reportPeriod);
                var lastSignOff = await _signOffService.LastApprovedRiskReportForPeriod(riskId, reportPeriod);
                var lastApprovedReport = lastSignOff != null ? JsonSerializer.Deserialize<SignOffCorporateRiskViewModel>(lastSignOff.ReportJson) : null;

                return new SignOffCorporateRiskDto // Convert objects to string to workaround OData $expand not working
                {
                    LastApproved = lastSignOff?.SignOffDate,
                    LastApprovedBy = lastSignOff?.SignOffUser?.Title,
                    ChangedSinceApproval = !_reportBuilderService.RiskReportsAreIdentical(report, lastApprovedReport),
                    Risk = JsonSerializer.Serialize(report.Risk),
                    RiskMitigationActions = JsonSerializer.Serialize(report.RiskMitigationActions)
                };
            }
            catch (Exception ex)
            {
                _logger.LogError("Error building risk report", ex);
                throw;
            }
        }

        // GET: odata/BuildFinancialRiskReport(RiskID=5,ReportPeriod=2021-01-12)
        [HttpGet]
        [EnableQuery]
        [ODataRoute("BuildFinancialRiskReport(RiskID={riskId},ReportPeriod={reportPeriod})")]
        public async Task<SignOffFinancialRiskDto> BuildFinancialRiskReport([FromODataUri] int riskId, [FromODataUri] DateTime reportPeriod)
        {
            try
            {
                var report = await _reportBuilderService.BuildFinancialRiskReport(riskId, reportPeriod);
                var lastSignOff = await _signOffService.LastApprovedFinancialRiskReportForPeriod(riskId, reportPeriod);
                var lastApprovedReport = lastSignOff != null ? JsonSerializer.Deserialize<SignOffFinancialRiskViewModel>(lastSignOff.ReportJson) : null;

                // Convert objects to string to workaround OData $expand not working
                return new SignOffFinancialRiskDto
                {
                    LastApproved = lastSignOff?.SignOffDate,
                    LastApprovedBy = lastSignOff?.SignOffUser?.Title,
                    ChangedSinceApproval = !_reportBuilderService.FinancialRiskReportsAreIdentical(report, lastApprovedReport),
                    FinancialRisk = JsonSerializer.Serialize(report.FinancialRisk),
                    FinancialRiskMitigationActions = JsonSerializer.Serialize(report.FinancialRiskMitigationActions)
                };
            }
            catch (Exception ex)
            {
                _logger.LogError("Error building financial risk report", ex);
                throw;
            }
        }
    }
}
