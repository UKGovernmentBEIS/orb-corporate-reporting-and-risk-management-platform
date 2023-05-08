using AutoMapper;
using Microsoft.AspNet.OData;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using ORB.Core.Services;
using ORB.Core.ReportViewModels;
using ORB.Services.Validations;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using System.Collections.ObjectModel;

namespace ORB.Services
{
    public class ReportBuilderService : IReportBuilderService
    {
        protected readonly IUnitOfWork _unitOfWork;
        protected readonly ILogger<ReportBuilderService> _logger;
        protected readonly IMapper _mapper;
        protected readonly IMetricService _metricService;
        protected readonly IBenefitService _benefitService;
        protected readonly IProjectService _projectService;

        public ReportBuilderService(IUnitOfWork unitOfWork, ILogger<ReportBuilderService> logger, IMapper mapper,
         IMetricService metricService, IBenefitService benefitService, IProjectService projectService)
        {
            _unitOfWork = unitOfWork;
            _logger = logger;
            _mapper = mapper;
            _metricService = metricService;
            _benefitService = benefitService;
            _projectService = projectService;
        }

        public async Task<SignOffDirectorateViewModel> BuildDirectorateReport(int directorateId, DateTime reportPeriod)
        {
            // Directorate and update

            var directorate = await _unitOfWork.Directorates.Entities
                .Include(d => d.Group)
                .SingleOrDefaultAsync(d => d.ID == directorateId);

            var dates = ReportingCycleService.ReportPeriodDates(directorate, reportPeriod);

            var directorateModel = _mapper.Map<DirectorateViewModel>(directorate);

            var latestDirectorateUpdate = _mapper.Map<DirectorateUpdateViewModel>(await _unitOfWork.DirectorateUpdates.Entities
                .Include(du => du.UpdateUser)
                .OrderByDescending(du => du.UpdateDate)
                .FirstOrDefaultAsync(du => du.DirectorateID == directorateId && du.UpdatePeriod == reportPeriod));

            directorateModel.DirectorateUpdates = latestDirectorateUpdate != null ? new[] { latestDirectorateUpdate } : Array.Empty<DirectorateUpdateViewModel>();


            // Key work areas

            var keyWorkAreas = await _unitOfWork.KeyWorkAreas.Entities
                .Include(k => k.Attributes).ThenInclude(a => a.AttributeType)
                .Include(k => k.LeadUser)
                .Where(k => k.DirectorateID == directorateId)
                .Select(k => _mapper.Map<KeyWorkAreaViewModel>(k))
                .ToListAsync();

            var latestKeyWorkAreaUpdates = _unitOfWork.KeyWorkAreas.Entities
                .Include(k => k.KeyWorkAreaUpdates).ThenInclude(u => u.UpdateUser)
                .Where(k => k.DirectorateID == directorateId)
                .SelectMany(keyWorkArea => keyWorkArea.KeyWorkAreaUpdates.Where(u => u.UpdatePeriod == reportPeriod).OrderByDescending(u => u.UpdateDate).Take(1));

            foreach (var keyWorkArea in keyWorkAreas)
            {
                var update = _mapper.Map<KeyWorkAreaUpdateViewModel>(latestKeyWorkAreaUpdates.SingleOrDefault(ku => ku.KeyWorkAreaID == keyWorkArea.ID));
                keyWorkArea.KeyWorkAreaUpdates = update != null ? new[] { update } : Array.Empty<KeyWorkAreaUpdateViewModel>();
            }

            // Commitments

            var commitments = await _unitOfWork.Commitments.Entities
                .Include(c => c.Attributes).ThenInclude(a => a.AttributeType)
                .Include(c => c.LeadUser)
                .Where(c => c.DirectorateID == directorateId)
                .Select(c => _mapper.Map<CommitmentViewModel>(c))
                .ToListAsync();

            var latestCommitmentUpdates = _unitOfWork.Commitments.Entities
                .Include(c => c.CommitmentUpdates).ThenInclude(u => u.UpdateUser)
                .Where(c => c.DirectorateID == directorateId)
                .SelectMany(commitment => commitment.CommitmentUpdates.Where(u => u.UpdatePeriod == reportPeriod).OrderByDescending(u => u.UpdateDate).Take(1));

            foreach (var commitment in commitments)
            {
                var update = _mapper.Map<CommitmentUpdateViewModel>(latestCommitmentUpdates.SingleOrDefault(cu => cu.CommitmentID == commitment.ID));
                commitment.CommitmentUpdates = update != null ? new[] { update } : Array.Empty<CommitmentUpdateViewModel>();
            }

            // Metrics

            var dueMetricIds = from dueMetric in _metricService.MetricsDueInDirectoratePeriod(directorateId, dates.Start, dates.End)
                               select dueMetric.ID;

            var metrics = _unitOfWork.Metrics.Entities
                            .Include(m => m.LeadUser)
                            .Include(m => m.Attributes).ThenInclude(a => a.AttributeType)
                            .Include(m => m.LeadUser)
                            .Include(m => m.MeasurementUnit)
                            .Include(m => m.Contributors)
                            .Where(m => dueMetricIds.Contains(m.ID))
                            .Select(m => _mapper.Map<MetricViewModel>(m))
                            .ToList();

            var latestMetricUpdates = _unitOfWork.Metrics.Entities
                .Include(m => m.MetricUpdates).ThenInclude(u => u.UpdateUser)
                .Where(m => m.DirectorateID == directorateId)
                .SelectMany(m => m.MetricUpdates.Where(u => u.UpdatePeriod > dates.Start && u.UpdatePeriod <= dates.End).OrderByDescending(u => u.UpdatePeriod).ThenByDescending(u => u.UpdateDate).Take(1));

            foreach (var metric in metrics)
            {
                var update = _mapper.Map<MetricUpdateViewModel>(latestMetricUpdates.SingleOrDefault(mu => mu.MetricID == metric.ID));
                metric.MetricUpdates = update != null ? new[] { update } : Array.Empty<MetricUpdateViewModel>();
            }

            // Milestones

            var milestones = await _unitOfWork.Milestones.Entities
                .Include(m => m.Attributes).ThenInclude(a => a.AttributeType)
                .Include(m => m.LeadUser)
                .Where(m => m.KeyWorkArea.DirectorateID == directorateId)
                .Select(m => _mapper.Map<DirectorateMilestoneViewModel>(m))
                .ToListAsync();

            var latestMilestoneUpdates = _unitOfWork.Milestones.Entities
                .Include(m => m.MilestoneUpdates).ThenInclude(u => u.UpdateUser)
                .Where(m => m.KeyWorkArea.DirectorateID == directorateId)
                .SelectMany(milestone => milestone.MilestoneUpdates.Where(u => u.UpdatePeriod == reportPeriod).OrderByDescending(u => u.UpdateDate).Take(1));

            foreach (var milestone in milestones)
            {
                var update = _mapper.Map<MilestoneUpdateViewModel>(latestMilestoneUpdates.SingleOrDefault(mu => mu.MilestoneID == milestone.ID));
                milestone.MilestoneUpdates = update != null ? new[] { update } : Array.Empty<MilestoneUpdateViewModel>();
            }

            // Projects

            var dueProjectIds = from dueProject in _projectService.ProjectsDueInDirectoratePeriod(directorateId, dates.Start, dates.End)
                                select dueProject.ID;

            var projects = _unitOfWork.Projects.Entities
                            .Include(p => p.Attributes).ThenInclude(a => a.AttributeType)
                            .Include(p => p.SeniorResponsibleOwnerUser)
                            .Where(p => dueProjectIds.Contains(p.ID) && p.ShowOnDirectorateReport == true)
                            .Select(p => _mapper.Map<ProjectViewModel>(p))
                            .ToList();

            var latestProjectUpdates = _unitOfWork.Projects.Entities
                .Where(p => p.DirectorateID == directorateId && p.ShowOnDirectorateReport == true)
                .SelectMany(p =>
                    p.ProjectUpdates.Where(u => u.UpdatePeriod > dates.Start && u.UpdatePeriod <= dates.End).OrderByDescending(u => u.UpdatePeriod).ThenByDescending(u => u.UpdateDate).Take(1)
                );

            foreach (var project in projects)
            {
                var latestProjectUpdate = latestProjectUpdates.SingleOrDefault(pu => pu.ProjectID == project.ID);
                if (latestProjectUpdate != null)
                {
                    latestProjectUpdate.UpdateUser = _unitOfWork.Users.Find((int)latestProjectUpdate.UpdateUserID);
                    project.ProjectUpdates = new[] { _mapper.Map<ProjectUpdateViewModel>(latestProjectUpdate) };
                }
                else
                {
                    project.ProjectUpdates = Array.Empty<ProjectUpdateViewModel>();
                }
            }

            // Custom reporting entities

            var reportingEntityTypes = await _unitOfWork.ReportingEntityTypes.Entities
                .Where(ret => ret.ReportTypeID == (int)ReportTypes.Directorate && ret.ID > 0)
                .Select(ret => _mapper.Map<CustomReportingEntityTypeViewModel>(ret))
                .ToListAsync();

            foreach (var reportingEntityType in reportingEntityTypes)
            {
                var reportingEntities = _unitOfWork.ReportingEntities.Entities
                                        .Include(re => re.Attributes).ThenInclude(a => a.AttributeType)
                                        .Include(re => re.EntityStatus)
                                        .Include(re => re.LeadUser)
                                        .Where(re => re.ReportingEntityTypeID == reportingEntityType.ID && re.DirectorateID == directorateId)
                                        .Select(re => _mapper.Map<CustomReportingEntityViewModel>(re));

                var reportingEntityUpdates = _unitOfWork.ReportingEntityUpdates.Entities
                                                    .Include(reu => reu.RagOption)
                                                    .Include(reu => reu.UpdateUser)
                                                    .Where(reu => reu.UpdatePeriod == reportPeriod && reu.ReportingEntity.ReportingEntityTypeID == reportingEntityType.ID)
                                                    .OrderByDescending(u => u.UpdateDate);

                foreach (var reportingEntity in reportingEntities)
                {
                    var latestReportingEntityUpdate = reportingEntityUpdates.FirstOrDefault(reu => reu.ReportingEntityID == reportingEntity.ID);
                    if (latestReportingEntityUpdate != null)
                    {
                        reportingEntity.ReportingEntityUpdates = new[] { _mapper.Map<CustomReportingEntityUpdateViewModel>(latestReportingEntityUpdate) };
                    }
                    else
                    {
                        reportingEntity.ReportingEntityUpdates = Array.Empty<CustomReportingEntityUpdateViewModel>();
                    }
                }

                reportingEntityType.ReportingEntities = reportingEntities.ToList();
            }

            return new SignOffDirectorateViewModel
            {
                Directorate = directorateModel,
                KeyWorkAreas = keyWorkAreas,
                Milestones = milestones,
                Metrics = metrics,
                Commitments = commitments,
                Projects = projects,
                ReportingEntityTypes = reportingEntityTypes
            };
        }

