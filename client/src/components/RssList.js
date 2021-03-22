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
        // console.log(result);  
        // console.log(result.data[0].generated_url);
        if(result.data[0].generated_url !== undefined){
          //addToast(result.data[0].generated_url,toast_type);
           setRssUrl(result.data[0].generated_url)
           setTimeout(() =>  setShowModal(true), 1500)
           setDelay(null) 
          // setTimeout(()=> window.location.reload() , 100000) 
        }           
      }
      )
    }, delay)
    const initialRss = {
        url:'',
      };

    const add_rss = rss => {
        // console.log(rss);
        setLoading(true);
       
        setRssUrl(rss.url)
       // setTimeout(() =>  setShowModal(true), 3000)
       let toast_type = "INFO"
       
        function generated_url_ready(id, toast_type) {
        
        axios.post(`/api/v1/rss/ready/`,qs.stringify({rss:{id:id}}))
          .then(result =>{
            // console.log(result);  
            // console.log(result.data[0].generated_url);
            if(result.data[0].generated_url !== undefined){
              //addToast(result.data[0].generated_url,toast_type);
              // setTimeout(() =>  setShowModal(true), 1500)
              // setTimeout(()=> window.location.reload() , 100000) 
            }           
          }
          )
        }
      
        axios.post('/api/v1/rss', qs.stringify(
            {
              rss:{
                original_url: rss.url
              }
            }))
            .then(res=>{
              // console.log(res.data);
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
                  setTimeout(()=>addToast(rss,toast_type),2500);  
                  
                  setGeneratedRss({
                    ...generatedRss,
                    id: id
                  });
                  setRss(rss)
                  setDelay(1000)                
                }
              }else {
                // console.log(res.data);
                // setTimeout(() =>  setShowModal(true), 1500)
                toast_type ="Exiest"
                // generated_url_ready( res.data[1].id, toast_type)
                let rss = [
                  res.data[1].title,
                  res.data[1].generated_url,
                  res.data[1].img_url,
                  res.data[1].description
                ]
                // console.log(rss);

                addToast(rss,toast_type);
                setRss(rss)
              }
              setRsslist([...rsslist, res]);
            } )
            .catch( error => {
              toast_type = "Error"
              addToast( "We unable to complete your request, try anthor RSS URL.",toast_type);
            } )
       
      };

    

  


  return (
      <div>
          <NewRss add_rss={add_rss} initialRssState={initialRss}/>
          <hr className="hr"></hr>
           { showModal && (
            <Modal onClose={() => setShowModal(false)}>
              <ReadyModal  rssData={rss} generated_url={rssUrl}/>
            </Modal>
          )} 
          <div className="rss-list">
              {rsslist.map((rss, index) => (
                // <li className="cards_item" key={index}>
                //     {rss.title} | {rss.original_url} 
                       <RssCard  initialRssState={rss} key={index}></RssCard>
                // </li>
            ))}
        </div>
    
      </div>
  )
};
export default RssList;