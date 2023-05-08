using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Repositories;
using System;
using System.Security.Principal;
using System.Threading.Tasks;

namespace ORB.Data.Repositories
{
    public abstract class Repository<TEntity> : IRepository<TEntity> where TEntity : class
    {
        protected readonly ApiPrincipal _principal;
        protected readonly DbContext _db;
        protected readonly UserSettings _userSettings;

        protected Repository(ApiPrincipal principal, DbContext context, IOptions<UserSettings> userSettings)
        {
            _principal = principal;
            _db = context;
            _userSettings = userSettings.Value;
        }

        public async Task<int> SaveChanges()
        {
            return await _db.SaveChangesAsync();
        }

        protected string Username
        {
            get
            {
                if (_principal != null)
                {
                    return _principal.Username;
                }
                else
                {
                    return null;
                }
            }
        }
    }
}