        public async Task<SignOffProjectViewModel> BuildProjectReport(int projectId, DateTime reportPeriod)
        {
            // Project and update

            var project = await _unitOfWork.Projects.Entities
                .Include(p => p.Attributes).ThenInclude(a => a.AttributeType)
                .SingleOrDefaultAsync(p => p.ID == projectId);

            var dates = ReportingCycleService.ReportPeriodDates(project, reportPeriod);

            var projectModel = _mapper.Map<ProjectViewModel>(project);

            var latestProjectUpdate = _mapper.Map<ProjectUpdateViewModel>(await _unitOfWork.ProjectUpdates.Entities
                .Include(pu => pu.UpdateUser)
                .OrderByDescending(pu => pu.UpdateDate)
                .FirstOrDefaultAsync(pu => pu.ProjectID == projectId && pu.UpdatePeriod == reportPeriod));

            projectModel.ProjectUpdates = latestProjectUpdate != null ? new[] { latestProjectUpdate } : Array.Empty<ProjectUpdateViewModel>();

            // Dependencies

            var dependencies = await _unitOfWork.Dependencies.Entities
                .Include(d => d.Attributes).ThenInclude(a => a.AttributeType)
                .Include(d => d.LeadUser)
                .Where(d => d.ProjectID == projectId)
                .Select(d => _mapper.Map<DependencyViewModel>(d))
                .ToListAsync();

            var latestDependencyUpdates = _unitOfWork.Dependencies.Entities
                .Include(d => d.DependencyUpdates).ThenInclude(du => du.UpdateUser)
                .Where(d => d.ProjectID == projectId)
                .SelectMany(d => d.DependencyUpdates.Where(u => u.UpdatePeriod == reportPeriod).OrderByDescending(u => u.UpdateDate).Take(1));

            foreach (var dependency in dependencies)
            {
                var update = _mapper.Map<DependencyUpdateViewModel>(latestDependencyUpdates.SingleOrDefault(du => du.DependencyID == dependency.ID));
                dependency.DependencyUpdates = update != null ? new[] { update } : Array.Empty<DependencyUpdateViewModel>();
            }

            // Work streams

            var workStreams = await _unitOfWork.WorkStreams.Entities
                .Include(w => w.Attributes).ThenInclude(a => a.AttributeType)
                .Include(w => w.LeadUser)
                .Where(w => w.ProjectID == projectId)
                .Select(w => _mapper.Map<WorkStreamViewModel>(w))
                .ToListAsync();

            var latestWorkStreamUpdates = _unitOfWork.WorkStreams.Entities
                .Include(w => w.WorkStreamUpdates).ThenInclude(u => u.UpdateUser)
                .Where(w => w.ProjectID == projectId)
                .SelectMany(w => w.WorkStreamUpdates.Where(u => u.UpdatePeriod == reportPeriod).OrderByDescending(u => u.UpdateDate).Take(1));

            foreach (var workStream in workStreams)
            {
                var update = _mapper.Map<WorkStreamUpdateViewModel>(latestWorkStreamUpdates.SingleOrDefault(wu => wu.WorkStreamID == workStream.ID));
                workStream.WorkStreamUpdates = update != null ? new[] { update } : Array.Empty<WorkStreamUpdateViewModel>();
            }

            // Benefits

            var benefits = (from dueBenefit in _benefitService.BenefitsDueInProjectPeriod(projectId, dates.Start, dates.End)
                            join benefit in _unitOfWork.Benefits.Entities on dueBenefit.ID equals benefit.ID
                            select benefit).AsQueryable()
                .Include(b => b.Attributes).ThenInclude(a => a.AttributeType)
                .Include(b => b.BenefitType)
                .Include(b => b.LeadUser)
                .Include(b => b.MeasurementUnit)
                .Select(b => _mapper.Map<BenefitViewModel>(b))
                .ToList();

            var latestBenefitUpdates = _unitOfWork.Benefits.Entities
                .Include(b => b.BenefitUpdates).ThenInclude(u => u.UpdateUser)
                .Where(b => b.ProjectID == projectId)
                .SelectMany(b => b.BenefitUpdates.Where(u => u.UpdatePeriod > dates.Start && u.UpdatePeriod <= dates.End).OrderByDescending(u => u.UpdatePeriod).ThenByDescending(u => u.UpdateDate).Take(1));

            foreach (var benefit in benefits)
            {
                var update = _mapper.Map<BenefitUpdateViewModel>(latestBenefitUpdates.SingleOrDefault(bu => bu.BenefitID == benefit.ID));
                benefit.BenefitUpdates = update != null ? new[] { update } : Array.Empty<BenefitUpdateViewModel>();
            }

            // Milestones

            var milestones = await _unitOfWork.Milestones.Entities
                .Include(m => m.Attributes).ThenInclude(a => a.AttributeType)
                .Include(m => m.LeadUser)
                .Where(m => m.WorkStream.ProjectID == projectId)
                .Select(m => _mapper.Map<ProjectMilestoneViewModel>(m))
                .ToListAsync();

            var latestMilestoneUpdates = _unitOfWork.Milestones.Entities
                .Include(m => m.MilestoneUpdates).ThenInclude(u => u.UpdateUser)
                .Where(m => m.WorkStream.ProjectID == projectId)
                .SelectMany(milestone => milestone.MilestoneUpdates.Where(u => u.UpdatePeriod == reportPeriod).OrderByDescending(u => u.UpdateDate).Take(1));

            foreach (var milestone in milestones)
            {
                var update = _mapper.Map<MilestoneUpdateViewModel>(latestMilestoneUpdates.SingleOrDefault(mu => mu.MilestoneID == milestone.ID));
                milestone.MilestoneUpdates = update != null ? new[] { update } : Array.Empty<MilestoneUpdateViewModel>();
            }

            // Sub-projects

            var subProjects = await _unitOfWork.Projects.Entities
                .Include(p => p.Attributes).ThenInclude(a => a.AttributeType)
                .Include(p => p.SeniorResponsibleOwnerUser)
                .Where(p => p.ParentProjectID == projectId && p.EntityStatusID == (int)EntityStatuses.Open)
                .Select(p => _mapper.Map<ProjectViewModel>(p))
                .ToListAsync();

            var latestSubProjectUpdates = _unitOfWork.Projects.Entities
                .Where(p => p.ParentProjectID == projectId && p.EntityStatusID == (int)EntityStatuses.Open)
                .SelectMany(p => p.ProjectUpdates.Where(u => u.UpdatePeriod == reportPeriod).OrderByDescending(u => u.UpdateDate).Take(1));

            foreach (var subProject in subProjects)
            {
                var latestSubProjectUpdate = latestSubProjectUpdates.SingleOrDefault(pu => pu.ProjectID == project.ID);
                if (latestSubProjectUpdate != null)
                {
                    latestSubProjectUpdate.UpdateUser = _unitOfWork.Users.Find((int)latestSubProjectUpdate.UpdateUserID);
                    subProject.ProjectUpdates = new[] { _mapper.Map<ProjectUpdateViewModel>(latestSubProjectUpdate) };
                }
                else
                {
                    subProject.ProjectUpdates = Array.Empty<ProjectUpdateViewModel>();
                }
            }

            // Custom reporting entities

            var reportingEntityTypes = await _unitOfWork.ReportingEntityTypes.Entities
                .Where(ret => ret.ReportTypeID == (int)ReportTypes.Project && ret.ID > 0)
                .Select(ret => _mapper.Map<CustomReportingEntityTypeViewModel>(ret))
                .ToListAsync();

            foreach (var reportingEntityType in reportingEntityTypes)
            {
                var reportingEntities = _unitOfWork.ReportingEntities.Entities
                                        .Include(re => re.Attributes).ThenInclude(a => a.AttributeType)
                                        .Include(re => re.EntityStatus)
                                        .Include(re => re.LeadUser)
                                        .Where(re => re.ReportingEntityTypeID == reportingEntityType.ID && re.ProjectID == projectId)
                                        .Select(re => _mapper.Map<CustomReportingEntityViewModel>(re));

                var reportingEntityUpdates = _unitOfWork.ReportingEntityUpdates.Entities
                                                     .Include(reu => reu.RagOption)
                                                     .Include(reu => reu.UpdateUser)
                                                     .Where(reu => reu.UpdatePeriod == reportPeriod && reu.ReportingEntity.ReportingEntityTypeID == reportingEntityType.ID)
                                                     .OrderByDescending(u => u.UpdateDate);

                foreach (var reportingEntity in reportingEntities)
                {
                    var latestReportingEntityUpdate = reportingEntityUpdates.FirstOrDefault(reu => reu.ReportingEntityID == reportingEntity.ID);
                    if (latestReportingEntityUpdate != null)
                    {
                        reportingEntity.ReportingEntityUpdates = new[] { _mapper.Map<CustomReportingEntityUpdateViewModel>(latestReportingEntityUpdate) };
                    }
                    else
                    {
                        reportingEntity.ReportingEntityUpdates = Array.Empty<CustomReportingEntityUpdateViewModel>();
                    }
                }

                reportingEntityType.ReportingEntities = reportingEntities.ToList();
            }

            return new SignOffProjectViewModel
            {
                Project = projectModel,
                Benefits = benefits,
                Dependencies = dependencies,
                Milestones = milestones,
                Projects = subProjects,
                WorkStreams = workStreams,
                ReportingEntityTypes = reportingEntityTypes
            };
        }

