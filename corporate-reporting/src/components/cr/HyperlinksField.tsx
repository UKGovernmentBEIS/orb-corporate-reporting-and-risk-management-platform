import React, { useState } from 'react';
import { DefaultButton, Dialog, DialogFooter, IconButton, Link, PrimaryButton, Text } from 'office-ui-fabric-react';
import styles from '../../styles/cr.module.scss';
import hyperlinksFieldStyles from '../../styles/HyperlinksField.module.scss';
import { Hyperlink, IHyperlink } from '../../types';
import { CrLabel } from './CrLabel';
import { ConfirmDialog } from './ConfirmDialog';
import { HyperlinkField } from './HyperlinkField';

interface IHyperlinksFieldProps {
    label?: string;
    description?: string;
    disabled?: boolean;
    addEditLinkHelpText?: string;
    className?: string;
    links: IHyperlink[];
    onChange?: (links: IHyperlink[]) => void;
}

export const HyperlinksField = ({ label, description, disabled, addEditLinkHelpText, className, links, onChange }: IHyperlinksFieldProps): React.ReactElement => {
    const [hideDialog, setHideDialog] = useState(true);
    const [hideDeleteDialog, setHideDeleteDialog] = useState(true);
    const [formItemIndex, setFormItemIndex] = useState(-1);
    const [link, setLink] = useState(new Hyperlink());
    const [validations, setValidations] = useState<{ linkUrl: string, linkText: string }>({ linkUrl: null, linkText: null });

    const isValid = (): boolean => {
        let valid = true;
        let linkUrlError = '', linkTextError = '';
        if (link.LinkUrl === null || link.LinkUrl === '') {
            linkUrlError = 'Link is required';
            valid = false;
        }
        if (link.LinkText === null || link.LinkText === '') {
            linkTextError = 'Description is required';
            valid = false;
        }
        setValidations({ linkUrl: linkUrlError, linkText: linkTextError });
        return valid;
    };

    const addItem = () => {
        setHideDialog(false);
        setFormItemIndex(-1);
        setLink(new Hyperlink());
    };

    const editItem = (index: number) => {
        setHideDialog(false);
        setFormItemIndex(index);
        setLink(links[index]);
    };

    const saveItem = () => {
        if (isValid()) {
            if (formItemIndex === -1) {
                onChange([...links, link]);
            } else {
                onChange(
                    [
                        ...links.slice(0, formItemIndex),
                        link,
                        ...links.slice(formItemIndex + 1)
                    ]
                );
            }
            closeForm();
        }
    };

    const onClickDelete = (index: number) => {
        setFormItemIndex(index);
        setHideDeleteDialog(false);
    };

    const deleteItem = () => {
        onChange(links.filter((_, i) => i !== formItemIndex));
        setHideDeleteDialog(true);
    };

    const closeForm = () => {
        setHideDialog(true);
        setValidations({ linkUrl: null, linkText: null });
    };

    return (
        <div className={className}>
            <div className={hyperlinksFieldStyles.hyperlinksField}>
                {label &&
                    <CrLabel text={label} icon="Link" />
                }
                <div className={styles.formText}>{description}</div>
                <ul className={hyperlinksFieldStyles.linksList}>
                    {links?.length === 0 &&
                        <li>No links have been added</li>
                    }
                    {links?.map((r, i) =>
                        <li key={i}>
                            <Link target="_blank" href={r.LinkUrl}>{r.LinkText}</Link>
                            {disabled !== true &&
                                <>
                                    <IconButton
                                        title="Edit link"
                                        ariaLabel="Edit label"
                                        iconProps={{ iconName: 'Edit' }}
                                        onClick={() => editItem(i)}
                                    />
                                    <IconButton
                                        title="Delete link"
                                        iconProps={{ iconName: 'Delete' }}
                                        onClick={() => onClickDelete(i)}
                                    />
                                </>
                            }
                        </li>
                    )}
                </ul>
                {disabled !== true &&
                    <>
                        <DefaultButton text="Add link" iconProps={{ iconName: 'Add' }} onClick={addItem} />
                        <Dialog
                            hidden={hideDialog}
                            minWidth={450}
                            onDismiss={closeForm}
                            modalProps={{ className: styles.cr, isBlocking: true }}
                            dialogContentProps={{ title: formItemIndex === -1 ? 'Add link' : 'Edit link' }}>
                            <HyperlinkField
                                required={true}
                                link={link}
                                onChange={l => setLink(l)}
                                errorMessages={validations}
                            />
                            {addEditLinkHelpText &&
                                <p>{addEditLinkHelpText}</p>
                            }
                            <DialogFooter>
                                <PrimaryButton onClick={saveItem} text="Save" />
                                <DefaultButton onClick={closeForm} text="Cancel" />
                            </DialogFooter>
                        </Dialog>
                        <ConfirmDialog
                            hidden={hideDeleteDialog}
                            title="Are you sure?"
                            confirmButtonText="Delete"
                            handleConfirm={deleteItem}
                            handleCancel={() => { setFormItemIndex(null); setHideDeleteDialog(true); }}
                        >
                            <Text>Are you sure that you want to delete this link?</Text>
                        </ConfirmDialog>
                    </>
                }
            </div>
        </div>
    );
};