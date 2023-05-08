import { useEffect, useState } from 'react';
import { IIntegrationProps } from '../types';

export const useIntegration = (integrationProps: IIntegrationProps): IIntegrationProps => {
    const [integrationName, setIntegrationName] = useState(integrationProps.dataSourceName);
    const [integrateDirectorates, setIntegrateDirectorates] = useState(integrationProps.disableDirectorateManagement);
    const [integrateGroups, setIntegrateGroups] = useState(integrationProps.disableGroupManagement);
    const [integratePartnerOrganisations, setIntegratePartnerOrganisations] = useState(integrationProps.disablePartnerOrganisationManagement);
    const [integrateProjects, setIntegrateProjects] = useState(integrationProps.disableProjectManagement);
    const [integrateUsers, setIntegrateUsers] = useState(integrationProps.disableUserManagement);

    useEffect(() => setIntegrationName(integrationProps.dataSourceName), [integrationProps.dataSourceName]);

    useEffect(() => setIntegrateDirectorates(integrationProps.disableDirectorateManagement), [integrationProps.disableDirectorateManagement]);

    useEffect(() => setIntegrateGroups(integrationProps.disableGroupManagement), [integrationProps.disableGroupManagement]);

    useEffect(() => setIntegratePartnerOrganisations(integrationProps.disablePartnerOrganisationManagement),
        [integrationProps.disablePartnerOrganisationManagement]);

    useEffect(() => setIntegrateProjects(integrationProps.disableProjectManagement), [integrationProps.disableProjectManagement]);

    useEffect(() => setIntegrateUsers(integrationProps.disableUserManagement), [integrationProps.disableUserManagement]);

    return {
        dataSourceName: integrationName,
        disableDirectorateManagement: integrateDirectorates,
        disableGroupManagement: integrateGroups,
        disablePartnerOrganisationManagement: integratePartnerOrganisations,
        disableProjectManagement: integrateProjects,
        disableUserManagement: integrateUsers
    };
};
