using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.Extensions.Options;
using Moq;
using ORB.Core;
using ORB.Data.Repositories;
using ORB.Data.Tests.MockData;
using System.Linq;
using Xunit;

namespace ORB.Data.Tests
{
    public class UserRepositoryTests
    {
        readonly Mock<OrbContext> _mockDb;
        readonly IOptions<UserSettings> _options;

        public UserRepositoryTests()
        {
            var mockDb = new Mock<OrbContext>();
            mockDb.Setup(db => db.Users).Returns(MockUsers.Users.Object);
            _mockDb = mockDb;
            _options = Options.Create<UserSettings>(new UserSettings() { ClientServiceIdentities = "" });
        }

        [Fact]
        public void Entities_AsAnyUser_ReturnsAllUsers()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "user2@domain.gov.uk" };
            var repo = new UserRepository(user, _mockDb.Object, _options);

            // Act
            var users = repo.Entities.ToList();

            // Assert
            Assert.Equal(5, users.Count());
        }

        [Fact]
        public async void Edit_AsAdmin_ReturnsUser()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "admin@domain.gov.uk" };
            var repo = new UserRepository(user, _mockDb.Object, _options);

            // Act
            var editUser = await repo.Edit(51234);

            // Assert
            Assert.NotNull(editUser);
            Assert.Equal(MockUsers.Users.Object.SingleOrDefault(u => u.ID == 51234).Title, editUser.Title);
        }

        [Fact]
        public async void Edit_AsNonAdmin_ReturnsNull()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "user2@domain.gov.uk" };
            var repo = new UserRepository(user, _mockDb.Object, _options);

            // Act
            var editUser = await repo.Edit(51234);

            // Assert
            Assert.Null(editUser);
        }

        [Fact]
        public void FirstRequest_WhileDbOffline_ReturnsErrorMessage()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "user2@domain.gov.uk" };
            var mockDbFacade = new Mock<DatabaseFacade>(_mockDb.Object);
            mockDbFacade.Setup(dbf => dbf.CanConnect()).Returns(false);
            _mockDb.Setup(db => db.Database).Returns(mockDbFacade.Object);
            var repo = new UserRepository(user, _mockDb.Object, _options);

            // Act
            var firstRequest = repo.FirstRequest();

            // Assert
            Assert.Equal("db_connect_error", firstRequest);
        }

        [Fact]
        public void FirstRequest_AsUserNotSetup_ReturnsUsernameForError()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "userNotSetup@domain.gov.uk" };
            var mockDbFacade = new Mock<DatabaseFacade>(_mockDb.Object);
            mockDbFacade.Setup(dbf => dbf.CanConnect()).Returns(true);
            _mockDb.Setup(db => db.Database).Returns(mockDbFacade.Object);
            var repo = new UserRepository(user, _mockDb.Object, _options);

            // Act
            var firstRequest = repo.FirstRequest();

            // Assert
            Assert.Equal("userNotSetup@domain.gov.uk", firstRequest);
        }

        [Fact]
        public void FirstRequest_AsDisabledUser_ReturnsDisabledErrorMessage()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "disableduser@domain.gov.uk" };
            var mockDbFacade = new Mock<DatabaseFacade>(_mockDb.Object);
            mockDbFacade.Setup(dbf => dbf.CanConnect()).Returns(true);
            _mockDb.Setup(db => db.Database).Returns(mockDbFacade.Object);
            var repo = new UserRepository(user, _mockDb.Object, _options);

            // Act
            var firstRequest = repo.FirstRequest();

            // Assert
            Assert.Equal("db_user_disabled", firstRequest);
        }

        [Fact]
        public void FirstRequest_AsValidEnabledUser_ReturnsOk()
        {
            // Arrange
            var user = new ApiPrincipal() { Username = "user3@domain.gov.uk" };
            var mockDbFacade = new Mock<DatabaseFacade>(_mockDb.Object);
            mockDbFacade.Setup(dbf => dbf.CanConnect()).Returns(true);
            _mockDb.Setup(db => db.Database).Returns(mockDbFacade.Object);
            var repo = new UserRepository(user, _mockDb.Object, _options);

            // Act
            var firstRequest = repo.FirstRequest();

            // Assert
            Assert.Equal("ok", firstRequest);
        }
    }
}
