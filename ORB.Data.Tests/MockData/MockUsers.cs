using Microsoft.EntityFrameworkCore;
using MockQueryable.Moq;
using Moq;
using ORB.Core;
using ORB.Core.Models;
using System.Collections.Generic;
using System.Linq;

namespace ORB.Data.Tests.MockData
{
    public static class MockUsers
    {
        public static Mock<DbSet<User>> Users
        {
            get
            {
                return new List<User> {
                    new User { ID = 1, Title = "User 1", Username = "user1@domain.gov.uk", UserRoles = new List<UserRole>() },
                    new User { ID = 51234, Title = "User 2", Username = "user2@domain.gov.uk", UserRoles = new List<UserRole>() },
                    new User { ID = 921034, Title = "User 3", Username = "user3@domain.gov.uk", UserRoles = new List<UserRole>() },
                    new User { ID = 3435, Title = "Admin user", Username = "admin@domain.gov.uk", UserRoles = MockUsers.UserRoles.Object.Where(ur => ur.UserID == 3435).ToList() },
                    new User { ID = 2300, Title = "Disabled user", Username = "disableduser@domain.gov.uk", EntityStatusID = (int)EntityStatuses.Closed }
                }.AsQueryable().BuildMockDbSet();
            }
        }

        public static Mock<DbSet<UserRole>> UserRoles
        {
            get
            {
                return new List<UserRole> {
                    new UserRole { ID = 1907, UserID = 3435, RoleID = (int)AdminRoles.SystemAdmin },
                    new UserRole { ID = 7153, UserID = 3435, RoleID = (int)AdminRoles.RiskAdmin }
                }.AsQueryable().BuildMockDbSet();
            }
        }
    }
}