namespace ORB.Core
{
    public class EmailSettings
    {
        public string GovUkNotifyApiKey { get; set; }
        public string AuthorReminderTemplateId { get; set; }
        public string ApproverReminderTemplateId { get; set; }
        public string PartnerOrgApproverReminderTemplateId { get; set; }
        public string GovUkNotifyEscalationTemplateId { get; set; }
        public string GovUkNotifyDeescalationTemplateId { get; set; }
        public string GovUkNotifyRiskClosureRiskOwnerTemplateId { get; set; }
        public string GovUkNotifyRiskClosureStakeholderTemplateId { get; set; }
        public string EmailReplyToId { get; set; }
        public string CorporateReportingInboxEmail { get; set; }
        public string ProjectReportSubmittedTemplateId { get; set; }
        public string FinancialRiskAuthorReminderTemplateId { get; set; }
        public string FinancialRiskApproverReminderTemplateId { get; set; }
    }
}