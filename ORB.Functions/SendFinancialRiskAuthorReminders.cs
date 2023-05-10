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
    public class SendFinancialRiskAuthorReminders
    {
        protected readonly IEntityService<ReportingFrequency> _reportingFrequencyService;
        protected readonly IReportingEntityService<FinancialRisk> _financialRiskService;
        protected readonly IUserService _userService;
        protected readonly IEmailService _emailService;
        protected readonly EmailSettings _emailSettings;

        public SendFinancialRiskAuthorReminders(
            IEntityService<ReportingFrequency> reportingFrequencyService,
            IReportingEntityService<FinancialRisk> financialRiskService,
            IUserService userService,
            IEmailService emailService,
            IOptions<EmailSettings> emailSettings)
        {
            _reportingFrequencyService = reportingFrequencyService;
            _financialRiskService = financialRiskService;
            _userService = userService;
            _emailService = emailService;
            _emailSettings = emailSettings.Value;
        }

        [Function("SendFinancialRiskAuthorReminders")]
        public void Run([TimerTrigger("0 30 10 * * *")] dynamic myTimer, FunctionContext context)
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

            // Weekly. Separate frequencies because email template requires frequency variable.
            if (weeklyCycleDue != null)
            {
                var templateVars = new Dictionary<string, dynamic>() { { "frequency", "week" } };
                var wr = new List<string>();
                AddFinancialRiskRecipients(wr, weeklyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, wr.Distinct(), _emailSettings.FinancialRiskAuthorReminderTemplateId, templateVars);
            }

            if (fortnightlyCycleDue != null)
            {
                var templateVars = new Dictionary<string, dynamic>() { { "frequency", "fortnight" } };
                var fr = new List<string>();
                AddFinancialRiskRecipients(fr, fortnightlyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, fr.Distinct(), _emailSettings.FinancialRiskAuthorReminderTemplateId, templateVars);
            }

            if (monthlyCycleDue != null || monthlyWeekdayCycleDue != null || monthlyWeekday2CycleDue != null)
            {
                var templateVars = new Dictionary<string, dynamic>() { { "frequency", "month" } };
                var mr = new List<string>();
                if (monthlyCycleDue != null)
                {
                    AddFinancialRiskRecipients(mr, monthlyCycleDue);
                }

                if (monthlyWeekdayCycleDue != null)
                {
                    AddFinancialRiskRecipients(mr, monthlyWeekdayCycleDue);
                }

                if (monthlyWeekday2CycleDue != null)
                {
                    AddFinancialRiskRecipients(mr, monthlyWeekday2CycleDue);
                }

                Notifications.SendEmails(log, _emailService, _emailSettings, mr.Distinct(), _emailSettings.FinancialRiskAuthorReminderTemplateId, templateVars);
            }

            if (quarterlyCycleDue != null)
            {
                var templateVars = new Dictionary<string, dynamic>() { { "frequency", "quarter" } };
                var qr = new List<string>();
                AddFinancialRiskRecipients(qr, quarterlyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, qr.Distinct(), _emailSettings.FinancialRiskAuthorReminderTemplateId, templateVars);
            }

            if (biannuallyCycleDue != null)
            {
                var templateVars = new Dictionary<string, dynamic>() { { "frequency", "half-year" } };
                var br = new List<string>();
                AddFinancialRiskRecipients(br, biannuallyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, br.Distinct(), _emailSettings.FinancialRiskAuthorReminderTemplateId, templateVars);
            }

            if (annuallyCycleDue != null)
            {
                var templateVars = new Dictionary<string, dynamic>() { { "frequency", "year" } };
                var ar = new List<string>();
                AddFinancialRiskRecipients(ar, annuallyCycleDue);
                Notifications.SendEmails(log, _emailService, _emailSettings, ar.Distinct(), _emailSettings.FinancialRiskAuthorReminderTemplateId, templateVars);
            }
        }

        private void AddFinancialRiskRecipients(List<string> recipients, IReportingCycle reportingCycle)
        {
            var risks = _financialRiskService.EntitiesWithReportingCycle(reportingCycle).ToList();
            risks.ForEach(r => recipients.AddRange(_userService.AuthorUsersInFinancialRisk(r).Select(u => u.Username)));
        }
    }
}
