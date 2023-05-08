import React, { ReactNode } from 'react';
import { Dialog, DialogType, DialogFooter } from 'office-ui-fabric-react/lib/Dialog';
import { PrimaryButton } from 'office-ui-fabric-react/lib/Button';
import { Text } from 'office-ui-fabric-react/lib/Text';

export interface IMessageDialogProps {
    hidden: boolean;
    title: string;
    content?: string;
    handleOk: () => void;
    children?: ReactNode;
}

export const MessageDialog = ({ hidden, title, content, handleOk, children }: IMessageDialogProps): React.ReactElement => {
    return (
        <Dialog hidden={hidden} onDismiss={handleOk} dialogContentProps={{ type: DialogType.normal, title: title }}>
            <Text>{content || children}</Text>
            <DialogFooter>
                <PrimaryButton text="OK" onClick={handleOk} />
            </DialogFooter>
        </Dialog>
    );
};
