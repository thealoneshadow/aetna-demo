import { motion, AnimatePresence } from "framer-motion";
import { useEffect, useRef, useState } from "react";

const TextSlider = () => {
  const [x, setX] = useState(0);
  const paused = useRef(false); // Pause flag

  useEffect(() => {
    const interval = setInterval(() => {
      if (!paused.current) {
        setX((prev) => (prev <= -100 ? 0 : prev - 1));
      }
    }, 16); // ~60 FPS

    return () => clearInterval(interval);
  }, []);

  return (
    <div
      style={{ overflow: "hidden", width: "100%", whiteSpace: "nowrap" }}
      onMouseEnter={() => (paused.current = true)}
      onMouseLeave={() => (paused.current = false)}
    >
      <AnimatePresence>
        <motion.div
          key="slider"
          style={{ x: `${x}%`, display: "inline-block" }}
        >
          👉 Sliding Text 👉 Sliding Text 👉 Sliding Text 👉
        </motion.div>
      </AnimatePresence>
    </div>
  );
};

export default TextSlider;
