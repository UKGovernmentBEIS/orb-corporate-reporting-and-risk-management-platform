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
    public abstract class EntityWithStatusService<TEntity> : EntityWithEditorService<TEntity>, IEntityService<TEntity> where TEntity : EntityWithStatus
    {
        protected int? _statusBeforeEdit;

        protected EntityWithStatusService(IUnitOfWork unitOfWork, IEntityRepository<TEntity> repository)
            : base(unitOfWork, repository) { }
        protected EntityWithStatusService(IUnitOfWork unitOfWork, IEntityRepository<TEntity> repository, AbstractValidator<TEntity> validator)
            : base(unitOfWork, repository, validator) { }

        protected virtual void BeforeClose(TEntity entity) { }

        protected override void BeforeAdd(TEntity entity)
        {
            base.BeforeAdd(entity);

            entity.EntityStatusID = (int)EntityStatuses.Open;
            entity.EntityStatusDate = DateTime.UtcNow;
            entity.ModifiedByUserID = _repository.ApiUser.ID;
        }

        protected override void BeforePatch(TEntity entity)
        {
            base.BeforePatch(entity);

            _statusBeforeEdit = entity.EntityStatusID;
        }

        protected override void AfterPatch(TEntity entity)
        {
            base.AfterPatch(entity);
            
            if (_statusBeforeEdit != entity.EntityStatusID)
            {
                entity.EntityStatusDate = DateTime.UtcNow;

                if (entity.EntityStatusID == (int)EntityStatuses.Closed)
                {
                    BeforeClose(entity);
                }
            }
        }

        protected void CloseEntityWithStatus(EntityWithStatus entity, DateTime closedDate)
        {
            entity.EntityStatusID = (int)EntityStatuses.Closed;
            entity.EntityStatusDate = closedDate;
        }
    }
}
