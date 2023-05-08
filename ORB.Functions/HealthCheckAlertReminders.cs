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
    public class HealthCheckAlertReminders
    {
        protected readonly IEntityService<HealthCheckAlert> _healthCheckAlertService;
        protected readonly IUserService _userService;
        protected readonly IEmailService _emailService;
        protected readonly EmailSettings _emailSettings;
        protected readonly IEntityService<ReportingFrequency> _reportingFrequencyService;
        protected readonly IBenefitService _benefitService;
        protected readonly IReportingEntityService<Directorate> _directorateService;
        protected readonly IMetricService _metricService;
        protected readonly IReportingEntityService<PartnerOrganisation> _partnerOrganisationService;
        protected readonly IProjectService _projectService;

        public HealthCheckAlertReminders(
            IEntityService<HealthCheckAlert> healthCheckAlertService,
            IUserService userService,
            IEmailService emailService,
            IOptions<EmailSettings> emailSettings,
            IEntityService<ReportingFrequency> reportingFrequencyService,
            IBenefitService benefitService,
            IReportingEntityService<Directorate> directorateService,
            IMetricService metricService,
            IReportingEntityService<PartnerOrganisation> partnerOrganisationService,
            IProjectService projectService)
        {
            _healthCheckAlertService = healthCheckAlertService;
            _userService = userService;
            _emailService = emailService;
            _emailSettings = emailSettings.Value;
            _reportingFrequencyService = reportingFrequencyService;
            _benefitService = benefitService;
            _directorateService = directorateService;
            _metricService = metricService;
            _partnerOrganisationService = partnerOrganisationService;
            _projectService = projectService;
        }

        /*
         * Note: no spaces before or after /
            0 * / 5 * * * *	once every five minutes
            0 0 * * * *		once at the top of every hour
            0 0 * / 2 * * *	once every two hours
            0 0 9-17 * * *	once every hour from 9 AM to 5 PM
            0 30 9 * * *	at 9:30 AM every day
            0 30 9 * * 1-5	at 9:30 AM every weekday
            0 30 9 * Jan Mon    at 9:30 AM every Monday in January
        */

        [Function("SendHealthCheckAlertReminders")]
        public void Run([TimerTrigger("0 0 13 * * *")] dynamic myTimer, FunctionContext context)
        {
            var log = context.GetLogger("SendHealthCheckAlertReminders");
            foreach(var entity in _healthCheckAlertService.Entities)
            {
                bool sendEmail = false;
                if(entity.Frequency == "Daily")
                {
                    sendEmail = true;
                }
                else if(entity.Frequency == "Weekly")
                {
                    if(DateTime.Now.DayOfWeek == DayOfWeek.Monday)
                    {
                        sendEmail = true;
                    }
                }
                else if(entity.Frequency == "Monthly")
                {
                    if(DateTime.Now.Day == 1)
                    {
                        sendEmail = true;
                    }
                }

                if(sendEmail)
                {
                    string debugData = "";
                    try
                    {
                        GetBodyText_AuthorReminders(out debugData);
                    }
                    catch (Exception ex) 
                    {                        
                        debugData += ex.Message + "\n" + ex.StackTrace.ToString();                     
                    }                    

                    var templateVars = new Dictionary<string, dynamic>() { { "DebugData", debugData } };
                    var wr = new List<string>();
                    wr.Add(entity.Email);
                    Notifications.SendEmails(log, _emailService, _emailSettings, wr, entity.EmailTemplateID , templateVars);


                }
            }


        }


        private void GetBodyText_AuthorReminders(out string debugData)
        {
            debugData = "";
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
            var biannuallyCycleDue = (biannuallyOffset ?? 0) != 0 ? ReportingCycleService.BiannuallyReportingCycleDue(now.AddDays((int)biannuallyOffset)) : null;
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

            // Fortnightly
            if (fortnightlyCycleDue != null)
            {

                benefitsDue.AddRange(_benefitService.EntitiesWithReportingCycle(fortnightlyCycleDue).ToList());
                directoratesDue.AddRange(_directorateService.EntitiesWithReportingCycle(fortnightlyCycleDue).ToList());
                metricsDue.AddRange(_metricService.EntitiesWithReportingCycle(fortnightlyCycleDue).ToList());
                partnerOrgsDue.AddRange(_partnerOrganisationService.EntitiesWithReportingCycle(fortnightlyCycleDue).ToList());
                projectsDue.AddRange(_projectService.EntitiesWithReportingCycle(fortnightlyCycleDue).ToList());
            }

            // Monthly and monthly weekday
            if (monthlyCycleDue != null || monthlyWeekdayCycleDue != null || monthlyWeekday2CycleDue != null)
            {
                if (monthlyCycleDue != null)
                {
                    benefitsDue.AddRange(_benefitService.EntitiesWithReportingCycle(monthlyCycleDue).ToList());
                    directoratesDue.AddRange(_directorateService.EntitiesWithReportingCycle(monthlyCycleDue).ToList());
                    metricsDue.AddRange(_metricService.EntitiesWithReportingCycle(monthlyCycleDue).ToList());
                    partnerOrgsDue.AddRange(_partnerOrganisationService.EntitiesWithReportingCycle(monthlyCycleDue).ToList());
                    projectsDue.AddRange(_projectService.EntitiesWithReportingCycle(monthlyCycleDue).ToList());

                    
                    debugData += $" Monthly Offset :  {monthlyOffset}    \n";
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

            // Quarterly
            if (quarterlyCycleDue != null)
            {
                benefitsDue.AddRange(_benefitService.EntitiesWithReportingCycle(quarterlyCycleDue).ToList());
                directoratesDue.AddRange(_directorateService.EntitiesWithReportingCycle(quarterlyCycleDue).ToList());
                metricsDue.AddRange(_metricService.EntitiesWithReportingCycle(quarterlyCycleDue).ToList());
                partnerOrgsDue.AddRange(_partnerOrganisationService.EntitiesWithReportingCycle(quarterlyCycleDue).ToList());
                projectsDue.AddRange(_projectService.EntitiesWithReportingCycle(quarterlyCycleDue).ToList());
            }

            // Biannually
            if (biannuallyCycleDue != null)
            {
                benefitsDue.AddRange(_benefitService.EntitiesWithReportingCycle(biannuallyCycleDue).ToList());
                directoratesDue.AddRange(_directorateService.EntitiesWithReportingCycle(biannuallyCycleDue).ToList());
                metricsDue.AddRange(_metricService.EntitiesWithReportingCycle(biannuallyCycleDue).ToList());
                partnerOrgsDue.AddRange(_partnerOrganisationService.EntitiesWithReportingCycle(biannuallyCycleDue).ToList());
                projectsDue.AddRange(_projectService.EntitiesWithReportingCycle(biannuallyCycleDue).ToList());
            }

            // Annually
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

        }

    }
}
