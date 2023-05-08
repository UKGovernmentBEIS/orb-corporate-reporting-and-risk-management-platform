namespace ORB.Core
{
    public class UserSettings
    {
        /// <summary>
        /// Semi-colon separated list of client service identities that should have admin permissions to database
        /// </summary>
        public string ClientServiceIdentities { get; set; }
        public string DomainFixFind { get; set; }
        public string DomainFixReplace { get; set; }
        public string MSAccountFixFind { get; set; }
        public string MSAccountFixReplace { get; set; }
    }
}
