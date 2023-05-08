using Microsoft.EntityFrameworkCore;
using MockQueryable.Moq;
using Moq;
using ORB.Core.Models;
using System.Collections.Generic;
using System.Linq;

namespace ORB.Data.Tests.MockData
{
    public static class MockProjects
    {
        public static Mock<DbSet<Project>> Projects
        {
            get
            {
                return new List<Project> {
                    new Project { ID = 1, Title = "Project 1", UserProjects = new List<UserProject>()  },
                    new Project { ID = 5555, Title = "Project 5555", UserProjects = new List<UserProject> {
                        new UserProject { ID = 1907, UserID = 51234, ProjectID = 5555, User = new User { Username = "user2@domain.gov.uk" } }}},
                    new Project { ID = 921034, Title = "Project 921034", UserProjects = new List<UserProject> {
                        new UserProject { ID = 7153, UserID = 51234, ProjectID = 921034, User = new User { Username = "user2@domain.gov.uk" } }}}
                }.AsQueryable().BuildMockDbSet();
            }
        }
    }
}