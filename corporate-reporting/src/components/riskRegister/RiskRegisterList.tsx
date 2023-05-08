import React, { useCallback, useContext, useEffect, useState } from 'react';
import { DateService } from '../../services';
import { IGroup, IDirectorate, IProject, IBaseComponentProps } from '../../types';
import styles from '../../styles/cr.module.scss';
import { RiskRegisterBuilder } from './RiskRegisterBuilder';
import { CrDropdown } from '../cr/CrDropdown';
import { Role } from '../../refData/Role';
import { IDropdownOption, DropdownMenuItemType } from 'office-ui-fabric-react/lib/Dropdown';
import { CrLoadingOverlay } from '../cr/CrLoadingOverlay';
import { CrMonthPicker } from '../cr/CrMonthPicker';
import { subMonths } from 'date-fns';
import { RiskRegister } from '../../refData/RiskRegister';
import { DataContext } from '../DataContext';
import { OrbUserContext } from '../OrbUserContext';

export const RiskRegisterList = (props: IBaseComponentProps): React.ReactElement => {
    const { errorHandling: { onError } } = props;
    const { userContext: { UserEntities: { UserRoles, UserGroups, UserDirectorates, UserProjects } } } = useContext(OrbUserContext);
    const { dataServices: { directorateService, groupService, projectService } } = useContext(DataContext);
    const [loading, setLoading] = useState(false);
    const [groups, setGroups] = useState<IGroup[]>([]);
    const [directorates, setDirectorates] = useState<IDirectorate[]>([]);
    const [projects, setProjects] = useState<IProject[]>([]);
    const [selectedPeriod, setSelectedPeriod] = useState(DateService.lastDateOfMonth(new Date()));
    const [selectedRegister, setSelectedRegister] = useState<{ type: RiskRegister, entityId: number }>({ type: null, entityId: null });
    const endOfCurrentMonth = DateService.lastDateOfMonth(new Date());

    const logError = useCallback(onError, [onError]);

    const usersFirstDirectorate = UserDirectorates?.[0]?.DirectorateID;
    useEffect(() => {
        setSelectedRegister({ type: RiskRegister.Directorate, entityId: usersFirstDirectorate });
    }, [usersFirstDirectorate]);

    useEffect(() => {
        const loadRiskRegisters = async (): Promise<void> => {
            setLoading(true);
            try {
                await Promise.all([
                    groupService.readAll().then(setGroups),
                    directorateService.readAll().then(setDirectorates),
                    projectService.readAll().then(setProjects)
                ]);
            } catch (err) {
                logError(`Error loading risk registers`, err.message);
            } finally {
                setLoading(false);
            }
        };

        loadRiskRegisters();
    }, [groupService, directorateService, projectService, logError]);

    const changeRegister = (_, option: IDropdownOption): void => {
        const ddoKey = option.key.toString().split(':');
        setSelectedRegister({ type: Number(ddoKey[0]), entityId: Number(ddoKey[1]) });
    };

    const registers: IDropdownOption[] = [];

    if (UserRoles?.filter(ur => ur.RoleID === Role.RiskManager).length > 0) {
        registers.push({ key: `${RiskRegister.Departmental}:1`, text: 'Department' });
        registers.push({ key: 'groupDivider', text: '', itemType: DropdownMenuItemType.Divider });
        registers.push({ key: 'groupHeader', text: 'Groups', itemType: DropdownMenuItemType.Header });
        registers.push(...groups.map(g => ({ key: `${RiskRegister.Group}:${g.ID}`, text: g.Title })));
        registers.push({ key: 'directorateDivider', text: '', itemType: DropdownMenuItemType.Divider });
        registers.push({ key: 'directorateHeader', text: 'Directorates', itemType: DropdownMenuItemType.Header });
        registers.push(...directorates.map(d => ({ key: `${RiskRegister.Directorate}:${d.ID}`, text: d.Title })));
        registers.push({ key: 'projectDivider', text: '', itemType: DropdownMenuItemType.Divider });
        registers.push({ key: 'projectHeader', text: 'Projects', itemType: DropdownMenuItemType.Header });
        registers.push(...projects.map(p => ({ key: `${RiskRegister.Project}:${p.ID}`, text: p.Title })));
    } else {
        if (UserGroups?.length > 0) {
            registers.push({ key: 'groupDivider', text: '', itemType: DropdownMenuItemType.Divider });
            registers.push({ 'key': 'groupHeader', text: 'Groups', itemType: DropdownMenuItemType.Header });
            registers.push(...UserGroups.map(ug => ({ key: `${RiskRegister.Group}:${ug.GroupID}`, text: ug.Group?.Title })));
        }

        if (UserDirectorates?.length > 0) {
            registers.push({ key: 'directorateDivider', text: '', itemType: DropdownMenuItemType.Divider });
            registers.push({ 'key': 'directorateHeader', text: 'Directorates', itemType: DropdownMenuItemType.Header });
            registers.push(...UserDirectorates.map(ud => ({ key: `${RiskRegister.Directorate}:${ud.DirectorateID}`, text: ud.Directorate?.Title })));
        }

        if (UserProjects?.length > 0) {
            registers.push({ key: 'projectDivider', text: '', itemType: DropdownMenuItemType.Divider });
            registers.push({ key: 'projectHeader', text: 'Projects', itemType: DropdownMenuItemType.Header });
            registers.push(...UserProjects.map(up => ({ key: `${RiskRegister.Project}:${up.ProjectID}`, text: up.Project?.Title })));
        }
    }

    const selectedRegisterName = selectedRegister.type === RiskRegister.Departmental ? `Department`
        : selectedRegister.type === RiskRegister.Group ? groups.find(g => g.ID === selectedRegister.entityId)?.Title
            : selectedRegister.type === RiskRegister.Directorate ? directorates.find(d => d.ID === selectedRegister.entityId)?.Title
                : selectedRegister.type === RiskRegister.Project ? projects.find(p => p.ID === selectedRegister.entityId)?.Title
                    : 'Unknown';

    return (
        <div className={`${styles.cr} ${props.isFullPage ? styles.crFullPage : ''}`} style={{ position: 'relative' }}>
            <CrLoadingOverlay isLoading={loading} opaque={true} />
            <div className={styles.crCommandBar}>
                <div className={styles.grid}>
                    <div className={styles.gridRow}>
                        <div className={`${styles.gridCol} ${styles.sm12} ${styles.lg4}`}>
                            <CrMonthPicker
                                className={styles.commandBarDropdown}
                                from={subMonths(endOfCurrentMonth, 6)}
                                to={endOfCurrentMonth}
                                value={selectedPeriod}
                                onChange={setSelectedPeriod}
                            />
                        </div>
                        <div className={`${styles.gridCol} ${styles.sm12} ${styles.lg8}`}>
                            <CrDropdown
                                className={styles.commandBarDropdown}
                                options={registers}
                                selectedKey={`${selectedRegister.type}:${selectedRegister.entityId}`}
                                onChange={changeRegister}
                                placeholder='Select a register'
                            />
                        </div>
                    </div>
                </div>
            </div>
            <div className={styles.crFullPageContentWithCommandBar}>
                <h2 className={`${styles.fontSize20} ${styles.fontWeightSemibold}`}>{selectedRegisterName} risk register - {DateService.dateToMonthNameFormat(selectedPeriod)}</h2>
                <RiskRegisterBuilder
                    {...props}
                    riskRegisterId={selectedRegister.type}
                    parentEntityId={selectedRegister.entityId}
                    reportDate={selectedPeriod}
                />
            </div>
        </div>
    );
};
