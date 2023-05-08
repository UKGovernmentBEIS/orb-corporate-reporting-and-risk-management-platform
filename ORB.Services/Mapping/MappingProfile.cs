using AutoMapper;
using ORB.Core.Models;
using mdl = ORB.Core.Models;
using ORB.Core.ReportViewModels;

namespace ORB.Services.Mapping
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            // Domain to Resource
            CreateMap<mdl.Attribute, BenefitAttributeViewModel>();
            CreateMap<mdl.Attribute, CommitmentAttributeViewModel>();
            CreateMap<mdl.Attribute, CustomReportingEntityAttributeViewModel>();
            CreateMap<mdl.Attribute, DependencyAttributeViewModel>();
            CreateMap<mdl.Attribute, KeyWorkAreaAttributeViewModel>();
            CreateMap<mdl.Attribute, MetricAttributeViewModel>();
            CreateMap<mdl.Attribute, MilestoneAttributeViewModel>();
            CreateMap<mdl.Attribute, ProjectAttributeViewModel>();
            CreateMap<mdl.Attribute, RiskAttributeViewModel>();
            CreateMap<mdl.Attribute, WorkStreamAttributeViewModel>();
            CreateMap<AttributeType, AttributeTypeViewModel>();
            CreateMap<Benefit, BenefitViewModel>();
            CreateMap<BenefitUpdate, BenefitUpdateViewModel>();
            CreateMap<Commitment, CommitmentViewModel>();
            CreateMap<CommitmentUpdate, CommitmentUpdateViewModel>();
            CreateMap<Contributor, CommitmentContributorViewModel>();
            CreateMap<Contributor, CustomReportingEntityContributorViewModel>();
            CreateMap<Contributor, DependencyContributorViewModel>();
            CreateMap<Contributor, KeyWorkAreaContributorViewModel>();
            CreateMap<Contributor, MetricContributorViewModel>();
            CreateMap<Contributor, RiskContributorViewModel>();
            CreateMap<Contributor, WorkStreamContributorViewModel>();
            CreateMap<CustomReportingEntity, CustomReportingEntityViewModel>();
            CreateMap<CustomReportingEntityType, CustomReportingEntityTypeViewModel>();
            CreateMap<CustomReportingEntityUpdate, CustomReportingEntityUpdateViewModel>();
            CreateMap<CorporateRisk, CorporateRiskViewModel>();
            CreateMap<CorporateRiskMitigationAction, CorporateRiskMitigationActionViewModel>();
            CreateMap<Dependency, DependencyViewModel>();
            CreateMap<DependencyUpdate, DependencyUpdateViewModel>();
            CreateMap<Directorate, DirectorateViewModel>();
            CreateMap<Directorate, RiskDirectorateViewModel>();
            CreateMap<DirectorateUpdate, DirectorateUpdateViewModel>();
            CreateMap<EntityStatus, EntityStatusViewModel>();
            CreateMap<FinancialRiskMitigationAction, FinancialRiskMitigationActionViewModel>();
            CreateMap<FinancialRiskMitigationActionUpdate, FinancialRiskMitigationActionUpdateViewModel>();
            CreateMap<FinancialRisk, FinancialRiskViewModel>();
            CreateMap<FinancialRiskUpdate, FinancialRiskUpdateViewModel>();
            CreateMap<Group, GroupViewModel>();
            CreateMap<Group, RiskGroupViewModel>();
            CreateMap<KeyWorkArea, KeyWorkAreaViewModel>();
            CreateMap<KeyWorkAreaUpdate, KeyWorkAreaUpdateViewModel>();
            CreateMap<Metric, MetricViewModel>();
            CreateMap<MetricUpdate, MetricUpdateViewModel>();
            CreateMap<Milestone, DirectorateMilestoneViewModel>();
            CreateMap<Milestone, PartnerOrganisationMilestoneViewModel>();
            CreateMap<Milestone, ProjectMilestoneViewModel>();
            CreateMap<MilestoneUpdate, MilestoneUpdateViewModel>();
            CreateMap<PartnerOrganisation, PartnerOrganisationViewModel>();
            CreateMap<PartnerOrganisationUpdate, PartnerOrganisationUpdateViewModel>();
            CreateMap<PartnerOrganisationRisk, PartnerOrganisationRiskViewModel>();
            CreateMap<PartnerOrganisationRiskUpdate, PartnerOrganisationRiskUpdateViewModel>();
            CreateMap<PartnerOrganisationRiskMitigationAction, PartnerOrganisationRiskMitigationActionViewModel>();
            CreateMap<PartnerOrganisationRiskMitigationActionUpdate, PartnerOrganisationRiskMitigationActionUpdateViewModel>();
            CreateMap<Project, ProjectViewModel>();
            CreateMap<ProjectUpdate, ProjectUpdateViewModel>();
            CreateMap<RagOption, RagOptionViewModel>();
            CreateMap<ReportingField, ReportingFieldViewModel>();
            CreateMap<RiskAppetite, RiskAppetiteViewModel>();
            CreateMap<RiskImpactLevel, RiskImpactLevelViewModel>();
            CreateMap<RiskProbability, RiskProbabilityViewModel>();
            CreateMap<RiskUpdate, RiskUpdateViewModel>();
            CreateMap<RiskMitigationAction, RiskMitigationActionViewModel>();
            CreateMap<RiskMitigationActionUpdate, RiskMitigationActionUpdateViewModel>();
            CreateMap<RiskRiskType, RiskRiskTypeViewModel>();
            CreateMap<RiskType, RiskTypeViewModel>();
            CreateMap<Threshold, ThresholdViewModel>();
            CreateMap<SignOff, SignOffCorporateRiskViewModel>();
            CreateMap<User, UserViewModel>();
            CreateMap<WorkStream, WorkStreamViewModel>();
            CreateMap<WorkStreamUpdate, WorkStreamUpdateViewModel>();

            // Resource to Domain

        }
    }
}
