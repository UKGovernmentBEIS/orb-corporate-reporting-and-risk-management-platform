using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using ORB.Core;
using ORB.Core.Services;
using ORB.Core.Models;
using ORB.Data;
using ORB.Services;
using System;
using System.Security.Principal;
using Microsoft.Azure.Functions.Worker.Configuration;
using Microsoft.Extensions.Hosting;

namespace ORB.Functions
{
    public static class Program
    {
        public static void Main()
        {
            var host = new HostBuilder()
            .ConfigureAppConfiguration(config =>
            {
                config.AddEnvironmentVariables();
            })
            .ConfigureFunctionsWorkerDefaults()
            .ConfigureServices(services =>
            {
                services.AddOptions<DbConnectionSettings>()
                    .Configure<IConfiguration>((settings, configuration) => configuration.GetSection("DbConnectionSettings").Bind(settings));
                services.AddOptions<EmailSettings>()
                    .Configure<IConfiguration>((settings, configuration) => configuration.GetSection("EmailSettings").Bind(settings));
                services.AddOptions<UserSettings>()
                    .Configure<IConfiguration>((settings, configuration) => configuration.GetSection("UserSettings").Bind(settings));

                var sqlConnection = Environment.GetEnvironmentVariable("SqlConnectionString");

                services.AddDbContext<OrbContext>(options => options.UseSqlServer(sqlConnection));

                services.AddSingleton<ApiPrincipal>(new ApiPrincipal() { Username = "ORB.Functions" });
                services.AddScoped<IUnitOfWork, UnitOfWork>();
                services.AddTransient<IEmailService, GovNotifyEmailService>();
                services.AddTransient<IBenefitService, BenefitService>();
                services.AddTransient<IReportingEntityService<Directorate>, DirectorateService>();
                services.AddTransient<IReportingEntityService<FinancialRisk>, FinancialRiskService>();
                services.AddTransient<IMetricService, MetricService>();
                services.AddTransient<IReportingEntityService<PartnerOrganisation>, PartnerOrganisationService>();
                services.AddTransient<IProjectService, ProjectService>();
                services.AddTransient<IEntityService<ReportingFrequency>, ReportingFrequencyService>();
                services.AddTransient<IEntityService<UserProject>, UserProjectService>();
                services.AddTransient<IUserService, UserService>();
                services.AddTransient<IEntityService<HealthCheckAlert>, HealthCheckAlertService>();
            })
            .Build();

            host.Run();
        }
    }
}
