import React from 'react';
import { SaveStatus } from '../../types/SaveStatus';
import { Icon } from 'office-ui-fabric-react/lib/Icon';
import { Spinner, SpinnerSize } from 'office-ui-fabric-react/lib/Spinner';
import styles from '../../styles/SaveIndicator.module.scss';

export interface ISaveIndicatorProps {
    saveStatus: SaveStatus;
    timeout?: number;
}

export interface ISaveIndicatorState {
    SaveStatus: SaveStatus;
}

export class SaveIndicator extends React.Component<ISaveIndicatorProps, ISaveIndicatorState> {
    constructor(props: ISaveIndicatorProps) {
        super(props);
        this.state = { SaveStatus: SaveStatus.None };
    }

    public render(): React.ReactElement {
        return (
            <div className={styles.saveIndicator}>
                {this.props.saveStatus === SaveStatus.Pending &&
                    <div className={styles.flexContainer}>
                        <Spinner className={styles.saveIcon} size={SpinnerSize.small} />
                        <div>Saving...</div>
                    </div>
                }
                {this.state.SaveStatus === SaveStatus.Success &&
                    <div className={styles.flexContainer}>
                        <Icon className={styles.saveIcon} iconName="Accept" />
                        <div>Saved</div>
                    </div>
                }
                {this.state.SaveStatus === SaveStatus.Error &&
                    <div className={styles.flexContainer}>
                        <Icon className={styles.saveIcon} iconName="Error" />
                        <div>Error</div>
                    </div>
                }
            </div>
        );
    }

    public componentDidUpdate(prevProps: ISaveIndicatorProps): void {
        if (prevProps.saveStatus !== this.props.saveStatus) {
            if (prevProps.saveStatus === SaveStatus.Pending && this.props.saveStatus === SaveStatus.Success) {
                this.onSaveSuccess();
            }
            if (prevProps.saveStatus === SaveStatus.Pending && this.props.saveStatus === SaveStatus.Error) {
                this.onSaveError();
            }
        }
    }

    private clearStatus = async () => setTimeout(() => this.setState({ SaveStatus: SaveStatus.None }), this.props.timeout || 2000);

    private onSaveSuccess = (): void => {
        this.setState({ SaveStatus: SaveStatus.Success }, this.clearStatus);
    }

    private onSaveError = (): void => {
        this.setState({ SaveStatus: SaveStatus.Error }, this.clearStatus);
    }
}
