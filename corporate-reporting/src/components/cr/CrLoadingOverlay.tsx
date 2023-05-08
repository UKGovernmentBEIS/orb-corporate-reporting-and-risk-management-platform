import React from 'react';
import styles from '../../styles/CrLoadingOverlay.module.scss';
import { Overlay } from 'office-ui-fabric-react/lib/Overlay';
import { Spinner, SpinnerSize } from 'office-ui-fabric-react/lib/Spinner';

export interface ICrLoadingOverlayProps {
    isLoading: boolean;
    opaque?: boolean;
}

export const CrLoadingOverlay = ({ isLoading, opaque }: ICrLoadingOverlayProps): React.ReactElement => {
    return isLoading && (
        <Overlay className={`${styles.crLoadingOverlay} ${opaque && styles.opaque}`}>
            <Spinner size={SpinnerSize.large} label="Loading..." />
        </Overlay>
    );
};
