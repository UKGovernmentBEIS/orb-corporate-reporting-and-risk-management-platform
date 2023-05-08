import { IconButton } from 'office-ui-fabric-react';
import React from 'react';
import { RagColours } from '../../refData/RagColours';
import { DateService } from '../../services';
import { PreviousRagIndicator } from './PreviousRagIndicator';
import { RagIndicator } from './RagIndicator';
import { ReviewListProgressUpdate } from './ReviewListProgressUpdate';

export const renderEditButton = (onEdit: (entityId: number, entityUpdateId: number) => void, entityId: number, entityUpdateId: number, showEditButton: boolean): JSX.Element => {
    return showEditButton &&
        <IconButton iconProps={{ iconName: 'Edit' }} title='Edit' onClick={() => onEdit(entityId, entityUpdateId)} />;
}

export const renderProgressUpdate = ({ title, comment, author, date, toBeClosed, attributes, previousComment }
    : { title: string, comment: string, author: string, date: Date, toBeClosed: boolean, attributes?: string[], previousComment?: string }): JSX.Element => {
    return (
        <ReviewListProgressUpdate
            entityName={title}
            progressUpdate={comment}
            updateAuthor={author}
            updateDate={date}
            toBeClosed={toBeClosed}
            attributes={attributes}
            previousUpdate={previousComment}
        />
    );
}

export const renderDate = (date: Date | string, noDateText?: string): JSX.Element =>
    <span>{date instanceof Date ? DateService.dateToUkDate(date) : date ? date : noDateText}</span>

export const renderRag = (rag: RagColours): JSX.Element => <RagIndicator rag={rag} />

export const renderPreviousRag = (rag: RagColours): JSX.Element => <PreviousRagIndicator rag={rag} />
