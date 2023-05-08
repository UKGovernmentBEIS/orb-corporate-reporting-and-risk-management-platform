using Microsoft.AspNet.OData.Builder;
using Microsoft.AspNet.OData.Extensions;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Identity.Web;
using Microsoft.OData.Edm;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Core.ReportViewModels;
using ORB.Data;
using ORB.Services;
using System;
using System.Linq;
using System.Security.Claims;
using Microsoft.AspNetCore.Mvc.Authorization;

namespace ORB.API
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.Configure<DbConnectionSettings>(options => Configuration.Bind("DbConnectionSettings", options));
            services.Configure<UserSettings>(options => Configuration.Bind("UserSettings", options));
            services.Configure<EmailSettings>(options => Configuration.Bind("EmailSettings", options));
            services.Configure<RiskSettings>(options => Configuration.Bind("RiskSettings", options));

            services.AddMicrosoftIdentityWebApiAuthentication(Configuration, "AzureAd");

            services.AddCors(options =>
            {
                options.AddDefaultPolicy(builder =>
                {
                    builder
                        .WithOrigins(Configuration.GetValue<string>("CorsOrigin"))
                        .WithMethods("GET", "POST", "PATCH", "DELETE")
                        .AllowCredentials()
                        .AllowAnyHeader();
                });
            });

            services.AddDbContext<OrbContext>(options => options.UseSqlServer(
                Configuration.GetConnectionString("ORB"),
                sqlServerOptions => sqlServerOptions
                    .CommandTimeout(Configuration.GetValue<int>("DatabaseCommandTimeoutInSeconds"))
                    .UseQuerySplittingBehavior(QuerySplittingBehavior.SingleQuery)
            ));

            services.AddOData();
            services.AddODataQueryFilter();

            services.AddMvc(options =>
            {
                options.EnableEndpointRouting = false;
                options.Filters.Add(new AuthorizeFilter());
            });

            services.AddHttpContextAccessor();
            services.AddScoped<ApiPrincipal>(provider =>
            {
                var user = provider.GetService<IHttpContextAccessor>().HttpContext.User;
                var userSettings = Configuration.GetSection("UserSettings").Get<UserSettings>();
                var username = user.Identity.Name ?? user.FindFirst(ClaimTypes.NameIdentifier).Value;
                return new ApiPrincipal
                {
                    RawUsername = username,
                    Username = HelperMethods.HackUsername(username, userSettings)
                };
            });

            services.AddSingleton<IEmailService, GovNotifyEmailService>();

            services.AddScoped<IUnitOfWork, UnitOfWork>();
            services.AddTransient<IEntityService<ORB.Core.Models.Attribute>, AttributeService>();
            services.AddTransient<IEntityService<AttributeType>, AttributeTypeService>();
            services.AddTransient<IBenefitService, BenefitService>();
            services.AddTransient<IEntityService<BenefitType>, BenefitTypeService>();
            services.AddTransient<IEntityUpdateService<BenefitUpdate>, BenefitUpdateService>();
            services.AddTransient<IEntityService<Commitment>, CommitmentService>();
            services.AddTransient<IEntityUpdateService<CommitmentUpdate>, CommitmentUpdateService>();
            services.AddTransient<IEntityService<Contributor>, ContributorService>();
            services.AddTransient<IEntityService<CorporateRiskMitigationAction>, CorporateRiskMitigationActionService>();
            services.AddTransient<IEntityUpdateService<CorporateRiskMitigationActionUpdate>, CorporateRiskMitigationActionUpdateService>();
            services.AddTransient<IEntityService<CorporateRisk>, CorporateRiskService>();
            services.AddTransient<IEntityService<CorporateRiskRiskMitigationAction>, CorporateRiskRiskMitigationActionService>();
            services.AddTransient<IEntityUpdateService<CorporateRiskUpdate>, CorporateRiskUpdateService>();
            services.AddTransient<IEntityService<CustomReportingEntity>, CustomReportingEntityService>();
            services.AddTransient<IEntityService<CustomReportingEntityType>, CustomReportingEntityTypeService>();
            services.AddTransient<IEntityUpdateService<CustomReportingEntityUpdate>, CustomReportingEntityUpdateService>();
            services.AddTransient<IEntityService<DepartmentalObjective>, DepartmentalObjectiveService>();
            services.AddTransient<IEntityService<Dependency>, DependencyService>();
            services.AddTransient<IEntityUpdateService<DependencyUpdate>, DependencyUpdateService>();
            services.AddTransient<IEntityService<Directorate>, DirectorateService>();
            services.AddTransient<IEntityUpdateService<DirectorateUpdate>, DirectorateUpdateService>();
            services.AddTransient<IEntityService<EntityStatus>, EntityStatusService>();
            services.AddTransient<IEntityService<FinancialRiskMitigationAction>, FinancialRiskMitigationActionService>();
            services.AddTransient<IEntityUpdateService<FinancialRiskMitigationActionUpdate>, FinancialRiskMitigationActionUpdateService>();
            services.AddTransient<IEntityService<FinancialRisk>, FinancialRiskService>();
            services.AddTransient<IEntityUpdateService<FinancialRiskUpdate>, FinancialRiskUpdateService>();
            services.AddTransient<IEntityService<FinancialRiskUserGroup>, FinancialRiskUserGroupService>();
            services.AddTransient<IEntityService<Group>, GroupService>();
            services.AddTransient<IEntityService<KeyWorkArea>, KeyWorkAreaService>();
            services.AddTransient<IEntityUpdateService<KeyWorkAreaUpdate>, KeyWorkAreaUpdateService>();
            services.AddTransient<IEntityService<MeasurementUnit>, MeasurementUnitService>();
            services.AddTransient<IMetricService, MetricService>();
            services.AddTransient<IEntityUpdateService<MetricUpdate>, MetricUpdateService>();
            services.AddTransient<IEntityService<Milestone>, MilestoneService>();
            services.AddTransient<IEntityService<MilestoneType>, MilestoneTypeService>();
            services.AddTransient<IEntityUpdateService<MilestoneUpdate>, MilestoneUpdateService>();
            services.AddTransient<IEntityService<PartnerOrganisationRiskMitigationAction>, PartnerOrganisationRiskMitigationActionService>();
            services.AddTransient<IEntityUpdateService<PartnerOrganisationRiskMitigationActionUpdate>, PartnerOrganisationRiskMitigationActionUpdateService>();
            services.AddTransient<IEntityService<PartnerOrganisationRiskRiskType>, PartnerOrganisationRiskRiskTypeService>();
            services.AddTransient<IEntityService<PartnerOrganisationRisk>, PartnerOrganisationRiskService>();
            services.AddTransient<IEntityUpdateService<PartnerOrganisationRiskUpdate>, PartnerOrganisationRiskUpdateService>();
            services.AddTransient<IEntityService<PartnerOrganisation>, PartnerOrganisationService>();
            services.AddTransient<IEntityUpdateService<PartnerOrganisationUpdate>, PartnerOrganisationUpdateService>();
            services.AddTransient<IProjectService, ProjectService>();
            services.AddTransient<IEntityService<ProjectBusinessCaseType>, ProjectBusinessCaseTypeService>();
            services.AddTransient<IEntityService<ProjectPhase>, ProjectPhaseService>();
            services.AddTransient<IEntityUpdateService<ProjectUpdate>, ProjectUpdateService>();
            services.AddTransient<IEntityReadService<RagOption>, RagOptionService>();
            services.AddTransient<IEntityService<ReportingFrequency>, ReportingFrequencyService>();
            services.AddTransient<IEntityService<RiskDiscussionForum>, RiskDiscussionForumService>();
            services.AddTransient<IEntityService<RiskAppetite>, RiskAppetiteService>();
            services.AddTransient<IEntityService<RiskImpactLevel>, RiskImpactLevelService>();
            services.AddTransient<IEntityService<RiskProbability>, RiskProbabilityService>();
            services.AddTransient<IEntityService<RiskRegister>, RiskRegisterService>();
            services.AddTransient<IEntityService<RiskRiskType>, RiskRiskTypeService>();
            services.AddTransient<IEntityService<RiskType>, RiskTypeService>();
            services.AddTransient<IEntityService<Role>, RoleService>();
            services.AddTransient<ISignOffService, SignOffService>();
            services.AddTransient<IEntityService<ThresholdAppetite>, ThresholdAppetiteService>();
            services.AddTransient<IEntityService<Threshold>, ThresholdService>();
            services.AddTransient<IEntityService<UserDirectorate>, UserDirectorateService>();
            services.AddTransient<IEntityService<UserGroup>, UserGroupService>();
            services.AddTransient<IEntityService<UserPartnerOrganisation>, UserPartnerOrganisationService>();
            services.AddTransient<IEntityService<UserProject>, UserProjectService>();
            services.AddTransient<IEntityService<UserRole>, UserRoleService>();
            services.AddTransient<IUserService, UserService>();
            services.AddTransient<IEntityService<WorkStream>, WorkStreamService>();
            services.AddTransient<IEntityUpdateService<WorkStreamUpdate>, WorkStreamUpdateService>();
            services.AddTransient<IReportBuilderService, ReportBuilderService>();
            services.AddTransient<IEntityService<HealthCheckAlert>, HealthCheckAlertService>();

            services.AddAutoMapper(typeof(ORB.Services.Mapping.MappingProfile));
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseCors();

            app.UseAuthentication();
            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });

            app.UseMvc(routeBuilder =>
            {
                routeBuilder.EnableDependencyInjection();
                routeBuilder.Select().OrderBy().Filter().Expand().MaxTop(5000);
                routeBuilder.MapODataServiceRoute("odata", "odata", GetEdmModel());
            });
        }

        private static IEdmModel GetEdmModel()
        {
            var builder = new ODataConventionModelBuilder();

            builder.EntitySet<ORB.Core.Models.Attribute>("Attributes");
            builder.EntitySet<AttributeType>("AttributeTypes");
            builder.EntitySet<Benefit>("Benefits");
            var benefitsDue = builder.EntityType<Benefit>().Collection.Function("GetBenefitsDueInPeriod").ReturnsCollectionFromEntitySet<Benefit>("Benefits");
            benefitsDue.Parameter<int>("ProjectId");
            benefitsDue.Parameter<byte>("Period");
            builder.EntitySet<BenefitType>("BenefitTypes");
            builder.EntitySet<BenefitUpdate>("BenefitUpdates");
            builder.EntitySet<Commitment>("Commitments");
            builder.EntitySet<CommitmentUpdate>("CommitmentUpdates");
            builder.EntitySet<Contributor>("Contributors");
            builder.EntitySet<CorporateRiskMitigationAction>("CorporateRiskMitigationActions");
            builder.EntitySet<CorporateRiskMitigationActionUpdate>("CorporateRiskMitigationActionUpdates");
            builder.EntitySet<CorporateRiskRiskMitigationAction>("CorporateRiskRiskMitigationActions");
            builder.EntitySet<CorporateRisk>("CorporateRisks");
            builder.EntitySet<CorporateRiskUpdate>("CorporateRiskUpdates");
            builder.EntitySet<CustomReportingEntity>("ReportingEntities");
            builder.EntitySet<CustomReportingEntityType>("ReportingEntityTypes");
            builder.EntitySet<CustomReportingEntityUpdate>("ReportingEntityUpdates");
            builder.EntitySet<DepartmentalObjective>("DepartmentalObjectives");
            builder.EntitySet<Dependency>("Dependencies");
            builder.EntitySet<DependencyUpdate>("DependencyUpdates");
            builder.EntitySet<Directorate>("Directorates");
            builder.EntitySet<DirectorateUpdate>("DirectorateUpdates");
            builder.EntitySet<EntityStatus>("EntityStatuses");
            builder.EntitySet<FinancialRiskMitigationAction>("FinancialRiskMitigationActions");
            builder.EntitySet<FinancialRiskMitigationActionUpdate>("FinancialRiskMitigationActionUpdates");
            builder.EntitySet<FinancialRisk>("FinancialRisks");
            builder.EntitySet<FinancialRiskUpdate>("FinancialRiskUpdates");
            builder.EntitySet<FinancialRiskUserGroup>("FinancialRiskUserGroups");
            builder.EntitySet<Group>("Groups");
            builder.EntitySet<HealthCheck>("HealthCheck");
            builder.EntitySet<KeyWorkArea>("KeyWorkAreas");
            builder.EntitySet<KeyWorkAreaUpdate>("KeyWorkAreaUpdates");
            builder.EntitySet<MeasurementUnit>("MeasurementUnits");
            builder.EntitySet<Metric>("Metrics");
            var metricsDue = builder.EntityType<Metric>().Collection.Function("GetMetricsDueInPeriod").ReturnsCollectionFromEntitySet<Metric>("Metrics");
            metricsDue.Parameter<int>("DirectorateId");
            metricsDue.Parameter<byte>("Period");
            builder.EntitySet<MetricUpdate>("MetricUpdates");
            builder.EntitySet<Milestone>("Milestones");
            builder.EntitySet<MilestoneType>("MilestoneTypes");
            builder.EntitySet<MilestoneUpdate>("MilestoneUpdates");
            builder.EntitySet<PartnerOrganisation>("PartnerOrganisations");
            builder.EntitySet<PartnerOrganisationRisk>("PartnerOrganisationRisks");
            builder.EntitySet<PartnerOrganisationRiskMitigationAction>("PartnerOrganisationRiskMitigationActions");
            builder.EntitySet<PartnerOrganisationRiskMitigationActionUpdate>("PartnerOrganisationRiskMitigationActionUpdates");
            builder.EntitySet<PartnerOrganisationRiskRiskType>("PartnerOrganisationRiskRiskTypes");
            builder.EntitySet<PartnerOrganisationRiskUpdate>("PartnerOrganisationRiskUpdates");
            builder.EntitySet<PartnerOrganisationUpdate>("PartnerOrganisationUpdates");
            builder.EntitySet<Project>("Projects");
            var projectsDue = builder.EntityType<Project>().Collection.Function("GetProjectsDueInPeriod").ReturnsCollectionFromEntitySet<Project>("Projects");
            projectsDue.Parameter<int>("DirectorateId");
            projectsDue.Parameter<byte>("Period");
            builder.EntitySet<ProjectBusinessCaseType>("ProjectBusinessCaseTypes");
            builder.EntitySet<ProjectPhase>("ProjectPhases");
            builder.EntitySet<ProjectUpdate>("ProjectUpdates");
            builder.EntitySet<RagOption>("RagOptions");
            builder.EntitySet<ReportingFrequency>("ReportingFrequencies");
            builder.EntitySet<RiskAppetite>("RiskAppetites");
            builder.EntitySet<RiskDiscussionForum>("RiskDiscussionForums");
            builder.EntitySet<RiskImpactLevel>("RiskImpactLevels");
            builder.EntitySet<RiskProbability>("RiskProbabilities");
            builder.EntitySet<RiskRegister>("RiskRegisters");
            builder.EntitySet<RiskRiskMitigationAction>("RiskRiskMitigationActions");
            builder.EntitySet<RiskRiskType>("RiskRiskTypes");
            builder.EntitySet<RiskType>("RiskTypes");
            builder.EntitySet<Role>("Roles");
            builder.EntitySet<SignOff>("SignOffs");
            builder.EntitySet<Threshold>("Thresholds");
            builder.EntitySet<ThresholdAppetite>("ThresholdAppetites");
            builder.EntitySet<UserDirectorate>("UserDirectorates");
            builder.EntitySet<UserGroup>("UserGroups");
            builder.EntitySet<User>("Users");
            var userPermissions = builder.EntityType<User>().Collection.Function("GetUserPermissions").ReturnsFromEntitySet<User>("Users");
            userPermissions.Parameter<string>("Username");
            builder.EntitySet<UserPartnerOrganisation>("UserPartnerOrganisations");
            builder.EntitySet<UserProject>("UserProjects");
            builder.EntitySet<UserRole>("UserRoles");
            builder.EntitySet<WorkStream>("WorkStreams");
            builder.EntitySet<WorkStreamUpdate>("WorkStreamUpdates");

            var benefit = builder.Function("GetBenefitReportDueDates").Returns<ReportDueDates>();
            benefit.Parameter<int>("ID");
            benefit.Parameter<DateTime>("AtDate");

            var directorate = builder.Function("GetDirectorateReportDueDates").Returns<ReportDueDates>();
            directorate.Parameter<int>("ID");
            directorate.Parameter<DateTime>("AtDate");

            var metric = builder.Function("GetMetricReportDueDates").Returns<ReportDueDates>();
            metric.Parameter<int>("ID");
            metric.Parameter<DateTime>("AtDate");

            var partnerOrg = builder.Function("GetPartnerOrganisationReportDueDates").Returns<ReportDueDates>();
            partnerOrg.Parameter<int>("ID");
            partnerOrg.Parameter<DateTime>("AtDate");

            var project = builder.Function("GetProjectReportDueDates").Returns<ReportDueDates>();
            project.Parameter<int>("ID");
            project.Parameter<DateTime>("AtDate");

            var financialRisk = builder.Function("GetFinancialRiskReportDueDates").Returns<ReportDueDates>();
            financialRisk.Parameter<int>("ID");
            financialRisk.Parameter<DateTime>("AtDate");

            var reportBuilderDirectorate = builder.Function("BuildDirectorateReport").Returns<SignOffDirectorateDto>();
            reportBuilderDirectorate.Parameter<int>("DirectorateID");
            reportBuilderDirectorate.Parameter<DateTime>("ReportPeriod");

            var reportBuilderPartnerOrg = builder.Function("BuildPartnerOrganisationReport").Returns<SignOffPartnerOrganisationDto>();
            reportBuilderPartnerOrg.Parameter<int>("PartnerOrganisationID");
            reportBuilderPartnerOrg.Parameter<DateTime>("ReportPeriod");

            var reportBuilderProject = builder.Function("BuildProjectReport").Returns<SignOffProjectDto>();
            reportBuilderProject.Parameter<int>("ProjectID");
            reportBuilderProject.Parameter<DateTime>("ReportPeriod");

            var reportBuilderRisk = builder.Function("BuildRiskReport").Returns<SignOffCorporateRiskDto>();
            reportBuilderRisk.Parameter<int>("RiskID");
            reportBuilderRisk.Parameter<DateTime>("ReportPeriod");

            var reportBuilderFinancialRisk = builder.Function("BuildFinancialRiskReport").Returns<SignOffFinancialRiskDto>();
            reportBuilderFinancialRisk.Parameter<int>("RiskID");
            reportBuilderFinancialRisk.Parameter<DateTime>("ReportPeriod");

            return builder.GetEdmModel();
        }
    }
}
