import { useMemo } from "react";
import styles from "./Card.module.css";

const Card = ({
  avatar,
  jonsSena,
  star4,
  prop,
  maskGroup,
  propAlignSelf,
  propWidth,
  propMinWidth,
  propMargin,
  propMinWidth1,
}) => {
  const cardStyle = useMemo(() => {
    return {
      alignSelf: propAlignSelf,
      width: propWidth,
    };
  }, [propAlignSelf, propWidth]);

  const jonsSenaStyle = useMemo(() => {
    return {
      minWidth: propMinWidth,
      margin: propMargin,
    };
  }, [propMinWidth, propMargin]);

  const divStyle = useMemo(() => {
    return {
      minWidth: propMinWidth1,
    };
  }, [propMinWidth1]);

  return (
    <div className={styles.card} style={cardStyle}>
      <div className={styles.arrayProcessor}>
        <img
          className={styles.avatarIcon}
          alt=""
          src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
        />
        <div className={styles.mappingMapper}>
          <div className={styles.jonsSena} style={jonsSenaStyle}>
            {jonsSena}
          </div>
          <div className={styles.daysAgo}>2 days ago</div>
        </div>
      </div>
      <div
        className={styles.loremIpsumIs}
      >{`Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text `}</div>
      <div className={styles.frameParent}>
        <div className={styles.frameWrapper}>
          <div className={styles.starParent}>
            <img
              className={styles.frameChild}
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
            <img
              className={styles.frameItem}
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
            <img
              className={styles.frameInner}
              loading="lazy"
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
            <img
              className={styles.starIcon}
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
            <img
              className={styles.frameChild1}
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
          </div>
        </div>
        <div className={styles.div} style={divStyle}>
          {prop}
        </div>
      </div>
      <div className={styles.wrapperMaskGroup}>
        <img
          className={styles.maskGroupIcon}
          loading="lazy"
          alt=""
          src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
        />
      </div>
    </div>
  );
};

export default Card;
