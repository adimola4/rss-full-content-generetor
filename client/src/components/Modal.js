import React, { useContext, useRef, useState, useEffect } from "react";
import ReactDOM from "react-dom";

import { ModalContext } from '../context/Modal'

export default function Modal({ onClose, children }) {
    const modalNode = useContext(ModalContext);
    if (!modalNode) return null;
  
    return ReactDOM.createPortal(
      <div id="modal">
        <div id="modal-background" onClick={onClose} />
        <div id="modal-content">{children}</div>
      </div>,
      modalNode
    );
  }