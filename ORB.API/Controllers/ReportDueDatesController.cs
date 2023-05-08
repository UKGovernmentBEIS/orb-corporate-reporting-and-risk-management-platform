using Microsoft.AspNet.OData;
using Microsoft.AspNet.OData.Routing;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.API.Controllers
{
    [Authorize]
    public class ReportDueDatesController : ODataController
    {
        private readonly IBenefitService _benefitService;
        private readonly IEntityService<Directorate> _directorateService;
        private readonly IEntityService<FinancialRisk> _financialRiskService;
        private readonly IMetricService _metricService;
        private readonly IEntityService<PartnerOrganisation> _partnerOrgService;
        private readonly IProjectService _projectService;

        public ReportDueDatesController(IBenefitService benefitService,
            IEntityService<Directorate> directorateService,
            IEntityService<FinancialRisk> financialRiskService,
            IMetricService metricService,
            IEntityService<PartnerOrganisation> partnerOrgService,
            IProjectService projectService)
        {
            _benefitService = benefitService;
            _directorateService = directorateService;
            _financialRiskService = financialRiskService;
            _metricService = metricService;
            _partnerOrgService = partnerOrgService;
            _projectService = projectService;
        }

        // GET: odata/GetBenefitReportDueDates(ID=5,AtDate=2021-01-12)
        [ODataRoute("GetBenefitReportDueDates(ID={key},AtDate={date})")]
        public ActionResult GetBenefitReportDueDates([FromODataUri] int key, [FromODataUri] DateTime date)
        {
            var entity = _benefitService.Find(key).SingleOrDefault();
            if (entity != null)
            {
                return Ok(new ReportDueDates
                {
                    Next = ReportingCycleService.NextReportDue(entity, date),
                    Previous = ReportingCycleService.PreviousReportDue(entity, date)
                });
            }
            return new NotFoundObjectResult(key);
        }

        // GET: odata/GetDirectorateReportDueDates(ID={key},AtDate={date})
        [ODataRoute("GetDirectorateReportDueDates(ID={key},AtDate={date})")]
        public ActionResult GetDirectorateReportDueDates([FromODataUri] int key, [FromODataUri] DateTime date)
        {
            var entity = _directorateService.Find(key).SingleOrDefault();
            if (entity != null)
            {
                return Ok(new ReportDueDates
                {
                    Next = ReportingCycleService.NextReportDue(entity, date),
                    Previous = ReportingCycleService.PreviousReportDue(entity, date)
                });
            }
            return new NotFoundObjectResult(key);
        }

        // GET: odata/GetMetricReportDueDates(ID={key},AtDate={date})
        [ODataRoute("GetMetricReportDueDates(ID={key},AtDate={date})")]
        public ActionResult GetMetricReportDueDates([FromODataUri] int key, [FromODataUri] DateTime date)
        {
            var entity = _metricService.Find(key).SingleOrDefault();
            if (entity != null)
            {
                return Ok(new ReportDueDates
                {
                    Next = ReportingCycleService.NextReportDue(entity, date),
                    Previous = ReportingCycleService.PreviousReportDue(entity, date)
                });
            }
            return new NotFoundObjectResult(key);
        }

        // GET: odata/GetPartnerOrganisationReportDueDates(ID={key},AtDate={date})
        [ODataRoute("GetPartnerOrganisationReportDueDates(ID={key},AtDate={date})")]
        public ActionResult GetPartnerOrganisationReportDueDates([FromODataUri] int key, [FromODataUri] DateTime date)
        {
            var entity = _partnerOrgService.Find(key).SingleOrDefault();
            if (entity != null)
            {
                return Ok(new ReportDueDates
                {
                    Next = ReportingCycleService.NextReportDue(entity, date),
                    Previous = ReportingCycleService.PreviousReportDue(entity, date)
                });
            }
            return new NotFoundObjectResult(key);
        }

        // GET: odata/GetProjectReportDueDates(ID={key},AtDate={date})
        [ODataRoute("GetProjectReportDueDates(ID={key},AtDate={date})")]
        public ActionResult GetProjectReportDueDates([FromODataUri] int key, [FromODataUri] DateTime date)
        {
            var entity = _projectService.Find(key).SingleOrDefault();
            if (entity != null)
            {
                return Ok(new ReportDueDates
                {
                    Next = ReportingCycleService.NextReportDue(entity, date),
                    Previous = ReportingCycleService.PreviousReportDue(entity, date)
                });
            }
            return new NotFoundObjectResult(key);
        }

        // GET: odata/GetFinancialRiskReportDueDates(ID={key},AtDate={date})
        [ODataRoute("GetFinancialRiskReportDueDates(ID={key},AtDate={date})")]
        public ActionResult GetFinancialRiskReportDueDates([FromODataUri] int key, [FromODataUri] DateTime date)
        {
            var entity = _financialRiskService.Find(key).SingleOrDefault();
            if (entity != null)
            {
                return Ok(new ReportDueDates
                {
                    Next = ReportingCycleService.NextReportDue(entity, date),
                    Previous = ReportingCycleService.PreviousReportDue(entity, date)
                });
            }
            return new NotFoundObjectResult(key);
        }
    }
}
