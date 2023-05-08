import React from 'react';
import { IRagIndicatorProps, RagIndicator } from './RagIndicator';

export const PreviousRagIndicator = ({ rag, label }: IRagIndicatorProps): React.ReactElement => {
    return (
        <RagIndicator rag={rag} label={rag === undefined || rag === null ? 'Not completed' : label} />
    );
};
