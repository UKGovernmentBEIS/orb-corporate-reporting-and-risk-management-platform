using Microsoft.Extensions.Logging;
using Notify.Client;
using ORB.Core.Services;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ORB.Services
{
    /// <summary>
    /// IEmailService implementation using the GOV.Notify service
    /// </summary>
    public class GovNotifyEmailService : IEmailService
    {
        private readonly ILogger<GovNotifyEmailService> _logger;

        public GovNotifyEmailService(ILogger<GovNotifyEmailService> logger)
        {
            _logger = logger;
        }

        public async Task SendEmail(string apiKey, string to, string template, Dictionary<string, dynamic> templatePersonalisations, string replyTo = null)
        {
            try
            {
                var client = new NotificationClient(apiKey);
                await client.SendEmailAsync(to, template, templatePersonalisations, null, replyTo);
            }
            catch (Exception ex)
            {
                _logger.LogWarning($"Error sending email to '{to}'. Exception: {ex.Message}");
            }
        }
    }
}