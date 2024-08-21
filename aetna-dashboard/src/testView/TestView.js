import React, { useState } from "react";
import "../Navbar/Navbar.css";
const TestView = () => {
  const [search, setSearch] = useState("");

  let arr1 = [1, 3, 2, 5, 4];
  let arr2 = ["thar", "far", "car"];
  let newArr = arr1.concat(arr2);

  newArr = newArr.sort();
  newArr = newArr.reverse();
  console.log(newArr);

  const debounce = (value) => {
    setSearch(value);
    let interval = 0;
    return () => {
      clearTimeout(interval);
      interval = setTimeout(() => {
        console.log(value);
      }, 200);
    };
  };

  // const handleChange = (e) => {
  //   setSearch(e.target.value);

  //   debounce(e.target.value);
  // };
  return (
    <div>
      <input
        type="text"
        value={search}
        onChange={(e) => debounce(e.target.value)}
      />
      <div className="div-main">
        <p>test 2</p>
      </div>
      {/* <div className={styles.sideMenu}>
        <div className={styles.inputCollector} />
        <OutputAggregator />
      </div> */}
      {/* <main className={styles.foodDeliveryDashboardInner}>
        <section className={styles.frameParent}>
          <FrameComponent2 />
          <ValueFilter />
          <ErrorCollector />
          <FrameComponent1 />
          <FrameComponent />
          <LabelList />
        </section>
      </main> */}
    </div>
  );
};

export default TestView;
