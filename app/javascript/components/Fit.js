import React, { useEffect, useRef, useState } from "react";

const Fit = ({ children, maxScale = 1, minScale = 0 }) => {
  const parentContainerRef = useRef();
  const childContainerRef = useRef();

  const [scale, setScale] = useState(1);

  const updateDimensions = () => {
    const parentWidth = parentContainerRef.current.clientWidth;
    const childWidth = childContainerRef.current.clientWidth;

    const ratio = parentWidth / childWidth;

    const scale = Math.min(Math.max(ratio, minScale), maxScale);
    setScale(scale);
  };

  useEffect(() => {
    window.addEventListener("load", updateDimensions);
    window.addEventListener("resize", updateDimensions);
    return () => {
      window.removeEventListener("load", updateDimensions);
      window.removeEventListener("resize", updateDimensions);
    };
  }, []);

  useEffect(() => {
    updateDimensions(); // also update dimensions when children change
  });

  return (
    <div ref={parentContainerRef}>
      <div
        ref={childContainerRef}
        style={{
          display: "inline-block",
          transform: `scale(${scale})`,
          transformOrigin: "left"
        }}
      >
        {children}
      </div>
    </div>
  );
};

export default Fit;
