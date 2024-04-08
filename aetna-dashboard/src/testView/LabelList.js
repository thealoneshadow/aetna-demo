import Card from "./Card";
import styles from "./LabelList.module.css";

const LabelList = () => {
  return (
    <div className={styles.labelList}>
      <div className={styles.checkboxChorus}>
        <div className={styles.dataCollector}>
          <div className={styles.conditionSplitter}>
            <h1 className={styles.title}>Customer Review</h1>
            <div className={styles.caption}>
              Eum fuga consequuntur utadsjn et.
            </div>
          </div>
          <Card
            avatar="/avatar-1@2x.png"
            jonsSena="Jons Sena"
            star4="/star-1.svg"
            prop="4.5"
            maskGroup="/mask-group@2x.png"
          />
        </div>
        <Card
          avatar="/avatar-2@2x.png"
          jonsSena="Sofia"
          star4="/star-5.svg"
          prop="40"
          maskGroup="/mask-group-1@2x.png"
          propAlignSelf="unset"
          propWidth="458px"
          propMinWidth="48px"
          propMargin="0"
          propMinWidth1="unset"
        />
        <div className={styles.btnnextParent}>
          <div className={styles.btnnext}>
            <div className={styles.background} />
            <img
              className={styles.icChevronIcon}
              loading="lazy"
              alt=""
              src="/ic-chevron.svg"
            />
          </div>
          <div className={styles.frameParent}>
            <div className={styles.btnnextWrapper}>
              <img
                className={styles.btnnextIcon}
                loading="lazy"
                alt=""
                src="/btnnext@2x.png"
              />
            </div>
            <Card
              avatar="/avatar-3@2x.png"
              jonsSena="Anandreansyah"
              star4="/star-1.svg"
              prop="4.5"
              maskGroup="/mask-group@2x.png"
              propAlignSelf="stretch"
              propWidth="unset"
              propMinWidth="unset"
              propMargin="0"
              propMinWidth1="25px"
            />
          </div>
        </div>
      </div>
    </div>
  );
};

export default LabelList;
