using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services;

namespace ORB.Functions
{
    public class SendAuthorReminders
    {
        protected readonly IEntityService<ReportingFrequency> _reportingFrequencyService;
        protected readonly IBenefitService _benefitService;
        protected readonly IReportingEntityService<Directorate> _directorateService;
        protected readonly IMetricService _metricService;
        protected readonly IReportingEntityService<PartnerOrganisation> _partnerOrganisationService;
        protected readonly IProjectService _projectService;
        protected readonly IUserService _userService;
        protected readonly IEmailService _emailService;
        protected readonly EmailSettings _emailSettings;

        public SendAuthorReminders(
            IEntityService<ReportingFrequency> reportingFrequencyService,
            IBenefitService benefitService,
            IReportingEntityService<Directorate> directorateService,
            IMetricService metricService,
            IReportingEntityService<PartnerOrganisation> partnerOrganisationService,
            IProjectService projectService,
            IUserService userService,
            IEmailService emailService,
            IOptions<EmailSettings> emailSettings)
        {
            _reportingFrequencyService = reportingFrequencyService;
            _benefitService = benefitService;
            _directorateService = directorateService;
            _metricService = metricService;
            _partnerOrganisationService = partnerOrganisationService;
            _projectService = projectService;
            _userService = userService;
            _emailService = emailService;
            _emailSettings = emailSettings.Value;
        }

