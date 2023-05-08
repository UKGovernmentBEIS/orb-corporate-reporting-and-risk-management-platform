import React from 'react';
import { CrBadge, ICrBadgeProps } from './CrBadge';

export const CrBadges = ({ badges }: { badges: ICrBadgeProps[] }): React.ReactElement =>
    <>
        { badges && badges.map((b, i) => <span key={i}><CrBadge text={b.text} description={b.description} badgeClass={b.badgeClass} /> </span>)}
    </>;
