using FluentValidation;
using FluentValidation.TestHelper;
using Moq;
using ORB.Core;
using ORB.Core.Models;
using ORB.Services.Validations;
using System;
using System.Linq;
using System.Threading.Tasks;
using Xunit;

namespace ORB.Services.Tests
{
    public class PartnerOrganisationValidatorTests
    {
        readonly Mock<IUnitOfWork> _mockUnitOfWork;
        readonly PartnerOrganisationValidator _partnerOrganisationValidator;

        public PartnerOrganisationValidatorTests()
        {
            _mockUnitOfWork = new Mock<IUnitOfWork>();
            _partnerOrganisationValidator = new PartnerOrganisationValidator(_mockUnitOfWork.Object);
            _mockUnitOfWork.Setup(uow => uow.Directorates.Entities).Returns(new[] {
                new Directorate { ID = 12, Title = "dir 1" },
                new Directorate { ID = 23, Title = "dir 2" },
                new Directorate { ID = 34, Title = "dir 3" } }.AsQueryable());
            _mockUnitOfWork.Setup(uow => uow.Users.Entities).Returns(new[] {
                new User { ID = 123, Title = "bob" },
                new User { ID = 234, Title = "john" },
                new User { ID = 345, Title = "jane" } }.AsQueryable());
        }

        [Fact]
        public async Task PartnerOrganisationValidatorTests_ValidPartnerOrganisation_ReturnsNoErrors()
        {
            // Arrange
            var testPartnerOrganisation = new PartnerOrganisation
            {
                Title = "Test partner organisation",
                DirectorateID = 23,
                ReportingFrequency = (byte)ReportingFrequencies.Monthly,
                ReportingDueDay = (byte)ReportingDueDays.LastDay,
                LeadPolicySponsorUserID = 234,
                ReportAuthorUserID = 123,
                Objectives = "Some objectives for the partner organisation",
                Description = "A description of the partner organisation"
            };

            // Act
            var result = await _partnerOrganisationValidator.TestValidateAsync(testPartnerOrganisation);

            // Assert
            result.ShouldNotHaveAnyValidationErrors();
        }

        [Fact]
        public async Task PartnerOrganisationValidatorTests_PartnerOrganisationWithoutMinimumProperties_ReturnsValidationErrors()
        {
            // Arrange
            var testPartnerOrganisation = new PartnerOrganisation { };

            // Act
            var result = await _partnerOrganisationValidator.TestValidateAsync(testPartnerOrganisation);

            // Assert
            result.ShouldHaveValidationErrorFor(partnerOrganisation => partnerOrganisation.Title);
            result.ShouldHaveValidationErrorFor(partnerOrganisation => partnerOrganisation.ReportingFrequency);
            result.ShouldHaveValidationErrorFor(partnerOrganisation => partnerOrganisation.ReportingDueDay);
        }

        [Fact]
        public async Task PartnerOrganisationValidatorTests_PartnerOrganisationWithLongName_ReturnsValidationError()
        {
            // Arrange
            var testPartnerOrganisation = new PartnerOrganisation
            {
                Title = @"Test partner organisation with very long name, too long for what is allowed in this field. Lorem ipsum dolor sit amet, 
                    consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                    quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in 
                    voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui 
                    officia deserunt mollit anim id est laborum."
            };

            // Act
            var result = await _partnerOrganisationValidator.TestValidateAsync(testPartnerOrganisation);

            // Assert
            result.ShouldHaveValidationErrorFor(partnerOrganisation => partnerOrganisation.Title);
        }

        [Fact]
        public async Task PartnerOrganisationValidatorTests_PartnerOrganisationWithInvalidDirectorate_ReturnsValidationError()
        {
            // Arrange
            var testPartnerOrganisation = new PartnerOrganisation
            {
                DirectorateID = 234
            };

            // Act
            var result = await _partnerOrganisationValidator.TestValidateAsync(testPartnerOrganisation);

            // Assert
            result.ShouldHaveValidationErrorFor(partnerOrganisation => partnerOrganisation.DirectorateID);
        }

        [Fact]
        public async Task PartnerOrganisationValidatorTests_PartnerOrganisationWithInvalidLeadPolicySponsor_ReturnsValidationError()
        {
            // Arrange
            var testPartnerOrganisation = new PartnerOrganisation
            {
                LeadPolicySponsorUserID = 6298
            };

            // Act
            var result = await _partnerOrganisationValidator.TestValidateAsync(testPartnerOrganisation);

            // Assert
            result.ShouldHaveValidationErrorFor(partnerOrganisation => partnerOrganisation.LeadPolicySponsorUserID);
        }

        [Fact]
        public async Task PartnerOrganisationValidatorTests_PartnerOrganisationWithInvalidReportAuthor_ReturnsValidationError()
        {
            // Arrange
            var testPartnerOrganisation = new PartnerOrganisation
            {
                ReportAuthorUserID = 5555
            };

            // Act
            var result = await _partnerOrganisationValidator.TestValidateAsync(testPartnerOrganisation);

            // Assert
            result.ShouldHaveValidationErrorFor(partnerOrganisation => partnerOrganisation.ReportAuthorUserID);
        }

        [Fact]
        public async Task PartnerOrganisationValidatorTests_PartnerOrganisationWithInvalidObjectives_ReturnsValidationError()
        {
            // Arrange
            var testPartnerOrganisation = new PartnerOrganisation
            {
                Objectives = StringTestHelpers.GenerateStringOfLength(10222)
            };

            // Act
            var result = await _partnerOrganisationValidator.TestValidateAsync(testPartnerOrganisation);

            // Assert
            result.ShouldHaveValidationErrorFor(partnerOrganisation => partnerOrganisation.Objectives);
        }

        [Fact]
        public async Task PartnerOrganisationValidatorTests_PartnerOrganisationWithInvalidDescription_ReturnsValidationError()
        {
            // Arrange
            var testPartnerOrganisation = new PartnerOrganisation
            {
                Description = StringTestHelpers.GenerateStringOfLength(590)
            };

            // Act
            var result = await _partnerOrganisationValidator.TestValidateAsync(testPartnerOrganisation);

            // Assert
            result.ShouldHaveValidationErrorFor(partnerOrganisation => partnerOrganisation.Description);
        }
    }
}
