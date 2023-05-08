using FluentValidation;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Linq;

namespace ORB.Services.Validations
{
    public class UserValidator : AbstractValidator<User>
    {
        private readonly IUnitOfWork _unitOfWork;

        public UserValidator(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
            var emailChecker = new System.ComponentModel.DataAnnotations.EmailAddressAttribute();

            RuleFor(u => u.Username).NotEmpty().MaximumLength(255)
                .Must(username => username != null && (emailChecker.IsValid(username) || Guid.TryParse(username, out _)))
                .WithMessage("Username must be in a valid user@domain.gov.uk or GUID (00000000-0000-0000-0000-000000000000) format")
                .Must((user, username) => username != null && !_unitOfWork.Users.Entities.Any(u => u.Username.ToLower() == username.ToLower() && u.ID != user.ID))
                .WithMessage("Username already in use");
            RuleFor(u => u.Title).NotEmpty().MaximumLength(255);
            RuleFor(u => u.EmailAddress).MaximumLength(255)
                .Must((user, emailAddress) => user.IsServiceAccount == true || (emailAddress != null && emailChecker.IsValid(emailAddress)))
                .WithMessage("EmailAddress must be a valid email address")
                .Must((user, emailAddress) => user.IsServiceAccount == true || (emailAddress != null && !_unitOfWork.Users.Entities.Any(u => u.EmailAddress != null && u.EmailAddress.ToLower() == emailAddress.ToLower() && u.ID != user.ID)))
                .WithMessage("EmailAddress already in use");
        }
    }
}
