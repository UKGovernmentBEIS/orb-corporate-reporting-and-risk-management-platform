import { IRisk, IRiskUpdate, IDirectorate, IGroup } from "../types";
import { RiskRegister } from "../refData/RiskRegister";
import { Role } from "../refData/Role";
import { IUserEntities } from "../types/UserEntities";

export class RiskPermissionsService {

    public RiskCanBeClosed = (userEntities: IUserEntities, risk: IRisk, latestRiskUpdate: IRiskUpdate): boolean => {
        let canBeClosed = latestRiskUpdate?.ToBeClosed;
        // TODO: Check user is allowed to close
        if (canBeClosed && risk) {
            // Departmental level risk
            if (risk.RiskRegisterID === RiskRegister.Departmental) {
                if (userEntities.UserRoles.filter(ur => ur.RoleID === Role.RiskManager).length === 0) {
                    canBeClosed = false;
                }
            }

            // Group level risk
            if (risk.RiskRegisterID === RiskRegister.Group) {
                if (userEntities.UserGroups.filter(ug => ug.GroupID === risk.Directorate?.GroupID && ug.IsRiskAdmin).length === 0) {
                    canBeClosed = false;
                }
            }

            // Directorate level risk
            if (risk.RiskRegisterID === RiskRegister.Directorate) {
                if (userEntities.UserDirectorates.filter(ud => ud.DirectorateID === risk.DirectorateID && ud.IsRiskAdmin).length === 0) {
                    canBeClosed = false;
                }
            }
        }
        return canBeClosed;
    }

    public RiskCanBeCreatedInRegisters = (userPermissions: IUserEntities): RiskRegister[] => {
        // Allow dept risk manager to create risk in any register
        if (this.userIsRiskManager(userPermissions)) {
            return [RiskRegister.Departmental, RiskRegister.Group, RiskRegister.Directorate];
        } else if (this.userIsGroupRiskAdmin(userPermissions)) {
            return [RiskRegister.Group];
        } else if (this.userIsDirectorateRiskAdmin(userPermissions)) {
            return [RiskRegister.Group, RiskRegister.Directorate];
        }
        return [];
    }

    public RiskCanBeEscalatedToRegisters = (userPermissions: IUserEntities, risk: IRisk, latestRiskUpdate: IRiskUpdate): RiskRegister[] => {
        // Allow dept risk manager to de/escalate any time
        if (this.userIsRiskManager(userPermissions)) {
            return [RiskRegister.Departmental, RiskRegister.Group, RiskRegister.Directorate];
        }

        const registers = [];

        if (risk) {
            registers.push(risk.RiskRegisterID);

            if (latestRiskUpdate) {
                if (latestRiskUpdate.Escalate) {
                    if (risk.RiskRegisterID === RiskRegister.Directorate) {
                        if (userPermissions.UserGroups.filter(ug => ug.GroupID === risk.Directorate?.GroupID && ug.IsRiskAdmin).length > 0) {
                            registers.push(RiskRegister.Group);
                        }
                    }
                    if (risk.RiskRegisterID === RiskRegister.Group) {
                        // Only Departmental Risk Managers can escalate Risks to the Department Register
                    }
                }

                if (latestRiskUpdate.DeEscalate) {
                    if (risk.RiskRegisterID === RiskRegister.Departmental) {
                        // Only Departmental Risk Managers can de-escalate Risks from the Department Register
                    }
                    if (risk.RiskRegisterID === RiskRegister.Group) {
                        if (userPermissions.UserGroups.filter(ug => ug.GroupID === risk.Directorate?.GroupID && ug.IsRiskAdmin).length > 0) {
                            registers.push(RiskRegister.Directorate);
                        }
                    }
                }
            }
        }

        return registers;
    }

    public RiskCanBeOwnedByGroups = (userPermissions: IUserEntities, groups: IGroup[]): number[] => {
        if (this.userIsRiskManager) {
            return groups.map(g => g.ID);
        } else {
            return userPermissions.UserGroups.filter(ug => ug.IsRiskAdmin).map(ug => ug.GroupID);
        }
    }

    public RiskCanBeOwnedByDirectorates = (userPermissions: IUserEntities, directorates: IDirectorate[]): number[] => {
        if (this.userIsRiskManager) {
            return directorates.map(d => d.ID);
        } else {
            const riskAdminOfGroups = userPermissions.UserGroups.filter(ug => ug.IsRiskAdmin).map(ug => ug.GroupID);
            const directoratesInGroups = directorates.filter(d => riskAdminOfGroups.indexOf(d.GroupID) !== -1).map(d => d.ID);
            return userPermissions.UserDirectorates.filter(ud => ud.IsRiskAdmin).map(ud => ud.DirectorateID).concat(directoratesInGroups);
        }
    }

    public RiskNameCanBeChanged(userPermissions: IUserEntities, risk: IRisk): boolean {
        if (this.userIsRiskManager(userPermissions) || risk?.RiskRegisterID !== RiskRegister.Departmental) {
            return true;
        }
        return false;
    }

    public RiskRegisterCanBeChanged(userPermissions: IUserEntities): boolean {
        if (this.userIsRiskManager(userPermissions) || this.userIsGroupRiskAdmin(userPermissions) || this.userIsDirectorateRiskAdmin(userPermissions)) {
            return true;
        }
        return false;
    }

    public RiskGroupCanBeChanged(userPermissions: IUserEntities): boolean {
        if (this.userIsRiskManager(userPermissions)) {
            return true;
        }
        return false;
    }

    public RiskDirectorateCanBeChanged(userPermissions: IUserEntities): boolean {
        if (this.userIsRiskManager(userPermissions) || this.userIsGroupRiskAdmin(userPermissions) || this.userIsDirectorateRiskAdmin(userPermissions)) {
            return true;
        }
        return false;
    }

    private userIsRiskManager(userPermissions: IUserEntities): boolean {
        return userPermissions.UserRoles.filter(ur => ur.RoleID === Role.RiskManager).length > 0;
    }

    private userIsGroupRiskAdmin(userPermissions: IUserEntities): boolean {
        return userPermissions.UserGroups.filter(ug => ug.IsRiskAdmin).length > 0;
    }

    private userIsDirectorateRiskAdmin(userPermissions: IUserEntities): boolean {
        return userPermissions.UserDirectorates.filter(ud => ud.IsRiskAdmin).length > 0;
    }
}