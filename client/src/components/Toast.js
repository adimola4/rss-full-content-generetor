import React, { useEffect, useState } from "react";
import { useToast } from "./ToastProvider";
import { animated } from "react-spring";




const Toast = ({ children, id, toast_type, data } ) => {
  const { removeToast } = useToast();
  const [type, setType] = useState(toast_type);

  useEffect(() => {
    const timer = setTimeout(() => {
      removeToast(id);
    }, 100000);

    return () => {
      clearTimeout(timer);
    };
  }, [id, removeToast]);

  const handleremove = () =>{
    removeToast(id);
  }

  return (

     <>
        {(() => {
  
           switch (type) {
              case 'Created':
                  return (
                      
                    <animated.div className = 'toast toast-green' >                     
                        <div className="toast_icon">
                                <svg version="1.1" className="toast_svg" xmlns="http://www.w3.org/2000/svg" xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 512 512"  space="preserve">
                                    <g><g><path d="M504.502,75.496c-9.997-9.998-26.205-9.998-36.204,0L161.594,382.203L43.702,264.311c-9.997-9.998-26.205-9.997-36.204,0    c-9.998,9.997-9.998,26.205,0,36.203l135.994,135.992c9.994,9.997,26.214,9.99,36.204,0L504.502,111.7    C514.5,101.703,514.499,85.494,504.502,75.496z"></path>
                                </g></g>
                                </svg>
                            </div>
                            <div className="toast_content">
                                <p className="toast_type">Success!</p>
                                <p className="toast_message" >We finish to check your url working hard to generet you a new URL with full content.</p>
                            </div>
                           
                            <div className="toast_close" onClick={ handleremove }>
                                <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 15.642 15.642" xlink="http://www.w3.org/1999/xlink" enableBackground="new 0 0 15.642 15.642">
                                    <path fillRule="evenodd" d="M8.882,7.821l6.541-6.541c0.293-0.293,0.293-0.768,0-1.061  c-0.293-0.293-0.768-0.293-1.061,0L7.821,6.76L1.28,0.22c-0.293-0.293-0.768-0.293-1.061,0c-0.293,0.293-0.293,0.768,0,1.061  l6.541,6.541L0.22,14.362c-0.293,0.293-0.293,0.768,0,1.061c0.147,0.146,0.338,0.22,0.53,0.22s0.384-0.073,0.53-0.22l6.541-6.541  l6.541,6.541c0.147,0.146,0.338,0.22,0.53,0.22c0.192,0,0.384-0.073,0.53-0.22c0.293-0.293,0.293-0.768,0-1.061L8.882,7.821z"></path>
                                </svg>
                        </div>
                    </animated.div>
                  )
              case 'Exiest':
                  return (
                    <animated.div className = 'toast toast-green' >                    
                            <div className="toast_icon">
                                <svg version="1.1" className="toast_svg" xmlns="http://www.w3.org/2000/svg" xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 512 512"  space="preserve">
                                    <g><g><path d="M504.502,75.496c-9.997-9.998-26.205-9.998-36.204,0L161.594,382.203L43.702,264.311c-9.997-9.998-26.205-9.997-36.204,0    c-9.998,9.997-9.998,26.205,0,36.203l135.994,135.992c9.994,9.997,26.214,9.99,36.204,0L504.502,111.7    C514.5,101.703,514.499,85.494,504.502,75.496z"></path>
                                </g></g>
                                </svg>
                            </div>
                            <div className="toast_content">
                                <p className="toast_type">We found This RSS that match to your URL!</p>
                                <p className="toast_message" onClick={ navigator.clipboard.writeText(data[1])}>Click here to copy URL</p>
                            </div>
                            <div className="toast_svg_copy" onClick={ navigator.clipboard.writeText(data[1])}>
                                <svg xmlns="http://www.w3.org/2000/svg" className="toast_svg" xlink="http://www.w3.org/1999/xlink" version="1.1" x="0px" y="0px" viewBox="0 0 15.642 15.642" enableBackground="new 0 0 15.642 15.642" space="preserve">
                                    <g><g><path d="M920,902.5v-595c0-4.7-1.7-8.8-5.2-12.3c-3.5-3.5-7.6-5.2-12.3-5.2h-595c-4.7,0-8.8,1.7-12.3,5.2s-5.2,7.6-5.2,12.3v595c0,4.7,1.7,8.8,5.2,12.3c3.5,3.5,7.6,5.2,12.3,5.2h595c4.7,0,8.8-1.7,12.3-5.2C918.3,911.3,920,907.2,920,902.5z M990,307.5v595c0,24.1-8.6,44.7-25.7,61.8c-17.1,17.1-37.7,25.7-61.8,25.7h-595c-24.1,0-44.7-8.6-61.8-25.7c-17.1-17.1-25.7-37.7-25.7-61.8v-595c0-24.1,8.6-44.7,25.7-61.8c17.1-17.1,37.7-25.7,61.8-25.7h595c24.1,0,44.7,8.6,61.8,25.7C981.4,262.8,990,283.4,990,307.5z M780,97.5V185h-70V97.5c0-4.7-1.7-8.8-5.2-12.3s-7.6-5.2-12.3-5.2h-595c-4.7,0-8.8,1.7-12.3,5.2S80,92.8,80,97.5v595c0,4.7,1.7,8.8,5.2,12.3c3.5,3.5,7.6,5.2,12.3,5.2H185v70H97.5c-24.1,0-44.7-8.6-61.8-25.7C18.6,737.2,10,716.6,10,692.5v-595c0-24.1,8.6-44.7,25.7-61.8C52.8,18.6,73.4,10,97.5,10h595c24.1,0,44.7,8.6,61.8,25.7C771.4,52.8,780,73.4,780,97.5L780,97.5z"/></g></g>
                                </svg> 
                            </div>
                            <div className="toast_close" onClick={ handleremove }>
                                <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 15.642 15.642" xlink="http://www.w3.org/1999/xlink" enableBackground="new 0 0 15.642 15.642">
                                    <path fillRule="evenodd" d="M8.882,7.821l6.541-6.541c0.293-0.293,0.293-0.768,0-1.061  c-0.293-0.293-0.768-0.293-1.061,0L7.821,6.76L1.28,0.22c-0.293-0.293-0.768-0.293-1.061,0c-0.293,0.293-0.293,0.768,0,1.061  l6.541,6.541L0.22,14.362c-0.293,0.293-0.293,0.768,0,1.061c0.147,0.146,0.338,0.22,0.53,0.22s0.384-0.073,0.53-0.22l6.541-6.541  l6.541,6.541c0.147,0.146,0.338,0.22,0.53,0.22c0.192,0,0.384-0.073,0.53-0.22c0.293-0.293,0.293-0.768,0-1.061L8.882,7.821z"></path>
                                </svg>
                            </div>
                    </animated.div> 
                  )
              case 'Info':
                    return (
                    <animated.div className = 'toast {{status}}' >
                       <div className="toast_icon">
                                <svg version="1.1" className="toast_svg" xmlns="http://www.w3.org/2000/svg" xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 512 512"  space="preserve">
                                    <g><g><path d="M504.502,75.496c-9.997-9.998-26.205-9.998-36.204,0L161.594,382.203L43.702,264.311c-9.997-9.998-26.205-9.997-36.204,0    c-9.998,9.997-9.998,26.205,0,36.203l135.994,135.992c9.994,9.997,26.214,9.99,36.204,0L504.502,111.7    C514.5,101.703,514.499,85.494,504.502,75.496z"></path>
                                </g></g>
                                </svg>
                            </div>
                            <div className="toast_content">
                                <p className="toast_type">We found This RSS that match to your URL!</p>
                                <p className="toast_message" onClick={ navigator.clipboard.writeText(data[1])}>Click here to copy URL</p>
                            </div>
                            <div className="toast_close" onClick={ handleremove }>
                                <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 15.642 15.642" xlink="http://www.w3.org/1999/xlink" enableBackground="new 0 0 15.642 15.642">
                                    <path fillRule="evenodd" d="M8.882,7.821l6.541-6.541c0.293-0.293,0.293-0.768,0-1.061  c-0.293-0.293-0.768-0.293-1.061,0L7.821,6.76L1.28,0.22c-0.293-0.293-0.768-0.293-1.061,0c-0.293,0.293-0.293,0.768,0,1.061  l6.541,6.541L0.22,14.362c-0.293,0.293-0.293,0.768,0,1.061c0.147,0.146,0.338,0.22,0.53,0.22s0.384-0.073,0.53-0.22l6.541-6.541  l6.541,6.541c0.147,0.146,0.338,0.22,0.53,0.22c0.192,0,0.384-0.073,0.53-0.22c0.293-0.293,0.293-0.768,0-1.061L8.882,7.821z"></path>
                                </svg>
                            </div>
                    </animated.div>
                    )
              case 'Error':
                  return (
                    <animated.div className = 'toast toast-red' >
                        <div className="toast_icon">
                        <svg version="1.1" className="toast__svg" xmlns="http://www.w3.org/2000/svg" xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 301.691 301.691"  space="preserve">
                            <g>
                                <polygon points="119.151,0 129.6,218.406 172.06,218.406 182.54,0  "></polygon>
                                <rect x="130.563" y="261.168" width="40.525" height="40.523"></rect>
                            </g>
                        </svg>                                
                            </div>
                            <div className="toast_content">
                            <p className="toast_type">{data}</p>
                                
                            </div>
                            <div className="toast_close" onClick={ handleremove }>
                                <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 15.642 15.642" xlink="http://www.w3.org/1999/xlink" enableBackground="new 0 0 15.642 15.642">
                                    <path fillRule="evenodd" d="M8.882,7.821l6.541-6.541c0.293-0.293,0.293-0.768,0-1.061  c-0.293-0.293-0.768-0.293-1.061,0L7.821,6.76L1.28,0.22c-0.293-0.293-0.768-0.293-1.061,0c-0.293,0.293-0.293,0.768,0,1.061  l6.541,6.541L0.22,14.362c-0.293,0.293-0.293,0.768,0,1.061c0.147,0.146,0.338,0.22,0.53,0.22s0.384-0.073,0.53-0.22l6.541-6.541  l6.541,6.541c0.147,0.146,0.338,0.22,0.53,0.22c0.192,0,0.384-0.073,0.53-0.22c0.293-0.293,0.293-0.768,0-1.061L8.882,7.821z"></path>
                                </svg>
                        </div>
                    </animated.div>
                )
              default:
                  return (
                    <div></div>
                  )
           }
  
        })()}
    </>
  );
};

export default Toast;
