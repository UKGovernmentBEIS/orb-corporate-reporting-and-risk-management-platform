import React, { useContext, useEffect, useState } from 'react';
import { ReportTypes } from '../../refData/ReportTypes';
import { ICustomReportingEntity, ICustomReportingEntityType, ListDefaults } from "../../types";
import { DataContext } from '../DataContext';
import { EntityList } from "../EntityList";
import { IUseApiProps } from '../useApi';
import { IWithErrorHandlingProps } from '../withErrorHandling';
import { ReportingEntityForm } from "./ReportingEntityForm";

interface IReportingEntityListProps extends IUseApiProps, IWithErrorHandlingProps {
    reportingEntityTypeId: number;
}

export const ReportingEntityList = (props: IReportingEntityListProps): React.ReactElement => {
    const { reportingEntityTypeId } = props;
    const { dataServices } = useContext(DataContext);
    const [reportingEntityType, setCustomReportingEntityType] = useState<ICustomReportingEntityType>(null);

    useEffect(() => {
        const loadType = async () => {
            setCustomReportingEntityType(await dataServices.reportingEntityTypeService.read(reportingEntityTypeId));
        };

        loadType();
    }, [reportingEntityTypeId, dataServices.reportingEntityTypeService]);

    const lcc = ListDefaults.columnWidths;
    const entityParent = reportingEntityType?.ReportTypeID === ReportTypes.Directorate ? { name: 'Directorate', field: 'Directorate' }
        : reportingEntityType?.ReportTypeID === ReportTypes.Project ? { name: 'Project', field: 'Project' }
            : reportingEntityType?.ReportTypeID === ReportTypes.PartnerOrganisation ? { name: 'Partner organisation', field: 'PartnerOrganisation' }
                : { name: null, field: null };

    return reportingEntityType && (
        <div key={reportingEntityType?.ID}>
            <EntityList<ICustomReportingEntity>
                {...props}
                entity="Custom"
                enableShowHideClosedEntities={true}
                entityName={{ Plural: reportingEntityType?.Title, Singular: reportingEntityType?.Title }}
                columns={[
                    { key: '1', name: 'Name', fieldName: 'Name', minWidth: 200, maxWidth: 400, isResizable: true },
                    { key: '2', name: entityParent.name, fieldName: entityParent.field, minWidth: 200, isResizable: true },
                    { key: '3', name: 'Lead', fieldName: 'Lead', minWidth: lcc.user, isResizable: true },
                    { key: '4', name: 'Contributors', fieldName: 'Contributors', minWidth: lcc.user, isResizable: true },
                    { key: '5', name: 'Status', fieldName: 'Status', minWidth: 100, isResizable: true }
                ]}
                loadListItems={showClosedEntities => dataServices.reportingEntityService.readAllForReportingEntityList(reportingEntityType.ID, showClosedEntities)}
                mapEntitiesToListItems={entities => entities.map(e => (
                    {
                        key: e.ID,
                        Directorate: e.Directorate?.Title,
                        Project: e.Project?.Title,
                        PartnerOrganisation: e.PartnerOrganisation?.Title,
                        Name: e.Title,
                        Lead: e.LeadUser?.Title,
                        Contributors: e.Contributors?.map(co => co.ContributorUser?.Title).join(', '),
                        Status: e.EntityStatus?.Title
                    }
                ))}
                entityForm={(showForm, entityId, onSaved, onCancelled) =>
                    <ReportingEntityForm
                        {...props}
                        entityName={reportingEntityType?.Title}
                        showForm={showForm}
                        entityId={entityId}
                        onSaved={onSaved}
                        onCancelled={onCancelled}
                        reportingEntityTypeId={reportingEntityType?.ID}
                    />
                }
                onCheckDelete={id => dataServices.reportingEntityService.entityChildren(id)}
                onDelete={id => dataServices.reportingEntityService.delete(id)}
            />
        </div>
    );
};