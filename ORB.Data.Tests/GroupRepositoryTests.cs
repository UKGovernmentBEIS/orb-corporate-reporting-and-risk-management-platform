using Microsoft.Extensions.Options;
using Moq;
using ORB.Core;
using ORB.Data.Repositories;
using ORB.Data.Tests.MockData;
using System.Linq;
using Xunit;

namespace ORB.Data.Tests
{
    public class GroupRepositoryTests
    {
        readonly Mock<OrbContext> _mockDb;
        readonly IOptions<UserSettings> _options;

        public GroupRepositoryTests()
        {
            var mockDb = new Mock<OrbContext>();
            mockDb.Setup(db => db.Users).Returns(MockUsers.Users.Object);
            mockDb.Setup(db => db.Groups).Returns(MockGroups.Groups.Object);
            _mockDb = mockDb;
            _options = Options.Create<UserSettings>(new UserSettings() { ClientServiceIdentities = "" });
        }

        [Fact]
        public void Entities_AsAnyUser_ReturnsAllGroups()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "user2@domain.gov.uk" };
            var repo = new GroupRepository(user, _mockDb.Object, _options);

            // Act
            var groups = repo.Entities.ToList();

            // Assert
            Assert.Equal(3, groups.Count());
        }
    }
}
