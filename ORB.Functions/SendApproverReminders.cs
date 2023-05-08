using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services;

namespace ORB.Functions
{
    public class SendApproverReminders
    {
        protected readonly IEntityService<ReportingFrequency> _reportingFrequencyService;
        protected readonly IReportingEntityService<Directorate> _directorateService;
        protected readonly IReportingEntityService<PartnerOrganisation> _partnerOrganisationService;
        protected readonly IProjectService _projectService;
        protected readonly IUserService _userService;
        protected readonly IEmailService _emailService;
        protected readonly EmailSettings _emailSettings;

        public SendApproverReminders(
            IEntityService<ReportingFrequency> reportingFrequencyService,
            IReportingEntityService<Directorate> directorateService,
            IReportingEntityService<PartnerOrganisation> partnerOrganisationService,
            IProjectService projectService,
            IUserService userService,
            IEmailService emailService,
            IOptions<EmailSettings> emailSettings)
        {
            _reportingFrequencyService = reportingFrequencyService;
            _directorateService = directorateService;
            _partnerOrganisationService = partnerOrganisationService;
            _projectService = projectService;
            _userService = userService;
            _emailService = emailService;
            _emailSettings = emailSettings.Value;
        }

        [Function("SendApproverReminders")]
        public void Run([TimerTrigger("0 0 9 * * *")] dynamic myTimer, FunctionContext context)
        {
            var log = context.GetLogger("SendApproverReminders");
            var now = DateTime.UtcNow;

            var reminderOffsets = _reportingFrequencyService.Entities.ToList();
            var weeklyOffset = reminderOffsets.SingleOrDefault(rf => rf.ID == (int)ReportingFrequencies.Weekly).RemindApproverDaysBeforeDue;
            var fortnightlyOffset = reminderOffsets.SingleOrDefault(rf => rf.ID == (int)ReportingFrequencies.Fortnightly).RemindApproverDaysBeforeDue;
            var monthlyOffset = reminderOffsets.SingleOrDefault(rf => rf.ID == (int)ReportingFrequencies.Monthly).RemindApproverDaysBeforeDue;
            var monthlyWeekdayOffset = reminderOffsets.SingleOrDefault(rf => rf.ID == (int)ReportingFrequencies.MonthlyWeekday).RemindApproverDaysBeforeDue;
            var quarterlyOffset = reminderOffsets.SingleOrDefault(rf => rf.ID == (int)ReportingFrequencies.Quarterly).RemindApproverDaysBeforeDue;
            var biannuallyOffset = reminderOffsets.SingleOrDefault(rf => rf.ID == (int)ReportingFrequencies.Biannually).RemindApproverDaysBeforeDue;
            var annuallyOffset = reminderOffsets.SingleOrDefault(rf => rf.ID == (int)ReportingFrequencies.Annually).RemindApproverDaysBeforeDue;

            var weeklyCycleDue = (weeklyOffset ?? 0) != 0 ? ReportingCycleService.WeeklyReportingCycleDue(now.AddDays(weeklyOffset.Value)) : null;
            var fortnightlyCycleDue = (fortnightlyOffset ?? 0) != 0 ? ReportingCycleService.FortnightlyReportingCycleDue(now.AddDays(fortnightlyOffset.Value)) : null;
            var monthlyCycleDue = (monthlyOffset ?? 0) != 0 ? ReportingCycleService.MonthlyReportingCycleDue(now.AddDays(monthlyOffset.Value)) : null;
            var monthlyWeekdayCycleDue = (monthlyWeekdayOffset ?? 0) != 0 ? ReportingCycleService.MonthlyWeekdayReportingCycleDue(now.AddDays(monthlyWeekdayOffset.Value)) : null;
            var monthlyWeekday2CycleDue = (monthlyWeekdayOffset ?? 0) != 0 ? ReportingCycleService.MonthlyWeekday2ReportingCycleDue(now.AddDays(monthlyWeekdayOffset.Value)) : null;
            var quarterlyCycleDue = (quarterlyOffset ?? 0) != 0 ? ReportingCycleService.QuarterlyReportingCycleDue(now.AddDays(quarterlyOffset.Value)) : null;
            var biannuallyCycleDue = (biannuallyOffset ?? 0) != 0 ? ReportingCycleService.BiannuallyReportingCycleDue(now.AddDays(biannuallyOffset.Value)) : null;
            var annuallyCycleDue = (annuallyOffset ?? 0) != 0 ? ReportingCycleService.AnnuallyReportingCycleDue(now.AddDays((int)annuallyOffset)) : null;

            // Weekly. Separate frequencies because email template requires frequency variable.
            if (weeklyCycleDue != null)
            {
                var templateVars = new Dictionary<string, dynamic>() { { "frequency", "week" } };
                var wr = new List<string>();
                AddProjectRecipients(wr, weeklyCycleDue);
                AddDirectorateRecipients(wr, weeklyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, wr.Distinct(), _emailSettings.ApproverReminderTemplateId, templateVars);

                var wpor = new List<string>();
                AddPartnerOrgRecipients(wpor, weeklyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, wpor.Distinct(), _emailSettings.PartnerOrgApproverReminderTemplateId, templateVars);
            }

            // Fortnightly
            if (fortnightlyCycleDue != null)
            {
                var templateVars = new Dictionary<string, dynamic>() { { "frequency", "fortnight" } };
                var fr = new List<string>();
                AddProjectRecipients(fr, fortnightlyCycleDue);
                AddDirectorateRecipients(fr, fortnightlyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, fr.Distinct(), _emailSettings.ApproverReminderTemplateId, templateVars);

                var fpor = new List<string>();
                AddPartnerOrgRecipients(fpor, fortnightlyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, fpor.Distinct(), _emailSettings.PartnerOrgApproverReminderTemplateId, templateVars);
            }

            // Monthly and monthly weekday
            if (monthlyCycleDue != null || monthlyWeekdayCycleDue != null || monthlyWeekday2CycleDue != null)
            {
                var templateVars = new Dictionary<string, dynamic>() { { "frequency", "month" } };
                var mr = new List<string>();
                if (monthlyCycleDue != null)
                {
                    AddProjectRecipients(mr, monthlyCycleDue);
                    AddDirectorateRecipients(mr, monthlyCycleDue);
                }

                if (monthlyWeekdayCycleDue != null)
                {
                    AddProjectRecipients(mr, monthlyWeekdayCycleDue);
                    AddDirectorateRecipients(mr, monthlyWeekdayCycleDue);
                }

                if (monthlyWeekday2CycleDue != null)
                {
                    AddProjectRecipients(mr, monthlyWeekday2CycleDue);
                    AddDirectorateRecipients(mr, monthlyWeekday2CycleDue);
                }

                Notifications.SendEmails(log, _emailService, _emailSettings, mr.Distinct(), _emailSettings.ApproverReminderTemplateId, templateVars);

                var mpor = new List<string>();
                if (monthlyCycleDue != null)
                {
                    AddPartnerOrgRecipients(mpor, monthlyCycleDue);
                }
                if (monthlyWeekdayCycleDue != null)
                {
                    AddPartnerOrgRecipients(mpor, monthlyWeekdayCycleDue);
                }
                if (monthlyWeekday2CycleDue != null)
                {
                    AddPartnerOrgRecipients(mpor, monthlyWeekday2CycleDue);
                }

                Notifications.SendEmails(log, _emailService, _emailSettings, mpor.Distinct(), _emailSettings.PartnerOrgApproverReminderTemplateId, templateVars);
            }

            // Quarterly
            if (quarterlyCycleDue != null)
            {
                var templateVars = new Dictionary<string, dynamic>() { { "frequency", "quarter" } };
                var qr = new List<string>();
                AddProjectRecipients(qr, quarterlyCycleDue);
                AddDirectorateRecipients(qr, quarterlyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, qr.Distinct(), _emailSettings.ApproverReminderTemplateId, templateVars);

                var qpor = new List<string>();
                AddPartnerOrgRecipients(qpor, quarterlyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, qpor.Distinct(), _emailSettings.PartnerOrgApproverReminderTemplateId, templateVars);
            }

            // Biannually
            if (biannuallyCycleDue != null)
            {
                var templateVars = new Dictionary<string, dynamic>() { { "frequency", "half-year" } };
                var br = new List<string>();
                AddProjectRecipients(br, biannuallyCycleDue);
                AddDirectorateRecipients(br, biannuallyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, br.Distinct(), _emailSettings.ApproverReminderTemplateId, templateVars);

                var bpor = new List<string>();
                AddPartnerOrgRecipients(bpor, biannuallyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, bpor.Distinct(), _emailSettings.PartnerOrgApproverReminderTemplateId, templateVars);
            }

            // Annually
            if (annuallyCycleDue != null)
            {
                var templateVars = new Dictionary<string, dynamic>() { { "frequency", "year" } };
                var ar = new List<string>();
                AddProjectRecipients(ar, annuallyCycleDue);
                AddDirectorateRecipients(ar, annuallyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, ar.Distinct(), _emailSettings.ApproverReminderTemplateId, templateVars);

                var apor = new List<string>();
                AddPartnerOrgRecipients(apor, annuallyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, apor.Distinct(), _emailSettings.PartnerOrgApproverReminderTemplateId, templateVars);
            }
        }

        private void AddProjectRecipients(List<string> recipients, IReportingCycle reportingCycle)
        {
            var projects = _projectService.EntitiesWithReportingCycle(reportingCycle).ToList();
            projects.ForEach(p => recipients.AddRange(_userService.ApproverUsersInProject(p).Select(u => u.Username)));
        }

        private void AddDirectorateRecipients(List<string> recipients, IReportingCycle reportingCycle)
        {
            var directorates = _directorateService.EntitiesWithReportingCycle(reportingCycle).ToList();
            directorates.ForEach(d => recipients.AddRange(_userService.ApproverUsersInDirectorate(d).Select(u => u.Username)));
        }

        private void AddPartnerOrgRecipients(List<string> recipients, IReportingCycle reportingCycle)
        {
            var partnerOrgs = _partnerOrganisationService.EntitiesWithReportingCycle(reportingCycle).ToList();
            partnerOrgs.ForEach(p => recipients.AddRange(_userService.ApproverUsersInPartnerOrganisation(p).Select(u => u.Username)));
        }
    }
}