        public async Task<SignOffPartnerOrganisationViewModel> BuildPartnerOrganisationReport(int partnerOrganisationId, DateTime reportPeriod)
        {
            // Partner organisation and update

            var partnerOrganisation = await _unitOfWork.PartnerOrganisations.Entities
                .SingleOrDefaultAsync(p => p.ID == partnerOrganisationId);


            var partnerOrganisationModel = _mapper.Map<PartnerOrganisationViewModel>(partnerOrganisation);

            var latestPartnerOrganisationUpdate = _mapper.Map<PartnerOrganisationUpdateViewModel>(await _unitOfWork.PartnerOrganisationUpdates.Entities
                .Include(pu => pu.UpdateUser)
                .OrderByDescending(pu => pu.UpdateDate)
                .FirstOrDefaultAsync(pu => pu.PartnerOrganisationID == partnerOrganisationId && pu.UpdatePeriod == reportPeriod));

            partnerOrganisationModel.PartnerOrganisationUpdates = latestPartnerOrganisationUpdate != null ? new[] { latestPartnerOrganisationUpdate } : Array.Empty<PartnerOrganisationUpdateViewModel>();

            // Milestones

            var milestones = await _unitOfWork.Milestones.Entities
                .Include(m => m.Attributes).ThenInclude(a => a.AttributeType)
                .Include(m => m.LeadUser)
                .Where(m => m.PartnerOrganisationID == partnerOrganisationId)
                .Select(m => _mapper.Map<PartnerOrganisationMilestoneViewModel>(m))
                .ToListAsync();

            var latestMilestoneUpdates = _unitOfWork.Milestones.Entities
                .Include(m => m.MilestoneUpdates).ThenInclude(u => u.UpdateUser)
                .Where(m => m.PartnerOrganisationID == partnerOrganisationId)
                .SelectMany(m => m.MilestoneUpdates.Where(u => u.UpdatePeriod == reportPeriod).OrderByDescending(u => u.UpdateDate).Take(1));

            foreach (var milestone in milestones)
            {
                var update = _mapper.Map<MilestoneUpdateViewModel>(latestMilestoneUpdates.SingleOrDefault(mu => mu.MilestoneID == milestone.ID));
                milestone.MilestoneUpdates = update != null ? new[] { update } : Array.Empty<MilestoneUpdateViewModel>();
            }

            // Risks

            var risks = await _unitOfWork.PartnerOrganisationRisks.Entities
                .Include(r => r.RiskOwnerUser)
                .Include(r => r.UnmitigatedRiskImpactLevel)
                .Include(r => r.UnmitigatedRiskProbability)
                .Include(r => r.BEISUnmitigatedRiskImpactLevel)
                .Include(r => r.BEISUnmitigatedRiskProbability)
                .Include(r => r.TargetRiskImpactLevel)
                .Include(r => r.TargetRiskProbability)
                .Include(r => r.BEISTargetRiskImpactLevel)
                .Include(r => r.BEISTargetRiskProbability)
                .Where(r => r.PartnerOrganisationID == partnerOrganisationId)
                .Select(r => _mapper.Map<PartnerOrganisationRiskViewModel>(r))
                .ToListAsync();

            var latestRiskUpdates = _unitOfWork.PartnerOrganisationRisks.Entities
                .Include(r => r.PartnerOrganisationRiskUpdates).ThenInclude(u => u.UpdateUser)
                .Include(r => r.PartnerOrganisationRiskUpdates).ThenInclude(u => u.BeisRiskImpactLevel)
                .Include(r => r.PartnerOrganisationRiskUpdates).ThenInclude(u => u.BeisRiskProbability)
                .Include(r => r.PartnerOrganisationRiskUpdates).ThenInclude(u => u.RiskImpactLevel)
                .Include(r => r.PartnerOrganisationRiskUpdates).ThenInclude(u => u.RiskProbability)
                .Where(r => r.PartnerOrganisationID == partnerOrganisationId)
                .SelectMany(r => r.PartnerOrganisationRiskUpdates.Where(u => u.UpdatePeriod == reportPeriod).OrderByDescending(u => u.UpdateDate).Take(1));

            foreach (var risk in risks)
            {
                var update = _mapper.Map<PartnerOrganisationRiskUpdateViewModel>(latestRiskUpdates.SingleOrDefault(ru => ru.PartnerOrganisationRiskID == risk.ID));
                risk.PartnerOrganisationRiskUpdates = update != null ? new[] { update } : Array.Empty<PartnerOrganisationRiskUpdateViewModel>();
            }

            // Risk actions

            var riskActions = await _unitOfWork.PartnerOrganisationRiskMitigationActions.Entities
                .Include(a => a.OwnerUser)
                .Where(a => a.PartnerOrganisationRisk.PartnerOrganisationID == partnerOrganisationId)
                .Select(a => _mapper.Map<PartnerOrganisationRiskMitigationActionViewModel>(a))
                .ToListAsync();

            var latestActionUpdates = _unitOfWork.PartnerOrganisationRiskMitigationActions.Entities
                .Include(a => a.PartnerOrganisationRiskMitigationActionUpdates).ThenInclude(u => u.UpdateUser)
                .Where(a => a.PartnerOrganisationRisk.PartnerOrganisationID == partnerOrganisationId)
                .SelectMany(a => a.PartnerOrganisationRiskMitigationActionUpdates.Where(u => u.UpdatePeriod == reportPeriod).OrderByDescending(u => u.UpdateDate).Take(1));

            foreach (var action in riskActions)
            {
                var update = _mapper.Map<PartnerOrganisationRiskMitigationActionUpdateViewModel>(latestActionUpdates.SingleOrDefault(au => au.PartnerOrganisationRiskMitigationActionID == action.ID));
                action.PartnerOrganisationRiskMitigationActionUpdates = update != null ? new[] { update } : Array.Empty<PartnerOrganisationRiskMitigationActionUpdateViewModel>();
            }

            // Custom reporting entities

            var reportingEntityTypes = await _unitOfWork.ReportingEntityTypes.Entities
                .Where(ret => ret.ReportTypeID == (int)ReportTypes.PartnerOrganistion && ret.ID > 0)
                .Select(ret => _mapper.Map<CustomReportingEntityTypeViewModel>(ret))
                .ToListAsync();

            foreach (var reportingEntityType in reportingEntityTypes)
            {
                var reportingEntities = _unitOfWork.ReportingEntities.Entities
                                        .Include(re => re.Attributes).ThenInclude(a => a.AttributeType)
                                        .Include(re => re.EntityStatus)
                                        .Include(re => re.LeadUser)
                                        .Where(re => re.ReportingEntityTypeID == reportingEntityType.ID && re.PartnerOrganisationID == partnerOrganisationId)
                                        .Select(re => _mapper.Map<CustomReportingEntityViewModel>(re));

                var reportingEntityUpdates = _unitOfWork.ReportingEntityUpdates.Entities
                                                    .Include(reu => reu.RagOption)
                                                    .Include(reu => reu.UpdateUser)
                                                    .Where(reu => reu.UpdatePeriod == reportPeriod && reu.ReportingEntity.ReportingEntityTypeID == reportingEntityType.ID)
                                                    .OrderByDescending(u => u.UpdateDate);

                foreach (var reportingEntity in reportingEntities)
                {
                    var latestReportingEntityUpdate = reportingEntityUpdates.FirstOrDefault(reu => reu.ReportingEntityID == reportingEntity.ID);
                    if (latestReportingEntityUpdate != null)
                    {
                        reportingEntity.ReportingEntityUpdates = new[] { _mapper.Map<CustomReportingEntityUpdateViewModel>(latestReportingEntityUpdate) };
                    }
                    else
                    {
                        reportingEntity.ReportingEntityUpdates = Array.Empty<CustomReportingEntityUpdateViewModel>();
                    }
                }

                reportingEntityType.ReportingEntities = reportingEntities.ToList();
            }

            return new SignOffPartnerOrganisationViewModel
            {
                PartnerOrganisation = partnerOrganisationModel,
                Milestones = milestones,
                PartnerOrganisationRisks = risks,
                PartnerOrganisationRiskMitigationActions = riskActions,
                ReportingEntityTypes = reportingEntityTypes
            };
        }

