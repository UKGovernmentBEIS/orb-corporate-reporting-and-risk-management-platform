using Microsoft.AspNet.OData;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using ORB.Core.Models;
using ORB.Core.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Principal;

namespace ORB.API.Controllers
{
    /// <summary>
    /// Provides a HealthCheck test to confirm that the system is running as expected
    /// </summary>
    [Authorize]
    public class HealthCheckController : ODataController
    {
        private readonly IUserService _userService;
        private readonly ILogger<HealthCheckController> _logger;

        public HealthCheckController(ILogger<HealthCheckController> logger, IUserService context)
        {
            _logger = logger;
            _userService = context;
        }

        // GET: odata/HealthCheck?firstRequest=&checkDb=&checkCurrentUser
        public string Get(string firstRequest, string checkDb, string checkCurrentUser)
        {
            const string LOG_TEMPLATE = "current user: {username}";

            var username = User.Identity.Name ?? User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier).Value;
            _logger.LogInformation(LOG_TEMPLATE, username);
            return _userService.FirstRequest();
        }

        // GET: odata/HealthCheck?apiVersion
        public string Get(string apiVersion)
        {
            const string LOG_TEMPLATE = "API version: {ApiVersion} - .NET version: {NetVersion} - OS version: {OsVersion}";

            string apiVersionn = "2.3";
            var netVersion = System.Environment.Version.ToString();
            var osVersion = System.Environment.OSVersion.ToString();

            _logger.LogInformation(LOG_TEMPLATE, apiVersionn, netVersion, osVersion);


            return LOG_TEMPLATE;

        }

    }
}
