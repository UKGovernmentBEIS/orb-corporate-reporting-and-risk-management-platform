using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text.Json;

namespace ORB.Data
{
    public partial class OrbContext : DbContext
    {
        public OrbContext()
        {
        }

        public OrbContext(DbContextOptions<OrbContext> options, IOptions<DbConnectionSettings> dbConnSettings) : base(options)
        {
            var connection = (SqlConnection)Database.GetDbConnection();
            if (!connection.ConnectionString.ToLower().Contains("password"))
            {
                connection.AccessToken = (new AzureServiceTokenProvider()).GetAccessTokenAsync(dbConnSettings.Value.DatabaseAccessTokenUrl).Result;
            }
        }

        public virtual DbSet<ORB.Core.Models.Attribute> Attributes { get; set; }
        public virtual DbSet<AttributeType> AttributeTypes { get; set; }
        public virtual DbSet<Benefit> Benefits { get; set; }
        public virtual DbSet<BenefitType> BenefitTypes { get; set; }
        public virtual DbSet<BenefitUpdate> BenefitUpdates { get; set; }
        public virtual DbSet<Commitment> Commitments { get; set; }
        public virtual DbSet<CommitmentUpdate> CommitmentUpdates { get; set; }
        public virtual DbSet<Contributor> Contributors { get; set; }
        public virtual DbSet<CorporateRiskMitigationAction> CorporateRiskMitigationActions { get; set; }
        public virtual DbSet<CorporateRiskMitigationActionUpdate> CorporateRiskMitigationActionUpdates { get; set; }
        public virtual DbSet<CorporateRiskRiskMitigationAction> CorporateRiskRiskMitigationActions { get; set; }
        public virtual DbSet<CorporateRisk> CorporateRisks { get; set; }
        public virtual DbSet<CorporateRiskUpdate> CorporateRiskUpdates { get; set; }
        public virtual DbSet<DepartmentalObjective> DepartmentalObjectives { get; set; }
        public virtual DbSet<Dependency> Dependencies { get; set; }
        public virtual DbSet<DependencyUpdate> DependencyUpdates { get; set; }
        public virtual DbSet<Directorate> Directorates { get; set; }
        public virtual DbSet<DirectorateUpdate> DirectorateUpdates { get; set; }
        public virtual DbSet<EntityStatus> EntityStatuses { get; set; }
        public virtual DbSet<FinancialRiskMitigationAction> FinancialRiskMitigationActions { get; set; }
        public virtual DbSet<FinancialRiskMitigationActionUpdate> FinancialRiskMitigationActionUpdates { get; set; }
        public virtual DbSet<FinancialRisk> FinancialRisks { get; set; }
        public virtual DbSet<FinancialRiskUpdate> FinancialRiskUpdates { get; set; }
        public virtual DbSet<Group> Groups { get; set; }
        public virtual DbSet<KeyWorkArea> KeyWorkAreas { get; set; }
        public virtual DbSet<KeyWorkAreaUpdate> KeyWorkAreaUpdates { get; set; }
        public virtual DbSet<MeasurementUnit> MeasurementUnits { get; set; }
        public virtual DbSet<Metric> Metrics { get; set; }
        public virtual DbSet<MetricUpdate> MetricUpdates { get; set; }
        public virtual DbSet<Milestone> Milestones { get; set; }
        public virtual DbSet<MilestoneType> MilestoneTypes { get; set; }
        public virtual DbSet<MilestoneUpdate> MilestoneUpdates { get; set; }
        public virtual DbSet<PartnerOrganisation> PartnerOrganisations { get; set; }
        public virtual DbSet<PartnerOrganisationRisk> PartnerOrganisationRisks { get; set; }
        public virtual DbSet<PartnerOrganisationRiskMitigationAction> PartnerOrganisationRiskMitigationActions { get; set; }
        public virtual DbSet<PartnerOrganisationRiskMitigationActionUpdate> PartnerOrganisationRiskMitigationActionUpdates { get; set; }
        public virtual DbSet<PartnerOrganisationRiskRiskType> PartnerOrganisationRiskRiskTypes { get; set; }
        public virtual DbSet<PartnerOrganisationRiskUpdate> PartnerOrganisationRiskUpdates { get; set; }
        public virtual DbSet<PartnerOrganisationUpdate> PartnerOrganisationUpdates { get; set; }
        public virtual DbSet<Project> Projects { get; set; }
        public virtual DbSet<ProjectBusinessCaseType> ProjectBusinessCaseTypes { get; set; }
        public virtual DbSet<ProjectPhase> ProjectPhases { get; set; }
        public virtual DbSet<ProjectUpdate> ProjectUpdates { get; set; }
        public virtual DbSet<RagOption> RagOptions { get; set; }
        public virtual DbSet<RagOptionsMapping> RagOptionsMappings { get; set; }
        public virtual DbSet<CustomReportingEntity> ReportingEntities { get; set; }
        public virtual DbSet<CustomReportingEntityType> ReportingEntityTypes { get; set; }
        public virtual DbSet<CustomReportingEntityUpdate> ReportingEntityUpdates { get; set; }
        public virtual DbSet<ReportingFrequency> ReportingFrequencies { get; set; }
        public virtual DbSet<ReportStaging> ReportStagings { get; set; }
        public virtual DbSet<ReportType> ReportTypes { get; set; }
        public virtual DbSet<Risk> Risks { get; set; }
        public virtual DbSet<RiskAppetite> RiskAppetites { get; set; }
        public virtual DbSet<RiskDiscussionForum> RiskDiscussionForums { get; set; }
        public virtual DbSet<RiskImpactLevel> RiskImpactLevels { get; set; }
        public virtual DbSet<RiskProbability> RiskProbabilities { get; set; }
        public virtual DbSet<RiskRegister> RiskRegisters { get; set; }
        public virtual DbSet<RiskRiskType> RiskRiskTypes { get; set; }
        public virtual DbSet<RiskType> RiskTypes { get; set; }
        public virtual DbSet<RiskUpdate> RiskUpdates { get; set; }
        public virtual DbSet<Role> Roles { get; set; }
        public virtual DbSet<SignOff> SignOffs { get; set; }
        public virtual DbSet<Threshold> Thresholds { get; set; }
        public virtual DbSet<ThresholdAppetite> ThresholdAppetites { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<UserDirectorate> UserDirectorates { get; set; }
        public virtual DbSet<UserGroup> UserGroups { get; set; }
        public virtual DbSet<FinancialRiskUserGroup> FinancialRiskUserGroups { get; set; }
        public virtual DbSet<UserPartnerOrganisation> UserPartnerOrganisations { get; set; }
        public virtual DbSet<UserProject> UserProjects { get; set; }
        public virtual DbSet<UserRole> UserRoles { get; set; }
        public virtual DbSet<WorkStream> WorkStreams { get; set; }
        public virtual DbSet<WorkStreamUpdate> WorkStreamUpdates { get; set; }
        public virtual DbSet<HealthCheckAlert> HealthCheckAlerts { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ORB.Core.Models.Attribute>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.AttributeTypeID).HasColumnName("AttributeTypeID");

                entity.Property(e => e.AttributeValue).HasMaxLength(255);

                entity.Property(e => e.BenefitID).HasColumnName("BenefitID");

                entity.Property(e => e.CommitmentID).HasColumnName("CommitmentID");

                entity.Property(e => e.KeyWorkAreaID).HasColumnName("KeyWorkAreaID");

                entity.Property(e => e.MetricID).HasColumnName("MetricID");

                entity.Property(e => e.MilestoneID).HasColumnName("MilestoneID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.PartnerOrganisationRiskID).HasColumnName("PartnerOrganisationRiskID");

                entity.Property(e => e.RiskID).HasColumnName("RiskID");

                entity.Property(e => e.Title).HasMaxLength(50);

                entity.Property(e => e.WorkStreamID).HasColumnName("WorkStreamID");

                entity.HasOne(d => d.AttributeType)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.AttributeTypeID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Attributes_AttributeTypes");

                entity.HasOne(d => d.Benefit)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.BenefitID)
                    .HasConstraintName("FK_Attributes_Benefits");

                entity.HasOne(d => d.Commitment)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.CommitmentID)
                    .HasConstraintName("FK_Attributes_Commitments");

                entity.HasOne(d => d.Dependency)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.DependencyID)
                    .HasConstraintName("FK_Attributes_Dependencies");

