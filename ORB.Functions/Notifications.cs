using Microsoft.Extensions.Logging;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using System;
using System.Collections.Generic;

namespace ORB.Functions
{
    public static class Notifications
    {
        public static void SendEmails(ILogger log, IEmailService emailService, EmailSettings emailSettings, IEnumerable<string> recipients, string templateId, Dictionary<string, dynamic> templatePersonalisations)
        {
            foreach (var recipient in recipients)
            {
                if (Guid.TryParse(recipient, out _))
                {
                    log.LogInformation($"Username is not an email address ({recipient})");
                }
                else
                {
                    try
                    {
                        emailService.SendEmail(
                            emailSettings.GovUkNotifyApiKey,
                            recipient,
                            templateId,
                            templatePersonalisations,
                            emailSettings.EmailReplyToId);

                        log.LogInformation($"Sent reminder email (based on template '{templateId}') to '{recipient}'");
                    }
                    catch (Exception ex)
                    {
                        log.LogWarning($"Error sending reminder to '{recipient}'", ex.Source);
                    }
                }
            }
        }
    }
}