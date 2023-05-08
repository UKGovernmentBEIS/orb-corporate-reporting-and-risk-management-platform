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
    public abstract class EntityReadService<T, R> : IEntityReadService<T> where T : ObjectWithId where R : IOrbRepository<T>
    {
        protected readonly IUnitOfWork _unitOfWork;
        protected readonly R _repository;
        protected readonly AbstractValidator<T> _validator;

        protected EntityReadService(IUnitOfWork unitOfWork, R repository)
        {
            _unitOfWork = unitOfWork;
            _repository = repository;
        }

        protected EntityReadService(IUnitOfWork unitOfWork, R repository, AbstractValidator<T> validator)
        {
            _unitOfWork = unitOfWork;
            _repository = repository;
            _validator = validator;
        }

        public IQueryable<T> Entities
        {
            get
            {
                return _repository.Entities;
            }
        }

        public IQueryable<T> Find(int id)
        {
            return _repository.Entities.Where(e => e.ID == id);
        }
    }
}
