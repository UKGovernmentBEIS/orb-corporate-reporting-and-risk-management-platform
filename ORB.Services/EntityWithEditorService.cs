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
    public abstract class EntityWithEditorService<T> : EntityService<T>, IEntityService<T> where T : EntityWithEditor
    {
        protected EntityWithEditorService(IUnitOfWork unitOfWork, IEntityRepository<T> repository) : base(unitOfWork, repository) { }
        protected EntityWithEditorService(IUnitOfWork unitOfWork, IEntityRepository<T> repository, AbstractValidator<T> validator) : base(unitOfWork, repository, validator) { }

        protected override void BeforeAdd(T entity)
        {
            base.BeforeAdd(entity);

            entity.ModifiedByUserID = _repository.ApiUser.ID;
        }

        protected override void AfterPatch(T entity)
        {
            base.AfterPatch(entity);
            
            entity.ModifiedByUserID = _repository.ApiUser.ID;
        }
    }
}
