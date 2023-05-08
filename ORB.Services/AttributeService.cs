using Microsoft.AspNet.OData;
using Microsoft.EntityFrameworkCore;
using ORB.Core;
using models = ORB.Core.Models;
using ORB.Core.Services;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class AttributeService : EntityWithEditorService<models.Attribute>, IEntityService<models.Attribute>
    {
        public AttributeService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.Attributes) { }
    }
}
