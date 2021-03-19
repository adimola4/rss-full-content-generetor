import React, { useState, useContext, useCallback } from "react";
import ToastContainer from "./ToastContainer";

const ToastContext = React.createContext(null);

let id = 1;

const ToastProvider = ({ children }) => {
  const [toasts, setToasts] = useState([]);

  const addToast = useCallback(
    (content, toast_type) => {
      console.log(content,toast_type);
      setToasts(toasts => [
        ...toasts,
        {
          id: id++,
          content,
          toast_type
        }
      ]);
    },
    [setToasts]
  );

  const removeToast = useCallback(
    id => {
      setToasts(toasts => toasts.filter(t => t.id !== id));
    },
    [setToasts]
  );

  return (
    <ToastContext.Provider
      value={{
        addToast,
        removeToast
      }}
    >
      <ToastContainer toasts={toasts} />
      {children}
    </ToastContext.Provider>
  );
};

const useToast = () => {
  const toastHelpers = useContext(ToastContext);

  return toastHelpers;
};

export { ToastContext, useToast };
export default ToastProvider;
