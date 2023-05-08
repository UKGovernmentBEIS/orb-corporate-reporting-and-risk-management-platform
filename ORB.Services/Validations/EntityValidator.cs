using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class EntityValidator<T> : AbstractValidator<T> where T : Entity
    {
        public EntityValidator()
        {
            RuleFor(e => e.Title).NotEmpty().MaximumLength(255);
        }
    }
}