        public async Task<SignOffCorporateRiskViewModel> BuildRiskReport(int riskId, DateTime reportPeriod)
        {
            // Risk and update

            var risk = await _unitOfWork.CorporateRisks.Entities
                .Include(r => r.Group)
                .Include(r => r.Directorate).ThenInclude(d => d.Group)
                .Include(r => r.Project)
                .Include(r => r.Attributes).ThenInclude(a => a.AttributeType)
                .Include(r => r.UnmitigatedRiskImpactLevel)
                .Include(r => r.UnmitigatedRiskProbability)
                .Include(r => r.TargetRiskImpactLevel)
                .Include(r => r.TargetRiskProbability)
                .Include(r => r.RiskAppetite)
                .Include(r => r.RiskOwnerUser)
                .Include(r => r.RiskRiskTypes).ThenInclude(rrt => rrt.RiskType).ThenInclude(rt => rt.Threshold)
                .SingleOrDefaultAsync(r => r.ID == riskId);

            var latestRiskUpdate = _mapper.Map<RiskUpdateViewModel>(await _unitOfWork.CorporateRiskUpdates.Entities
                .Include(ru => ru.UpdateUser)
                .Include(ru => ru.RiskImpactLevel)
                .Include(ru => ru.RiskProbability)
                .Where(ru => ru.RiskID == riskId && ru.UpdatePeriod == reportPeriod)
                .OrderByDescending(ru => ru.UpdateDate)
                .FirstOrDefaultAsync());

            var riskModel = _mapper.Map<CorporateRiskViewModel>(risk);

            riskModel.RiskUpdates = latestRiskUpdate != null ? new[] { latestRiskUpdate } : Array.Empty<RiskUpdateViewModel>();

            // Actions

            var actions = _unitOfWork.CorporateRiskMitigationActions.Entities
                .Where(a => a.RiskID == riskId || a.CorporateRiskRiskMitigationActions.Any(rrma => rrma.RiskID == riskId))
                .Include(a => a.OwnerUser);

            var actionModels = _mapper.Map<CorporateRiskMitigationActionViewModel[]>(actions);

            var latestActionUpdates = _unitOfWork.CorporateRiskMitigationActions.Entities
                .Include(a => a.RiskMitigationActionUpdates).ThenInclude(u => u.UpdateUser)
                .Where(a => a.RiskID == riskId || a.CorporateRiskRiskMitigationActions.Any(rrma => rrma.RiskID == riskId))
                .SelectMany(action => action.RiskMitigationActionUpdates.Where(u => u.UpdatePeriod == reportPeriod).OrderByDescending(u => u.UpdateDate).Take(1));

            foreach (var action in actionModels)
            {
                if (action.ActionIsOngoing == true && action.OngoingActionReviewFrequency != null)
                {
                    action.NextReviewDate = ReportingCycleService.NextReportDue(
                        (ReportingFrequencies)action.OngoingActionReviewFrequency,
                        (ReportingDueDays?)action.OngoingActionReviewDueDay,
                        action.OngoingActionReviewStartDate,
                        reportPeriod
                    );
                }

                var update = _mapper.Map<RiskMitigationActionUpdateViewModel>(latestActionUpdates.SingleOrDefault(u => u.RiskMitigationActionID == action.ID));
                action.RiskMitigationActionUpdates = update != null ? new[] { update } : Array.Empty<RiskMitigationActionUpdateViewModel>();
            }

            return new SignOffCorporateRiskViewModel
            {
                Risk = riskModel,
                RiskMitigationActions = actionModels
            };
        }

