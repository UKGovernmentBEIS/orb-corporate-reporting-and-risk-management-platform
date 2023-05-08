using Microsoft.AspNet.OData;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services.Validations;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class CorporateRiskUpdateService : EntityUpdateService<CorporateRiskUpdate>, IEntityUpdateService<CorporateRiskUpdate>
    {
        private readonly ILogger<CorporateRiskUpdateService> _logger;
        private readonly EmailSettings _settings;
        private readonly IEmailService _emailService;

        public CorporateRiskUpdateService(ILogger<CorporateRiskUpdateService> logger, IOptions<EmailSettings> options, IEmailService emailService, IUnitOfWork unitOfWork)
            : base(unitOfWork, unitOfWork.CorporateRiskUpdates, new RiskUpdateValidator<CorporateRiskUpdate>())
        {
            _logger = logger;
            _settings = options.Value;
            _emailService = emailService;
        }

        protected override void BeforeAdd(CorporateRiskUpdate riskUpdate)
        {
            base.BeforeAdd(riskUpdate);

            riskUpdate.IsCurrent = true;

            var lastApprovals = _repository.Entities.Where(ru => ru.IsCurrent == true && ru.UpdatePeriod == riskUpdate.UpdatePeriod && ru.RiskID == riskUpdate.RiskID);
            foreach (var l in lastApprovals) l.IsCurrent = false;
        }

        protected async override Task AfterAdd(CorporateRiskUpdate entity)
        {
            if (entity.SendNotifications == true)
            {
                if (entity.Escalate == true)
                {
                    await SendEscalationNotifications(entity);
                }

                if (entity.DeEscalate == true)
                {
                    await SendDeEscalationNotifications(entity);
                }

                if (entity.ToBeClosed == true)
                {
                    await SendClosureNotifications(entity);
                }
            }
        }

        private async Task SendEscalationNotifications(CorporateRiskUpdate riskUpdate)
        {
            var apiKey = _settings.GovUkNotifyApiKey;
            if (string.IsNullOrEmpty(apiKey))
            {
                _logger.LogWarning("GOV.UK Notify API key is not configured.");
                return;
            }

            // Load each property individually so lazy-loading or EF references not required in service layer
            var risk = (from r in _unitOfWork.CorporateRisks.Entities
                        where r.ID == riskUpdate.RiskID
                        select new
                        {
                            r.Title,
                            r.RiskCode,
                            r.RiskRegisterID,
                            r.RiskOwnerUser,
                            r.ReportApproverUser,
                            r.Contributors,
                            r.Directorate.Group.RiskChampionDeputyDirectorUser,
                            r.Directorate.Group.BusinessPartnerUser
                        }).SingleOrDefault();
            

            if (risk != null)
            {
                var recipients = new HashSet<string>();
                var templatePersonalisations = new Dictionary<string, dynamic>() {
                    { "risk name", risk.Title },
                    { "risk owner", (risk.RiskOwnerUser != null) ? risk.RiskOwnerUser.Title : string.Empty },
                    { "risk code", risk.RiskCode }
                };

                // RiskOwner
                if (risk.RiskOwnerUser != null)
                {
                    recipients.Add(risk.RiskOwnerUser.Username);
                }

                // Alternate Approver
                if (risk.ReportApproverUser != null)
                {
                    recipients.Add(risk.ReportApproverUser.Username);
                }

                // Contributors
                var contributorUserIds = risk.Contributors.Select(c => c.ContributorUserID);
                var contributorUsers = _unitOfWork.Users.Entities.Where(u => contributorUserIds.Contains(u.ID));
                foreach (var contributor in contributorUsers)
                {
                    recipients.Add(contributor.Username);
                }

                // Escalate to group and Directorate
                if (risk.RiskRegisterID == (int)RiskRegisters.Directorate || risk.RiskRegisterID == (int)RiskRegisters.Group || risk.RiskRegisterID == (int)RiskRegisters.Departmental)
                {
                    // DD risk champion
                    if (risk.RiskChampionDeputyDirectorUser != null) recipients.Add(risk.RiskChampionDeputyDirectorUser.Username);

                    // Portfolio office business partner
                    if (risk.BusinessPartnerUser != null) recipients.Add(risk.BusinessPartnerUser.Username);

                    // Corporate Reporting inbox (corporatereporting@beis.gov.uk)
                    if (!string.IsNullOrEmpty(_settings.CorporateReportingInboxEmail)) recipients.Add(_settings.CorporateReportingInboxEmail);
                }
                foreach (var r in recipients)
                {
                    await _emailService.SendEmail(apiKey, r, _settings.GovUkNotifyEscalationTemplateId, templatePersonalisations);
                }

            }
           
        }

        private async Task SendDeEscalationNotifications(CorporateRiskUpdate riskUpdate)
        {
            var apiKey = _settings.GovUkNotifyApiKey;
            if (string.IsNullOrEmpty(apiKey))
            {
                _logger.LogWarning("GOV.UK Notify API key is not configured.");
                return;
            }

            var risk = (from r in _unitOfWork.CorporateRisks.Entities
                        where r.ID == riskUpdate.RiskID
                        select new
                        {
                            r.Title,
                            r.RiskCode,
                            r.RiskRegisterID,
                            r.RiskOwnerUser,
                            r.ReportApproverUser,
                            r.Contributors,
                            r.Directorate.Group.RiskChampionDeputyDirectorUser,
                            r.Directorate.Group.BusinessPartnerUser
                        }).SingleOrDefault();
            if(risk == null) 
            {
                _logger.LogWarning("SendDeEscalationNotifications - risk is null");
                return;
            }
            var recipients = new HashSet<string>();

            var templatePersonalisations = new Dictionary<string, dynamic>() {
                { "risk name", risk.Title },
                { "risk owner", (risk.RiskOwnerUser != null) ? risk.RiskOwnerUser.Title : string.Empty },
                { "risk code", risk.RiskCode }
            };

            // RiskOwner
            if (risk.RiskOwnerUser != null)
            {
                recipients.Add(risk.RiskOwnerUser.Username);
            }

            // Alternate Approver
            if (risk.ReportApproverUser != null)
            {
                recipients.Add(risk.ReportApproverUser.Username);
            }

            // Contributors
            var contributorUserIds = risk.Contributors.Select(c => c.ContributorUserID);
            var contributorUsers = _unitOfWork.Users.Entities.Where(u => contributorUserIds.Contains(u.ID));
            foreach (var contributor in contributorUsers)
            {
                recipients.Add(contributor.Username);
            }

            // De-escalate to group/ department
            if (risk.RiskRegisterID == (int)RiskRegisters.Departmental || risk.RiskRegisterID == (int)RiskRegisters.Group || risk.RiskRegisterID == (int)RiskRegisters.Departmental)
            {
                // DD risk champion
                if (risk.RiskChampionDeputyDirectorUser != null) recipients.Add(risk.RiskChampionDeputyDirectorUser.Username);

                // Portfolio office business partner
                if (risk.BusinessPartnerUser != null) recipients.Add(risk.BusinessPartnerUser.Username);

                // Corporate Reporting inbox (corporatereporting@beis.gov.uk)
                if (!string.IsNullOrEmpty(_settings.CorporateReportingInboxEmail)) recipients.Add(_settings.CorporateReportingInboxEmail);
            }

            foreach (var r in recipients)
            {
                await _emailService.SendEmail(apiKey, r, _settings.GovUkNotifyDeescalationTemplateId, templatePersonalisations);
            }
        }

        private async Task SendClosureNotifications(CorporateRiskUpdate riskUpdate)
        {
            var apiKey = _settings.GovUkNotifyApiKey;
            if (string.IsNullOrEmpty(apiKey))
            {
                _logger.LogWarning("GOV.UK Notify API key is not configured.");
                return;
            }

            var risk = (from r in _unitOfWork.CorporateRisks.Entities
                        where r.ID == riskUpdate.RiskID
                        select new
                        {
                            r.Title,
                            r.RiskCode,
                            r.RiskRegisterID,
                            r.RiskOwnerUser,
                            r.ReportApproverUser,
                            r.Contributors,
                            r.Directorate.Group.RiskChampionDeputyDirectorUser,
                            r.Directorate.Group.BusinessPartnerUser
                        }).SingleOrDefault();
            if(risk != null)
            {
                var recipients = new HashSet<string>();

                var templatePersonalisations = new Dictionary<string, dynamic>() {
                    { "risk name", risk.Title },
                    { "risk owner", (risk.RiskOwnerUser != null) ? risk.RiskOwnerUser.Title : string.Empty },
                    { "risk code", risk.RiskCode }
                };

                // Prepare recipients list

                // Risk Owner
                if (risk.RiskOwnerUser != null)
                {
                    await _emailService.SendEmail(apiKey, risk.RiskOwnerUser.Username, _settings.GovUkNotifyRiskClosureRiskOwnerTemplateId, templatePersonalisations);
                }

                // Alternate Approver
                if (risk.ReportApproverUser != null)
                {
                    recipients.Add(risk.ReportApproverUser.Username);
                }

                // Contributors
                var contributorUserIds = risk.Contributors.Select(c => c.ContributorUserID);
                var contributorUsers = _unitOfWork.Users.Entities.Where(u => contributorUserIds.Contains(u.ID));
                foreach (var contributor in contributorUsers)
                {
                    recipients.Add(contributor.Username);
                }

                if (risk.RiskRegisterID == (int)RiskRegisters.Departmental || risk.RiskRegisterID == (int)RiskRegisters.Group) // Close departmental or group risk
                {
                    // Closure emails should be sent to the Risk Owner, Alternate Approver, Contributors, Group Risk Champion (for the Risk Group), 
                    // Group Business Partner (for the Risk Group) and Corporate Reporting inbox (corporatereporting@beis.gov.uk)

                    // Group Risk Champion (for the Risk Group)
                    if (risk.RiskChampionDeputyDirectorUser != null)
                    {
                        recipients.Add(risk.RiskChampionDeputyDirectorUser.Username);
                    }

                    // Group Business Partner (for the Risk Group)
                    if (risk.BusinessPartnerUser != null)
                    {
                        recipients.Add(risk.BusinessPartnerUser.Username);
                    }

                    // Corporate Reporting inbox (corporatereporting@beis.gov.uk)
                    if (!string.IsNullOrEmpty(_settings.CorporateReportingInboxEmail))
                    {
                        recipients.Add(_settings.CorporateReportingInboxEmail);
                    }
                }

                foreach (var r in recipients)
                {
                    await _emailService.SendEmail(apiKey, r, _settings.GovUkNotifyRiskClosureStakeholderTemplateId, templatePersonalisations);
                }
            }

        }
    }
}
