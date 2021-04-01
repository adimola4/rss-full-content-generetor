import React, { useState } from 'react';
import Clipboard from '../helpers/Clipboard';
import rss_icon from './rss_icon.svg';


const RssCard = ({initialRssState,}) => {
    
    
    const [rss, setRss] = useState(initialRssState);
    const defaultImg=event=>{
      event.target.src = rss_icon;
    }
    
    return (
          <div className="rss-card" id={"rss-"+rss.id}>
                <div className="rss-card-title">
                  <a href= {rss.url}>
                    <img src={rss.img_url} className="rss-card-avatar lazy" data-src={rss.img_url} alt="" onError={defaultImg}/>
                  </a>
                    <a href={rss.url }>
                    {rss.title}</a>
                </div>
                <p className="rss-card-desc">
                   { rss.description }
                </p>
                <button className="rss-card-btn" onClick={()=>Clipboard("https://" + rss.generated_url)}>click to copy</button>

                {/* <div class="toggle checkcross cont-bef-aft ">
                    <input id="checkcross<%= rss.id %>" type="checkbox" name="check" class="cont-bef-aft checkcrosss " value="false"/>
                    <label class="toggle-item cont-bef-aft" for="checkcross<%= rss.id %>">
                        <div class="check cont-bef-aft"></div>
                    </label>
                </div> */}
          </div>
       
           
    )
};
export default RssCard;