import React, { useState } from 'react';

const NewRss = ({ add_rss, initialRssState}) => {
  const [rss, setRss] = useState(initialRssState);
  const [errors, setErrors] = useState({});

  const validate = value =>{
   // let expression = /(^|\s)((https?:\/\/)?[\w-]+(\.[\w-]+)+\.?(:\d+)?(\/\S*)?)/gi;
    if ( value.length === "" ) {
      setErrors('URL is required');
   // } else if (!expression.test(rss.url)) {
    //  setErrors('URL is invalid');
    }else{
      setErrors({})
    }
  }

  const handleInputChange = event => {
    const { name, value } = event.target
    setRss({ ...rss, [name]: value })
    validate(value)
  };

  return (
      <form className="wrapper" onSubmit={event => {
        event.preventDefault()
        if (errors.length > 0)
        {
          console.log("errors...",errors);
          return;
        } 
        add_rss(rss)
        setRss(initialRssState)
      }}>
            <input 
              type="text" 
              placeholder="Please Enter URL" 
              className="input" 
              name="url" 
              value={rss.url || ''} 
              onChange={handleInputChange}  
              required></input>
            <span className="underline"></span>
        <button type="submit" className="btn">Create</button>
      </form>
  )
};

export default NewRss;