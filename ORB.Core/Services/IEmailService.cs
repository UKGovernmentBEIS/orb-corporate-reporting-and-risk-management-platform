using System.Collections.Generic;
using System.Threading.Tasks;

namespace ORB.Core.Services
{
    /// <summary>
    /// Interface used when sending emails
    /// </summary>
    public interface IEmailService
    {
        Task SendEmail(string apiKey, string to, string template, Dictionary<string, dynamic> templatePersonalisations, string replyTo = null);
    }
}
