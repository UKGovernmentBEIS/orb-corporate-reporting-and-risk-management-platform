import React from 'react';
import { ActivityItem, Icon, TooltipHost } from 'office-ui-fabric-react';
import { DateService } from '../../services';

export interface ICrPreviousApprovalDetailsProps {
    className?: string;
    previouslyApproved: boolean;
    approvedBy?: string;
    approvedDate?: Date;
    changedSinceApproval?: boolean;
}

export const CrPreviousApprovalDetails = ({ className, previouslyApproved, approvedBy, approvedDate, changedSinceApproval }: ICrPreviousApprovalDetailsProps): React.ReactElement => {
    const person = approvedBy || `[unknown]`;
    const time = DateService.relativeToNow(approvedDate);
    return (
        <ActivityItem
            className={className}
            activityDescription={
                !previouslyApproved ?
                    <span>This report has not been approved.</span>
                    : previouslyApproved && !changedSinceApproval ?
                        <span>This report was <strong>approved</strong> by {person}.</span>
                        : previouslyApproved && changedSinceApproval ?
                            <span>A version of this report was approved by {person}, but it has since been edited.</span>
                            : ``
            }
            activityIcon={
                <Icon iconName={!previouslyApproved ? `PageEdit` : previouslyApproved && !changedSinceApproval ? `DocumentApproval` : previouslyApproved && changedSinceApproval ? `DocumentReply` : ``} />
            }
            timeStamp={
                <TooltipHost content={DateService.dateToUkDateTime(approvedDate)} > {previouslyApproved && `${time} ago`}</TooltipHost >
            }
        />
    );
}