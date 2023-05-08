import React, { useContext, useMemo } from 'react';
import {
	IFinancialRisk,
	IFinancialRiskMitigationAction,
	ListDefaults,
	ICorporateRiskMitigationAction,
	ICorporateRisk
} from '../types';
import { EntityList } from './EntityList';
import { RiskForm } from './risk/RiskForm';
import { RiskMitigationActionForm } from './riskMitigationAction/RiskMitigationActionForm';
import { ErrorBoundary } from './ErrorBoundary';
import { IWithErrorHandlingProps, withErrorHandling } from './withErrorHandling';
import { IUseApiProps } from './useApi';
import { FinancialRiskForm } from './financialRisk/FinancialRiskForm';
import { DataContext } from './DataContext';
import { FinancialRiskMitigationActionForm } from './financialRisk/FinancialRiskMitigationActionForm';

export interface IRiskReportingAdminProps extends IUseApiProps, IWithErrorHandlingProps {
	entity: string;
}

const RiskReportingAdmin = (props: IRiskReportingAdminProps): React.ReactElement => {
	const { entity } = props;
	const { dataServices, loadLookupData: { corporateRisks, financialRisks } } = useContext(DataContext);

	useMemo(() => corporateRisks(), [corporateRisks]);
	useMemo(() => financialRisks(), [financialRisks]);

	const lcc = ListDefaults.columnWidths;
	return (
		<ErrorBoundary>
			{entity === 'Risks' &&
				<EntityList<ICorporateRisk>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Risks', Singular: 'Risk' }}
					addChild={{ Name: 'Risk mitigating action' }}
					columns={[
						{ key: '1', name: 'Risk ID', fieldName: 'RiskCode', minWidth: 70, maxWidth: 70, isResizable: true },
						{ key: '2', name: 'Risk name', fieldName: 'Name', minWidth: 250, isResizable: true },
						{ key: '3', name: 'Register', fieldName: 'Register', minWidth: 100, isResizable: true },
						{ key: '4', name: 'Group', fieldName: 'Group', minWidth: 100, isResizable: true },
						{ key: '5', name: 'Directorate', fieldName: 'Directorate', minWidth: 100, isResizable: true },
						{ key: '6', name: 'Owner', fieldName: 'Owner', minWidth: lcc.user, isResizable: true },
						{ key: '7', name: 'Contributors', fieldName: 'Contributors', minWidth: lcc.user, isResizable: true },
						{ key: '8', name: 'No. of actions', fieldName: 'NumberOfActions', minWidth: 50, isResizable: true },
						{ key: '9', name: 'Status', fieldName: 'Status', minWidth: 50, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.corporateRiskService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={risks => risks.map(r => (
						{
							key: r.ID,
							Register: r.RiskRegister?.Title,
							RiskCode: r.RiskCode,
							Name: r.Title,
							Group: r.Directorate?.Group?.Title,
							Directorate: r.Directorate?.Title,
							Owner: r.RiskOwnerUser?.Title,
							Contributors: r.Contributors?.map(c => c.ContributorUser?.Title).join(', '),
							NumberOfActions: r.RiskMitigationActions?.length,
							Status: r.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<RiskForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					childEntityForm={(showForm, parentEntityId, onSaved, onCancelled) =>
						<RiskMitigationActionForm
							{...props}
							maxDependentRisks={1}
							showForm={showForm}
							onSaved={onSaved}
							onCancelled={onCancelled}
							defaultValues={[{ field: 'RiskID', value: parentEntityId }]}
						/>
					}
					onCheckDelete={id => dataServices.corporateRiskService.entityChildren(id)}
					onDelete={id => dataServices.corporateRiskService.delete(id)}
					onChange={() => corporateRisks(true)}
				/>
			}
			{entity === 'RiskMitigationActions' &&
				<EntityList<ICorporateRiskMitigationAction>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Risk mitigating actions', Singular: 'Risk mitigating action' }}
					columns={[
						{ key: '0', name: 'Risk ID', fieldName: 'RiskCode', minWidth: 50, maxWidth: 70, isResizable: true },
						{ key: '1', name: 'ID', fieldName: 'Code', minWidth: 20, maxWidth: 20, isResizable: true },
						{ key: '2', name: 'Risk mitigating action name', fieldName: 'Name', minWidth: 300, isResizable: true },
						{ key: '3', name: 'Risk', fieldName: 'Risk', minWidth: 200, isResizable: true },
						{ key: '4', name: 'Owner', fieldName: 'Owner', minWidth: lcc.user, isResizable: true },
						{ key: '5', name: 'Contributors', fieldName: 'Contributors', minWidth: lcc.user, isResizable: true },
						{ key: '6', name: 'Status', fieldName: 'Status', minWidth: 50, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.corporateRiskMitigationActionService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={riskMitigationActions => riskMitigationActions.map(a => (
						{
							key: a.ID,
							RiskCode: a.Risk?.RiskCode,
							Code: a.RiskMitigationActionCode,
							Risk: a.Risk?.Title,
							Name: a.Title,
							Owner: a.OwnerUser?.Title,
							Contributors: a.Contributors?.map(c => c.ContributorUser?.Title).join(', '),
							Status: a.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<RiskMitigationActionForm
							{...props}
							maxDependentRisks={1}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onCheckDelete={id => dataServices.corporateRiskMitigationActionService.entityChildren(id)}
					onDelete={id => dataServices.corporateRiskMitigationActionService.delete(id)}
				/>
			}
			{entity === 'FinancialRisks' &&
				<EntityList<IFinancialRisk>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Financial risks', Singular: 'Financial risk' }}
					addChild={{ Name: 'Risk mitigating action' }}
					columns={[
						{ key: '1', name: 'Risk ID', fieldName: 'RiskCode', minWidth: 70, maxWidth: 70, isResizable: true },
						{ key: '2', name: 'Risk name', fieldName: 'Name', minWidth: 250, isResizable: true },
						{ key: '4', name: 'Group', fieldName: 'Group', minWidth: 100, isResizable: true },
						{ key: '5', name: 'Directorate', fieldName: 'Directorate', minWidth: 100, isResizable: true },
						{ key: '6', name: 'Owner', fieldName: 'Owner', minWidth: lcc.user, isResizable: true },
						{ key: '7', name: 'Contributors', fieldName: 'Contributors', minWidth: lcc.user, isResizable: true },
						{ key: '8', name: 'No. of actions', fieldName: 'NumberOfActions', minWidth: 50, isResizable: true },
						{ key: '9', name: 'Status', fieldName: 'Status', minWidth: 50, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.financialRiskService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={risks => risks.map(r => (
						{
							key: r.ID,
							RiskCode: r.RiskCode,
							Name: r.Title,
							Group: r.OwnedByMultipleGroups ? `Central` : r.Group?.Title,
							Directorate: r.OwnedByMultipleGroups ? `Central` : r.OwnedByDgOffice ? `DG Office` : r.Directorate?.Title,
							Owner: r.RiskOwnerUser?.Title,
							Contributors: r.Contributors?.map(c => c.ContributorUser?.Title).join(', '),
							NumberOfActions: r.FinancialRiskMitigationActions?.length,
							Status: r.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<FinancialRiskForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					childEntityForm={(showForm, parentEntityId, onSaved, onCancelled) =>
						<FinancialRiskMitigationActionForm
							{...props}
							showForm={showForm}
							onSaved={onSaved}
							onCancelled={onCancelled}
							defaultValues={[{ field: 'RiskID', value: parentEntityId }]}
						/>
					}
					onCheckDelete={id => dataServices.financialRiskService.entityChildren(id)}
					onDelete={id => dataServices.financialRiskService.delete(id)}
					onChange={() => financialRisks(true)}
				/>
			}
			{entity === 'FinancialRiskMitigationActions' &&
				<EntityList<IFinancialRiskMitigationAction>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Financial risk mitigating actions', Singular: 'Financial risk mitigating action' }}
					columns={[
						{ key: '0', name: 'Risk ID', fieldName: 'RiskCode', minWidth: 50, maxWidth: 70, isResizable: true },
						{ key: '1', name: 'ID', fieldName: 'Code', minWidth: 20, maxWidth: 20, isResizable: true },
						{ key: '2', name: 'Risk mitigating action name', fieldName: 'Name', minWidth: 300, isResizable: true },
						{ key: '3', name: 'Risk', fieldName: 'Risk', minWidth: 200, isResizable: true },
						{ key: '4', name: 'Owner', fieldName: 'Owner', minWidth: lcc.user, isResizable: true },
						{ key: '5', name: 'Contributors', fieldName: 'Contributors', minWidth: lcc.user, isResizable: true },
						{ key: '6', name: 'Status', fieldName: 'Status', minWidth: 50, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.financialRiskMitigationActionService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={riskMitigationActions => riskMitigationActions.map(a => (
						{
							key: a.ID,
							RiskCode: a.FinancialRisk?.RiskCode,
							Code: a.RiskMitigationActionCode,
							Risk: a.FinancialRisk?.Title,
							Name: a.Title,
							Owner: a.OwnerUser?.Title,
							Contributors: a.Contributors?.map(c => c.ContributorUser?.Title).join(', '),
							Status: a.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<FinancialRiskMitigationActionForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onCheckDelete={id => dataServices.financialRiskMitigationActionService.entityChildren(id)}
					onDelete={id => dataServices.financialRiskMitigationActionService.delete(id)}
				/>
			}
		</ErrorBoundary>
	);
};

export default withErrorHandling(RiskReportingAdmin);
