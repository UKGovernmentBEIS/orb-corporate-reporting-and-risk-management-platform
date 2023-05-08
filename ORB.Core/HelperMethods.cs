namespace ORB.Core
{
    public static class HelperMethods
    {
        public static string HackUsername(string username, UserSettings userSettings)
        {
            if (!string.IsNullOrWhiteSpace(username))
            {
                if (!string.IsNullOrWhiteSpace(userSettings.DomainFixFind) && userSettings.DomainFixReplace != null)
                {
                    username = username.Replace(userSettings.DomainFixFind, userSettings.DomainFixReplace);
                }

                if (!string.IsNullOrWhiteSpace(userSettings.MSAccountFixFind) && userSettings.MSAccountFixReplace != null)
                {
                    username = username.Replace(userSettings.MSAccountFixFind, userSettings.MSAccountFixReplace);
                }
            }
            
            return username;
        }
    }
}