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
    public abstract class EntityService<T> : EntityAddService<T, IEntityRepository<T>>, IEntityService<T> where T : ObjectWithId
    {
        protected EntityService(IUnitOfWork unitOfWork, IEntityRepository<T> repository) : base(unitOfWork, repository) { }

        protected EntityService(IUnitOfWork unitOfWork, IEntityRepository<T> repository, AbstractValidator<T> validator) : base(unitOfWork, repository, validator) { }

        protected virtual void BeforePatch(T entity) { }
        protected virtual void AfterPatch(T entity) { }
        protected virtual void BeforeRemove(T entity) { }

        public virtual async Task<T> Edit(int id, Delta<T> patch)
        {
            var entity = await _repository.Edit(id);

            if (entity == null)
            {
                return null;
            }

            BeforePatch(entity);

            patch.Patch(entity);

            if (_validator != null)
            {
                _validator.ValidateAndThrow(entity);
            }

            AfterPatch(entity);

            try
            {
                await _unitOfWork.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!EntityExists(id))
                {
                    return null;
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }

        public async Task<T> Remove(T entity)
        {
            BeforeRemove(entity);
            _repository.Remove(entity);
            await _unitOfWork.SaveChanges();
            return entity;
        }

        protected bool EntityExists(int key)
        {
            return _repository.Entities.Any(e => e.ID == key);
        }
    }
}
