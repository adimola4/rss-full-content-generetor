import React, { useState, useEffect, useRef } from 'react';
import Clipboard from '../helpers/Clipboard';


import Tooltip from "./Tooltip";



const NewRss = ({ add_rss, initialRssState, loading, new_rss_url}) => {
  const [inputValue, setInputValue] = useState('');
  const [rss, setRss] = useState(initialRssState);
  const [errors, setErrors] = useState({});
  const [newUrl,setNewUrl] = useState("")
  const [inCopyMode,setInCopyMode] = useState(null)
  const [showTooltip,setShowTooltip] = useState(false)
  const first = useRef(true);
 

  useEffect(()=>{
    if (first.current) {
      first.current = false;
      return;
    }
      if(new_rss_url === "Error"){
        setInCopyMode(false);
        setInputValue('');
        //new_rss_url="bloblo"
        setNewUrl("");
        rss.url="";
      }else{
        if(Object.keys(new_rss_url).length !== 0){
          setInputValue(new_rss_url);
          setInCopyMode(true);
          setNewUrl("");
        }else{
          setInCopyMode(null);
        }
      }
      // console.log("use effect:",rss, newUrl, new_rss_url,inCopyMode);

      
  },[new_rss_url])

  const validate = value =>{
    if ( value.length === "" ) {
      setErrors('URL is required');
    }else{
      setErrors({})
    }
  }

  const handleInputChange = event => {
    const { name, value } = event.target
    setRss({ ...rss, [name]: value })
    setInputValue(event.target.value)
    validate(value)
  };
  const handleSubmit = event =>{
    event.preventDefault()
    if (errors.length > 0)
    {
      setNewUrl(null)  
      return;
    } 
    if(inCopyMode === true){
      setInCopyMode(false)
      setNewUrl("")
      setRss({
        url:'',
      })
      return;
    }
    
    add_rss(rss)
    if(Object.keys(new_rss_url).length !== 0){
      setNewUrl("http://"+new_rss_url)
    }
    
    setRss(initialRssState)
  }
  const copyClick = event =>{
    event.preventDefault()
    if(inCopyMode === true && newUrl === "") setShowTooltip(true);
    Clipboard("https://"+new_rss_url);
    setInputValue('');
    setInCopyMode(false)
    setRss(initialRssState)
    new_rss_url = null;

  }
  

  return (
      <form className="wrapper" onSubmit={handleSubmit}>
        <div className="inputs-div">
        <input 
              id="url_input"
              type="text" 
              placeholder={new_rss_url === "Error" ? "Error!!! please enter a new URL." : "Generate your rss url" }
              className={`input ${((newUrl==="" || newUrl === null) && Object.keys(new_rss_url).length !== 0) && "fake-a-tag" } ${new_rss_url === "Error" && "fake-a-tag-error"}`}
              name="url" 
              // value={ (newUrl==="" &&  Object.keys(new_rss_url).length !== 0 && new_rss_url !== "Error")? new_rss_url : rss.url !== "" ? rss.url : ''} 
              value = {inputValue}
              onChange={handleInputChange}
              required></input>
        <Tooltip content="Copied!" direction="bottom" delay="0" showable={showTooltip}>
        <button type="submit"
              className="btn"
              disabled={loading}
              > 
               {(loading &&
                  <span>Loading new URL...</span>)
                || (inCopyMode === true && newUrl === "" &&
                  <span onClick={copyClick}> Copy</span>)
                || (<span>Create</span>)
                }
        </button>
        </Tooltip>
        </div>
      </form>
  )
};

export default NewRss;