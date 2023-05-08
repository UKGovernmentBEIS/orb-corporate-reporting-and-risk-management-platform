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
    public class DirectorateValidatorTests
    {
        readonly Mock<IUnitOfWork> _mockUnitOfWork;
        readonly DirectorateValidator _directorateValidator;

        public DirectorateValidatorTests()
        {
            _mockUnitOfWork = new Mock<IUnitOfWork>();
            _directorateValidator = new DirectorateValidator(_mockUnitOfWork.Object);
            _mockUnitOfWork.Setup(uow => uow.Users.Entities).Returns(new[] {
                new User { ID = 123, Title = "bob" },
                new User { ID = 234, Title = "john" },
                new User { ID = 345, Title = "jane" } }.AsQueryable());
            _mockUnitOfWork.Setup(uow => uow.Groups.Entities).Returns(new[] {
                new Group { ID = 3, Title = "group 1" },
                new Group { ID = 7, Title = "group 2" },
                new Group { ID = 15, Title = "group 3" } }.AsQueryable());
        }

        [Fact]
        public async Task DirectorateValidatorTests_ValidDirectorate_ReturnsNoErrors()
        {
            // Arrange
            var testDirectorate = new Directorate
            {
                Title = "Test directorate",
                GroupID = 7,
                ReportingFrequency = (byte)ReportingFrequencies.Quarterly,
                ReportingDueDay = (byte)ReportingDueDays.D25,
                ReportingStartDate = new DateTime(2021, 6, 1)
            };

            // Act
            var result = await _directorateValidator.TestValidateAsync(testDirectorate);

            // Assert
            result.ShouldNotHaveAnyValidationErrors();
        }

        [Fact]
        public async Task DirectorateValidatorTests_DirectorateWithoutMinimumProperties_ReturnsValidationErrors()
        {
            // Arrange
            var testDirectorate = new Directorate { };

            // Act
            var result = await _directorateValidator.TestValidateAsync(testDirectorate);

            // Assert
            result.ShouldHaveValidationErrorFor(directorate => directorate.Title);
            result.ShouldHaveValidationErrorFor(directorate => directorate.GroupID);
            result.ShouldHaveValidationErrorFor(directorate => directorate.ReportingFrequency);
            result.ShouldHaveValidationErrorFor(directorate => directorate.ReportingDueDay);
        }

        [Fact]
        public async Task DirectorateValidatorTests_DirectorateWithBlankName_ReturnsValidationError()
        {
            // Arrange
            var testDirectorate = new Directorate
            {
                Title = ""
            };

            // Act
            var result = await _directorateValidator.TestValidateAsync(testDirectorate);

            // Assert
            result.ShouldHaveValidationErrorFor(directorate => directorate.Title);
        }

        [Fact]
        public async Task DirectorateValidatorTests_DirectorateWithLongName_ReturnsValidationError()
        {
            // Arrange
            var testDirectorate = new Directorate
            {
                Title = @"Test directorate with very long name, too long for what is allowed in this field. 
                    Hic eaque consequatur voluptatem. Cupiditate modi sed sit architecto. 
                    Ipsum et voluptas fugiat officiis nemo repellendus. Laudantium maxime commodi ad officia odit. 
                    Doloremque qui officia accusantium nesciunt."
            };

            // Act
            var result = await _directorateValidator.TestValidateAsync(testDirectorate);

            // Assert
            result.ShouldHaveValidationErrorFor(directorate => directorate.Title);
        }

        [Fact]
        public async Task DirectorateValidatorTests_DirectorateWithInvalidGroup_ReturnsValidationError()
        {
            // Arrange
            var testDirectorate = new Directorate
            {
                GroupID = 44
            };

            // Act
            var result = await _directorateValidator.TestValidateAsync(testDirectorate);

            // Assert
            result.ShouldHaveValidationErrorFor(directorate => directorate.GroupID);
        }

        [Fact]
        public async Task DirectorateValidatorTests_DirectorateWithInvalidDirector_ReturnsValidationError()
        {
            // Arrange
            var testDirectorate = new Directorate
            {
                DirectorUserID = 6547
            };

            // Act
            var result = await _directorateValidator.TestValidateAsync(testDirectorate);

            // Assert
            result.ShouldHaveValidationErrorFor(directorate => directorate.DirectorUserID);
        }

        [Fact]
        public async Task DirectorateValidatorTests_DirectorateWithObjectivesTooLong_ReturnsValidationError()
        {
            // Arrange
            var testDirectorate = new Directorate
            {
                Objectives = StringTestHelpers.GenerateStringOfLength(10002)
            };

            // Act
            var result = await _directorateValidator.TestValidateAsync(testDirectorate);

            // Assert
            result.ShouldHaveValidationErrorFor(directorate => directorate.Objectives);
        }

        [Fact]
        public async Task DirectorateValidatorTests_DirectorateWithInvalidReportApprover_ReturnsValidationError()
        {
            // Arrange
            var testDirectorate = new Directorate
            {
                ReportApproverUserID = 3311
            };

            // Act
            var result = await _directorateValidator.TestValidateAsync(testDirectorate);

            // Assert
            result.ShouldHaveValidationErrorFor(directorate => directorate.ReportApproverUserID);
        }

        [Fact]
        public async Task DirectorateValidatorTests_DirectorateWithInvalidReportingLead_ReturnsValidationError()
        {
            // Arrange
            var testDirectorate = new Directorate
            {
                ReportingLeadUserID = 3311
            };

            // Act
            var result = await _directorateValidator.TestValidateAsync(testDirectorate);

            // Assert
            result.ShouldHaveValidationErrorFor(directorate => directorate.ReportingLeadUserID);
        }

        [Fact]
        public async Task DirectorateValidatorTests_DirectorateWithDescriptionTooLong_ReturnsValidationError()
        {
            // Arrange
            var testDirectorate = new Directorate
            {
                Description = StringTestHelpers.GenerateStringOfLength(523)
            };

            // Act
            var result = await _directorateValidator.TestValidateAsync(testDirectorate);

            // Assert
            result.ShouldHaveValidationErrorFor(directorate => directorate.Description);
        }
    }
}
