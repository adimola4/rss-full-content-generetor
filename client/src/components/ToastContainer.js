import React from "react";
import { createPortal } from "react-dom";
import { useTransition, animated} from "react-spring";

import Toast from "./Toast";

const ToastContainer = ({ toasts }) => {
  const transitions = useTransition(toasts, toast => toast.id, {
    from: { right: "-100%" },
    enter: { right: "0%" },
    leave: { right: "-100%" }
  });

  return createPortal(
    <animated.div className="toast-container">
      {transitions.map(({ item, key, props }) => (
        <Toast key={key} id={item.id} style={props}  toast_type={item.toast_type} data={item.content} >
          {item.content}
        </Toast>
      ))}
    </animated.div>,
    document.body
  );
};

export default ToastContainer;