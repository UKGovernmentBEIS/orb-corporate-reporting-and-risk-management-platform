import React, { ReactNode } from 'react';
import appStyles from '../../styles/cr.module.scss';
import styles from '../../styles/CrReportShimmer.module.scss';
import { Overlay, Shimmer, ShimmeredDetailsList, ShimmerElementsGroup, ShimmerElementType } from 'office-ui-fabric-react';

const ReportGridBlock = ({ disableAnimation }: { disableAnimation?: boolean }): React.ReactElement => {
    const anim = disableAnimation ? { shimmerGradient: [{ animation: 'none' }] } : {};
    return (
        <Shimmer
            styles={{ ...anim }}
            customElementsGroup={<ShimmerElementsGroup shimmerElements={[{ type: ShimmerElementType.line, height: 150 }]} />}
        />
    )
};

export const CrReportShimmer = ({ disableAnimation, children }: { disableAnimation?: boolean, children?: ReactNode }): React.ReactElement => {
    const anim = disableAnimation ? { shimmerGradient: [{ animation: 'none' }] } : {};
    return (
        <div className={styles.crReportShimmer}>
            {children &&
                <Overlay className={styles.reportShimmerOverlay}>
                    <div>
                        <div className={styles.reportShimmerOverlayMessage}>
                            {children}
                        </div>
                    </div>
                </Overlay>
            }
            <div className={appStyles.grid} style={{ marginTop: '12px' }}>
                <div className={`${appStyles.gridRow} ${appStyles.signOffGridRow}`}>
                    <div className={`${appStyles.gridCol} ${appStyles.sm12}`}>
                        <Shimmer styles={{ shimmerWrapper: { height: '32px' }, ...anim }} />
                    </div>
                </div>
                <div className={`${appStyles.gridRow} ${appStyles.signOffGridRow}`}>
                    <div className={`${appStyles.gridCol} ${appStyles.sm12}`}>
                        <Shimmer styles={{ ...anim }} />
                    </div>
                </div>
                <div className={`${appStyles.gridRow} ${appStyles.signOffGridRow}`}>
                    <div className={`${appStyles.gridCol} ${appStyles.sm4}`}>
                        <ReportGridBlock disableAnimation={disableAnimation} />
                    </div>
                    <div className={`${appStyles.gridCol} ${appStyles.sm4}`}>
                        <ReportGridBlock disableAnimation={disableAnimation} />
                    </div>
                    <div className={`${appStyles.gridCol} ${appStyles.sm4}`}>
                        <ReportGridBlock disableAnimation={disableAnimation} />
                    </div>
                </div>
                <div className={`${appStyles.gridRow} ${appStyles.signOffGridRow}`}>
                    <div className={`${appStyles.gridCol} ${appStyles.sm3}`}>
                        <ReportGridBlock disableAnimation={disableAnimation} />
                    </div>
                    <div className={`${appStyles.gridCol} ${appStyles.sm3}`}>
                        <ReportGridBlock disableAnimation={disableAnimation} />
                    </div>
                    <div className={`${appStyles.gridCol} ${appStyles.sm3}`}>
                        <ReportGridBlock disableAnimation={disableAnimation} />
                    </div>
                    <div className={`${appStyles.gridCol} ${appStyles.sm3}`}>
                        <ReportGridBlock disableAnimation={disableAnimation} />
                    </div>
                </div>
                <div className={`${appStyles.gridRow} ${appStyles.signOffGridRow}`}>
                    <div className={`${appStyles.gridCol} ${appStyles.sm12}`}>
                        {[0, 1].map(i =>
                            <ShimmeredDetailsList
                                key={i}
                                columns={[
                                    { key: '1', name: null, minWidth: 350 },
                                    { key: '2', name: null, minWidth: 100 },
                                    { key: '3', name: null, minWidth: 100 }]}
                                items={[]}
                                enableShimmer={true}
                                className={disableAnimation ? styles.disableShimmerAnimation : ''}
                            />
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
}
