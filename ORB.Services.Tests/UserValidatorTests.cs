using FluentValidation;
using FluentValidation.TestHelper;
using Moq;
using ORB.Core;
using ORB.Core.Models;
using ORB.Services.Validations;
using System.Linq;
using System.Threading.Tasks;
using Xunit;

namespace ORB.Services.Tests
{
    public class UserValidatorTests
    {
        readonly Mock<IUnitOfWork> _mockUnitOfWork;
        readonly UserValidator _userValidator;

        public UserValidatorTests()
        {
            _mockUnitOfWork = new Mock<IUnitOfWork>();
            _userValidator = new UserValidator(_mockUnitOfWork.Object);
            _mockUnitOfWork.Setup(uow => uow.Users.Entities).Returns(new[] {
                new User { ID = 123, Title = "bob", Username = "bob@beis.gov.uk", EmailAddress = "bob@email.com" },
                new User { ID = 234, Title = "john", Username = "john@beis.gov.uk", EmailAddress = "john@beis.gov.uk" },
                new User { ID = 345, Title = "jane", Username = "jane@beis.gov.uk", EmailAddress = null } }.AsQueryable());
        }

        [Fact]
        public async Task UserValidatorTests_ValidUser_ReturnsNoErrors()
        {
            // Arrange
            var testUser = new User
            {
                ID = 123,
                Title = "bob",
                Username = "bob@beis.gov.uk",
                EmailAddress = "bob@email.com"
            };

            // Act
            var result = await _userValidator.TestValidateAsync(testUser);

            // Assert
            result.ShouldNotHaveAnyValidationErrors();
        }

        [Fact]
        public async Task UserValidatorTests_ValidAppUser_ReturnsNoErrors()
        {
            // Arrange
            var testUser = new User
            {
                ID = 123,
                Title = "client app",
                Username = "00000000-B000-0000-0000-000000000000",
                EmailAddress = "client.app@fake.email"
            };

            // Act
            var result = await _userValidator.TestValidateAsync(testUser);

            // Assert
            result.ShouldNotHaveAnyValidationErrors();
        }

        [Fact]
        public async Task UserValidatorTests_UserWithoutMinimumProperties_ReturnsValidationErrors()
        {
            // Arrange
            var testUser = new User { };

            // Act
            var result = await _userValidator.TestValidateAsync(testUser);

            // Assert
            result.ShouldHaveValidationErrorFor(user => user.Title);
            result.ShouldHaveValidationErrorFor(user => user.Username);
        }

        [Fact]
        public async Task UserValidatorTests_UserWithStringsTooLong_ReturnsValidationErrors()
        {
            // Arrange
            var testUser = new User
            {
                Title = StringTestHelpers.GenerateStringOfLength(300),
                Username = StringTestHelpers.GenerateStringOfLength(300),
                EmailAddress = StringTestHelpers.GenerateStringOfLength(300)
            };

            // Act
            var result = await _userValidator.TestValidateAsync(testUser);

            // Assert
            result.ShouldHaveValidationErrorFor(user => user.Title);
            result.ShouldHaveValidationErrorFor(user => user.Username);
            result.ShouldHaveValidationErrorFor(user => user.EmailAddress);
        }

        [Fact]
        public async Task UserValidatorTests_UserWithInvalidEmail_ReturnsValidationError()
        {
            // Arrange
            var testUser = new User
            {
                EmailAddress = StringTestHelpers.GenerateStringOfLength(300)
            };

            // Act
            var result = await _userValidator.TestValidateAsync(testUser);

            // Assert
            result.ShouldHaveValidationErrorFor(user => user.EmailAddress);
        }

        [Fact]
        public async Task UserValidatorTests_UserWithDuplicateUsername_ReturnsValidationError()
        {
            // Arrange
            var testUser = new User
            {
                Username = "john@beis.gov.uk"
            };

            // Act
            var result = await _userValidator.TestValidateAsync(testUser);

            // Assert
            result.ShouldHaveValidationErrorFor(user => user.Username);
        }

        [Fact]
        public async Task UserValidatorTests_UserWithInvalidEmailUsername_ReturnsValidationError()
        {
            // Arrange
            var testUser = new User
            {
                Username = "@asdfasd@aasdf.com"
            };

            // Act
            var result = await _userValidator.TestValidateAsync(testUser);

            // Assert
            result.ShouldHaveValidationErrorFor(user => user.Username);
        }

        [Fact]
        public async Task UserValidatorTests_UserWithInvalidGuidUsername_ReturnsValidationError()
        {
            // Arrange
            var testUser = new User
            {
                Username = "00000000-Z000-0000-0000-000000000000"
            };

            // Act
            var result = await _userValidator.TestValidateAsync(testUser);

            // Assert
            result.ShouldHaveValidationErrorFor(user => user.Username);
        }
    }
}
