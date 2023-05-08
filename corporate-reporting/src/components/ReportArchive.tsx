import React from 'react';
import { IWebPartComponentProps } from '../types';
import { SignOffReviewList } from './signOff/SignOffReviewList';
import { IWithErrorHandlingProps, withErrorHandling } from './withErrorHandling';

interface IReportArchiveProps extends IWebPartComponentProps, IWithErrorHandlingProps {
    apiConnected: boolean;
}

const ReportArchive = (props: IReportArchiveProps) => <SignOffReviewList {...props} />;

export default withErrorHandling(ReportArchive);
