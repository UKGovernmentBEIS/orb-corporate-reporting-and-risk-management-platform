import React from 'react';
import styles from '../../styles/RagWithComments.module.scss';
import { CrTextField } from '../cr/CrTextField';
import { RagPicker } from './RagPicker';
import { CrLabel } from './CrLabel';
import { FieldDescriptionAbove } from './FieldDecorators';

export interface IRagWithCommentsProps {
    label?: string;
    className?: string;
    commentsPlaceholder?: string;
    commentsRows?: number;
    commentsMaxLength?: number;
    selectedColor?: number;
    commentValue?: string;
    onColorChanged: (id: number) => void;
    onCommentChanged: (value: string) => void;
    history?: { color: number, comment: string };
    disabled?: boolean;
}

export const RagWithComments = (
    { className, label, commentsPlaceholder, commentsMaxLength, commentsRows, commentValue,
        selectedColor, onColorChanged, onCommentChanged, history, disabled }: IRagWithCommentsProps): React.ReactElement => {
    return (
        <div className={className}>
            <div className={styles.ragWithComments}>
                {label &&
                    <CrLabel text={label} />
                }
                <FieldDescriptionAbove value={commentsPlaceholder} />
                <RagPicker
                    selectedRAG={selectedColor}
                    onColorChanged={onColorChanged}
                    history={history && history.color}
                    disabled={disabled}
                />
                <CrTextField
                    maxLength={commentsMaxLength}
                    charCounter={commentsMaxLength != null}
                    multiline
                    rows={commentsRows || 2}
                    value={commentValue}
                    history={history?.comment}
                    onChange={onCommentChanged}
                    disabled={disabled}
                />
            </div>
        </div>
    );
};
