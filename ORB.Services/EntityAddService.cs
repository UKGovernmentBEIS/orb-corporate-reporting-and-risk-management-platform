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
    public abstract class EntityAddService<T, R> : EntityReadService<T, R>, IEntityAddService<T> where T : ObjectWithId where R : IEntityAddRepository<T>
    {
        protected EntityAddService(IUnitOfWork unitOfWork, R repository) : base(unitOfWork, repository) { }

        protected EntityAddService(IUnitOfWork unitOfWork, R repository, AbstractValidator<T> validator) : base(unitOfWork, repository, validator) { }

        protected virtual void BeforeAdd(T entity) { }
        protected virtual Task AfterAdd(T entity) { return Task.CompletedTask; }

        public virtual async Task<T> Add(T entity)
        {
            BeforeAdd(entity);

            if (_validator != null)
            {
                _validator.ValidateAndThrow(entity);
            }

            var addedEntity = _repository.Add(entity);
            if (addedEntity != null)
            {
                await _unitOfWork.SaveChanges();
                await AfterAdd(addedEntity);
                return addedEntity;
            }
            else
            {
                return null;
            }
        }
    }
}
