using FluentValidation;
using Microsoft.AspNet.OData;
using Microsoft.EntityFrameworkCore;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using ORB.Core.Services;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public abstract class EntityUpdateService<T> : EntityAddService<T, IEntityUpdateRepository<T>>, IEntityUpdateService<T> where T : EntityUpdate
    {
        protected EntityUpdateService(IUnitOfWork unitOfWork, IEntityUpdateRepository<T> repository) : base(unitOfWork, repository) { }

        protected EntityUpdateService(IUnitOfWork unitOfWork, IEntityUpdateRepository<T> repository, AbstractValidator<T> validator) : base(unitOfWork, repository, validator) { }

        protected override void BeforeAdd(T entity)
        {
            base.BeforeAdd(entity);
            entity.UpdateDate = DateTime.UtcNow;
            entity.UpdateUserID = _repository.ApiUser.ID;
            entity.SignOffID = null;
        }
    }
}
