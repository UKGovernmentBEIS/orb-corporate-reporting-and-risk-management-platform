using Microsoft.EntityFrameworkCore;
using MockQueryable.Moq;
using Moq;
using ORB.Core.Models;
using System.Collections.Generic;
using System.Linq;

namespace ORB.Data.Tests.MockData
{
    public static class MockGroups
    {
        public static Mock<DbSet<Group>> Groups
        {
            get
            {
                return new List<Group> {
                    new Group { ID = 2, Title = "Group 2", UserGroups = new List<UserGroup>()  },
                    new Group { ID = 33, Title = "Group 33", UserGroups = new List<UserGroup> {
                        new UserGroup { ID = 6245, UserID = 51234, GroupID = 33, User = new User { Username = "user2@domain.gov.uk" } }}},
                    new Group { ID = 6126, Title = "Directorate 6126", UserGroups = new List<UserGroup> {
                        new UserGroup { ID = 4467, UserID = 51234, GroupID = 6126, User = new User { Username = "user2@domain.gov.uk" } }}}
                }.AsQueryable().BuildMockDbSet();
            }
        }
    }
}