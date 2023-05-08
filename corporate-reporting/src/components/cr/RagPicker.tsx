import React from 'react';
import styles from '../../styles/RagPicker.module.scss';
import { SwatchColorPicker, IColorCellProps } from 'office-ui-fabric-react/lib/SwatchColorPicker';
import { FieldErrorMessage, FieldHistory } from './FieldDecorators';
import { RagColours } from '../../refData/RagColours';
import { CrLabel } from './CrLabel';

export interface IRagPickerProps {
    label?: string;
    required?: boolean;
    className?: string;
    disabled?: boolean;
    selectedRAG?: number;
    onColorChanged?: (colorId: number) => void;
    history?: number;
    errorMessage?: string;
}

export interface IRagPickerState {
    value: number;
}

export class RagPicker extends React.Component<IRagPickerProps, IRagPickerState> {

    constructor(props: IRagPickerProps) {
        super(props);
        this.state = { value: props.selectedRAG };
    }

    private raraaggColors: IColorCellProps[] = [
        { id: RagColours.Red.toString(), label: 'Red\nImpossible to meet the agreed outcome - major issues which do not appear to be currently manageable or resolvable', color: '#FF0000' },
        { id: RagColours.AmberRed.toString(), label: 'Amber Red\nDoubtful the agreed outcome will be met - major issues in a number of key areas. Urgent action required to find out if a resolution is possible', color: '#FF6000' },
        { id: RagColours.Amber.toString(), label: 'Amber\nWill possibly meet the agreed outcome, but resolvable issues need management attention. Action these quickly to avoid major long-term problems', color: '#FFBF00' },
        { id: RagColours.AmberGreen.toString(), label: 'Amber Green\nWill probably meet the agreed outcome - no current major issues affecting delivery', color: '#809F00' },
        { id: RagColours.Green.toString(), label: 'Green\nLikely to meet the agreed outcome - no current outstanding issues affecting delivery', color: '#007F00' }
    ];

    public render(): React.ReactElement {
        const { className, label, required, errorMessage, disabled, selectedRAG, history } = this.props;
        return (
            <div className={className}>
                <div className={styles.ragPicker}>
                    {label &&
                        <CrLabel text={label} required={required} icon="SpeedHigh" />
                    }
                    <SwatchColorPicker
                        className={errorMessage && styles.invalid}
                        disabled={disabled}
                        columnCount={5}
                        cellShape={'circle'}
                        colorCells={this.raraaggColors}
                        selectedId={selectedRAG && selectedRAG.toString()}
                        onColorChanged={this._changeColor} />
                    {history &&
                        <div>
                            <FieldHistory value=' ' />
                            <SwatchColorPicker
                                disabled={true}
                                columnCount={5}
                                cellShape={'circle'}
                                colorCells={this.raraaggColors}
                                selectedId={history.toString()} />
                        </div>
                    }
                    {errorMessage &&
                        <FieldErrorMessage value={errorMessage} />}
                </div>
            </div>
        );
    }

    public componentDidMount(): void {
        this.hackSwatchColorPickerColors();
    }

    public componentDidUpdate(prevProps: IRagPickerProps): void {
        if (prevProps.history !== this.props.history) {
            this.hackSwatchColorPickerColors();
        }
    }

    private hackSwatchColorPickerColors = (): void => {
        const redAmber = document.querySelectorAll('svg[fill="#FF6000"]');
        for (let i = 0; i < redAmber.length; i++) {
            redAmber[i].innerHTML += `<defs><linearGradient id="redAmberDot${i}" x1="0%" y1="0%" x2="100%" y2="0%">`
                + `<stop style="stop-color:#FF0000;stop-opacity:1" offset="0%" /><stop style="stop-color:#FF0000;stop-opacity:1" offset="50%" />`
                + `<stop style="stop-color:#FFBF00;stop-opacity:1" offset="50%" /><stop style="stop-color:#FFBF00;stop-opacity:1" offset="100%" />`
                + `</linearGradient></defs>`;
        }
        const redAmberCircle = document.querySelectorAll('svg[fill="#FF6000"] circle');
        for (let i = 0; i < redAmberCircle.length; i++) {
            redAmberCircle[i].setAttribute('fill', `url(#redAmberDot${i})`);
        }

        const amberGreen = document.querySelectorAll('svg[fill="#809F00"]');
        for (let i = 0; i < amberGreen.length; i++) {
            amberGreen[i].innerHTML += `<defs><linearGradient id="amberGreenDot${i}" x1="0%" y1="0%" x2="100%" y2="0%">`
                + `<stop style="stop-color:#FFBF00;stop-opacity:1" offset="0%" /><stop style="stop-color:#FFBF00;stop-opacity:1" offset="50%" />`
                + `<stop style="stop-color:#007F00;stop-opacity:1" offset="50%" /><stop style="stop-color:#007F00;stop-opacity:1" offset="100%" />`
                + `</linearGradient></defs>`;
        }
        const amberGreenCirle = document.querySelectorAll('svg[fill="#809F00"] circle');
        for (let i = 0; i < amberGreenCirle.length; i++) {
            amberGreenCirle[i].setAttribute('fill', `url(#amberGreenDot${i})`);
        }
    }

    private _changeColor = (colorId: string): void => {
        this.setState({ value: parseInt(colorId) });
        if (this.props.onColorChanged) this.props.onColorChanged(parseInt(colorId));
    }
}
