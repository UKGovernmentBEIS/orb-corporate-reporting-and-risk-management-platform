using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.Extensions.Options;
using MockQueryable.Moq;
using Moq;
using ORB.Core;
using ORB.Core.Models;
using ORB.Data.Repositories;
using ORB.Data.Tests.MockData;
using System.Collections.Generic;
using System.Linq;
using Xunit;

namespace ORB.Data.Tests
{
    public class RoleRepositoryTests
    {
        readonly Mock<OrbContext> _mockDb;
        readonly IOptions<UserSettings> _options;

        public RoleRepositoryTests()
        {
            var mockDb = new Mock<OrbContext>();
            mockDb.Setup(db => db.Roles).Returns(new List<Role>() {
                new Role { ID = 22, Title = "Role 22" },
                new Role { ID = 33, Title = "Role 33" }
                }.AsQueryable().BuildMockDbSet().Object);
            _mockDb = mockDb;
            _options = Options.Create<UserSettings>(new UserSettings() { ClientServiceIdentities = "" });
        }

        [Fact]
        public void Entities_AsAnyRole_ReturnsAllRoles()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "user2@domain.gov.uk" };
            var repo = new RoleRepository(user, _mockDb.Object, _options);

            // Act
            var roles = repo.Entities.ToList();

            // Assert
            Assert.Equal(2, roles.Count());
        }
    }
}
