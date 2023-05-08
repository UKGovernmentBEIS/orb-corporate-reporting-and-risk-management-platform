import React, { ErrorInfo, ReactNode } from 'react';
import styles from '../styles/cr.module.scss';
import { MessageBar, MessageBarType } from 'office-ui-fabric-react/lib/MessageBar';

export interface IErrorBoundaryState {
    HasError: boolean;
    Error: string;
}

export class ErrorBoundary extends React.Component<{ children?: ReactNode }, IErrorBoundaryState> {
    constructor(props: { children?: ReactNode }) {
        super(props);
        this.state = { HasError: false, Error: null };
    }

    public static getDerivedStateFromError(): { HasError: boolean } {
        return { HasError: true };
    }

    public componentDidCatch(error: Error, errorInfo: ErrorInfo): void {
        this.setState({ HasError: true, Error: error.message });
        console.log(error, errorInfo);
    }

    public render(): React.ReactNode {
        if (this.state.HasError) {
            return (
                <div className={styles.cr}>
                    <MessageBar messageBarType={MessageBarType.error}>Something went wrong</MessageBar>
                    <p>{this.state.Error}</p>
                </div>
            );
        }

        return this.props.children;
    }
}
