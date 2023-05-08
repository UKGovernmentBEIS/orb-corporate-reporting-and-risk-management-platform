import React from 'react';
import styles from '../../../styles/cr.module.scss';
import { IWebPartComponentProps } from '../../../types';
import { GroupSummaryList } from '../../../components/group/GroupSummaryList';
import { GroupRagSummary } from '../../../components/group/GroupRagSummary';
import { withErrorHandling, IWithErrorHandlingProps } from '../../../components/withErrorHandling';
import { ErrorBoundary } from '../../../components/ErrorBoundary';

const DgDashboard: React.FC<IWebPartComponentProps & IWithErrorHandlingProps> = props =>
	<ErrorBoundary>
		<h2 className={styles.fontSize18}>Director General Dashboard</h2>
		<GroupSummaryList {...props} />
		<h2 className={styles.fontSize18}>Group RAG Summary</h2>
		<GroupRagSummary {...props} />
	</ErrorBoundary>;

export default withErrorHandling(DgDashboard);
