import React from 'react';
import { CommandBar, ICommandBarProps } from 'office-ui-fabric-react/lib/CommandBar';
import styles from '../../styles/cr.module.scss';

export const CrCommandBar = ({ className, ...props }: ICommandBarProps): React.ReactElement =>
    <div className={`${className} ${styles.crCommandBar}`}><CommandBar {...props} /></div>;
