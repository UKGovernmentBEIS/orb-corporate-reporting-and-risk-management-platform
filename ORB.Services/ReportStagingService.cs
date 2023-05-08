using FluentValidation;
using Microsoft.AspNet.OData;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using ORB.Core.Services;
using ORB.Services.Validations;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class ReportStagingService : EntityAddService<ReportStaging, IEntityAddRepository<ReportStaging>>, IEntityAddService<ReportStaging>
    {
        private readonly IEntityUpdateService<ProjectUpdate> _projectUpdateService;
        private readonly IEntityUpdateService<WorkStreamUpdate> _workStreamUpdateService;
        private readonly IEntityUpdateService<MilestoneUpdate> _milestoneUpdateService;
        private readonly IEntityUpdateService<BenefitUpdate> _benefitUpdateService;
        private readonly IEntityUpdateService<DependencyUpdate> _dependencyUpdateService;
        private readonly IEntityService<Project> _projectService;
        private readonly IUserService _userService;
        private readonly EmailSettings _settings;
        private readonly IEmailService _emailService;

        public ReportStagingService(IUnitOfWork unitOfWork, IEntityUpdateService<ProjectUpdate> projectUpdateService,
            IEntityUpdateService<WorkStreamUpdate> workStreamUpdateService, IEntityUpdateService<MilestoneUpdate> milestoneUpdateService,
            IEntityUpdateService<BenefitUpdate> benefitUpdateService, IEntityUpdateService<DependencyUpdate> dependencyUpdateService,
            IEntityService<Project> projectService, IUserService userService, IOptions<EmailSettings> options, 
            IEmailService emailService) : base(unitOfWork, unitOfWork.ReportStagings)
        {
            _projectUpdateService = projectUpdateService;
            _workStreamUpdateService = workStreamUpdateService;
            _milestoneUpdateService = milestoneUpdateService;
            _benefitUpdateService = benefitUpdateService;
            _dependencyUpdateService = dependencyUpdateService;
            _projectService = projectService;
            _userService = userService;
            _settings = options.Value;
            _emailService = emailService;
        }

        protected override void BeforeAdd(ReportStaging entity)
        {
            base.BeforeAdd(entity);

            entity.SubmittedByUserID = _repository.ApiUser.ID;
            entity.SubmittedDate = DateTime.UtcNow;
        }

        protected async override Task AfterAdd(ReportStaging entity)
        {
            var report = JsonSerializer.Deserialize<ProjectReport>(entity.ReportJson);
            var project = _projectService.Find(report.ProjectUpdate.ProjectID).SingleOrDefault();

            if (project != null) {
                await _projectUpdateService.Add(report.ProjectUpdate);
                if (report.WorkStreamUpdates != null) { foreach (var wsu in report.WorkStreamUpdates) { await _workStreamUpdateService.Add(wsu); } }
                if (report.MilestoneUpdates != null) { foreach (var mu in report.MilestoneUpdates) { await _milestoneUpdateService.Add(mu); } }
                if (report.BenefitUpdates != null) { foreach (var bu in report.BenefitUpdates) { await _benefitUpdateService.Add(bu); } }
                if (report.DependencyUpdates != null) { foreach (var du in report.DependencyUpdates) { await _dependencyUpdateService.Add(du); } }

                if (project.SeniorResponsibleOwnerUserID != null)
                {
                    var approver = _userService.Find((int)project.SeniorResponsibleOwnerUserID).SingleOrDefault();
                    var submitter = _userService.Find(entity.SubmittedByUserID).SingleOrDefault();
                    var d = entity.SubmittedDate;
                    var emailVariables = new Dictionary<string, dynamic>() {
                        { "project name", project.Title },
                        { "report period", report.ProjectUpdate.UpdatePeriod.Value.ToString("d MMMM yyyy") },
                        { "submitted by", submitter?.Title  },
                        { "submitted time", $"{d:d MMMM yyyy \\a\\t h:mm}{d.ToString("tt").ToLower()}" }
                    };
                    await _emailService.SendEmail(
                          _settings.GovUkNotifyApiKey,
                          approver.Username,
                          _settings.ProjectReportSubmittedTemplateId,
                          emailVariables
                    );
                }
            }
        }
    }
}
