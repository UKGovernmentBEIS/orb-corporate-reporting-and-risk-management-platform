import React, { ReactNode } from 'react';
import { Dialog, DialogType, DialogFooter } from 'office-ui-fabric-react/lib/Dialog';
import { FormButtons } from './FormButtons';

export interface IConfirmDialogProps {
    hidden: boolean;
    title: string;
    content?: string;
    confirmButtonText: string;
    handleConfirm: () => void;
    handleCancel: () => void;
    children?: ReactNode;
}

export const ConfirmDialog = ({ hidden, title, content, confirmButtonText, handleConfirm, handleCancel, children }: IConfirmDialogProps): React.ReactElement => {
    return (
        <Dialog hidden={hidden} onDismiss={handleCancel} dialogContentProps={{ type: DialogType.normal, title: title }}>
            {content || children}
            <DialogFooter>
                <FormButtons onPrimaryClick={handleConfirm} onSecondaryClick={handleCancel} primaryText={confirmButtonText} />
            </DialogFooter>
        </Dialog>
    );
};
