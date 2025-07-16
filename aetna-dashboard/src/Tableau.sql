import { motion } from "framer-motion";
import { useEffect, useRef, useState } from "react";

const SlidingText = () => {
  const [x, setX] = useState(0);
  const intervalRef = useRef(null);
  const pausedRef = useRef(false);

  // Start interval
  useEffect(() => {
    startSliding();

    return () => {
      clearInterval(intervalRef.current);
    };
  }, []);

  const startSliding = () => {
    intervalRef.current = setInterval(() => {
      if (!pausedRef.current) {
        setX((prev) => (prev <= -100 ? 0 : prev - 1)); // Looping slide
      }
    }, 16); // ~60 FPS
  };

  const handleMouseEnter = () => {
    pausedRef.current = true;
  };

  const handleMouseLeave = () => {
    pausedRef.current = false;
  };

  return (
    <div
      style={{
        overflow: "hidden",
        width: "100%",
        whiteSpace: "nowrap"
      }}
    >
      <motion.div
        style={{
          x: `${x}%`,
          display: "inline-block"
        }}
        onMouseEnter={handleMouseEnter}
        onMouseLeave={handleMouseLeave}
      >
        👉 Sliding Text 👉 Sliding Text 👉 Sliding Text 👉
      </motion.div>
    </div>
  );
};

export default SlidingText;