        public async Task<SignOffFinancialRiskViewModel> BuildFinancialRiskReport(int riskId, DateTime reportPeriod)
        {
            // Risk and update

            var risk = await _unitOfWork.FinancialRisks.Entities
                .Include(r => r.Group)
                .Include(r => r.Directorate)
                .Include(r => r.Attributes).ThenInclude(a => a.AttributeType)
                .Include(r => r.UnmitigatedRiskImpactLevel)
                .Include(r => r.UnmitigatedRiskProbability)
                .Include(r => r.TargetRiskImpactLevel)
                .Include(r => r.TargetRiskProbability)
                .Include(r => r.RiskAppetite)
                .Include(r => r.RiskOwnerUser)
                .SingleOrDefaultAsync(r => r.ID == riskId);

            var latestRiskUpdate = await _unitOfWork.FinancialRiskUpdates.Entities
                .Include(ru => ru.UpdateUser)
                .Include(ru => ru.RiskImpactLevel)
                .Include(ru => ru.RiskProbability)
                .Where(ru => ru.RiskID == riskId && ru.UpdatePeriod == reportPeriod)
                .OrderByDescending(ru => ru.UpdateDate)
                .FirstOrDefaultAsync();

            var riskModel = _mapper.Map<FinancialRiskViewModel>(risk);

            riskModel.FinancialRiskUpdates = latestRiskUpdate != null ? new[] { _mapper.Map<FinancialRiskUpdateViewModel>(latestRiskUpdate) } : Array.Empty<FinancialRiskUpdateViewModel>();

            // Actions

            var actions = _unitOfWork.FinancialRiskMitigationActions.Entities
                .Where(a => a.RiskID == riskId || a.FinancialRiskRiskMitigationActions.Any(rrma => rrma.RiskID == riskId))
                .Include(a => a.OwnerUser);

            var actionModels = _mapper.Map<FinancialRiskMitigationActionViewModel[]>(actions);

            var latestActionUpdates = _unitOfWork.FinancialRiskMitigationActions.Entities
                .Include(a => a.FinancialRiskMitigationActionUpdates).ThenInclude(u => u.UpdateUser)
                .Where(a => a.RiskID == riskId || a.FinancialRiskRiskMitigationActions.Any(rrma => rrma.RiskID == riskId))
                .SelectMany(action => action.FinancialRiskMitigationActionUpdates.Where(u => u.UpdatePeriod == reportPeriod).OrderByDescending(u => u.UpdateDate).Take(1));

            foreach (var action in actionModels)
            {
                var update = _mapper.Map<FinancialRiskMitigationActionUpdateViewModel>(latestActionUpdates.SingleOrDefault(u => u.RiskMitigationActionID == action.ID));
                action.FinancialRiskMitigationActionUpdates = update != null ? new[] { update } : Array.Empty<FinancialRiskMitigationActionUpdateViewModel>();
            }

            return new SignOffFinancialRiskViewModel
            {
                FinancialRisk = riskModel,
                FinancialRiskMitigationActions = actionModels
            };
        }

