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
    public class GroupValidatorTests
    {
        readonly Mock<IUnitOfWork> _mockUnitOfWork;
        readonly GroupValidator _groupValidator;

        public GroupValidatorTests()
        {
            _mockUnitOfWork = new Mock<IUnitOfWork>();
            _groupValidator = new GroupValidator(_mockUnitOfWork.Object);
            _mockUnitOfWork.Setup(uow => uow.Users.Entities).Returns(new[] {
                new User { ID = 123, Title = "bob" },
                new User { ID = 234, Title = "john" },
                new User { ID = 345, Title = "jane" } }.AsQueryable());
        }

        [Fact]
        public async Task GroupValidatorTests_ValidGroup_ReturnsNoErrors()
        {
            // Arrange
            var testGroup = new Group
            {
                Title = "Test group",
                DirectorGeneralUserID = 345,
                RiskChampionDeputyDirectorUserID = 234,
                BusinessPartnerUserID = 123
            };

            // Act
            var result = await _groupValidator.TestValidateAsync(testGroup);

            // Assert
            result.ShouldNotHaveAnyValidationErrors();
        }

        [Fact]
        public async Task GroupValidatorTests_GroupWithoutMinimumProperties_ReturnsErrors()
        {
            // Arrange
            var testGroup = new Group { };

            // Act
            var result = await _groupValidator.TestValidateAsync(testGroup);

            // Assert
            result.ShouldHaveValidationErrorFor(group => group.Title);
        }

        [Fact]
        public async Task GroupValidatorTests_GroupWithLongName_ReturnsValidationError()
        {
            // Arrange
            var testGroup = new Group
            {
                Title = "Test group with very long name, too long for what is allowed in this field"
            };

            // Act
            var result = await _groupValidator.TestValidateAsync(testGroup);

            // Assert
            result.ShouldHaveValidationErrorFor(group => group.Title);
        }

        [Fact]
        public async Task GroupValidatorTests_GroupWithInvalidDG_ReturnsValidationError()
        {
            // Arrange
            var testGroup = new Group
            {
                DirectorGeneralUserID = 1111
            };

            // Act
            var result = await _groupValidator.TestValidateAsync(testGroup);

            // Assert
            result.ShouldHaveValidationErrorFor(group => group.DirectorGeneralUserID);
        }

        [Fact]
        public async Task GroupValidatorTests_GroupWithInvalidRiskChampion_ReturnsValidationError()
        {
            // Arrange
            var testGroup = new Group
            {
                RiskChampionDeputyDirectorUserID = 444
            };

            // Act
            var result = await _groupValidator.TestValidateAsync(testGroup);

            // Assert
            result.ShouldHaveValidationErrorFor(group => group.RiskChampionDeputyDirectorUserID);
        }

        [Fact]
        public async Task GroupValidatorTests_GroupWithInvalidBusinessPartner_ReturnsValidationError()
        {
            // Arrange
            var testGroup = new Group
            {
                BusinessPartnerUserID = 222
            };

            // Act
            var result = await _groupValidator.TestValidateAsync(testGroup);

            // Assert
            result.ShouldHaveValidationErrorFor(group => group.BusinessPartnerUserID);
        }
    }
}