                entity.HasOne(d => d.KeyWorkArea)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.KeyWorkAreaID)
                    .HasConstraintName("FK_Attributes_KeyWorkAreas");

                entity.HasOne(d => d.Metric)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.MetricID)
                    .HasConstraintName("FK_Attributes_Metrics");

                entity.HasOne(d => d.Milestone)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.MilestoneID)
                    .HasConstraintName("FK_Attributes_Milestones");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_Attributes_ModifiedByUsers");

                entity.HasOne(d => d.PartnerOrganisation)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.PartnerOrganisationID)
                    .HasConstraintName("FK_Attributes_PartnerOrganisations");

                entity.HasOne(d => d.PartnerOrganisationRisk)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.PartnerOrganisationRiskID)
                    .HasConstraintName("FK_Attributes_PartnerOrganisationRisks");

                entity.HasOne(d => d.PartnerOrganisationRiskMitigationAction)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.PartnerOrganisationRiskMitigationActionID)
                    .HasConstraintName("FK_Attributes_PartnerOrganisationRiskMitigationActions");

                entity.HasOne(d => d.CorporateRisk)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.RiskID)
                    .HasConstraintName("FK_Attributes_Risks");

                entity.HasOne(d => d.CorporateRiskMitigationAction)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.RiskMitigationActionID)
                    .HasConstraintName("FK_Attributes_RiskMitigationActions");

                entity.HasOne(d => d.FinancialRisk)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.RiskID)
                    .HasConstraintName("FK_Attributes_Risks");

                entity.HasOne(d => d.FinancialRiskMitigationAction)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.RiskMitigationActionID)
                    .HasConstraintName("FK_Attributes_RiskMitigationActions");

                entity.HasOne(d => d.WorkStream)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.WorkStreamID)
                    .HasConstraintName("FK_Attributes_WorkStreams");

                entity.HasOne(d => d.Directorate)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.DirectorateID)
                    .HasConstraintName("FK_Attributes_Directorates");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.ProjectID)
                    .HasConstraintName("FK_Attributes_Projects");

                entity.HasOne(d => d.ReportingEntity)
                    .WithMany(p => p.Attributes)
                    .HasForeignKey(d => d.ReportingEntityID)
                    .HasConstraintName("FK_Attributes_ReportingEntities");
            });

            modelBuilder.Entity<AttributeType>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Title).HasMaxLength(50);
            });

            modelBuilder.Entity<Benefit>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.BaselineDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.BenefitTypeID).HasColumnName("BenefitTypeID");

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.ForecastDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.LeadUserID).HasColumnName("LeadUserID");

                entity.Property(e => e.MeasurementUnitID).HasColumnName("MeasurementUnitID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.ProjectID).HasColumnName("ProjectID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.TargetPerformanceLowerLimit).HasColumnType("decimal(18, 4)");

                entity.Property(e => e.TargetPerformanceUpperLimit).HasColumnType("decimal(18, 4)");

                entity.Property(e => e.ReportingStartDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.HasOne(d => d.BenefitType)
                    .WithMany(p => p.Benefits)
                    .HasForeignKey(d => d.BenefitTypeID)
                    .HasConstraintName("FK_Benefits_BenefitTypes");

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.Benefits)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_Benefits_EntityStatuses");

                entity.HasOne(d => d.LeadUser)
                    .WithMany(p => p.BenefitLeadUsers)
                    .HasForeignKey(d => d.LeadUserID)
                    .HasConstraintName("FK_Benefits_Users");

                entity.HasOne(d => d.MeasurementUnit)
                    .WithMany(p => p.Benefits)
                    .HasForeignKey(d => d.MeasurementUnitID)
                    .HasConstraintName("FK_Benefits_MeasurementUnits");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.BenefitModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_Benefits_ModifiedByUsers");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.Benefits)
                    .HasForeignKey(d => d.ProjectID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Benefits_Projects");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.Benefits)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_Benefits_RagOptions");
            });

            modelBuilder.Entity<BenefitType>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<BenefitUpdate>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.ActualDate).HasColumnType("date");

                entity.Property(e => e.BenefitID).HasColumnName("BenefitID");

                entity.Property(e => e.Comment).HasMaxLength(500);

                entity.Property(e => e.CurrentPerformance).HasColumnType("decimal(18, 4)");

                entity.Property(e => e.ForecastDate).HasColumnType("date");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.SignOffID).HasColumnName("SignOffID");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.UpdatePeriod).HasColumnType("date");

                entity.Property(e => e.UpdateUserID).HasColumnName("UpdateUserID");

                entity.HasOne(d => d.Benefit)
                    .WithMany(p => p.BenefitUpdates)
                    .HasForeignKey(d => d.BenefitID)
                    .HasConstraintName("FK_BenefitUpdates_Benefits");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.BenefitUpdates)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_BenefitUpdates_RagOptions");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.BenefitUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_BenefitUpdates_SignOffs");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.BenefitUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_BenefitUpdates_Users");
            });

            modelBuilder.Entity<Commitment>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.ActualDate).HasColumnType("date");

                entity.Property(e => e.BaselineDate).HasColumnType("date");

                entity.Property(e => e.DirectorateID).HasColumnName("DirectorateID");

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.ForecastDate).HasColumnType("date");

                entity.Property(e => e.LeadUserID).HasColumnName("LeadUserID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.ReportingStartDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.HasOne(d => d.Directorate)
                    .WithMany(p => p.Commitments)
                    .HasForeignKey(d => d.DirectorateID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Commitments_Directorates");

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.Commitments)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_Commitments_EntityStatuses");

                entity.HasOne(d => d.LeadUser)
                    .WithMany(p => p.CommitmentLeadUsers)
                    .HasForeignKey(d => d.LeadUserID)
                    .HasConstraintName("FK_Commitments_Users");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.CommitmentModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_Commitments_ModifiedByUsers");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.Commitments)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_Commitments_RagOptions");
            });

            modelBuilder.Entity<CommitmentUpdate>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.ActualDate).HasColumnType("date");

                entity.Property(e => e.Comment).HasMaxLength(500);

                entity.Property(e => e.CommitmentID).HasColumnName("CommitmentID");

                entity.Property(e => e.ForecastDate).HasColumnType("date");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.SignOffID).HasColumnName("SignOffID");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.UpdatePeriod).HasColumnType("date");

                entity.Property(e => e.UpdateUserID).HasColumnName("UpdateUserID");

                entity.HasOne(d => d.Commitment)
                    .WithMany(p => p.CommitmentUpdates)
                    .HasForeignKey(d => d.CommitmentID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CommitmentUpdates_Commitments");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.CommitmentUpdates)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_CommitmentUpdates_RagOptions");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.CommitmentUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_CommitmentUpdates_SignOffs");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.CommitmentUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_CommitmentUpdates_Users");
            });

            modelBuilder.Entity<Contributor>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.BenefitID).HasColumnName("BenefitID");

                entity.Property(e => e.CommitmentID).HasColumnName("CommitmentID");

                entity.Property(e => e.ContributorUserID).HasColumnName("ContributorUserID");

                entity.Property(e => e.DependencyID).HasColumnName("DependencyID");

                entity.Property(e => e.KeyWorkAreaID).HasColumnName("KeyWorkAreaID");

                entity.Property(e => e.MetricID).HasColumnName("MetricID");

                entity.Property(e => e.MilestoneID).HasColumnName("MilestoneID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.PartnerOrganisationID).HasColumnName("PartnerOrganisationID");

                entity.Property(e => e.PartnerOrganisationRiskID).HasColumnName("PartnerOrganisationRiskID");

                entity.Property(e => e.PartnerOrganisationRiskMitigationActionID).HasColumnName("PartnerOrganisationRiskMitigationActionID");

                entity.Property(e => e.RiskID).HasColumnName("RiskID");

                entity.Property(e => e.RiskMitigationActionID).HasColumnName("RiskMitigationActionID");

                entity.Property(e => e.Title).HasMaxLength(50);

                entity.Property(e => e.WorkStreamID).HasColumnName("WorkStreamID");

                entity.HasOne(d => d.Benefit)
                    .WithMany(p => p.Contributors)
                    .HasForeignKey(d => d.BenefitID)
                    .HasConstraintName("FK_Contributors_Benefits");

                entity.HasOne(d => d.Commitment)
                    .WithMany(p => p.Contributors)
                    .HasForeignKey(d => d.CommitmentID)
                    .HasConstraintName("FK_Contributors_Commitments");

                entity.HasOne(d => d.ContributorUser)
                    .WithMany(p => p.ContributorContributorUsers)
                    .HasForeignKey(d => d.ContributorUserID)
                    .HasConstraintName("FK_Contributors_Users");

                entity.HasOne(d => d.CorporateRisk)
                    .WithMany(p => p.Contributors)
                    .HasForeignKey(d => d.RiskID)
                    .HasConstraintName("FK_Contributors_Risks");

                entity.HasOne(d => d.CorporateRiskMitigationAction)
                    .WithMany(p => p.Contributors)
                    .HasForeignKey(d => d.RiskMitigationActionID)
                    .HasConstraintName("FK_Contributors_RiskMitigationActions");

                entity.HasOne(d => d.Dependency)
                    .WithMany(p => p.Contributors)
                    .HasForeignKey(d => d.DependencyID)
                    .HasConstraintName("FK_Contributors_Dependencies");

                entity.HasOne(d => d.FinancialRisk)
                    .WithMany(p => p.Contributors)
                    .HasForeignKey(d => d.RiskID)
                    .HasConstraintName("FK_Contributors_Risks");

                entity.HasOne(d => d.FinancialRiskMitigationAction)
                    .WithMany(p => p.Contributors)
                    .HasForeignKey(d => d.RiskMitigationActionID)
                    .HasConstraintName("FK_Contributors_RiskMitigationActions");

                entity.HasOne(d => d.KeyWorkArea)
                    .WithMany(p => p.Contributors)
                    .HasForeignKey(d => d.KeyWorkAreaID)
                    .HasConstraintName("FK_Contributors_KeyWorkAreas");

                entity.HasOne(d => d.Metric)
                    .WithMany(p => p.Contributors)
                    .HasForeignKey(d => d.MetricID)
                    .HasConstraintName("FK_Contributors_Metrics");

                entity.HasOne(d => d.Milestone)
                    .WithMany(p => p.Contributors)
                    .HasForeignKey(d => d.MilestoneID)
                    .HasConstraintName("FK_Contributors_Milestones");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.ContributorModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_Contributors_ModifiedByUsers");

                entity.HasOne(d => d.PartnerOrganisation)
                    .WithMany(p => p.Contributors)
                    .HasForeignKey(d => d.PartnerOrganisationID)
                    .HasConstraintName("FK_Contributors_PartnerOrganisations");

                entity.HasOne(d => d.PartnerOrganisationRisk)
                    .WithMany(p => p.Contributors)
                    .HasForeignKey(d => d.PartnerOrganisationRiskID)
                    .HasConstraintName("FK_Contributors_PartnerOrganisationRisks");

                entity.HasOne(d => d.PartnerOrganisationRiskMitigationAction)
                    .WithMany(p => p.Contributors)
                    .HasForeignKey(d => d.PartnerOrganisationRiskMitigationActionID)
                    .HasConstraintName("FK_Contributors_PartnerOrganisationRiskMitigationActions");

                entity.HasOne(d => d.WorkStream)
                    .WithMany(p => p.Contributors)
                    .HasForeignKey(d => d.WorkStreamID)
                    .HasConstraintName("FK_Contributors_WorkStreams");
            });

            modelBuilder.Entity<CustomReportingEntity>(entity =>
            {
                entity.ToTable("ReportingEntities");

                entity.Property(d => d.ID).HasColumnName("ID");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("datetime2(0)")
                    .HasDefaultValueSql("(getutcdate())");

                entity.Property(e => e.TargetPerformanceLowerLimit).HasColumnType("decimal(18, 4)");

                entity.Property(e => e.TargetPerformanceUpperLimit).HasColumnType("decimal(18, 4)");

                entity.Property(e => e.Properties).HasJsonConversion<IDictionary<string, object>>();

                entity.HasOne(d => d.LeadUser)
                    .WithMany(p => p.ReportingEntityLeadUsers)
                    .HasForeignKey(d => d.LeadUserID)
                    .HasConstraintName("FK_ReportingEntities_LeadUsers");

                entity.HasOne(d => d.ReportingEntityType)
                    .WithMany(p => p.ReportingEntities)
                    .HasForeignKey(d => d.ReportingEntityTypeID)
                    .HasConstraintName("FK_ReportingEntities_ReportingEntityTypes");

                entity.HasOne(d => d.Directorate)
                    .WithMany(p => p.ReportingEntities)
                    .HasForeignKey(d => d.DirectorateID)
                    .HasConstraintName("FK_ReportingEntities_Directorates");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.ReportingEntities)
                    .HasForeignKey(d => d.ProjectID)
                    .HasConstraintName("FK_ReportingEntities_Projects");

                entity.HasOne(d => d.PartnerOrganisation)
                    .WithMany(p => p.ReportingEntities)
                    .HasForeignKey(d => d.PartnerOrganisationID)
                    .HasConstraintName("FK_ReportingEntities_PartnerOrganisations");
            });

            modelBuilder.Entity<CustomReportingEntityType>(entity =>
            {
                entity.ToTable("ReportingEntityTypes");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("datetime2(0)")
                    .HasDefaultValueSql("(getutcdate())");

                entity.HasOne(d => d.ReportType)
                    .WithMany(p => p.ReportingEntityTypes)
                    .HasForeignKey(d => d.ReportTypeID)
                    .HasConstraintName("FK_ReportingEntityTypes_ReportTypes");

                entity.Property(e => e.CustomFields).HasConversion(
                    v => JsonSerializer.Serialize(v, new JsonSerializerOptions { PropertyNameCaseInsensitive = true, IgnoreNullValues = true }),
                    v => JsonSerializer.Deserialize<ICollection<ReportingField>>(v, new JsonSerializerOptions { PropertyNameCaseInsensitive = true, IgnoreNullValues = true }),
                    new ValueComparer<ICollection<ReportingField>>(
                        (c1, c2) => c1.SequenceEqual(c2),
                        c => c.Aggregate(0, (a, v) => HashCode.Combine(a, v.GetHashCode())),
                        c => (ICollection<ReportingField>)c.ToHashSet()));
            });

            modelBuilder.Entity<CustomReportingEntityUpdate>(entity =>
            {
                entity.ToTable("ReportingEntityUpdates");

                entity.Property(e => e.CurrentPerformance).HasColumnType("decimal(18, 4)");

                entity.HasOne(d => d.ReportingEntity)
                    .WithMany(p => p.ReportingEntityUpdates)
                    .HasForeignKey(d => d.ReportingEntityID)
                    .HasConstraintName("FK_ReportingEntityUpdates_ReportingEntities");
            });

            modelBuilder.Entity<DepartmentalObjective>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Title).HasMaxLength(255);
            });

            modelBuilder.Entity<Dependency>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.LeadUserID).HasColumnName("LeadUserID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.ProjectID).HasColumnName("ProjectID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.ReportingStartDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.ThirdParty).HasMaxLength(255);

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.Property(e => e.StartDate).HasColumnType("date");

                entity.Property(e => e.EndDate).HasColumnType("date");

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.Dependencies)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_Dependencies_EntityStatuses");

                entity.HasOne(d => d.LeadUser)
                    .WithMany(p => p.DependencyLeadUsers)
                    .HasForeignKey(d => d.LeadUserID)
                    .HasConstraintName("FK_Dependencies_Users");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.DependencyModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_Dependencies_ModifiedByUsers");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.Dependencies)
                    .HasForeignKey(d => d.ProjectID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Dependencies_Projects");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.Dependencies)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_Dependencies_RagOptions");
            });

            modelBuilder.Entity<DependencyUpdate>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Comment).HasMaxLength(500);

                entity.Property(e => e.DependencyID).HasColumnName("DependencyID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.SignOffID).HasColumnName("SignOffID");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.UpdatePeriod).HasColumnType("date");

                entity.Property(e => e.UpdateUserID).HasColumnName("UpdateUserID");

                entity.HasOne(d => d.Dependency)
                    .WithMany(p => p.DependencyUpdates)
                    .HasForeignKey(d => d.DependencyID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_DependencyUpdates_Dependencies");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.DependencyUpdates)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_DependencyUpdates_RagOptions");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.DependencyUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_DependencyUpdates_SignOffs");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.DependencyUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_DependencyUpdates_Users");
            });

            modelBuilder.Entity<Directorate>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.DirectorUserID).HasColumnName("DirectorUserID");

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.GroupID).HasColumnName("GroupID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.ReportApproverUserID).HasColumnName("ReportApproverUserID");

                entity.Property(e => e.ReportingLeadUserID).HasColumnName("ReportingLeadUserID");

                entity.Property(e => e.ReportingStartDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Objectives).HasMaxLength(10000);

                entity.HasOne(d => d.DirectorUser)
                    .WithMany(p => p.DirectorateDirectorUsers)
                    .HasForeignKey(d => d.DirectorUserID)
                    .HasConstraintName("FK_Directorates_Users");

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.Directorates)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_Directorates_EntityStatuses");

                entity.HasOne(d => d.Group)
                    .WithMany(p => p.Directorates)
                    .HasForeignKey(d => d.GroupID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Directorates_Groups");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.DirectorateModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_Directorates_ModifiedByUsers");

                entity.HasOne(d => d.ReportApproverUser)
                    .WithMany(p => p.DirectorateReportApproverUsers)
                    .HasForeignKey(d => d.ReportApproverUserID)
                    .HasConstraintName("FK_Directorates_ReportApproverUsers");

                entity.HasOne(d => d.ReportingLeadUser)
                    .WithMany(p => p.DirectorateReportingLeadUsers)
                    .HasForeignKey(d => d.ReportingLeadUserID)
                    .HasConstraintName("FK_Directorates_ReportingLeadUsers");
            });

            modelBuilder.Entity<DirectorateUpdate>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Comment).HasMaxLength(50);

                entity.Property(e => e.DirectorateID).HasColumnName("DirectorateID");

                entity.Property(e => e.Escalations).HasMaxLength(500);

                entity.Property(e => e.FinanceComment).HasMaxLength(500);

                entity.Property(e => e.FinanceRagOptionID).HasColumnName("FinanceRagOptionID");

                entity.Property(e => e.FutureActions).HasMaxLength(500);

                entity.Property(e => e.MetricsComment).HasMaxLength(500);

                entity.Property(e => e.MetricsRagOptionID).HasColumnName("MetricsRagOptionID");

                entity.Property(e => e.MilestonesComment).HasMaxLength(500);

                entity.Property(e => e.MilestonesRagOptionID).HasColumnName("MilestonesRagOptionID");

                entity.Property(e => e.OverallRagOptionID).HasColumnName("OverallRagOptionID");

                entity.Property(e => e.PeopleComment).HasMaxLength(500);

                entity.Property(e => e.PeopleRagOptionID).HasColumnName("PeopleRagOptionID");

                entity.Property(e => e.ProgressUpdate).HasMaxLength(500);

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.SignOffID).HasColumnName("SignOffID");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.UpdatePeriod).HasColumnType("date");

                entity.Property(e => e.UpdateUserID).HasColumnName("UpdateUserID");

                entity.HasOne(d => d.Directorate)
                    .WithMany(p => p.DirectorateUpdates)
                    .HasForeignKey(d => d.DirectorateID)
                    .HasConstraintName("FK_DirectorateUpdates_Directorates");

                entity.HasOne(d => d.FinanceRagOption)
                    .WithMany(p => p.DirectorateUpdateFinanceRagOptions)
                    .HasForeignKey(d => d.FinanceRagOptionID)
                    .HasConstraintName("FK_DirectorateUpdates_RagOptionFinance");

                entity.HasOne(d => d.MetricsRagOption)
                    .WithMany(p => p.DirectorateUpdateMetricsRagOptions)
                    .HasForeignKey(d => d.MetricsRagOptionID)
                    .HasConstraintName("FK_DirectorateUpdates_RagOptionMetric");

                entity.HasOne(d => d.MilestonesRagOption)
                    .WithMany(p => p.DirectorateUpdateMilestonesRagOptions)
                    .HasForeignKey(d => d.MilestonesRagOptionID)
                    .HasConstraintName("FK_DirectorateUpdates_RagOptionMilestone");

                entity.HasOne(d => d.OverallRagOption)
                    .WithMany(p => p.DirectorateUpdateOverallRagOptions)
                    .HasForeignKey(d => d.OverallRagOptionID)
                    .HasConstraintName("FK_DirectorateUpdates_RagOptionOverall");

                entity.HasOne(d => d.PeopleRagOption)
                    .WithMany(p => p.DirectorateUpdatePeopleRagOptions)
                    .HasForeignKey(d => d.PeopleRagOptionID)
                    .HasConstraintName("FK_DirectorateUpdates_RagOptionPeople");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.DirectorateUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_DirectorateUpdates_SignOffs");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.DirectorateUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_DirectorateUpdates_Users");
            });

            modelBuilder.Entity<EntityStatus>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Title).HasMaxLength(50);
            });

            modelBuilder.Entity<Group>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.BusinessPartnerUserID).HasColumnName("BusinessPartnerUserID");

                entity.Property(e => e.DirectorGeneralUserID).HasColumnName("DirectorGeneralUserID");

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.RiskChampionDeputyDirectorUserID).HasColumnName("RiskChampionDeputyDirectorUserID");

                entity.Property(e => e.Title).HasMaxLength(50);

                entity.HasOne(d => d.BusinessPartnerUser)
                    .WithMany(p => p.GroupBusinessPartnerUsers)
                    .HasForeignKey(d => d.BusinessPartnerUserID)
                    .HasConstraintName("FK_Groups_BusinessPartnerUsers");

                entity.HasOne(d => d.DirectorGeneralUser)
                    .WithMany(p => p.GroupDirectorGeneralUsers)
                    .HasForeignKey(d => d.DirectorGeneralUserID)
                    .HasConstraintName("FK_Groups_Users");

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.Groups)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_Groups_EntityStatuses");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.GroupModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_Groups_ModifiedByUsers");

                entity.HasOne(d => d.RiskChampionDeputyDirectorUser)
                    .WithMany(p => p.GroupRiskChampionDeputyDirectorUsers)
                    .HasForeignKey(d => d.RiskChampionDeputyDirectorUserID)
                    .HasConstraintName("FK_Groups_RiskChampionUsers");
            });

            modelBuilder.Entity<KeyWorkArea>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.DirectorateID).HasColumnName("DirectorateID");

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.LeadUserID).HasColumnName("LeadUserID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.ReportingStartDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.HasOne(d => d.Directorate)
                    .WithMany(p => p.KeyWorkAreas)
                    .HasForeignKey(d => d.DirectorateID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_KeyWorkAreas_Directorates");

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.KeyWorkAreas)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_KeyWorkAreas_EntityStatuses");

                entity.HasOne(d => d.LeadUser)
                    .WithMany(p => p.KeyWorkAreaLeadUsers)
                    .HasForeignKey(d => d.LeadUserID)
                    .HasConstraintName("FK_KeyWorkAreas_Users");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.KeyWorkAreaModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_KeyWorkAreas_ModifiedByUsers");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.KeyWorkAreas)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_KeyWorkAreas_RagOptions");
            });

            modelBuilder.Entity<KeyWorkAreaUpdate>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Comment).HasMaxLength(500);

                entity.Property(e => e.KeyWorkAreaID).HasColumnName("KeyWorkAreaID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.SignOffID).HasColumnName("SignOffID");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.UpdatePeriod).HasColumnType("date");

                entity.Property(e => e.UpdateUserID).HasColumnName("UpdateUserID");

                entity.HasOne(d => d.KeyWorkArea)
                    .WithMany(p => p.KeyWorkAreaUpdates)
                    .HasForeignKey(d => d.KeyWorkAreaID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_KeyWorkAreaUpdates_KeyWorkAreas");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.KeyWorkAreaUpdates)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_KeyWorkAreaUpdates_RagOptions");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.KeyWorkAreaUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_KeyWorkAreaUpdates_SignOffs");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.KeyWorkAreaUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_KeyWorkAreaUpdates_Users");
            });

            modelBuilder.Entity<MeasurementUnit>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Title).HasMaxLength(50);
            });

            modelBuilder.Entity<Metric>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.DirectorateID).HasColumnName("DirectorateID");

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.LeadUserID).HasColumnName("LeadUserID");

                entity.Property(e => e.MeasurementUnitID).HasColumnName("MeasurementUnitID");

                entity.Property(e => e.MetricCode).HasMaxLength(255);

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.ReportingStartDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.TargetPerformanceLowerLimit).HasColumnType("decimal(18, 4)");

                entity.Property(e => e.TargetPerformanceUpperLimit).HasColumnType("decimal(18, 4)");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.HasOne(d => d.Directorate)
                    .WithMany(p => p.Metrics)
                    .HasForeignKey(d => d.DirectorateID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Metrics_Directorates");

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.Metrics)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_Metrics_EntityStatuses");

                entity.HasOne(d => d.LeadUser)
                    .WithMany(p => p.MetricLeadUsers)
                    .HasForeignKey(d => d.LeadUserID)
                    .HasConstraintName("FK_Metrics_Users");

                entity.HasOne(d => d.MeasurementUnit)
                    .WithMany(p => p.Metrics)
                    .HasForeignKey(d => d.MeasurementUnitID)
                    .HasConstraintName("FK_Metrics_MeasurementUnits");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.MetricModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_Metrics_ModifiedByUsers");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.Metrics)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_Metrics_RagOptions");
            });

            modelBuilder.Entity<MetricUpdate>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Comment).HasMaxLength(500);

                entity.Property(e => e.CurrentPerformance).HasColumnType("decimal(18, 4)");

                entity.Property(e => e.MetricID).HasColumnName("MetricID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.SignOffID).HasColumnName("SignOffID");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.UpdatePeriod).HasColumnType("date");

                entity.Property(e => e.UpdateUserID).HasColumnName("UpdateUserID");

                entity.HasOne(d => d.Metric)
                    .WithMany(p => p.MetricUpdates)
                    .HasForeignKey(d => d.MetricID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_MetricUpdates_Metrics");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.MetricUpdates)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_MetricUpdates_RagOptions");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.MetricUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_MetricUpdates_SignOffs");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.MetricUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_MetricUpdates_Users");
            });

            modelBuilder.Entity<Milestone>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.ActualDate).HasColumnType("datetime");

                entity.Property(e => e.BaselineDate).HasColumnType("datetime");

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.ForecastDate).HasColumnType("datetime");

                entity.Property(e => e.KeyWorkAreaID).HasColumnName("KeyWorkAreaID");

                entity.Property(e => e.LeadUserID).HasColumnName("LeadUserID");

                entity.Property(e => e.MilestoneCode).HasMaxLength(255);

                entity.Property(e => e.MilestoneTypeID).HasColumnName("MilestoneTypeID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.PartnerOrganisationID).HasColumnName("PartnerOrganisationID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.StartDate).HasColumnType("datetime");

                entity.Property(e => e.ReportingStartDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.WorkStreamID).HasColumnName("WorkStreamID");

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.Milestones)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_Milestones_EntityStatuses");

                entity.HasOne(d => d.KeyWorkArea)
                    .WithMany(p => p.Milestones)
                    .HasForeignKey(d => d.KeyWorkAreaID)
                    .HasConstraintName("FK_Milestones_KeyWorkAreas");

                entity.HasOne(d => d.LeadUser)
                    .WithMany(p => p.MilestoneLeadUsers)
                    .HasForeignKey(d => d.LeadUserID)
                    .HasConstraintName("FK_Milestones_Users");

                entity.HasOne(d => d.MilestoneType)
                    .WithMany(p => p.Milestones)
                    .HasForeignKey(d => d.MilestoneTypeID)
                    .HasConstraintName("FK_Milestones_MilestoneTypes");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.MilestoneModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_Milestones_ModifiedByUsers");

                entity.HasOne(d => d.PartnerOrganisation)
                    .WithMany(p => p.Milestones)
                    .HasForeignKey(d => d.PartnerOrganisationID)
                    .HasConstraintName("FK_Milestones_PartnerOrganisations");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.Milestones)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_Milestones_RagOptions");

                entity.HasOne(d => d.WorkStream)
                    .WithMany(p => p.Milestones)
                    .HasForeignKey(d => d.WorkStreamID)
                    .HasConstraintName("FK_Milestones_WorkStreams");
            });

            modelBuilder.Entity<MilestoneType>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<MilestoneUpdate>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Comment).HasMaxLength(500);

                entity.Property(e => e.MilestoneID).HasColumnName("MilestoneID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.SignOffID).HasColumnName("SignOffID");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.UpdatePeriod).HasColumnType("date");

                entity.Property(e => e.UpdateUserID).HasColumnName("UpdateUserID");

                entity.HasOne(d => d.Milestone)
                    .WithMany(p => p.MilestoneUpdates)
                    .HasForeignKey(d => d.MilestoneID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_MilestoneUpdates_Milestones");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.MilestoneUpdates)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_MilestoneUpdates_RagOptions");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.MilestoneUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_MilestoneUpdates_SignOffs");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.MilestoneUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_MilestoneUpdates_Users");
            });

            modelBuilder.Entity<PartnerOrganisation>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.DirectorateID).HasColumnName("DirectorateID");

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.LeadPolicySponsorUserID).HasColumnName("LeadPolicySponsorUserID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.ReportAuthorUserID).HasColumnName("ReportAuthorUserID");

                entity.Property(e => e.ReportingStartDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.Objectives).HasMaxLength(10000);

                entity.HasOne(d => d.Directorate)
                    .WithMany(p => p.PartnerOrganisations)
                    .HasForeignKey(d => d.DirectorateID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PartnerOrganisations_Directorates");

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.PartnerOrganisations)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_PartnerOrganisations_EntityStatuses");

                entity.HasOne(d => d.LeadPolicySponsorUser)
                    .WithMany(p => p.PartnerOrganisationLeadPolicySponsorUsers)
                    .HasForeignKey(d => d.LeadPolicySponsorUserID)
                    .HasConstraintName("FK_PartnerOrganisations_LeadPolicySponsorUsers");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.PartnerOrganisationModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_PartnerOrganisations_Users");

                entity.HasOne(d => d.ReportAuthorUser)
                    .WithMany(p => p.PartnerOrganisationReportAuthorUsers)
                    .HasForeignKey(d => d.ReportAuthorUserID)
                    .HasConstraintName("FK_PartnerOrganisations_ReportAuthorUsers");
            });

            modelBuilder.Entity<PartnerOrganisationRisk>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.BeisRiskAppetiteID).HasColumnName("BeisRiskAppetiteID");

                entity.Property(e => e.BeisRiskOwnerUserID).HasColumnName("BeisRiskOwnerUserID");

                entity.Property(e => e.BEISTargetRiskImpactLevelID).HasColumnName("BEISTargetRiskImpactLevelID");

                entity.Property(e => e.BEISTargetRiskProbabilityID).HasColumnName("BEISTargetRiskProbabilityID");

                entity.Property(e => e.BEISUnmitigatedRiskImpactLevelID).HasColumnName("BEISUnmitigatedRiskImpactLevelID");

                entity.Property(e => e.BEISUnmitigatedRiskProbabilityID).HasColumnName("BEISUnmitigatedRiskProbabilityID");

                entity.Property(e => e.DepartmentalObjectiveID).HasColumnName("DepartmentalObjectiveID");

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.PartnerOrganisationID).HasColumnName("PartnerOrganisationID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.RiskAppetiteID).HasColumnName("RiskAppetiteID");

                entity.Property(e => e.RiskCauseDescription).HasMaxLength(600);

                entity.Property(e => e.RiskCode).HasMaxLength(50);

                entity.Property(e => e.RiskEventDescription).HasMaxLength(600);

                entity.Property(e => e.RiskImpactDescription).HasMaxLength(600);

                entity.Property(e => e.RiskOwnerUserID).HasColumnName("RiskOwnerUserID");

                entity.Property(e => e.RiskProximity).HasColumnType("date");

                entity.Property(e => e.ReportingStartDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.TargetRiskImpactLevelID).HasColumnName("TargetRiskImpactLevelID");

                entity.Property(e => e.TargetRiskProbabilityID).HasColumnName("TargetRiskProbabilityID");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.UnmitigatedRiskImpactLevelID).HasColumnName("UnmitigatedRiskImpactLevelID");

                entity.Property(e => e.UnmitigatedRiskProbabilityID).HasColumnName("UnmitigatedRiskProbabilityID");

                entity.HasOne(d => d.BeisRiskAppetite)
                    .WithMany(p => p.PartnerOrganisationRiskBeisRiskAppetites)
                    .HasForeignKey(d => d.BeisRiskAppetiteID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_BeisRiskAppetites");

                entity.HasOne(d => d.BeisRiskOwnerUser)
                    .WithMany(p => p.PartnerOrganisationRiskBeisRiskOwnerUsers)
                    .HasForeignKey(d => d.BeisRiskOwnerUserID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_BeisUsers");

                entity.HasOne(d => d.BEISTargetRiskImpactLevel)
                    .WithMany(p => p.PartnerOrganisationRiskBeistargetRiskImpactLevels)
                    .HasForeignKey(d => d.BEISTargetRiskImpactLevelID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_BEISTargetRiskImpactLevels");

                entity.HasOne(d => d.BEISTargetRiskProbability)
                    .WithMany(p => p.PartnerOrganisationRiskBeistargetRiskProbabilities)
                    .HasForeignKey(d => d.BEISTargetRiskProbabilityID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_BEISTargetRiskProbabilities");

                entity.HasOne(d => d.BEISUnmitigatedRiskImpactLevel)
                    .WithMany(p => p.PartnerOrganisationRiskBeisunmitigatedRiskImpactLevels)
                    .HasForeignKey(d => d.BEISUnmitigatedRiskImpactLevelID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_BEISUnmitigatedRiskImpactLevels");

                entity.HasOne(d => d.BEISUnmitigatedRiskProbability)
                    .WithMany(p => p.PartnerOrganisationRiskBeisunmitigatedRiskProbabilities)
                    .HasForeignKey(d => d.BEISUnmitigatedRiskProbabilityID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_BEISUnmitigatedRiskProbabilities");

                entity.HasOne(d => d.DepartmentalObjective)
                    .WithMany(p => p.PartnerOrganisationRisks)
                    .HasForeignKey(d => d.DepartmentalObjectiveID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_DepartmentalObjectives");

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.PartnerOrganisationRisks)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_EntityStatuses");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.PartnerOrganisationRiskModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_ModifiedByUsers");

                entity.HasOne(d => d.PartnerOrganisation)
                    .WithMany(p => p.PartnerOrganisationRisks)
                    .HasForeignKey(d => d.PartnerOrganisationID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PartnerOrganisationRisks_PartnerOrganisations");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.PartnerOrganisationRisks)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_RagOptions");

                entity.HasOne(d => d.RiskAppetite)
                    .WithMany(p => p.PartnerOrganisationRiskRiskAppetites)
                    .HasForeignKey(d => d.RiskAppetiteID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_RiskAppetites");

                entity.HasOne(d => d.RiskOwnerUser)
                    .WithMany(p => p.PartnerOrganisationRiskRiskOwnerUsers)
                    .HasForeignKey(d => d.RiskOwnerUserID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_Users");

                entity.HasOne(d => d.TargetRiskImpactLevel)
                    .WithMany(p => p.PartnerOrganisationRiskTargetRiskImpactLevels)
                    .HasForeignKey(d => d.TargetRiskImpactLevelID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_TargetRiskImpactLevels");

                entity.HasOne(d => d.TargetRiskProbability)
                    .WithMany(p => p.PartnerOrganisationRiskTargetRiskProbabilities)
                    .HasForeignKey(d => d.TargetRiskProbabilityID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_TargetRiskProbabilities");

                entity.HasOne(d => d.UnmitigatedRiskImpactLevel)
                    .WithMany(p => p.PartnerOrganisationRiskUnmitigatedRiskImpactLevels)
                    .HasForeignKey(d => d.UnmitigatedRiskImpactLevelID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_UnmitigatedRiskImpactLevels");

                entity.HasOne(d => d.UnmitigatedRiskProbability)
                    .WithMany(p => p.PartnerOrganisationRiskUnmitigatedRiskProbabilities)
                    .HasForeignKey(d => d.UnmitigatedRiskProbabilityID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_UnmitigatedRiskProbabilities");

                entity.HasOne(d => d.LeadUser)
                    .WithMany(p => p.PartnerOrganisationRiskLeadUsers)
                    .HasForeignKey(d => d.LeadUserID)
                    .HasConstraintName("FK_PartnerOrganisationRisks_LeadUsers");
            });

            modelBuilder.Entity<PartnerOrganisationRiskMitigationAction>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.ActualDate).HasColumnType("date");

                entity.Property(e => e.BaselineDate).HasColumnType("date");

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.ForecastDate).HasColumnType("date");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.OwnerUserID).HasColumnName("OwnerUserID");

                entity.Property(e => e.PartnerOrganisationRiskID).HasColumnName("PartnerOrganisationRiskID");

                entity.Property(e => e.ReportingStartDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.Title).HasMaxLength(200);

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.PartnerOrganisationRiskMitigationActions)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_PartnerOrganisationRiskMitigationActions_EntityStatuses");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.PartnerOrganisationRiskMitigationActionModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_PartnerOrganisationRiskMitigationActions_ModifiedByUsers");

                entity.HasOne(d => d.OwnerUser)
                    .WithMany(p => p.PartnerOrganisationRiskMitigationActionOwnerUsers)
                    .HasForeignKey(d => d.OwnerUserID)
                    .HasConstraintName("FK_PartnerOrganisationRiskMitigationActions_Users");

                entity.HasOne(d => d.PartnerOrganisationRisk)
                    .WithMany(p => p.PartnerOrganisationRiskMitigationActions)
                    .HasForeignKey(d => d.PartnerOrganisationRiskID)
                    .HasConstraintName("FK_PartnerOrganisationRiskMitigationActions_PartnerOrganisationRisks");
            });

            modelBuilder.Entity<PartnerOrganisationRiskMitigationActionUpdate>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.ActualDate).HasColumnType("date");

                entity.Property(e => e.Comment).HasMaxLength(500);

                entity.Property(e => e.ForecastDate).HasColumnType("date");

                entity.Property(e => e.PartnerOrganisationRiskMitigationActionID).HasColumnName("PartnerOrganisationRiskMitigationActionID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.SignOffID).HasColumnName("SignOffID");

                entity.Property(e => e.Title).HasMaxLength(500);

                entity.Property(e => e.UpdatePeriod).HasColumnType("date");

                entity.Property(e => e.UpdateUserID).HasColumnName("UpdateUserID");

                entity.HasOne(d => d.PartnerOrganisationRiskMitigationAction)
                    .WithMany(p => p.PartnerOrganisationRiskMitigationActionUpdates)
                    .HasForeignKey(d => d.PartnerOrganisationRiskMitigationActionID)
                    .HasConstraintName("FK_PartnerOrganisationRiskMitigationActionUpdates_PartnerOrganisationRiskMitigationActions");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.PartnerOrganisationRiskMitigationActionUpdates)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_PartnerOrganisationRiskMitigationActionUpdates_RagOptions");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.PartnerOrganisationRiskMitigationActionUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_PartnerOrganisationRiskMitigationActionUpdates_SignOffs");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.PartnerOrganisationRiskMitigationActionUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_PartnerOrganisationRiskMitigationActionUpdates_Users");
            });

            modelBuilder.Entity<PartnerOrganisationRiskRiskType>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.PartnerOrganisationRiskID).HasColumnName("PartnerOrganisationRiskID");

                entity.Property(e => e.RiskTypeID).HasColumnName("RiskTypeID");

                entity.Property(e => e.Title).HasMaxLength(50);

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.PartnerOrganisationRiskRiskTypes)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_PartnerOrganisationRiskRiskTypes_Users");

                entity.HasOne(d => d.PartnerOrganisationRisk)
                    .WithMany(p => p.PartnerOrganisationRiskRiskTypes)
                    .HasForeignKey(d => d.PartnerOrganisationRiskID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PartnerOrganisationRiskRiskTypes_PartnerOrganisationRisks");

                entity.HasOne(d => d.RiskType)
                    .WithMany(p => p.PartnerOrganisationRiskRiskTypes)
                    .HasForeignKey(d => d.RiskTypeID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PartnerOrganisationRiskRiskTypes_RiskTypes");
            });

            modelBuilder.Entity<PartnerOrganisationRiskUpdate>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.BeisRagOptionID).HasColumnName("BeisRagOptionID");

                entity.Property(e => e.BeisRiskImpactLevelID).HasColumnName("BeisRiskImpactLevelID");

                entity.Property(e => e.BeisRiskProbabilityID).HasColumnName("BeisRiskProbabilityID");

                entity.Property(e => e.Comment).HasMaxLength(500);

                entity.Property(e => e.PartnerOrganisationRiskID).HasColumnName("PartnerOrganisationRiskID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.RiskImpactLevelID).HasColumnName("RiskImpactLevelID");

                entity.Property(e => e.RiskProbabilityID).HasColumnName("RiskProbabilityID");

                entity.Property(e => e.RiskProximity).HasColumnType("date");

                entity.Property(e => e.SignOffID).HasColumnName("SignOffID");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.UpdatePeriod).HasColumnType("date");

                entity.Property(e => e.UpdateUserID).HasColumnName("UpdateUserID");

                entity.HasOne(d => d.BeisRagOption)
                    .WithMany(p => p.PartnerOrganisationRiskUpdateBeisRagOptions)
                    .HasForeignKey(d => d.BeisRagOptionID)
                    .HasConstraintName("FK_PartnerOrganisationRiskUpdates_BeisRagOptions");

                entity.HasOne(d => d.BeisRiskImpactLevel)
                    .WithMany(p => p.PartnerOrganisationRiskUpdateBeisRiskImpactLevels)
                    .HasForeignKey(d => d.BeisRiskImpactLevelID)
                    .HasConstraintName("FK_PartnerOrganisationRiskUpdates_BeisRiskImpactLevels");

                entity.HasOne(d => d.BeisRiskProbability)
                    .WithMany(p => p.PartnerOrganisationRiskUpdateBeisRiskProbabilities)
                    .HasForeignKey(d => d.BeisRiskProbabilityID)
                    .HasConstraintName("FK_PartnerOrganisationRiskUpdates_BeisRiskProbabilities");

                entity.HasOne(d => d.PartnerOrganisationRisk)
                    .WithMany(p => p.PartnerOrganisationRiskUpdates)
                    .HasForeignKey(d => d.PartnerOrganisationRiskID)
                    .HasConstraintName("FK_PartnerOrganisationRiskUpdates_PartnerOrganisationRisks");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.PartnerOrganisationRiskUpdateRagOptions)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_PartnerOrganisationRiskUpdates_RagOptions");

                entity.HasOne(d => d.RiskImpactLevel)
                    .WithMany(p => p.PartnerOrganisationRiskUpdateRiskImpactLevels)
                    .HasForeignKey(d => d.RiskImpactLevelID)
                    .HasConstraintName("FK_PartnerOrganisationRiskUpdates_RiskImpactLevels");

                entity.HasOne(d => d.RiskProbability)
                    .WithMany(p => p.PartnerOrganisationRiskUpdateRiskProbabilities)
                    .HasForeignKey(d => d.RiskProbabilityID)
                    .HasConstraintName("FK_PartnerOrganisationRiskUpdates_RiskProbabilities");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.PartnerOrganisationRiskUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_PartnerOrganisationRiskUpdates_SignOffs");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.PartnerOrganisationRiskUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_PartnerOrganisationRiskUpdates_Users");
            });

            modelBuilder.Entity<PartnerOrganisationUpdate>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Comment).HasMaxLength(50);

                entity.Property(e => e.Escalations).HasMaxLength(1000);

                entity.Property(e => e.FinanceComment).HasMaxLength(500);

                entity.Property(e => e.FinanceRagOptionID).HasColumnName("FinanceRagOptionID");

                entity.Property(e => e.FutureActions).HasMaxLength(1000);

                entity.Property(e => e.KPIComment).HasMaxLength(500);

                entity.Property(e => e.KPIRagOptionID).HasColumnName("KPIRagOptionID");

                entity.Property(e => e.MilestonesComment).HasMaxLength(500);

                entity.Property(e => e.MilestonesRagOptionID).HasColumnName("MilestonesRagOptionID");

                entity.Property(e => e.OverallRagOptionID).HasColumnName("OverallRagOptionID");

                entity.Property(e => e.PartnerOrganisationID).HasColumnName("PartnerOrganisationID");

                entity.Property(e => e.PeopleComment).HasMaxLength(500);

                entity.Property(e => e.PeopleRagOptionID).HasColumnName("PeopleRagOptionID");

                entity.Property(e => e.ProgressUpdate).HasMaxLength(1000);

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.SignOffID).HasColumnName("SignOffID");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.UpdatePeriod).HasColumnType("date");

                entity.Property(e => e.UpdateUserID).HasColumnName("UpdateUserID");

                entity.HasOne(d => d.FinanceRagOption)
                    .WithMany(p => p.PartnerOrganisationUpdateFinanceRagOptions)
                    .HasForeignKey(d => d.FinanceRagOptionID)
                    .HasConstraintName("FK_PartnerOrganisationUpdates_RagOptionFinance");

                entity.HasOne(d => d.KPIRagOption)
                    .WithMany(p => p.PartnerOrganisationUpdateKpiragOptions)
                    .HasForeignKey(d => d.KPIRagOptionID)
                    .HasConstraintName("FK_PartnerOrganisationUpdates_RagOptionKPI");

                entity.HasOne(d => d.MilestonesRagOption)
                    .WithMany(p => p.PartnerOrganisationUpdateMilestonesRagOptions)
                    .HasForeignKey(d => d.MilestonesRagOptionID)
                    .HasConstraintName("FK_PartnerOrganisationUpdates_RagOptionMilestone");

                entity.HasOne(d => d.OverallRagOption)
                    .WithMany(p => p.PartnerOrganisationUpdateOverallRagOptions)
                    .HasForeignKey(d => d.OverallRagOptionID)
                    .HasConstraintName("FK_PartnerOrganisationUpdates_RagOptionOverall");

                entity.HasOne(d => d.PartnerOrganisation)
                    .WithMany(p => p.PartnerOrganisationUpdates)
                    .HasForeignKey(d => d.PartnerOrganisationID)
                    .HasConstraintName("FK_PartnerOrganisationUpdates_PartnerOrganisations");

                entity.HasOne(d => d.PeopleRagOption)
                    .WithMany(p => p.PartnerOrganisationUpdatePeopleRagOptions)
                    .HasForeignKey(d => d.PeopleRagOptionID)
                    .HasConstraintName("FK_PartnerOrganisationUpdates_RagOptionPeople");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.PartnerOrganisationUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_PartnerOrganisationUpdates_SignOffs");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.PartnerOrganisationUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_PartnerOrganisationUpdates_Users");
            });

            modelBuilder.Entity<Project>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.DirectorateID).HasColumnName("DirectorateID");

                entity.Property(e => e.EndDate).HasColumnType("datetime");

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.ParentProjectID).HasColumnName("ParentProjectID");

                entity.Property(e => e.ProjectManagerUserID).HasColumnName("ProjectManagerUserID");

                entity.Property(e => e.ReportApproverUserID).HasColumnName("ReportApproverUserID");

                entity.Property(e => e.ReportingLeadUserID).HasColumnName("ReportingLeadUserID");

                entity.Property(e => e.SeniorResponsibleOwnerUserID).HasColumnName("SeniorResponsibleOwnerUserID");

                entity.Property(e => e.ShowOnDirectorateReport).HasDefaultValueSql("('false')");

                entity.Property(e => e.StartDate).HasColumnType("datetime");

                entity.Property(e => e.ReportingStartDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Objectives).HasMaxLength(10000);

                entity.HasOne(d => d.Directorate)
                    .WithMany(p => p.Projects)
                    .HasForeignKey(d => d.DirectorateID)
                    .HasConstraintName("FK_Projects_Directorates");

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.Projects)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_Projects_EntityStatuses");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.ProjectModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_Projects_ModifiedByUsers");

                entity.HasOne(d => d.ParentProject)
                    .WithMany(p => p.ChildProjects)
                    .HasForeignKey(d => d.ParentProjectID)
                    .HasConstraintName("FK_Projects_ParentProject");

                entity.HasOne(d => d.ProjectManagerUser)
                    .WithMany(p => p.ProjectProjectManagerUsers)
                    .HasForeignKey(d => d.ProjectManagerUserID)
                    .HasConstraintName("FK_Projects_ProjectManager");

                entity.HasOne(d => d.ReportApproverUser)
                    .WithMany(p => p.ProjectReportApproverUsers)
                    .HasForeignKey(d => d.ReportApproverUserID)
                    .HasConstraintName("FK_Projects_ReportApproverUsers");

                entity.HasOne(d => d.ReportingLeadUser)
                    .WithMany(p => p.ProjectReportingLeadUsers)
                    .HasForeignKey(d => d.ReportingLeadUserID)
                    .HasConstraintName("FK_Projects_ReportingLeadUsers");

                entity.HasOne(d => d.SeniorResponsibleOwnerUser)
                    .WithMany(p => p.ProjectSeniorResponsibleOwnerUsers)
                    .HasForeignKey(d => d.SeniorResponsibleOwnerUserID)
                    .HasConstraintName("FK_Projects_SeniorResponsibleOwner");
            });

            modelBuilder.Entity<ProjectBusinessCaseType>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<ProjectPhase>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<ProjectUpdate>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.BenefitsComment).HasMaxLength(500);

                entity.Property(e => e.BenefitsRagOptionID).HasColumnName("BenefitsRagOptionID");

                entity.Property(e => e.BusinessCaseTypeID).HasColumnName("BusinessCaseTypeID");

                entity.Property(e => e.Comment)
                    .HasMaxLength(1000)
                    .IsUnicode(false);

                entity.Property(e => e.Escalations).HasMaxLength(500);

                entity.Property(e => e.FinanceComment).HasMaxLength(500);

                entity.Property(e => e.FinanceRagOptionID).HasColumnName("FinanceRagOptionID");

                entity.Property(e => e.FutureActions).HasMaxLength(500);

                entity.Property(e => e.MilestonesComment).HasMaxLength(500);

                entity.Property(e => e.MilestonesRagOptionID).HasColumnName("MilestonesRagOptionID");

                entity.Property(e => e.NetPresentValue).HasColumnType("decimal(18, 4)");

                entity.Property(e => e.OverallRagOptionID).HasColumnName("OverallRagOptionID");

                entity.Property(e => e.PeopleComment).HasMaxLength(500);

                entity.Property(e => e.PeopleRagOptionID).HasColumnName("PeopleRagOptionID");

                entity.Property(e => e.ProgressUpdate).HasMaxLength(500);

                entity.Property(e => e.ProjectID).HasColumnName("ProjectID");

                entity.Property(e => e.ProjectPhaseID).HasColumnName("ProjectPhaseID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.SignOffID).HasColumnName("SignOffID");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.UpdatePeriod).HasColumnType("date");

                entity.Property(e => e.UpdateUserID).HasColumnName("UpdateUserID");

                entity.Property(e => e.WholeLifeBenefit).HasColumnType("decimal(18, 4)");

                entity.Property(e => e.WholeLifeCost).HasColumnType("decimal(18, 4)");

                entity.HasOne(d => d.BenefitsRagOption)
                    .WithMany(p => p.ProjectUpdateBenefitsRagOptions)
                    .HasForeignKey(d => d.BenefitsRagOptionID)
                    .HasConstraintName("FK_ProjectUpdates_RagOptionBenefit");

                entity.HasOne(d => d.BusinessCaseType)
                    .WithMany(p => p.ProjectUpdates)
                    .HasForeignKey(d => d.BusinessCaseTypeID)
                    .HasConstraintName("FK_ProjectUpdates_ProjectBusinessCaseTypes");

                entity.HasOne(d => d.FinanceRagOption)
                    .WithMany(p => p.ProjectUpdateFinanceRagOptions)
                    .HasForeignKey(d => d.FinanceRagOptionID)
                    .HasConstraintName("FK_ProjectUpdates_RagOptionFinance");

                entity.HasOne(d => d.MilestonesRagOption)
                    .WithMany(p => p.ProjectUpdateMilestonesRagOptions)
                    .HasForeignKey(d => d.MilestonesRagOptionID)
                    .HasConstraintName("FK_ProjectUpdates_RagOptionMilestone");

                entity.HasOne(d => d.OverallRagOption)
                    .WithMany(p => p.ProjectUpdateOverallRagOptions)
                    .HasForeignKey(d => d.OverallRagOptionID)
                    .HasConstraintName("FK_ProjectUpdates_RagOptionOverall");

                entity.HasOne(d => d.PeopleRagOption)
                    .WithMany(p => p.ProjectUpdatePeopleRagOptions)
                    .HasForeignKey(d => d.PeopleRagOptionID)
                    .HasConstraintName("FK_ProjectUpdates_RagOptionPeople");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.ProjectUpdates)
                    .HasForeignKey(d => d.ProjectID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ProjectUpdates_Projects");

                entity.HasOne(d => d.ProjectPhase)
                    .WithMany(p => p.ProjectUpdates)
                    .HasForeignKey(d => d.ProjectPhaseID)
                    .HasConstraintName("FK_ProjectUpdates_ProjectPhases");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.ProjectUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_ProjectUpdates_SignOffs");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.ProjectUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_ProjectUpdates_UpdateUser");
            });

            modelBuilder.Entity<RagOption>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Name).HasMaxLength(50);

                entity.Property(e => e.ReportName).HasMaxLength(2);
            });

            modelBuilder.Entity<RagOptionsMapping>(entity =>
            {
                entity.ToTable("RagOptionsMapping");

                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.RiskImpactLevelID).HasColumnName("RiskImpactLevelID");

                entity.Property(e => e.RiskProbabilityID).HasColumnName("RiskProbabilityID");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.RagOptionsMappings)
                    .HasForeignKey(d => d.RagOptionID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_RagOptionsMapping_RagOptions");

                entity.HasOne(d => d.RiskImpactLevel)
                    .WithMany(p => p.RagOptionsMappings)
                    .HasForeignKey(d => d.RiskImpactLevelID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_RagOptionsMapping_RiskImpactLevels");

                entity.HasOne(d => d.RiskProbability)
                    .WithMany(p => p.RagOptionsMappings)
                    .HasForeignKey(d => d.RiskProbabilityID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_RagOptionsMapping_RiskProbabilities");
            });

            modelBuilder.Entity<ReportingFrequency>(entity =>
            {
                entity.Property(e => e.Title).IsRequired().HasMaxLength(50);
            });

            modelBuilder.Entity<ReportStaging>(entity =>
            {
                entity.ToTable("ReportStaging");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.SubmittedDate)
                    .HasColumnType("datetime2(7)")
                    .HasDefaultValueSql("(getutcdate())");

                entity.HasOne(r => r.Project)
                    .WithMany(p => p.ReportStagings)
                    .HasForeignKey(r => r.ProjectID)
                    .HasConstraintName("FK_ReportStaging_Projects");

                entity.HasOne(r => r.SubmittedByUser)
                    .WithMany(u => u.ReportSubmittedByUsers)
                    .HasForeignKey(r => r.SubmittedByUserID)
                    .HasConstraintName("FK_ReportStaging_Users");
            });

            modelBuilder.Entity<ReportType>(entity =>
            {
                entity.Property(e => e.Title).HasMaxLength(255);
            });

            modelBuilder.Entity<Risk>(entity =>
             {
                 entity.Property(e => e.ID).HasColumnName("ID");

                 entity.Property(e => e.CreatedDate)
                     .HasColumnType("datetime2(0)")
                     .HasDefaultValueSql("(getutcdate())");

                 entity.Property(e => e.GroupID).HasColumnName("GroupID");

                 entity.Property(e => e.DirectorateID).HasColumnName("DirectorateID");

                 entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                 entity.Property(e => e.LinkedRiskID).HasColumnName("LinkedRiskID");

                 entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                 entity.Property(e => e.ProjectID).HasColumnName("ProjectID");

                 entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                 entity.Property(e => e.ReportApproverUserID).HasColumnName("ReportApproverUserID");

                 entity.Property(e => e.RiskAppetiteID).HasColumnName("RiskAppetiteID");

                 entity.Property(e => e.RiskCauseDescription).HasMaxLength(750);

                 entity.Property(e => e.RiskCode).HasMaxLength(50);

                 entity.Property(e => e.RiskEventDescription).HasMaxLength(750);

                 entity.Property(e => e.RiskImpactDescription).HasMaxLength(750);

                 entity.Property(e => e.RiskOwnerUserID).HasColumnName("RiskOwnerUserID");

                 entity.Property(e => e.RiskProximity).HasColumnType("date");

                 entity.Property(e => e.RiskRegisterID).HasColumnName("RiskRegisterID");

                 entity.Property(e => e.ReportingStartDate).HasColumnType("datetime2(0)");

                 entity.Property(e => e.TargetRiskImpactLevelID).HasColumnName("TargetRiskImpactLevelID");

                 entity.Property(e => e.TargetRiskProbabilityID).HasColumnName("TargetRiskProbabilityID");

                 entity.Property(e => e.Title).HasMaxLength(255);

                 entity.Property(e => e.Description).HasMaxLength(500);

                 entity.Property(e => e.UnmitigatedRiskImpactLevelID).HasColumnName("UnmitigatedRiskImpactLevelID");

                 entity.Property(e => e.UnmitigatedRiskProbabilityID).HasColumnName("UnmitigatedRiskProbabilityID");

                 entity.HasOne(d => d.EntityStatus)
                     .WithMany(p => p.Risks)
                     .HasForeignKey(d => d.EntityStatusID)
                     .HasConstraintName("FK_Risks_EntityStatuses");
             });

            modelBuilder.Entity<CorporateRisk>(entity =>
            {
                entity.Property(e => e.DepartmentalObjectiveID).HasColumnName("DepartmentalObjectiveID");

                entity.HasOne(d => d.Group)
                  .WithMany(p => p.CorporateRisks)
                  .HasForeignKey(d => d.GroupID)
                  .HasConstraintName("FK_Risks_Groups");

                entity.HasOne(d => d.Directorate)
                    .WithMany(p => p.CorporateRisks)
                    .HasForeignKey(d => d.DirectorateID)
                    .HasConstraintName("FK_Risks_Directorates");

                entity.HasOne(d => d.DepartmentalObjective)
                   .WithMany(p => p.Risks)
                   .HasForeignKey(d => d.DepartmentalObjectiveID)
                   .HasConstraintName("FK_Risks_DepartmentalObjectives");

                entity.HasOne(d => d.LinkedRisk)
                 .WithMany(p => p.ChildRisks)
                 .HasForeignKey(d => d.LinkedRiskID)
                 .HasConstraintName("FK_Risks_Risks");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.CorporateRisks)
                    .HasForeignKey(d => d.ProjectID)
                    .HasConstraintName("FK_Risks_Projects");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.CorporateRisks)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_Risks_RagOptions");

                entity.HasOne(d => d.ReportApproverUser)
                    .WithMany(p => p.CorporateRiskReportApproverUsers)
                    .HasForeignKey(d => d.ReportApproverUserID)
                    .HasConstraintName("FK_Risks_ReportApproverUsers");

                entity.HasOne(d => d.RiskAppetite)
                    .WithMany(p => p.CorporateRisks)
                    .HasForeignKey(d => d.RiskAppetiteID)
                    .HasConstraintName("FK_Risks_RiskAppetites");

                entity.HasOne(d => d.RiskRegister)
                    .WithMany(p => p.CorporateRisks)
                    .HasForeignKey(d => d.RiskRegisterID)
                    .HasConstraintName("FK_Risks_RiskRegisters");

                entity.HasOne(d => d.TargetRiskImpactLevel)
                    .WithMany(p => p.CorporateRiskTargetRiskImpactLevels)
                    .HasForeignKey(d => d.TargetRiskImpactLevelID)
                    .HasConstraintName("FK_Risks_TargetRiskImpactLevels");

                entity.HasOne(d => d.TargetRiskProbability)
                    .WithMany(p => p.CorporateRiskTargetRiskProbabilities)
                    .HasForeignKey(d => d.TargetRiskProbabilityID)
                    .HasConstraintName("FK_Risks_TargetRiskProbabilities");

                entity.HasOne(d => d.UnmitigatedRiskImpactLevel)
                    .WithMany(p => p.CorporateRiskUnmitigatedRiskImpactLevels)
                    .HasForeignKey(d => d.UnmitigatedRiskImpactLevelID)
                    .HasConstraintName("FK_Risks_UnmitigatedRiskImpactLevels");

                entity.HasOne(d => d.UnmitigatedRiskProbability)
                    .WithMany(p => p.CorporateRiskUnmitigatedRiskProbabilities)
                    .HasForeignKey(d => d.UnmitigatedRiskProbabilityID)
                    .HasConstraintName("FK_Risks_UnmitigatedRiskProbabilities");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.CorporateRiskModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_Risks_ModifiedByUsers");

                entity.HasOne(d => d.RiskOwnerUser)
                    .WithMany(p => p.CorporateRiskRiskOwnerUsers)
                    .HasForeignKey(d => d.RiskOwnerUserID)
                    .HasConstraintName("FK_Risks_Users");
            });

            modelBuilder.Entity<FinancialRisk>(entity =>
            {
                entity.Property(e => e.StaffNonStaffSpend).HasColumnName("StaffNonStaffSpend");

                entity.Property(e => e.FundingClassification).HasConversion(
                    v => JsonSerializer.Serialize(v, new JsonSerializerOptions { PropertyNameCaseInsensitive = true, IgnoreNullValues = true }),
                    v => JsonSerializer.Deserialize<ICollection<string>>(v, new JsonSerializerOptions { PropertyNameCaseInsensitive = true, IgnoreNullValues = true }),
                    new ValueComparer<ICollection<string>>(
                        (c1, c2) => c1.SequenceEqual(c2),
                        c => c.Aggregate(0, (a, v) => HashCode.Combine(a, v.GetHashCode())),
                        c => (ICollection<string>)c.ToHashSet()));

                entity.Property(e => e.EconomicRingfence).HasConversion(
                    v => JsonSerializer.Serialize(v, new JsonSerializerOptions { PropertyNameCaseInsensitive = true, IgnoreNullValues = true }),
                    v => JsonSerializer.Deserialize<ICollection<string>>(v, new JsonSerializerOptions { PropertyNameCaseInsensitive = true, IgnoreNullValues = true }),
                    new ValueComparer<ICollection<string>>(
                        (c1, c2) => c1.SequenceEqual(c2),
                        c => c.Aggregate(0, (a, v) => HashCode.Combine(a, v.GetHashCode())),
                        c => (ICollection<string>)c.ToHashSet()));

                entity.Property(e => e.PolicyRingfence).HasConversion(
                    v => JsonSerializer.Serialize(v, new JsonSerializerOptions { PropertyNameCaseInsensitive = true, IgnoreNullValues = true }),
                    v => JsonSerializer.Deserialize<ICollection<string>>(v, new JsonSerializerOptions { PropertyNameCaseInsensitive = true, IgnoreNullValues = true }),
                    new ValueComparer<ICollection<string>>(
                        (c1, c2) => c1.SequenceEqual(c2),
                        c => c.Aggregate(0, (a, v) => HashCode.Combine(a, v.GetHashCode())),
                        c => (ICollection<string>)c.ToHashSet()));

                entity.HasOne(d => d.Group)
                  .WithMany(p => p.FinancialRisks)
                  .HasForeignKey(d => d.GroupID)
                  .OnDelete(DeleteBehavior.ClientSetNull)
                  .HasConstraintName("FK_Risks_Groups");

                entity.HasOne(d => d.Directorate)
                    .WithMany(p => p.FinancialRisks)
                    .HasForeignKey(d => d.DirectorateID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Risks_Directorates");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.FinancialRisks)
                    .HasForeignKey(d => d.ProjectID)
                    .HasConstraintName("FK_Risks_Projects");

                entity.HasOne(d => d.RiskAppetite)
                    .WithMany(p => p.FinancialRisks)
                    .HasForeignKey(d => d.RiskAppetiteID)
                    .HasConstraintName("FK_Risks_RiskAppetites");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.FinancialRiskModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_Risks_ModifiedByUsers");

                entity.HasOne(d => d.RiskOwnerUser)
                    .WithMany(p => p.FinancialRiskRiskOwnerUsers)
                    .HasForeignKey(d => d.RiskOwnerUserID)
                    .HasConstraintName("FK_Risks_Users");
            });

            modelBuilder.Entity<RiskAppetite>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Title).HasMaxLength(255);
            });

            modelBuilder.Entity<RiskDiscussionForum>(entity =>
            {
                entity.Property(e => e.Title).HasMaxLength(255);
            });

            modelBuilder.Entity<RiskImpactLevel>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Description).HasMaxLength(255);

                entity.Property(e => e.EndUpdatePeriod).HasColumnType("date");

                entity.Property(e => e.StartUpdatePeriod).HasColumnType("date");

                entity.Property(e => e.Title).HasMaxLength(255);
            });

            modelBuilder.Entity<RiskMitigationAction>(entity =>
            {
                entity.ToTable("RiskMitigationActions");

                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.ActualDate).HasColumnType("date");

                entity.Property(e => e.BaselineDate).HasColumnType("date");

                entity.Property(e => e.Description).HasMaxLength(750);

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.ForecastDate).HasColumnType("date");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.OwnerUserID).HasColumnName("OwnerUserID");

                entity.Property(e => e.ReportingStartDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.RiskMitigationActionModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_RiskMitigationActions_ModifiedByUsers");

                entity.HasOne(d => d.OwnerUser)
                    .WithMany(p => p.RiskMitigationActionOwnerUsers)
                    .HasForeignKey(d => d.OwnerUserID)
                    .HasConstraintName("FK_RiskMitigationActions_Users");
            });

            modelBuilder.Entity<CorporateRiskMitigationAction>(entity =>
            {
                entity.HasOne(d => d.Risk)
                    .WithMany(p => p.RiskMitigationActions)
                    .HasForeignKey(d => d.RiskID)
                    .HasConstraintName("FK_RiskMitigationActions_Risks");

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.CorporateRiskMitigationActions)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_RiskMitigationActions_EntityStatuses");
            });

            modelBuilder.Entity<FinancialRiskMitigationAction>(entity =>
            {
                entity.HasOne(d => d.FinancialRisk)
                    .WithMany(p => p.FinancialRiskMitigationActions)
                    .HasForeignKey(d => d.RiskID)
                    .HasConstraintName("FK_RiskMitigationActions_Risks");

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.FinancialRiskMitigationActions)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_RiskMitigationActions_EntityStatuses");
            });

            modelBuilder.Entity<CorporateRiskRiskMitigationAction>(entity =>
            {
                entity.HasOne(d => d.Risk)
                    .WithMany(p => p.CorporateRiskRiskMitigationActions)
                    .HasForeignKey(d => d.RiskID)
                    .HasConstraintName("FK_RiskRiskMitigationActions_Risks");

                entity.HasOne(d => d.RiskMitigationAction)
                    .WithMany(p => p.CorporateRiskRiskMitigationActions)
                    .HasForeignKey(d => d.RiskMitigationActionID)
                    .HasConstraintName("FK_RiskRiskMitigationActions_RiskMitigationActions");
            });

            modelBuilder.Entity<FinancialRiskRiskMitigationAction>(entity =>
            {
                entity.HasOne(d => d.Risk)
                    .WithMany(p => p.FinancialRiskRiskMitigationActions)
                    .HasForeignKey(d => d.RiskID)
                    .HasConstraintName("FK_RiskRiskMitigationActions_Risks");

                entity.HasOne(d => d.RiskMitigationAction)
                    .WithMany(p => p.FinancialRiskRiskMitigationActions)
                    .HasForeignKey(d => d.RiskMitigationActionID)
                    .HasConstraintName("FK_RiskRiskMitigationActions_RiskMitigationActions");
            });

            modelBuilder.Entity<RiskMitigationActionUpdate>(entity =>
            {
                entity.ToTable("RiskMitigationActionUpdates");

                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.ActualDate).HasColumnType("date");

                entity.Property(e => e.Comment).HasMaxLength(1000);

                entity.Property(e => e.ForecastDate).HasColumnType("date");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.RiskMitigationActionID).HasColumnName("RiskMitigationActionID");

                entity.Property(e => e.RiskUpdateID).HasColumnName("RiskUpdateID");

                entity.Property(e => e.SignOffID).HasColumnName("SignOffID");

                entity.Property(e => e.Title).HasMaxLength(500);

                entity.Property(e => e.UpdatePeriod).HasColumnType("date");

                entity.Property(e => e.UpdateUserID).HasColumnName("UpdateUserID");
            });

            modelBuilder.Entity<CorporateRiskMitigationActionUpdate>(entity =>
            {
                entity.HasOne(d => d.RiskMitigationAction)
                    .WithMany(p => p.RiskMitigationActionUpdates)
                    .HasForeignKey(d => d.RiskMitigationActionID)
                    .HasConstraintName("FK_RiskMitigationActionUpdates_RiskMitigationActions");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.CorporateRiskMitigationActionUpdates)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_RiskMitigationActionUpdates_RagOptions");

                entity.HasOne(d => d.RiskUpdate)
                    .WithMany(p => p.RiskMitigationActionUpdatesNavigation)
                    .HasForeignKey(d => d.RiskUpdateID)
                    .HasConstraintName("FK_RiskMitigationActionUpdates_RiskUpdates");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.CorporateRiskMitigationActionUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_RiskMitigationActionUpdates_SignOffs");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.CorporateRiskMitigationActionUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_RiskMitigationActionUpdates_Users");
            });

            modelBuilder.Entity<FinancialRiskMitigationActionUpdate>(entity =>
            {
                entity.HasOne(d => d.FinancialRiskMitigationAction)
                    .WithMany(p => p.FinancialRiskMitigationActionUpdates)
                    .HasForeignKey(d => d.RiskMitigationActionID)
                    .HasConstraintName("FK_RiskMitigationActionUpdates_RiskMitigationActions");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.FinancialRiskMitigationActionUpdates)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_RiskMitigationActionUpdates_RagOptions");

                entity.HasOne(d => d.FinancialRiskUpdate)
                    .WithMany(p => p.FinancialRiskMitigationActionUpdatesNavigation)
                    .HasForeignKey(d => d.RiskUpdateID)
                    .HasConstraintName("FK_RiskMitigationActionUpdates_RiskUpdates");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.FinancialRiskMitigationActionUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_RiskMitigationActionUpdates_SignOffs");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.FinancialRiskMitigationActionUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_RiskMitigationActionUpdates_Users");
            });

            modelBuilder.Entity<RiskProbability>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.EndUpdatePeriod).HasColumnType("date");

                entity.Property(e => e.StartUpdatePeriod).HasColumnType("date");

                entity.Property(e => e.Title).HasMaxLength(50);
            });

            modelBuilder.Entity<RiskRegister>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.RiskCodePrefix).HasMaxLength(50);

                entity.Property(e => e.Title).HasMaxLength(50);
            });

            modelBuilder.Entity<RiskRiskMitigationAction>(entity =>
            {
                entity.ToTable("RiskRiskMitigationActions");
            });

            modelBuilder.Entity<CorporateRiskRiskMitigationAction>(entity =>
            {
                entity.HasOne(d => d.Risk)
                    .WithMany(p => p.CorporateRiskRiskMitigationActions)
                    .HasForeignKey(d => d.RiskID)
                    .HasConstraintName("FK_RiskRiskMitigationActions_Risks");
            });

            modelBuilder.Entity<FinancialRiskRiskMitigationAction>(entity =>
            {
                entity.HasOne(d => d.Risk)
                    .WithMany(p => p.FinancialRiskRiskMitigationActions)
                    .HasForeignKey(d => d.RiskID)
                    .HasConstraintName("FK_RiskRiskMitigationActions_Risks");
            });

            modelBuilder.Entity<RiskRiskType>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.RiskID).HasColumnName("RiskID");

                entity.Property(e => e.RiskTypeID).HasColumnName("RiskTypeID");

                entity.Property(e => e.Title).HasMaxLength(50);

                entity.HasOne(d => d.CorporateRisk)
                    .WithMany(p => p.RiskRiskTypes)
                    .HasForeignKey(d => d.RiskID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_RiskRiskTypes_Risks");

                entity.HasOne(d => d.RiskType)
                    .WithMany(p => p.RiskRiskTypes)
                    .HasForeignKey(d => d.RiskTypeID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_RiskRiskTypes_RiskTypes");
            });

            modelBuilder.Entity<RiskType>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.ThresholdID).HasColumnName("ThresholdID");

                entity.Property(e => e.Title).HasMaxLength(50);

                entity.HasOne(d => d.Threshold)
                    .WithMany(p => p.RiskTypes)
                    .HasForeignKey(d => d.ThresholdID)
                    .HasConstraintName("FK_RiskTypes_Thresholds");
            });

            modelBuilder.Entity<RiskUpdate>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.ClosureReason).HasMaxLength(50);

                entity.Property(e => e.Comment).HasMaxLength(500);

                entity.Property(e => e.Narrative).HasMaxLength(1000);

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.RiskCode).HasMaxLength(50);

                entity.Property(e => e.RiskID).HasColumnName("RiskID");

                entity.Property(e => e.RiskImpactLevelID).HasColumnName("RiskImpactLevelID");

                entity.Property(e => e.RiskProbabilityID).HasColumnName("RiskProbabilityID");

                entity.Property(e => e.RiskProximity).HasColumnType("date");

                entity.Property(e => e.RiskRegisterID).HasColumnName("RiskRegisterID");

                entity.Property(e => e.SignOffID).HasColumnName("SignOffID");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.UpdatePeriod).HasColumnType("date");

                entity.Property(e => e.UpdateUserID).HasColumnName("UpdateUserID");

                entity.Property(e => e.Attachments).HasConversion(
                    v => JsonSerializer.Serialize(v, new JsonSerializerOptions { PropertyNameCaseInsensitive = true, IgnoreNullValues = true }),
                    v => JsonSerializer.Deserialize<ICollection<Hyperlink>>(v, new JsonSerializerOptions { PropertyNameCaseInsensitive = true, IgnoreNullValues = true }),
                    new ValueComparer<ICollection<Hyperlink>>(
                        (c1, c2) => c1.SequenceEqual(c2),
                        c => c.Aggregate(0, (a, v) => HashCode.Combine(a, v.GetHashCode())),
                        c => (ICollection<Hyperlink>)c.ToHashSet()));

                entity.Property(e => e.DiscussionForum).HasConversion(
                    v => JsonSerializer.Serialize(v, new JsonSerializerOptions { PropertyNameCaseInsensitive = true, IgnoreNullValues = true }),
                    v => JsonSerializer.Deserialize<ICollection<string>>(v, new JsonSerializerOptions { PropertyNameCaseInsensitive = true, IgnoreNullValues = true }),
                    new ValueComparer<ICollection<string>>(
                        (c1, c2) => c1.SequenceEqual(c2),
                        c => c.Aggregate(0, (a, v) => HashCode.Combine(a, v.GetHashCode())),
                        c => (ICollection<string>)c.ToHashSet()));

                entity.HasOne(d => d.EscalateToRiskRegister)
                    .WithMany(p => p.RiskUpdatesEscalateTo)
                    .HasForeignKey(d => d.EscalateToRiskRegisterID)
                    .HasConstraintName("FK_RiskUpdates_EscalateToRiskRegisters");

                entity.HasOne(d => d.RiskRegister)
                    .WithMany(p => p.RiskUpdates)
                    .HasForeignKey(d => d.RiskRegisterID)
                    .HasConstraintName("FK_RiskUpdates_RiskRegisters");
            });

            modelBuilder.Entity<CorporateRiskUpdate>(entity =>
            {
                entity.HasOne(d => d.Risk)
                    .WithMany(p => p.RiskUpdates)
                    .HasForeignKey(d => d.RiskID)
                    .HasConstraintName("FK_RiskUpdates_Risks");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.CorporateRiskUpdates)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_RiskUpdates_RagOptions");

                entity.HasOne(d => d.RiskImpactLevel)
                    .WithMany(p => p.CorporateRiskUpdates)
                    .HasForeignKey(d => d.RiskImpactLevelID)
                    .HasConstraintName("FK_RiskUpdates_RiskImpactLevels");

                entity.HasOne(d => d.RiskProbability)
                    .WithMany(p => p.CorporateRiskUpdates)
                    .HasForeignKey(d => d.RiskProbabilityID)
                    .HasConstraintName("FK_RiskUpdates_RiskProbabilities");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.CorporateRiskUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_RiskUpdates_Users");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.CorporateRiskUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_RiskUpdates_SignOffs");
            });

            modelBuilder.Entity<FinancialRiskUpdate>(entity =>
            {
                entity.Property(e => e.Measurements).HasConversion(
                    v => JsonSerializer.Serialize(v, new JsonSerializerOptions { PropertyNameCaseInsensitive = true, IgnoreNullValues = true }),
                    v => JsonSerializer.Deserialize<FinancialRiskMeasurements>(v, new JsonSerializerOptions { PropertyNameCaseInsensitive = true, IgnoreNullValues = true }));

                entity.HasOne(d => d.FinancialRisk)
                    .WithMany(p => p.FinancialRiskUpdates)
                    .HasForeignKey(d => d.RiskID)
                    .HasConstraintName("FK_RiskUpdates_Risks");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.FinancialRiskUpdates)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_RiskUpdates_RagOptions");

                entity.HasOne(d => d.RiskImpactLevel)
                    .WithMany(p => p.FinancialRiskUpdates)
                    .HasForeignKey(d => d.RiskImpactLevelID)
                    .HasConstraintName("FK_RiskUpdates_RiskImpactLevels");

                entity.HasOne(d => d.RiskProbability)
                    .WithMany(p => p.FinancialRiskUpdates)
                    .HasForeignKey(d => d.RiskProbabilityID)
                    .HasConstraintName("FK_RiskUpdates_RiskProbabilities");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.FinancialRiskUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_RiskUpdates_Users");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.FinancialRiskUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_RiskUpdates_SignOffs");
            });

            modelBuilder.Entity<Role>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<SignOff>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.DirectorateID).HasColumnName("DirectorateID");

                entity.Property(e => e.IsCurrent).HasDefaultValueSql("((0))");

                entity.Property(e => e.PartnerOrganisationID).HasColumnName("PartnerOrganisationID");

                entity.Property(e => e.ProjectID).HasColumnName("ProjectID");

                entity.Property(e => e.ReportMonth).HasColumnType("date");

                entity.Property(e => e.RiskID).HasColumnName("RiskID");

                entity.Property(e => e.SignOffUserID).HasColumnName("SignOffUserID");

                entity.Property(e => e.Title).HasMaxLength(350);

                entity.HasOne(d => d.Directorate)
                    .WithMany(p => p.SignOffs)
                    .HasForeignKey(d => d.DirectorateID)
                    .HasConstraintName("FK_SignOffs_Directorates");

                entity.HasOne(d => d.PartnerOrganisation)
                    .WithMany(p => p.SignOffs)
                    .HasForeignKey(d => d.PartnerOrganisationID)
                    .HasConstraintName("FK_SignOffs_PartnerOrganisations");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.SignOffs)
                    .HasForeignKey(d => d.ProjectID)
                    .HasConstraintName("FK_SignOffs_Projects");

                entity.HasOne(d => d.CorporateRisk)
                    .WithMany(p => p.SignOffs)
                    .HasForeignKey(d => d.RiskID)
                    .HasConstraintName("FK_SignOffs_Risks");

                entity.HasOne(d => d.FinancialRisk)
                    .WithMany(p => p.SignOffs)
                    .HasForeignKey(d => d.RiskID)
                    .HasConstraintName("FK_SignOffs_Risks");

                entity.HasOne(d => d.SignOffUser)
                    .WithMany(p => p.SignOffs)
                    .HasForeignKey(d => d.SignOffUserID)
                    .HasConstraintName("FK_SignOffs_Users");
            });

            modelBuilder.Entity<Threshold>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<ThresholdAppetite>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.RiskImpactLevelID).HasColumnName("RiskImpactLevelID");

                entity.Property(e => e.RiskProbabilityID).HasColumnName("RiskProbabilityID");

                entity.Property(e => e.ThresholdID).HasColumnName("ThresholdID");

                entity.HasOne(d => d.RiskImpactLevel)
                    .WithMany(p => p.ThresholdAppetites)
                    .HasForeignKey(d => d.RiskImpactLevelID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ThresholdAppetites_RiskImpactLevels");

                entity.HasOne(d => d.RiskProbability)
                    .WithMany(p => p.ThresholdAppetites)
                    .HasForeignKey(d => d.RiskProbabilityID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ThresholdAppetites_RiskProbabilities");

                entity.HasOne(d => d.Threshold)
                    .WithMany(p => p.ThresholdAppetites)
                    .HasForeignKey(d => d.ThresholdID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ThresholdAppetites_Thresholds");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.HasIndex(e => e.Username)
                    .HasDatabaseName("UQ_Users")
                    .IsUnique();

                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("datetime2(0)")
                    .HasDefaultValueSql("(getutcdate())");

                entity.Property(e => e.EntityStatusDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.Username)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.Users)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_Users_EntityStatuses");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.UsersModifiedByUser)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_Users_ModifiedByUsers");
            });

            modelBuilder.Entity<UserDirectorate>(entity =>
            {
                entity.HasIndex(e => new { e.UserID, e.DirectorateID })
                    .HasDatabaseName("UQ_UserDirectorates")
                    .IsUnique();

                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.DirectorateID).HasColumnName("DirectorateID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.Title).HasMaxLength(50);

                entity.Property(e => e.UserID).HasColumnName("UserID");

                entity.HasOne(d => d.Directorate)
                    .WithMany(p => p.UserDirectorates)
                    .HasForeignKey(d => d.DirectorateID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserDirectorates_Directorates");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.UserDirectorateModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_UserDirectorates_ModifiedByUsers");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserDirectorates)
                    .HasForeignKey(d => d.UserID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserDirectorates_Users");
            });

            modelBuilder.Entity<BaseUserGroup>(entity =>
            {
                entity.ToTable("UserGroups");

                entity.Property("Discriminator").HasMaxLength(50);

                entity.HasIndex("UserID", "GroupID", "Discriminator")
                    .HasDatabaseName("UQ_UserGroups")
                    .IsUnique();

                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.GroupID).HasColumnName("GroupID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.Title).HasMaxLength(50);

                entity.Property(e => e.UserID).HasColumnName("UserID");
            });

            modelBuilder.Entity<UserGroup>(entity =>
            {
                entity.HasOne(d => d.Group)
                    .WithMany(p => p.UserGroups)
                    .HasForeignKey(d => d.GroupID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserGroups_Groups");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.UserGroupModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_UserGroups_ModifiedByUsers");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserGroups)
                    .HasForeignKey(d => d.UserID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserGroups_Users");
            });

            modelBuilder.Entity<FinancialRiskUserGroup>(entity =>
            {
                entity.HasOne(d => d.Group)
                    .WithMany(p => p.FinancialRiskUserGroups)
                    .HasForeignKey(d => d.GroupID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserGroups_Groups");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.FinancialRiskUserGroupModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_UserGroups_ModifiedByUsers");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.FinancialRiskUserGroups)
                    .HasForeignKey(d => d.UserID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserGroups_Users");
            });

            modelBuilder.Entity<UserPartnerOrganisation>(entity =>
            {
                entity.HasIndex(e => new { e.UserID, e.PartnerOrganisationID })
                    .HasDatabaseName("UQ_UserPartnerOrganisations")
                    .IsUnique();

                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.PartnerOrganisationID).HasColumnName("PartnerOrganisationID");

                entity.Property(e => e.Title).HasMaxLength(50);

                entity.Property(e => e.UserID).HasColumnName("UserID");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.UserPartnerOrganisationModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_UserPartnerOrganisations_ModifiedByUsers");

                entity.HasOne(d => d.PartnerOrganisation)
                    .WithMany(p => p.UserPartnerOrganisations)
                    .HasForeignKey(d => d.PartnerOrganisationID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserPartnerOrganisations_PartnerOrganisations");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserPartnerOrganisations)
                    .HasForeignKey(d => d.UserID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserPartnerOrganisations_Users");
            });

            modelBuilder.Entity<UserProject>(entity =>
            {
                entity.HasIndex(e => new { e.UserID, e.ProjectID })
                    .HasDatabaseName("UQ_UserProjects")
                    .IsUnique();

                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.ProjectID).HasColumnName("ProjectID");

                entity.Property(e => e.Title).HasMaxLength(50);

                entity.Property(e => e.UserID).HasColumnName("UserID");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.UserProjectModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_UserProjects_ModifiedByUsers");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.UserProjects)
                    .HasForeignKey(d => d.ProjectID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserProjects_Projects");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserProjects)
                    .HasForeignKey(d => d.UserID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserProjects_Users");
            });

            modelBuilder.Entity<UserRole>(entity =>
            {
                entity.HasIndex(e => new { e.UserID, e.RoleID })
                    .HasDatabaseName("UQ_UserRoles")
                    .IsUnique();

                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.RoleID).HasColumnName("RoleID");

                entity.Property(e => e.Title).HasMaxLength(50);

                entity.Property(e => e.UserID).HasColumnName("UserID");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.UserRoleModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_UserRoles_ModifiedByUsers");

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.UserRoles)
                    .HasForeignKey(d => d.RoleID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserRoles_Roles");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserRoles)
                    .HasForeignKey(d => d.UserID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserRoles_Users");
            });

            modelBuilder.Entity<WorkStream>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.EntityStatusID).HasColumnName("EntityStatusID");

                entity.Property(e => e.LeadUserID).HasColumnName("LeadUserID");

                entity.Property(e => e.ModifiedByUserID).HasColumnName("ModifiedByUserID");

                entity.Property(e => e.ProjectID).HasColumnName("ProjectID");

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.ReportingStartDate).HasColumnType("datetime2(0)");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.Property(e => e.WorkStreamCode).HasMaxLength(255);

                entity.HasOne(d => d.EntityStatus)
                    .WithMany(p => p.WorkStreams)
                    .HasForeignKey(d => d.EntityStatusID)
                    .HasConstraintName("FK_WorkStreams_EntityStatuses");

                entity.HasOne(d => d.LeadUser)
                    .WithMany(p => p.WorkStreamLeadUsers)
                    .HasForeignKey(d => d.LeadUserID)
                    .HasConstraintName("FK_WorkStreams_Users");

                entity.HasOne(d => d.ModifiedByUser)
                    .WithMany(p => p.WorkStreamModifiedByUsers)
                    .HasForeignKey(d => d.ModifiedByUserID)
                    .HasConstraintName("FK_WorkStreams_ModifiedByUsers");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.WorkStreams)
                    .HasForeignKey(d => d.ProjectID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_WorkStreams_Projects");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.WorkStreams)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_WorkStreams_RagOptions");
            });

            modelBuilder.Entity<WorkStreamUpdate>(entity =>
            {
                entity.Property(e => e.ID).HasColumnName("ID");

                entity.Property(e => e.Comment).HasMaxLength(500);

                entity.Property(e => e.RagOptionID).HasColumnName("RagOptionID");

                entity.Property(e => e.SignOffID).HasColumnName("SignOffID");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.Property(e => e.UpdatePeriod).HasColumnType("date");

                entity.Property(e => e.UpdateUserID).HasColumnName("UpdateUserID");

                entity.Property(e => e.WorkStreamID).HasColumnName("WorkStreamID");

                entity.HasOne(d => d.RagOption)
                    .WithMany(p => p.WorkStreamUpdates)
                    .HasForeignKey(d => d.RagOptionID)
                    .HasConstraintName("FK_WorkStreamUpdates_RagOptions");

                entity.HasOne(d => d.SignOff)
                    .WithMany(p => p.WorkStreamUpdates)
                    .HasForeignKey(d => d.SignOffID)
                    .HasConstraintName("FK_WorkStreamUpdates_SignOffs");

                entity.HasOne(d => d.UpdateUser)
                    .WithMany(p => p.WorkStreamUpdates)
                    .HasForeignKey(d => d.UpdateUserID)
                    .HasConstraintName("FK_WorkStreamUpdates_UpdateUser");

                entity.HasOne(d => d.WorkStream)
                    .WithMany(p => p.WorkStreamUpdates)
                    .HasForeignKey(d => d.WorkStreamID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_WorkStreamUpdates_WorkStreams");
            });

            // Specify that all DateTime columns in database are UTC values
            // https://stackoverflow.com/questions/50727860/ef-core-2-1-hasconversion-on-all-properties-of-type-datetime
            var dateTimeConverter = new ValueConverter<DateTime, DateTime>(v => v, v => DateTime.SpecifyKind(v, DateTimeKind.Utc));

            foreach (var entityType in modelBuilder.Model.GetEntityTypes())
            {
                foreach (var property in entityType.GetProperties())
                {
                    if (property.ClrType == typeof(DateTime) || property.ClrType == typeof(DateTime?))
                        property.SetValueConverter(dateTimeConverter);
                }
            }

        }

    }
}
