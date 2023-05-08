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
    public class AttributeRepositoryTests
    {
        readonly Mock<OrbContext> _mockDb;
        readonly IOptions<UserSettings> _options;

        public AttributeRepositoryTests()
        {
            var mockDb = new Mock<OrbContext>();
            mockDb.Setup(db => db.Users).Returns(MockUsers.Users.Object);
            mockDb.Setup(db => db.Attributes).Returns(new List<Attribute>{
                new Attribute {
                    ID = 100,
                    AttributeTypeID = 3,
                    DirectorateID = 321,
                    Directorate = new Directorate {
                        ID = 444,
                        Title = "Directorate 444",
                        UserDirectorates = new List<UserDirectorate>{
                            new UserDirectorate { ID = 769, User = new User { ID = 321, Username = "user2@domain.gov.uk" }}
                        }
                    }
                },
                new Attribute {
                    ID = 9733,
                    AttributeTypeID = 6,
                    DirectorateID = 873,
                    Directorate = new Directorate {
                        ID = 21,
                        Title = "Directorate 21",
                        UserDirectorates = new List<UserDirectorate>{ 
                            new UserDirectorate { ID = 543, User = new User { ID = 123, Username = "user2@domain.gov.uk" }}
                        }
                    }
                }
            }.AsQueryable().BuildMockDbSet().Object);
            _mockDb = mockDb;
            _options = Options.Create<UserSettings>(new UserSettings() { ClientServiceIdentities = "" });
        }

        // [Fact]
        // public void Entities_AsAdmin_ReturnsAllAttributes()
        // {
        //     // Arrange
        //     var user = new ApiPrincipal() { Username = "admin@domain.gov.uk" };
        //     var repo = new AttributeRepository(user, _mockDb.Object, _options);

        //     // Act
        //     var attr = repo.Entities.ToList();

        //     // Assert
        //     Assert.Equal(3, attr.Count());
        // }

        // [Fact]
        // public void Entities_AsUserWithOneDirectorate_ReturnsDirectorateAttributes()
        // {
        //     // Arrange
        //     var user = new ApiPrincipal() { Username = "user2@domain.gov.uk" };
        //     var repo = new AttributeRepository(user, _mockDb.Object, _options);

        //     // Act
        //     var attr = repo.Entities.ToList();

        //     // Assert
        //     Assert.Equal(2, attr.Count());
        // }
    }
}
