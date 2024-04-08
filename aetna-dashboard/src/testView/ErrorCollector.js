import CardTotalOrder from "./CardTotalOrder";
import styles from "./ErrorCollector.module.css";

const ErrorCollector = () => {
  return (
    <div className={styles.errorCollector}>
      <div className={styles.cardTotalOrderParent}>
        <CardTotalOrder
          iconOrder="/icon-order.svg"
          prop="75"
          totalOrders="Total Orders"
          icon="/icon-14@2x.png"
          days="4% (30 days)"
        />
        <CardTotalOrder
          iconOrder="/icon-delivered.svg"
          prop="357"
          totalOrders="Total Delivered"
          icon="/icon-14@2x.png"
          days="4% (30 days)"
          propPadding="var(--padding-18xl) var(--padding-41xl-2) var(--padding-17xl) var(--padding-42xl)"
          propFlexWrap="wrap"
          propWidth="84px"
          propMinWidth="unset"
          propMinWidth1="106px"
          propMinWidth2="65px"
        />
        <CardTotalOrder
          iconOrder="/icon-order-1.svg"
          prop="65"
          totalOrders="Total Canceled"
          icon="/icon-16@2x.png"
          days="25% (30 days)"
          propPadding="var(--padding-18xl) var(--padding-41xl-7) var(--padding-17xl) var(--padding-42xl)"
          propFlexWrap="unset"
          propWidth="84px"
          propMinWidth="unset"
          propMinWidth1="106px"
          propMinWidth2="71px"
        />
        <div className={styles.cardTotalRevenue}>
          <div className={styles.background} />
          <CardTotalOrder
            iconOrder="/group-148.svg"
            prop="$128"
            totalOrders="Total Revenue"
            icon="/icon-16@2x.png"
            days="12% (30 days)"
            propPadding="var(--padding-18xl) var(--padding-41xl) var(--padding-17xl) var(--padding-42xl-2)"
            propFlexWrap="wrap"
            propWidth="unset"
            propMinWidth="97px"
            propMinWidth1="106px"
            propMinWidth2="69px"
          />
        </div>
      </div>
    </div>
  );
};

export default ErrorCollector;
