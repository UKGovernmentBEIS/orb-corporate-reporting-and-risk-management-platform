namespace ORB.Core.Models
{
    public class HealthCheckAlert : Entity
    {
        public string Email { get; set; }
        public string EmailTemplateID { get; set; }
        public string Frequency { get; set; }
    }
}
