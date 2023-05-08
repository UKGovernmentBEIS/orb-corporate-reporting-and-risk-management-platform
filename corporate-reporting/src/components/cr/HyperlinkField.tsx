import React from 'react';
import { IHyperlink } from '../../types';
import { CrTextField } from './CrTextField';

interface IHyperlinkFieldProps {
    className?: string;
    required?: boolean;
    link: IHyperlink;
    onChange?: (link: IHyperlink) => void;
    errorMessages?: { linkUrl: string, linkText: string };
}

export const HyperlinkField = ({ className, required, link, onChange, errorMessages }: IHyperlinkFieldProps): React.ReactElement => {
    return (
        <div className={className}>
            <CrTextField
                label="Link"
                required={required}
                placeholder="https://..."
                value={link.LinkUrl}
                onChange={url => onChange({ LinkUrl: url, LinkText: link.LinkText })}
                errorMessage={errorMessages.linkUrl}
            />
            <CrTextField
                label="Description"
                required={required}
                placeholder="Title or description of the document or file"
                value={link.LinkText}
                onChange={desc => onChange({ LinkUrl: link.LinkUrl, LinkText: desc })}
                errorMessage={errorMessages.linkText}
            />
        </div>
    );
};