using Microsoft.EntityFrameworkCore;
using MockQueryable.Moq;
using Moq;
using ORB.Core.Models;
using System.Collections.Generic;
using System.Linq;

namespace ORB.Data.Tests.MockData
{
    public static class MockDirectorates
    {
        public static Mock<DbSet<Directorate>> Directorates
        {
            get
            {
                return new List<Directorate> {
                    new Directorate { ID = 2, Title = "Directorate 2", Group = new Group { UserGroups = new List<UserGroup>() }, UserDirectorates = new List<UserDirectorate>()  },
                    new Directorate { ID = 33, Title = "Directorate 33", Group = new Group { UserGroups = new List<UserGroup>() }, UserDirectorates = new List<UserDirectorate> {
                        new UserDirectorate { ID = 6245, UserID = 51234, DirectorateID = 33, User = new User { Username = "user2@domain.gov.uk" } }}},
                    new Directorate { ID = 6126, Title = "Directorate 6126", Group = new Group { UserGroups = new List<UserGroup>() }, UserDirectorates = new List<UserDirectorate> {
                        new UserDirectorate { ID = 4467, UserID = 51234, DirectorateID = 6126, User = new User { Username = "user2@domain.gov.uk" } }}}
                }.AsQueryable().BuildMockDbSet();
            }
        }
    }
}