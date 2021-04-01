import React, { useState } from "react";

const Tooltip = (props ) => {
  let timeout;
  const [active, setActive] = useState(false);

  const showTip = () => {
    if(props.showable === true){
        timeout = setTimeout(() => {
            setActive(true);
          }, props.delay || 400);
        timeout = setTimeout(()=>{
            setActive(false);
        },10000)
    }
    else
        return
    
  };

  const hideTip = () => {
    clearInterval(timeout);
    setActive(false);
  };

  return (
    <div
      className="Tooltip-Wrapper"
      onClick={showTip}
    >
      {props.children}
      {active === true && (
        <div className={`Tooltip-Tip ${props.direction || "top"}`}>
          {props.content}
        </div>
      )}
    </div>
  );
};

export default Tooltip;
