import styles from "./OutputAggregator.module.css";

const OutputAggregator = () => {
  return (
    <div className={styles.outputAggregator}>
      <div className={styles.sedapParent}>
        <h1 className={styles.sedap}>
          <span>Sedap</span>
          <span className={styles.span}>.</span>
        </h1>
        <div className={styles.captionWrapper}>
          <div className={styles.caption}>Modern Admin Dashboard</div>
        </div>
      </div>
      <div className={styles.outputAggregatorInner}>
        <div className={styles.frameParent}>
          <div className={styles.iconParent}>
            <img
              className={styles.icon}
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
            <div className={styles.orderList}>Order List</div>
          </div>
          <div className={styles.iconGroup}>
            <img
              className={styles.icon1}
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
            <div className={styles.orderDetail}>Order Detail</div>
          </div>
          <div className={styles.iconContainer}>
            <img
              className={styles.icon2}
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
            <div className={styles.customer}>Customer</div>
          </div>
          <div className={styles.frameDiv}>
            <img
              className={styles.icon3}
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
            <div className={styles.analytics}>Analytics</div>
          </div>
          <div className={styles.iconParent1}>
            <img
              className={styles.icon4}
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
            <div className={styles.reviews}>Reviews</div>
          </div>
          <div className={styles.iconParent2}>
            <img
              className={styles.icon5}
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
            <div className={styles.foods}>Foods</div>
          </div>
          <div className={styles.iconParent3}>
            <input className={styles.icon6} type="checkbox" />
            <div className={styles.foodDetail}>Food Detail</div>
          </div>
          <div className={styles.iconParent4}>
            <img
              className={styles.icon7}
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
            <div className={styles.customerDetail}>Customer Detail</div>
          </div>
          <div className={styles.iconParent5}>
            <img
              className={styles.icon8}
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
            <div className={styles.calendar}>Calendar</div>
          </div>
          <div className={styles.iconParent6}>
            <img
              className={styles.icon9}
              alt=""
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
            />
            <div className={styles.chat}>Chat</div>
          </div>
          <div className={styles.iconParent7}>
            <input className={styles.icon10} type="checkbox" />
            <div className={styles.wallet}>Wallet</div>
          </div>
        </div>
      </div>
      <div className={styles.outputAggregatorChild}>
        <div className={styles.sedapRestaurantAdminDashboaParent}>
          <div className={styles.sedapRestaurantAdminContainer}>
            <p className={styles.sedapRestaurantAdminDashboa}>
              <b>Sedap Restaurant Admin Dashboard</b>
            </p>
            <p className={styles.allRightsReserved}>
              © 2020 All Rights Reserved
            </p>
          </div>
          <div className={styles.madeWith}>Made with ♥ by Peterdraw</div>
        </div>
      </div>
      <div className={styles.rectangleParent}>
        <div className={styles.frameChild} />
        <button className={styles.rectangle}>
          <img
            className={styles.icon11}
            alt=""
            src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
          />
          <b className={styles.dashboard}>Dashboard</b>
        </button>
        <div className={styles.bgStyle}>
          <div className={styles.bgStyleChild} />
          <button className={styles.button}>
            <div className={styles.buttonChild} />
            <div className={styles.addMenus}>+Add Menus</div>
          </button>
          <div className={styles.caption1}>
            <p className={styles.pleaseOrganizeYour}>Please, organize your</p>
            <p className={styles.menusThroughButton}>menus through button</p>
            <p className={styles.bellow}>bellow!</p>
          </div>
          <img
            className={styles.illustrationIcon}
            loading="lazy"
            alt=""
            src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU"
          />
        </div>
      </div>
    </div>
  );
};
export default OutputAggregator;
