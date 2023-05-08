using Microsoft.Extensions.Options;
using Moq;
using ORB.Core;
using ORB.Data.Repositories;
using ORB.Data.Tests.MockData;
using System.Linq;
using Xunit;

namespace ORB.Data.Tests
{
    public class ProjectRepositoryTests
    {
        readonly Mock<OrbContext> _mockDb;
        readonly IOptions<UserSettings> _options;

        public ProjectRepositoryTests()
        {
            var mockDb = new Mock<OrbContext>();
            mockDb.Setup(db => db.Users).Returns(MockUsers.Users.Object);
            mockDb.Setup(db => db.Projects).Returns(MockProjects.Projects.Object);
            _mockDb = mockDb;
            _options = Options.Create<UserSettings>(new UserSettings() { ClientServiceIdentities = "" });
        }

        [Fact]
        public void Entities_AsAdmin_ReturnsAllProjects()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "admin@domain.gov.uk" };
            var repo = new ProjectRepository(user, _mockDb.Object, _options);

            // Act
            var projects = repo.Entities.ToList();

            // Assert
            Assert.Equal(3, projects.Count());
        }

        [Fact]
        public void Entities_AsUserWithTwoProjects_ReturnsTwoProjects()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "user2@domain.gov.uk" };
            var repo = new ProjectRepository(user, _mockDb.Object, _options);

            // Act
            var projects = repo.Entities.ToList();

            // Assert
            Assert.Equal(2, projects.Count());
        }

        [Fact]
        public void Entities_AsUserWithNoProjects_ReturnsNoProjects()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "user3@domain.gov.uk" };
            var repo = new ProjectRepository(user, _mockDb.Object, _options);

            // Act
            var projects = repo.Entities.ToList();

            // Assert
            Assert.Empty(projects);
        }
    }
}
