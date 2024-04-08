import React from "react";
import styles from "./FrameComponent2.module.css";

const FrameComponent2 = () => {
  return (
    <header className={styles.frameWrapper}>
      <div className={styles.frameParent}>
        <div className={styles.backgroundParent}>
          <div className={styles.background} />
          <div className={styles.searchHereParent}>
            <input
              className={styles.searchHere}
              placeholder="Search here"
              type="text"
            />
            <div className={styles.cursor} />
          </div>
          <div className={styles.searchWrapper}>
            <img
              className={styles.searchIcon}
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
          </div>
        </div>
        <div className={styles.frameGroup}>
          <div className={styles.frameContainer}>
            <div className={styles.frameDiv}>
              <div className={styles.frameParent1}>
                <div className={styles.rectangleParent}>
                  <div className={styles.frameChild} />
                  <img
                    className={styles.iconDashboard}
                    loading="lazy"
                    alt=""
                    src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
                  />
                </div>
                <div className={styles.backgroundGroup}>
                  <div className={styles.background1} />
                  <div className={styles.div}>21</div>
                </div>
              </div>
              <div className={styles.frameParent2}>
                <div className={styles.rectangleGroup}>
                  <div className={styles.frameItem} />
                  <img
                    className={styles.iconDashboard1}
                    alt=""
                    src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
                  />
                </div>
                <div className={styles.backgroundContainer}>
                  <div className={styles.background2} />
                  <div className={styles.div1}>53</div>
                </div>
              </div>
              <div className={styles.frameParent3}>
                <button className={styles.rectangleContainer}>
                  <div className={styles.frameInner} />
                  <img
                    className={styles.iconDashboard2}
                    alt=""
                    src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
                  />
                </button>
                <div className={styles.groupDiv}>
                  <div className={styles.background3} />
                  <div className={styles.div2}>15</div>
                </div>
              </div>
              <div className={styles.frameParent4}>
                <button className={styles.frameButton}>
                  <div className={styles.rectangleDiv} />
                  <img
                    className={styles.iconDashboard3}
                    alt=""
                    src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
                  />
                </button>
                <div className={styles.backgroundParent1}>
                  <div className={styles.background4} />
                  <div className={styles.div3}>19</div>
                </div>
              </div>
            </div>
          </div>
          <div className={styles.separator} />
          <div className={styles.frameParent5}>
            <div className={styles.helloSamanthaWrapper}>
              <div className={styles.helloSamantha}>
                <span>{`Hello, `}</span>
                <span className={styles.samantha}>Samantha</span>
              </div>
            </div>
            <img
              className={styles.avatarIcon}
              loading="lazy"
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
          </div>
        </div>
      </div>
    </header>
  );
};

export default FrameComponent2;
