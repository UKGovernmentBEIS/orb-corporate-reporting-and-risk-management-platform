using Moq;
using ORB.Core;
using ORB.Core.Models;
using System.Linq;
using System.Threading.Tasks;
using Xunit;

namespace ORB.Services.Tests
{
    public class BenefitServiceTests
    {
        readonly Mock<IUnitOfWork> _mockUnitOfWork;

        public BenefitServiceTests()
        {
            _mockUnitOfWork = new Mock<IUnitOfWork>();
        }

        [Fact]
        public async Task BenefitServiceTests_AddBenefit_ReturnsBenefitWithSystemValues()
        {
            // Arrange
            var testBenefit = new Benefit
            {
                Title = "Test benefit",
                ProjectID = 333,
                ReportingFrequency = 1,
                ReportingDueDay = 100
            };
            _mockUnitOfWork.Setup(uow => uow.Benefits.ApiUser).Returns(new User { ID = 666 });
            _mockUnitOfWork.Setup(uow => uow.Benefits.Add(It.IsAny<Benefit>())).Returns(testBenefit);
            _mockUnitOfWork.Setup(uow => uow.Projects.Entities).Returns(new[] { new Project { ID = 333 } }.AsQueryable());
            var service = new BenefitService(_mockUnitOfWork.Object);

            // Act
            var benefit = await service.Add(testBenefit);

            // Assert
            Assert.Equal(666, benefit.ModifiedByUserID);
            Assert.Equal((int)EntityStatuses.Open, benefit.EntityStatusID);
            Assert.NotNull(benefit.EntityStatusDate);
        }

        //ChangeReportingCycle_CycleIsCopiedToBenefitUpdates
    }
}
