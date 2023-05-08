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
    public class ProjectValidatorTests
    {
        readonly Mock<IUnitOfWork> _mockUnitOfWork;
        readonly ProjectValidator _projectValidator;

        public ProjectValidatorTests()
        {
            _mockUnitOfWork = new Mock<IUnitOfWork>();
            _projectValidator = new ProjectValidator(_mockUnitOfWork.Object);
            _mockUnitOfWork.Setup(uow => uow.Users.Entities).Returns(new[] {
                new User { ID = 123, Title = "bob" },
                new User { ID = 234, Title = "john" },
                new User { ID = 345, Title = "jane" } }.AsQueryable());
            _mockUnitOfWork.Setup(uow => uow.Directorates.Entities).Returns(new[] {
                new Directorate { ID = 3, Title = "dir 1" },
                new Directorate { ID = 7, Title = "dir 2" },
                new Directorate { ID = 15, Title = "dir 3" } }.AsQueryable());
            _mockUnitOfWork.Setup(uow => uow.Projects.Entities).Returns(new[] {
                new Project { ID = 3, Title = "project 1" },
                new Project { ID = 7, Title = "project 2" },
                new Project { ID = 15, Title = "project 3", CorporateProjectID = "DPO-1122" } }.AsQueryable());
        }

        [Fact]
        public async Task ProjectValidatorTests_ValidProject_ReturnsNoErrors()
        {
            // Arrange
            var testProject = new Project
            {
                ID = 15,
                Title = "Test project",
                DirectorateID = 7,
                ReportingFrequency = (byte)ReportingFrequencies.Quarterly,
                ReportingDueDay = (byte)ReportingDueDays.D25,
                ReportingStartDate = new DateTime(2021, 6, 1),
                CorporateProjectID = "DPO-1122"
            };

            // Act
            var result = await _projectValidator.TestValidateAsync(testProject);

            // Assert
            result.ShouldNotHaveAnyValidationErrors();
        }

        [Fact]
        public async Task ProjectValidatorTests_ProjectWithoutMinimumProperties_ReturnsValidationErrors()
        {
            // Arrange
            var testProject = new Project { };

            // Act
            var result = await _projectValidator.TestValidateAsync(testProject);

            // Assert
            result.ShouldHaveValidationErrorFor(project => project.Title);
            result.ShouldHaveValidationErrorFor(project => project.DirectorateID);
            result.ShouldHaveValidationErrorFor(project => project.ReportingFrequency);
            result.ShouldHaveValidationErrorFor(project => project.ReportingDueDay);
        }

        [Fact]
        public async Task ProjectValidatorTests_ProjectWithBlankName_ReturnsValidationError()
        {
            // Arrange
            var testProject = new Project
            {
                Title = ""
            };

            // Act
            var result = await _projectValidator.TestValidateAsync(testProject);

            // Assert
            result.ShouldHaveValidationErrorFor(project => project.Title);
        }

        [Fact]
        public async Task ProjectValidatorTests_ProjectWithLongName_ReturnsValidationError()
        {
            // Arrange
            var testProject = new Project
            {
                Title = @"Test project with very long name, too long for what is allowed in this field. 
                    Hic eaque consequatur voluptatem. Cupiditate modi sed sit architecto. 
                    Ipsum et voluptas fugiat officiis nemo repellendus. Laudantium maxime commodi ad officia odit. 
                    Doloremque qui officia accusantium nesciunt."
            };

            // Act
            var result = await _projectValidator.TestValidateAsync(testProject);

            // Assert
            result.ShouldHaveValidationErrorFor(project => project.Title);
        }

        [Fact]
        public async Task ProjectValidatorTests_ProjectWithInvalidDirectorate_ReturnsValidationError()
        {
            // Arrange
            var testProject = new Project
            {
                DirectorateID = 44
            };

            // Act
            var result = await _projectValidator.TestValidateAsync(testProject);

            // Assert
            result.ShouldHaveValidationErrorFor(project => project.DirectorateID);
        }

        [Fact]
        public async Task ProjectValidatorTests_ProjectWithInvalidSRO_ReturnsValidationError()
        {
            // Arrange
            var testProject = new Project
            {
                SeniorResponsibleOwnerUserID = 6547
            };

            // Act
            var result = await _projectValidator.TestValidateAsync(testProject);

            // Assert
            result.ShouldHaveValidationErrorFor(project => project.SeniorResponsibleOwnerUserID);
        }

        [Fact]
        public async Task ProjectValidatorTests_ProjectWithObjectivesTooLong_ReturnsValidationError()
        {
            // Arrange
            var testProject = new Project
            {
                Objectives = StringTestHelpers.GenerateStringOfLength(10002)
            };

            // Act
            var result = await _projectValidator.TestValidateAsync(testProject);

            // Assert
            result.ShouldHaveValidationErrorFor(project => project.Objectives);
        }

        [Fact]
        public async Task ProjectValidatorTests_ProjectWithInvalidProjectManager_ReturnsValidationError()
        {
            // Arrange
            var testProject = new Project
            {
                ProjectManagerUserID = 3311
            };

            // Act
            var result = await _projectValidator.TestValidateAsync(testProject);

            // Assert
            result.ShouldHaveValidationErrorFor(project => project.ProjectManagerUserID);
        }

        [Fact]
        public async Task ProjectValidatorTests_ProjectWithInvalidReportApprover_ReturnsValidationError()
        {
            // Arrange
            var testProject = new Project
            {
                ReportApproverUserID = 3311
            };

            // Act
            var result = await _projectValidator.TestValidateAsync(testProject);

            // Assert
            result.ShouldHaveValidationErrorFor(project => project.ReportApproverUserID);
        }

        [Fact]
        public async Task ProjectValidatorTests_ProjectWithInvalidReportingLead_ReturnsValidationError()
        {
            // Arrange
            var testProject = new Project
            {
                ReportingLeadUserID = 3311
            };

            // Act
            var result = await _projectValidator.TestValidateAsync(testProject);

            // Assert
            result.ShouldHaveValidationErrorFor(project => project.ReportingLeadUserID);
        }

        [Fact]
        public async Task ProjectValidatorTests_ProjectWithInvalidParentProject_ReturnsValidationError()
        {
            // Arrange
            var testProject = new Project
            {
                ParentProjectID = 3311
            };

            // Act
            var result = await _projectValidator.TestValidateAsync(testProject);

            // Assert
            result.ShouldHaveValidationErrorFor(project => project.ParentProjectID);
        }

        [Fact]
        public async Task ProjectValidatorTests_ProjectWithDescriptionTooLong_ReturnsValidationError()
        {
            // Arrange
            var testProject = new Project
            {
                Description = StringTestHelpers.GenerateStringOfLength(523)
            };

            // Act
            var result = await _projectValidator.TestValidateAsync(testProject);

            // Assert
            result.ShouldHaveValidationErrorFor(project => project.Description);
        }

        [Fact]
        public async Task ProjectValidatorTests_ProjectWithEndDateBeforeStartDate_ReturnsValidationError()
        {
            // Arrange
            var testProject = new Project
            {
                StartDate = new DateTime(2021, 3, 1),
                EndDate = new DateTime(2021, 2, 2)
            };

            // Act
            var result = await _projectValidator.TestValidateAsync(testProject);

            // Assert
            result.ShouldHaveValidationErrorFor(project => project.EndDate);
        }

        [Fact]
        public async Task ProjectValidatorTests_ProjectWithDuplicateCorporateId_ReturnsValidationError()
        {
            // Arrange
            var testProject = new Project
            {
                CorporateProjectID = "DPO-1122"
            };

            // Act
            var result = await _projectValidator.TestValidateAsync(testProject);

            // Assert
            result.ShouldHaveValidationErrorFor(project => project.CorporateProjectID);
        }
    }
}
