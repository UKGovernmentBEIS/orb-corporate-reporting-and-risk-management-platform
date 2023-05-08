﻿using Microsoft.AspNet.OData;
using Microsoft.EntityFrameworkCore;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using ORB.Core.Services;
using ORB.Services.Validations;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class ReportingFrequencyService : EntityService<ReportingFrequency>, IEntityService<ReportingFrequency>
    {
        public ReportingFrequencyService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.ReportingFrequencies) { }
    }
}