        [Function("SendAuthorReminders")]
        public void Run([TimerTrigger("0 30 13 * * *")] dynamic myTimer, FunctionContext context)
        {
            var log = context.GetLogger("SendAuthorReminders");
            var now = DateTime.UtcNow;

            var reminderOffsets = _reportingFrequencyService.Entities.ToList();
            var weeklyOffset = reminderOffsets.SingleOrDefault(rf => rf.ID == (int)ReportingFrequencies.Weekly).RemindAuthorsDaysBeforeDue;
            var fortnightlyOffset = reminderOffsets.SingleOrDefault(rf => rf.ID == (int)ReportingFrequencies.Fortnightly).RemindAuthorsDaysBeforeDue;
            var monthlyOffset = reminderOffsets.SingleOrDefault(rf => rf.ID == (int)ReportingFrequencies.Monthly).RemindAuthorsDaysBeforeDue;
            var monthlyWeekdayOffset = reminderOffsets.SingleOrDefault(rf => rf.ID == (int)ReportingFrequencies.MonthlyWeekday).RemindAuthorsDaysBeforeDue;
            var quarterlyOffset = reminderOffsets.SingleOrDefault(rf => rf.ID == (int)ReportingFrequencies.Quarterly).RemindAuthorsDaysBeforeDue;
            var biannuallyOffset = reminderOffsets.SingleOrDefault(rf => rf.ID == (int)ReportingFrequencies.Biannually).RemindAuthorsDaysBeforeDue;
            var annuallyOffset = reminderOffsets.SingleOrDefault(rf => rf.ID == (int)ReportingFrequencies.Annually).RemindAuthorsDaysBeforeDue;

            var weeklyCycleDue = (weeklyOffset ?? 0) != 0 ? ReportingCycleService.WeeklyReportingCycleDue(now.AddDays(weeklyOffset.Value)) : null;
            var fortnightlyCycleDue = (fortnightlyOffset ?? 0) != 0 ? ReportingCycleService.FortnightlyReportingCycleDue(now.AddDays(fortnightlyOffset.Value)) : null;
            var monthlyCycleDue = (monthlyOffset ?? 0) != 0 ? ReportingCycleService.MonthlyReportingCycleDue(now.AddDays(monthlyOffset.Value)) : null;
            var monthlyWeekdayCycleDue = (monthlyWeekdayOffset ?? 0) != 0 ? ReportingCycleService.MonthlyWeekdayReportingCycleDue(now.AddDays(monthlyWeekdayOffset.Value)) : null;
            var monthlyWeekday2CycleDue = (monthlyWeekdayOffset ?? 0) != 0 ? ReportingCycleService.MonthlyWeekday2ReportingCycleDue(now.AddDays(monthlyWeekdayOffset.Value)) : null;
            var quarterlyCycleDue = (quarterlyOffset ?? 0) != 0 ? ReportingCycleService.QuarterlyReportingCycleDue(now.AddDays(quarterlyOffset.Value)) : null;
            var biannuallyCycleDue = (biannuallyOffset ?? 0) != 0 ? ReportingCycleService.BiannuallyReportingCycleDue(now.AddDays(biannuallyOffset.Value)) : null;
            var annuallyCycleDue = (annuallyOffset ?? 0) != 0 ? ReportingCycleService.AnnuallyReportingCycleDue(now.AddDays((int)annuallyOffset)) : null;

            List<Benefit> benefitsDue = new List<Benefit>();
            List<Directorate> directoratesDue = new List<Directorate>();
            List<Metric> metricsDue = new List<Metric>();
            List<PartnerOrganisation> partnerOrgsDue = new List<PartnerOrganisation>();
            List<Project> projectsDue = new List<Project>();

            // Weekly. Separate frequencies because email template requires frequency variable.
            if (weeklyCycleDue != null)
            {
                benefitsDue.AddRange(_benefitService.EntitiesWithReportingCycle(weeklyCycleDue).ToList());
                directoratesDue.AddRange(_directorateService.EntitiesWithReportingCycle(weeklyCycleDue).ToList());
                metricsDue.AddRange(_metricService.EntitiesWithReportingCycle(weeklyCycleDue).ToList());
                partnerOrgsDue.AddRange(_partnerOrganisationService.EntitiesWithReportingCycle(weeklyCycleDue).ToList());
                projectsDue.AddRange(_projectService.EntitiesWithReportingCycle(weeklyCycleDue).ToList());
            }


            if (fortnightlyCycleDue != null)
            {

                benefitsDue.AddRange(_benefitService.EntitiesWithReportingCycle(fortnightlyCycleDue).ToList());
                directoratesDue.AddRange(_directorateService.EntitiesWithReportingCycle(fortnightlyCycleDue).ToList());
                metricsDue.AddRange(_metricService.EntitiesWithReportingCycle(fortnightlyCycleDue).ToList());
                partnerOrgsDue.AddRange(_partnerOrganisationService.EntitiesWithReportingCycle(fortnightlyCycleDue).ToList());
                projectsDue.AddRange(_projectService.EntitiesWithReportingCycle(fortnightlyCycleDue).ToList());
            }

            if (monthlyCycleDue != null || monthlyWeekdayCycleDue != null || monthlyWeekday2CycleDue != null)
            {
                if (monthlyCycleDue != null)
                {
                    benefitsDue.AddRange(_benefitService.EntitiesWithReportingCycle(monthlyCycleDue).ToList());
                    directoratesDue.AddRange(_directorateService.EntitiesWithReportingCycle(monthlyCycleDue).ToList());
                    metricsDue.AddRange(_metricService.EntitiesWithReportingCycle(monthlyCycleDue).ToList());
                    partnerOrgsDue.AddRange(_partnerOrganisationService.EntitiesWithReportingCycle(monthlyCycleDue).ToList());
                    projectsDue.AddRange(_projectService.EntitiesWithReportingCycle(monthlyCycleDue).ToList());
                }

                if (monthlyWeekdayCycleDue != null)
                {
                    benefitsDue.AddRange(_benefitService.EntitiesWithReportingCycle(monthlyWeekdayCycleDue).ToList());
                    directoratesDue.AddRange(_directorateService.EntitiesWithReportingCycle(monthlyWeekdayCycleDue).ToList());
                    metricsDue.AddRange(_metricService.EntitiesWithReportingCycle(monthlyWeekdayCycleDue).ToList());
                    partnerOrgsDue.AddRange(_partnerOrganisationService.EntitiesWithReportingCycle(monthlyWeekdayCycleDue).ToList());
                    projectsDue.AddRange(_projectService.EntitiesWithReportingCycle(monthlyWeekdayCycleDue).ToList());
                }

                if (monthlyWeekday2CycleDue != null)
                {
                    benefitsDue.AddRange(_benefitService.EntitiesWithReportingCycle(monthlyWeekday2CycleDue).ToList());
                    directoratesDue.AddRange(_directorateService.EntitiesWithReportingCycle(monthlyWeekday2CycleDue).ToList());
                    metricsDue.AddRange(_metricService.EntitiesWithReportingCycle(monthlyWeekday2CycleDue).ToList());
                    partnerOrgsDue.AddRange(_partnerOrganisationService.EntitiesWithReportingCycle(monthlyWeekday2CycleDue).ToList());
                    projectsDue.AddRange(_projectService.EntitiesWithReportingCycle(monthlyWeekday2CycleDue).ToList());
                }
            }

            if (quarterlyCycleDue != null)
            {
                benefitsDue.AddRange(_benefitService.EntitiesWithReportingCycle(quarterlyCycleDue).ToList());
                directoratesDue.AddRange(_directorateService.EntitiesWithReportingCycle(quarterlyCycleDue).ToList());
                metricsDue.AddRange(_metricService.EntitiesWithReportingCycle(quarterlyCycleDue).ToList());
                partnerOrgsDue.AddRange(_partnerOrganisationService.EntitiesWithReportingCycle(quarterlyCycleDue).ToList());
                projectsDue.AddRange(_projectService.EntitiesWithReportingCycle(quarterlyCycleDue).ToList());
            }

            if (biannuallyCycleDue != null)
            {
                benefitsDue.AddRange(_benefitService.EntitiesWithReportingCycle(biannuallyCycleDue).ToList());
                directoratesDue.AddRange(_directorateService.EntitiesWithReportingCycle(biannuallyCycleDue).ToList());
                metricsDue.AddRange(_metricService.EntitiesWithReportingCycle(biannuallyCycleDue).ToList());
                partnerOrgsDue.AddRange(_partnerOrganisationService.EntitiesWithReportingCycle(biannuallyCycleDue).ToList());
                projectsDue.AddRange(_projectService.EntitiesWithReportingCycle(biannuallyCycleDue).ToList());
            }

            if (annuallyCycleDue != null)
            {
                benefitsDue.AddRange(_benefitService.EntitiesWithReportingCycle(annuallyCycleDue).ToList());
                directoratesDue.AddRange(_directorateService.EntitiesWithReportingCycle(annuallyCycleDue).ToList());
                metricsDue.AddRange(_metricService.EntitiesWithReportingCycle(annuallyCycleDue).ToList());
                partnerOrgsDue.AddRange(_partnerOrganisationService.EntitiesWithReportingCycle(annuallyCycleDue).ToList());
                projectsDue.AddRange(_projectService.EntitiesWithReportingCycle(annuallyCycleDue).ToList());
            }

            var benefitRecipients = new Dictionary<Benefit, List<User>>();
            var directorateRecipients = new Dictionary<Directorate, List<User>>();
            var metricRecipients = new Dictionary<Metric, List<User>>();
            var partnerOrgRecipients = new Dictionary<PartnerOrganisation, List<User>>();
            var projectRecipients = new Dictionary<Project, List<User>>();

            benefitsDue.Distinct().ToList().ForEach(b => benefitRecipients.Add(b, _userService.AuthorUsersInBenefit(b).ToList()));
            directoratesDue.Distinct().ToList().ForEach(d => directorateRecipients.Add(d, _userService.AuthorUsersInDirectorate(d).ToList()));
            metricsDue.Distinct().ToList().ForEach(m => metricRecipients.Add(m, _userService.AuthorUsersInMetric(m).ToList()));
            partnerOrgsDue.Distinct().ToList().ForEach(p => partnerOrgRecipients.Add(p, _userService.AuthorUsersInPartnerOrganisation(p).ToList()));
            projectsDue.Distinct().ToList().ForEach(p => projectRecipients.Add(p, _userService.AuthorUsersInProject(p).ToList()));

            foreach (var recipient in benefitRecipients.SelectMany(br => br.Value)
                .Concat(directorateRecipients.SelectMany(dr => dr.Value))
                .Concat(metricRecipients.SelectMany(mr => mr.Value))
                .Concat(partnerOrgRecipients.SelectMany(por => por.Value))
                .Concat(projectRecipients.SelectMany(pr => pr.Value)).Distinct()
                )
            {
                var recipientsBenefits = benefitRecipients.Where(br => br.Value.Contains(recipient)).Select(br => new { Due = ReportingCycleService.NextReportDue(br.Key, now), Report = $"{br.Key.Title} (benefit)" });
                var recipientsDirectorates = directorateRecipients.Where(dr => dr.Value.Contains(recipient)).Select(dr => new { Due = ReportingCycleService.NextReportDue(dr.Key, now), Report = $"{dr.Key.Title} (directorate)" });
                var recipientsMetrics = metricRecipients.Where(mr => mr.Value.Contains(recipient)).Select(mr => new { Due = ReportingCycleService.NextReportDue(mr.Key, now), Report = $"{mr.Key.Title} (metric)" });
                var recipientsPartnerOrgs = partnerOrgRecipients.Where(por => por.Value.Contains(recipient)).Select(por => new { Due = ReportingCycleService.NextReportDue(por.Key, now), Report = $"{por.Key.Title} (partner organisation)" });
                var recipientsProjects = projectRecipients.Where(pr => pr.Value.Contains(recipient)).Select(pr => new { Due = ReportingCycleService.NextReportDue(pr.Key, now), Report = $"{pr.Key.Title} (project)" });

                var uniqueDue = recipientsBenefits.Select(b => b.Due)
                    .Concat(recipientsDirectorates.Select(d => d.Due))
                    .Concat(recipientsMetrics.Select(m => m.Due))
                    .Concat(recipientsPartnerOrgs.Select(po => po.Due))
                    .Concat(recipientsProjects.Select(p => p.Due)).Distinct().OrderBy(d => d);

                StringBuilder reportsList = new StringBuilder();
                foreach (var due in uniqueDue)
                {
                    var reports = String.Join("\n * ", recipientsBenefits.Where(b => b.Due == due).Select(b => b.Report)
                        .Concat(recipientsDirectorates.Where(d => d.Due == due).Select(d => d.Report))
                        .Concat(recipientsMetrics.Where(m => m.Due == due).Select(m => m.Report))
                        .Concat(recipientsPartnerOrgs.Where(po => po.Due == due).Select(po => po.Report))
                        .Concat(recipientsProjects.Where(p => p.Due == due).Select(p => p.Report)));
                    reportsList.Append($"The following reports are due in {(due.Date - now.Date).TotalDays} days on {due.ToString("d", new CultureInfo("en-GB"))}: \n * {reports}\n\n");
                }

                Notifications.SendEmails(
                    log,
                    _emailService,
                    _emailSettings,
                    new string[] { recipient.Username },
                    _emailSettings.AuthorReminderTemplateId,
                    new Dictionary<string, dynamic>() { { "ReportsList", reportsList.ToString() } }
                );
            }
        }
    }
}
