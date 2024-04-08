import { useMemo } from "react";
import styles from "./CardTotalOrder.module.css";

const CardTotalOrder = ({
  iconOrder,
  prop,
  totalOrders,
  icon,
  days,
  propPadding,
  propFlexWrap,
  propWidth,
  propMinWidth,
  propMinWidth1,
  propMinWidth2,
}) => {
  const cardTotalOrderStyle = useMemo(() => {
    return {
      padding: propPadding,
      flexWrap: propFlexWrap,
    };
  }, [propPadding, propFlexWrap]);

  const bStyle = useMemo(() => {
    return {
      width: propWidth,
      minWidth: propMinWidth,
    };
  }, [propWidth, propMinWidth]);

  const totalOrdersStyle = useMemo(() => {
    return {
      minWidth: propMinWidth1,
    };
  }, [propMinWidth1]);

  const daysStyle = useMemo(() => {
    return {
      minWidth: propMinWidth2,
    };
  }, [propMinWidth2]);

  return (
    <div className={styles.cardTotalOrder} style={cardTotalOrderStyle}>
      <div className={styles.background} />
      <img className={styles.iconOrder} loading="lazy" alt="" src={iconOrder} />
      <div className={styles.parent}>
        <b className={styles.b} style={bStyle}>
          {prop}
        </b>
        <div className={styles.totalOrders} style={totalOrdersStyle}>
          {totalOrders}
        </div>
        <div className={styles.iconParent}>
          <img className={styles.icon} alt="" src={icon} />
          <div className={styles.days} style={daysStyle}>
            {days}
          </div>
        </div>
      </div>
    </div>
  );
};

export default CardTotalOrder;
