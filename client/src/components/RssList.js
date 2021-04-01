import React, { useState, useEffect } from 'react';
import axios from 'axios';

import NewRss from './NewRss';
import RssCard from './RssCard';
import Modal from './Modal';
 import ReadyModal from './ReadyModal';
import { useToast } from "./ToastProvider";
import   useInterval  from '../hooks/useInterval';

const qs = require('qs');




const RssList = props => {
  const { addToast } = useToast();
  const [rsslist, setRsslist] = useState([]);
  const [showModal, setShowModal] = useState(false);
  const [rssUrl, setRssUrl] = useState({});
  const [rss, setRss] = useState({});
  const [generatedRssUrl, setGeneratedRssUrl] = useState({});
  const [generatedRss, setGeneratedRss] = useState({url:'',id:''});
  const [loading, setLoading ] = useState(false);
  const [delay, setDelay] = useState(null);
  

    useEffect(() => {

      const loadRss = async () => {
        let response = {};
        try {
          response = await axios.get('/api/v1/rss.json')
          .then(res =>{
            setRsslist(res.data)
          } )
        } catch (err) {
            // console.log("err", err)
            // console.log(response)
        }
      }
      loadRss()
      }, []);
    useInterval(() =>{
      axios.post(`/api/v1/rss/ready/`,qs.stringify({rss:{id:generatedRss.id}}))
      .then(result =>{
        if(result.data[0].generated_url !== undefined){
           setGeneratedRssUrl(result.data[0].generated_url)
           setRssUrl(result.data[0].generated_url)
           setTimeout(() =>  setShowModal(true), 1500)
           setLoading(false)               
           setDelay(null) 
        }           
      }
      )
    }, delay)

    const initialRss = {
        url:'',
      };

    const add_rss = rss => {
        setLoading(true);
        setRssUrl(rss.url)       
       let toast_type = "INFO"
        axios.post('/api/v1/rss', qs.stringify(
            {
              rss:{
                original_url: rss.url
              }
            }))
            .then(res=>{              
              toast_type = "Created"
              if(res.status === 201)              
              {
                let id = "";
                if(res.data.id){
                  id = res.data.id;
                  let rss = [
                    res.data.title,
                    res.data.generated_url,
                    res.data.img_url,
                    res.data.description
                  ]
                  console.log(rss[1]);
                  setTimeout(()=>addToast(rss,toast_type),1000);  
                  setGeneratedRss({
                    ...generatedRss,
                    id: id
                  });
                  setRss(rss)
                  setGeneratedRssUrl(rss[1])
                  setRssUrl(rss[1])                  
                  setLoading(false) 
                  
                }
              }else {
                toast_type ="Exiest"
                let rss = [
                  res.data[1].title,
                  res.data[1].generated_url,
                  res.data[1].img_url,
                  res.data[1].description
                ]
                addToast(rss,toast_type);
                setRss(rss)
                setGeneratedRssUrl(rss[1])
                setLoading(false)
              }
              setRsslist([...rsslist, res]);
            } )
            .catch( error => {
              toast_type = "Error"
              addToast( "We unable to complete your request, try anthor RSS URL.",toast_type);
              setLoading(false)
              setGeneratedRssUrl("Error")
            } )
       
      };

    

  


  return (
    <div className="main">
          <NewRss add_rss={add_rss} initialRssState={initialRss} loading={loading} new_rss_url={generatedRssUrl} />
           { showModal && (
            <Modal onClose={() => setShowModal(false)}>
              <ReadyModal  rssData={rss} generated_url={rssUrl}/>
            </Modal>
          )} 
        <div className="rss-list">
              {rsslist.map((rss, index) => (
                       <RssCard  initialRssState={rss} key={index}></RssCard>                
              ))}
        </div>
    
   
    </div>
  )
};
export default RssList;