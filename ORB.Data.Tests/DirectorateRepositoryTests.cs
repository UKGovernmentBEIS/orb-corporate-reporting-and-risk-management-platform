using Microsoft.Extensions.Options;
using Moq;
using ORB.Core;
using ORB.Data.Repositories;
using ORB.Data.Tests.MockData;
using System.Linq;
using Xunit;

namespace ORB.Data.Tests
{
    public class DirectorateRepositoryTests
    {
        readonly Mock<OrbContext> _mockDb;
        readonly IOptions<UserSettings> _options;

        public DirectorateRepositoryTests()
        {
            var mockDb = new Mock<OrbContext>();
            mockDb.Setup(db => db.Users).Returns(MockUsers.Users.Object);
            mockDb.Setup(db => db.Directorates).Returns(MockDirectorates.Directorates.Object);
            _mockDb = mockDb;
            _options = Options.Create<UserSettings>(new UserSettings() { ClientServiceIdentities = "" });
        }

        [Fact]
        public void Entities_AsAdmin_ReturnsAllDirectorates()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "admin@domain.gov.uk" };
            var repo = new DirectorateRepository(user, _mockDb.Object, _options);

            // Act
            var directorates = repo.Entities.ToList();

            // Assert
            Assert.Equal(3, directorates.Count());
        }

        [Fact]
        public void Entities_AsUserWithTwoDirectorates_ReturnsTwoDirectorates()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "user2@domain.gov.uk" };
            var repo = new DirectorateRepository(user, _mockDb.Object, _options);

            // Act
            var directorates = repo.Entities.ToList();

            // Assert
            Assert.Equal(2, directorates.Count());
        }

        [Fact]
        public void Entities_AsUserWithNoDirectorates_ReturnsNoDirectorates()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "user3@domain.gov.uk" };
            var repo = new DirectorateRepository(user, _mockDb.Object, _options);

            // Act
            var directorates = repo.Entities.ToList();

            // Assert
            Assert.Empty(directorates);
        }
    }
}