        public bool? DirectorateReportsAreIdentical(SignOffDirectorateViewModel report1, SignOffDirectorateViewModel report2)
        {
            if (report1 == null || report2 == null)
            {
                return null;
            }

            if (report1.Directorate.ID != report2.Directorate.ID) { return false; }

            if (report1.Commitments.Count != report2.Commitments.Count
                || report1.KeyWorkAreas.Count != report2.KeyWorkAreas.Count
                || report1.Metrics.Count != report2.Metrics.Count
                || report1.Milestones.Count != report2.Milestones.Count
                || report1.Projects.Count != report2.Projects.Count
                || ((report1.ReportingEntityTypes == null || report2.ReportingEntityTypes == null) && report1.ReportingEntityTypes != report2.ReportingEntityTypes)
                || report1.ReportingEntityTypes.Count != report2.ReportingEntityTypes.Count)
            {
                return false;
            }

            var r1CommitmentUpdates = report1.Commitments.Select(c => c.CommitmentUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2CommitmentUpdates = report2.Commitments.Select(c => c.CommitmentUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r1KeyWorkAreaUpdates = report1.KeyWorkAreas.Select(k => k.KeyWorkAreaUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2KeyWorkAreaUpdates = report2.KeyWorkAreas.Select(k => k.KeyWorkAreaUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r1MetricUpdates = report1.Metrics.Select(m => m.MetricUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2MetricUpdates = report2.Metrics.Select(m => m.MetricUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r1MilestoneUpdates = report1.Milestones.Select(m => m.MilestoneUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2MilestoneUpdates = report2.Milestones.Select(m => m.MilestoneUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r1ProjectUpdates = report1.Projects.Select(p => p.ProjectUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2ProjectUpdates = report2.Projects.Select(p => p.ProjectUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r1ReportingEntityUpdates = report1.ReportingEntityTypes.SelectMany(ret => ret.ReportingEntities.Select(re => re.ReportingEntityUpdates.SingleOrDefault()?.ID)).ToHashSet();
            var r2ReportingEntityUpdates = report2.ReportingEntityTypes.SelectMany(ret => ret.ReportingEntities.Select(re => re.ReportingEntityUpdates.SingleOrDefault()?.ID)).ToHashSet();

            if (!r1CommitmentUpdates.SetEquals(r2CommitmentUpdates)
                || report1.Directorate.DirectorateUpdates.SingleOrDefault()?.ID != report2.Directorate.DirectorateUpdates.SingleOrDefault()?.ID
                || !r1KeyWorkAreaUpdates.SetEquals(r2KeyWorkAreaUpdates)
                || !r1MetricUpdates.SetEquals(r2MetricUpdates)
                || !r1MilestoneUpdates.SetEquals(r2MilestoneUpdates)
                || !r1ProjectUpdates.SetEquals(r2ProjectUpdates)
                || !r1ReportingEntityUpdates.SetEquals(r2ReportingEntityUpdates))
            {
                return false;
            }

            return true;
        }

        public bool? ProjectReportsAreIdentical(SignOffProjectViewModel report1, SignOffProjectViewModel report2)
        {
            if (report1 == null || report2 == null)
            {
                return null;
            }

            if (report1.Project.ID != report2.Project.ID) { return false; }

            if (report1.Benefits.Count != report2.Benefits.Count
                || report1.Dependencies.Count != report2.Dependencies.Count
                || report1.Milestones.Count != report2.Milestones.Count
                || report1.Projects.Count != report2.Projects.Count
                || ((report1.ReportingEntityTypes == null || report2.ReportingEntityTypes == null) && report1.ReportingEntityTypes != report2.ReportingEntityTypes)
                || report1.ReportingEntityTypes.Count != report2.ReportingEntityTypes.Count
                || report1.WorkStreams.Count != report2.WorkStreams.Count)
            {
                return false;
            }

            var r1BenefitUpdates = report1.Benefits.Select(c => c.BenefitUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2BenefitUpdates = report2.Benefits.Select(c => c.BenefitUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r1DependencyUpdates = report1.Dependencies.Select(k => k.DependencyUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2DependencyUpdates = report2.Dependencies.Select(k => k.DependencyUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r1MilestoneUpdates = report1.Milestones.Select(m => m.MilestoneUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2MilestoneUpdates = report2.Milestones.Select(m => m.MilestoneUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r1ProjectUpdates = report1.Projects.Select(m => m.ProjectUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2ProjectUpdates = report2.Projects.Select(m => m.ProjectUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r1ReportingEntityUpdates = report1.ReportingEntityTypes.SelectMany(ret => ret.ReportingEntities.Select(re => re.ReportingEntityUpdates.SingleOrDefault()?.ID)).ToHashSet();
            var r2ReportingEntityUpdates = report2.ReportingEntityTypes.SelectMany(ret => ret.ReportingEntities.Select(re => re.ReportingEntityUpdates.SingleOrDefault()?.ID)).ToHashSet();
            var r1WorkStreamUpdates = report1.WorkStreams.Select(p => p.WorkStreamUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2WorkStreamUpdates = report2.WorkStreams.Select(p => p.WorkStreamUpdates.SingleOrDefault()?.ID).ToHashSet();

            if (!r1BenefitUpdates.SetEquals(r2BenefitUpdates)
                || !r1DependencyUpdates.SetEquals(r2DependencyUpdates)
                || !r1MilestoneUpdates.SetEquals(r2MilestoneUpdates)
                || !r1ProjectUpdates.SetEquals(r2ProjectUpdates)
                || report1.Project.ProjectUpdates.SingleOrDefault()?.ID != report2.Project.ProjectUpdates.SingleOrDefault()?.ID
                || !r1ReportingEntityUpdates.SetEquals(r2ReportingEntityUpdates)
                || !r1WorkStreamUpdates.SetEquals(r2WorkStreamUpdates))
            {
                return false;
            }

            return true;
        }

        public bool? PartnerOrganisationReportsAreIdentical(SignOffPartnerOrganisationViewModel report1, SignOffPartnerOrganisationViewModel report2)
        {
            if (report1 == null || report2 == null)
            {
                return null;
            }

            if (report1.PartnerOrganisation.ID != report2.PartnerOrganisation.ID) { return false; }

            if (report1.Milestones.Count != report2.Milestones.Count
                || report1.PartnerOrganisationRiskMitigationActions.Count != report2.PartnerOrganisationRiskMitigationActions.Count
                || report1.PartnerOrganisationRisks.Count != report2.PartnerOrganisationRisks.Count
                || ((report1.ReportingEntityTypes == null || report2.ReportingEntityTypes == null) && report1.ReportingEntityTypes != report2.ReportingEntityTypes)
                || report1.ReportingEntityTypes.Count != report2.ReportingEntityTypes.Count)
            {
                return false;
            }

            var r1MilestoneUpdates = report1.Milestones.Select(m => m.MilestoneUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2MilestoneUpdates = report2.Milestones.Select(m => m.MilestoneUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r1PartnerOrganisationRiskMitigationActions = report1.PartnerOrganisationRiskMitigationActions.Select(m => m.PartnerOrganisationRiskMitigationActionUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2PartnerOrganisationRiskMitigationActions = report2.PartnerOrganisationRiskMitigationActions.Select(m => m.PartnerOrganisationRiskMitigationActionUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r1PartnerOrganisationRisks = report1.PartnerOrganisationRisks.Select(p => p.PartnerOrganisationRiskUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2PartnerOrganisationRisks = report2.PartnerOrganisationRisks.Select(p => p.PartnerOrganisationRiskUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r1ReportingEntityUpdates = report1.ReportingEntityTypes.SelectMany(ret => ret.ReportingEntities.Select(re => re.ReportingEntityUpdates.SingleOrDefault()?.ID)).ToHashSet();
            var r2ReportingEntityUpdates = report2.ReportingEntityTypes.SelectMany(ret => ret.ReportingEntities.Select(re => re.ReportingEntityUpdates.SingleOrDefault()?.ID)).ToHashSet();

            if (!r1MilestoneUpdates.SetEquals(r2MilestoneUpdates)
                || report1.PartnerOrganisation.PartnerOrganisationUpdates.SingleOrDefault()?.ID != report2.PartnerOrganisation.PartnerOrganisationUpdates.SingleOrDefault()?.ID
                || !r1PartnerOrganisationRiskMitigationActions.SetEquals(r2PartnerOrganisationRiskMitigationActions)
                || !r1PartnerOrganisationRisks.SetEquals(r2PartnerOrganisationRisks)
                || !r1ReportingEntityUpdates.SetEquals(r2ReportingEntityUpdates))
            {
                return false;
            }

            return true;
        }

        public bool? RiskReportsAreIdentical(SignOffCorporateRiskViewModel report1, SignOffCorporateRiskViewModel report2)
        {
            if (report1 == null || report2 == null)
            {
                return null;
            }

            if (report1.Risk.ID != report2.Risk.ID) { return false; }

            if (report1.RiskMitigationActions.Count != report2.RiskMitigationActions.Count)
            {
                return false;
            }

            var r1RiskMitigationActions = report1.RiskMitigationActions.Select(m => m.RiskMitigationActionUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2RiskMitigationActions = report2.RiskMitigationActions.Select(m => m.RiskMitigationActionUpdates.SingleOrDefault()?.ID).ToHashSet();

            if (report1.Risk.RiskUpdates.SingleOrDefault()?.ID != report2.Risk.RiskUpdates.SingleOrDefault()?.ID
                || !r1RiskMitigationActions.SetEquals(r2RiskMitigationActions))
            {
                return false;
            }

            return true;
        }

        public bool? FinancialRiskReportsAreIdentical(SignOffFinancialRiskViewModel report1, SignOffFinancialRiskViewModel report2)
        {
            if (report1 == null || report2 == null)
            {
                return null;
            }

            if (report1.FinancialRisk.ID != report2.FinancialRisk.ID) { return false; }

            if (report1.FinancialRiskMitigationActions.Count != report2.FinancialRiskMitigationActions.Count)
            {
                return false;
            }

            var r1RiskMitigationActions = report1.FinancialRiskMitigationActions.Select(m => m.FinancialRiskMitigationActionUpdates.SingleOrDefault()?.ID).ToHashSet();
            var r2RiskMitigationActions = report2.FinancialRiskMitigationActions.Select(m => m.FinancialRiskMitigationActionUpdates.SingleOrDefault()?.ID).ToHashSet();

            if (report1.FinancialRisk.FinancialRiskUpdates.SingleOrDefault()?.ID != report2.FinancialRisk.FinancialRiskUpdates.SingleOrDefault()?.ID
                || !r1RiskMitigationActions.SetEquals(r2RiskMitigationActions))
            {
                return false;
            }

            return true;
        }
    }
}
