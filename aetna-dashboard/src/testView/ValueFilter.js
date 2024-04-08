import React from "react";
import styles from "./ValueFilter.module.css";

const ValueFilter = () => {
  return (
    <div className={styles.valueFilter}>
      <div className={styles.sequenceCombiner}>
        <div className={styles.inputMultiplier}>
          <div className={styles.outputSorter}>
            <h1 className={styles.dashboard}>Dashboard</h1>
            <div className={styles.hiSamanthaWelcome}>
              Hi, Samantha. Welcome back to Sedap Admin!
            </div>
          </div>
        </div>
        <div className={styles.btnFilterPeriode}>
          <div className={styles.background} />
          <div className={styles.valueTransformer}>
            <div className={styles.valueTransformerChild} />
            <img className={styles.icon} alt="" src="/icon-12.svg" />
          </div>
          <div className={styles.btnFilterPeriodeInner}>
            <div className={styles.filterPeriodeParent}>
              <div className={styles.filterPeriode}>Filter Periode</div>
              <div className={styles.april2020}>
                17 April 2020 - 21 May 2020
              </div>
            </div>
          </div>
          <div className={styles.iconWrapper}>
            <img className={styles.icon1} alt="" src="/icon-13.svg" />
          </div>
        </div>
      </div>
    </div>
  );
};

export default ValueFilter;
