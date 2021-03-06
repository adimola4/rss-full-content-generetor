import React, { useState } from 'react';
import Clipboard from '../helpers/Clipboard';


const ReadyModal = ({ rssData, generated_url }) => {
    
    
    const [rss, setRss] = useState(rssData);
    
   
    
    return (
        <>
          
                { rss && 
                    <div className="notify-card" >
                            <div className="notify-card-title">
                                <a href= {rss[1]}>
                                    <img src={rss[2]} className="notify-card-avatar lazy" data-src={rss[2]} alt="" />
                                </a>
                                    <a href={rss[2] }>
                                    {rss[0]}</a>
                            </div>
                            <div className="notify-card-body">
                                 <p className="notify-card-desc">
                                { rss }
                                </p >
                             </div> 
                             <div className="notify-card-footer"> 
                                <a href={generated_url} className="notify-card-btn btn-left" onClick={Clipboard("https://"+generated_url)}> RSS file </a>
                                <button  className="notify-card-btn btn-right" onClick= {Clipboard("https://"+generated_url)} > Copy link! </button>
                             </div>
                                
                    
                      </div>            
                }
                
       
        </>           
    )
};
export default ReadyModal;