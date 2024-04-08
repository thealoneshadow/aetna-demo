import React from "react";
import OutputAggregator from "./OutputAggregator";
import FrameComponent2 from "./FrameComponent2";
import ValueFilter from "./ValueFilter";
import ErrorCollector from "./ErrorCollector";
import FrameComponent1 from "./FrameComponent1";
import FrameComponent from "./FrameComponent";
import LabelList from "./LabelList";
import styles from "./FoodDeliveryDashboard.module.css";

const TestView = () => {
  return (
    <div className={styles.foodDeliveryDashboard}>
      <div className={styles.sideMenu}>
        <div className={styles.inputCollector} />
        <OutputAggregator />
      </div>
      <main className={styles.foodDeliveryDashboardInner}>
        <section className={styles.frameParent}>
          <FrameComponent2 />
          <ValueFilter />
          <ErrorCollector />
          <FrameComponent1 />
          <FrameComponent />
          <LabelList />
        </section>
      </main>
    </div>
  );
};

export default TestView;
