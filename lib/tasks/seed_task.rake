task seed_task: :environment do

   # CNN
Rss.create_or_find_by!(
    title: 'CNN - Top Story',
    original_url: "http://rss.cnn.com/rss/cnn_topstories.rss" ,
    description: "View the latest news and breaking news today for U.S., world, weather, entertainment, politics and health at CNN.com.", 
    img_url: "http://www.difret.com/wp-content/uploads/2015/03/CNN.jpg",
    generated_url: "en" 
   )
Rss.create_or_find_by!(
   title: 'CNN - Politics',
   original_url: "http://rss.cnn.com/rss/cnn_allpolitics.rss" ,
   description: "Politics at CNN has news, opinion and analysis of American and global politics Find news and video about elections, the White House, the U.N and much more.", 
   img_url: "https://www.aaronread.com/img/links/cnn-politics.png",
   generated_url: "en"
   )        
Rss.create_or_find_by!(
   title: 'CNN - World',
  original_url: "http://rss.cnn.com/rss/cnn_world.rss" ,
   description: "View CNN world news today for international news and videos from Europe, Asia, Africa, the Middle East and the Americas.", 
   img_url: "https://ethicsalarms.files.wordpress.com/2017/07/cnn-logo.jpg",
   generated_url: "en"
   )   
Rss.create_or_find_by!(
   title: 'CNN - Tech',
  original_url: "http://rss.cnn.com/rss/cnn_tech.rss" ,
   description: "", 
   img_url: "https://pbs.twimg.com/profile_images/923188649981829122/JI0Rsjy5_400x400.jpg",
   generated_url: "en"
   )
Rss.create_or_find_by!(
   title: 'CNN - Health',
  original_url: "http://rss.cnn.com/rss/cnn_health.rss" ,
   description: "View the latest health news and explore articles on fitness, diet, nutrition, parenting, relationships, medicine, diseases and healthy living at CNN Health.", 
   img_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/CNN.svg/350px-CNN.svg.png",
   generated_url: "en"
   ) 
Rss.create_or_find_by!(
       title: 'CNN - Entertainment',
      original_url: "http://rss.cnn.com/rss/cnn_showbiz.rss" ,
       description: "View entertainment news and videos for the latest movie, music, TV and celebrity headlines on CNN.com.", 
       img_url: "http://i2.cdn.turner.com/cnn/2015/images/09/24/cnn.digital.png",
       generated_url: "en"
   )
# NYT                          
Rss.create_or_find_by!(
       title: 'NYT - Top Stories',
      original_url: "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml" ,
       description: "Live news, investigations, opinion, photos and video by the journalists of The New York Times from more than 150 countries around the world. Subscribe for coverage of U.S. and international news, politics, business, technology, science, health, arts, sports and more.", 
       img_url: "https://static01.nyt.com/images/misc/NYT_logo_rss_250x40.png",
       generated_url: "en-us"
   )                        
Rss.create_or_find_by!(
       title: 'NYT - Politics',
      original_url: "https://rss.nytimes.com/services/xml/rss/nyt/politics.xml" ,
       description: "Politics", 
       img_url: "https://static01.nyt.com/images/misc/NYT_logo_rss_250x40.png",
       generated_url: "en-us"
   )                         
Rss.create_or_find_by!(
       title: 'NYT - World News',
      original_url: "https://rss.nytimes.com/services/xml/rss/nyt/world.xml" ,
       description: "Find international breaking news, top stories, latest headlines and features.", 
       img_url: "https://static01.nyt.com/images/misc/NYT_logo_rss_250x40.png",
       generated_url: "en-us"
   ) 
Rss.create_or_find_by!(
       title: 'NYT - Business',
      original_url: "https://rss.nytimes.com/services/xml/rss/nyt/Business.xml" ,
       description: "Exclusive reporting and breaking news about the most important business and technology news, covering everything from Wall Street to media and economics.", 
       img_url: "https://static01.nyt.com/images/misc/NYT_logo_rss_250x40.png",
       generated_url: "en-us"
   ) 
Rss.create_or_find_by!(
       title: 'NYT - Health',
      original_url: "https://rss.nytimes.com/services/xml/rss/nyt/health.xml" ,
       description: "The latest news on health and medicine, health policy, global health, vaping, ecigarettes, Obamacare, health insurance, Medicare, opioids, cancer, heart disease and other topics.", 
       img_url: "https://static01.nyt.com/images/misc/NYT_logo_rss_250x40.png",
       generated_url: "en-us"
   ) 
Rss.create_or_find_by!(
       title: 'NYT - Technology',
      original_url: "https://rss.nytimes.com/services/xml/rss/nyt/technology.xml" ,
       description: "Exploring the business, culture and impact of the technology industry with reporting on the biggest internet companies to the newest startups.", 
       img_url: "https://static01.nyt.com/images/misc/NYT_logo_rss_250x40.png",
       generated_url: "en-us"
   ) 
Rss.create_or_find_by!(
       title: 'NYT - Sports',
      original_url: "https://rss.nytimes.com/services/xml/rss/nyt/Sports.xml" ,
       description: "Find breaking news & sports news on the NFL, the NBA, the NCAA, the NHL, baseball, golf, tennis, soccer, the World Series, Super Bowl, the Olympics and more.", 
       img_url: "https://static01.nyt.com/images/misc/NYT_logo_rss_250x40.png",
       generated_url: "en-us"
   ) 
Rss.create_or_find_by!(
       title: 'NYT - Opinion',
      original_url: "https://rss.nytimes.com/services/xml/rss/nyt/opinion.xml" ,
       description: "New York Times Opinion columnists, editorials and op-eds. Analysis from David Brooks, Maureen Dowd, Charles Blow, Paul Krugman and others.", 
       img_url: "https://static01.nyt.com/images/misc/NYT_logo_rss_250x40.png",
       generated_url: "en-us"
   ) 
Rss.create_or_find_by!(
       title: 'NYT - Climate',
      original_url: "https://rss.nytimes.com/services/xml/rss/nyt/Environment.xml" ,
       description: "Climate and Environment", 
       img_url: "https://static01.nyt.com/images/misc/NYT_logo_rss_250x40.png",
       generated_url: "en-us"
   )
# ESPN                        
Rss.create_or_find_by!(
       title: 'www.espn.com - TOP',
      original_url: "https://www.espn.com/espn/rss" ,
       description: "Visit ESPN to get up-to-the-minute sports news coverage, scores, highlights and commentary for NFL, MLB, NBA, College Football, NCAA Basketball and more.", 
       img_url: "https://a.espncdn.com/i/espn/teamlogos/lrg/trans/espn_dotcom_black.gif",
       generated_url: "en-us"
   )
#FOX
Rss.create_or_find_by!(
    title: 'FOX News - Latest',
   original_url: "http://feeds.foxnews.com/foxnews/latest" ,
    description: "Breaking News, Latest News and Current News from FOXNews.com. Breaking news and video. Latest Current News: U.S., World, Entertainment, Health, Business, Technology, Politics, Sports.", 
    img_url: "http://tools.foxnews.com/sites/tools.foxnews.com/files/images/fox-news-logo.png",
    generated_url: "en"
   )
Rss.create_or_find_by!(
   title: 'FOX News - Politics',
  original_url: "http://feeds.foxnews.com/foxnews/politics" ,
   description: "Presidential politics and political news from foxnews.com. News about political parties, political campaigns, world and international politics, politics news headlines plus in-depth features and video clips.", 
   img_url: "http://tools.foxnews.com/sites/tools.foxnews.com/files/images/fox-news-logo.png",
   generated_url: "en"
   )        
Rss.create_or_find_by!(
   title: 'FOX News - World',
  original_url: "http://feeds.foxnews.com/foxnews/world" ,
   description: "Latest world news, international news, world video, international video on Fox News.", 
   img_url: "http://tools.foxnews.com/sites/tools.foxnews.com/files/images/fox-news-logo.png",
   generated_url: "en"
   )   
Rss.create_or_find_by!(
   title: 'FOX News - Tech',
  original_url: "http://feeds.foxnews.com/foxnews/tech" ,
   description: "News for Hardware, software, networking, and Internet media. Reporting on information technology, technology and business news.", 
   img_url: "http://tools.foxnews.com/sites/tools.foxnews.com/files/images/fox-news-logo.png",
   generated_url: "en"
   )
Rss.create_or_find_by!(
   title: 'FOX News - Health',
  original_url: "http://feeds.foxnews.com/foxnews/health" ,
   description: "Health News, Current Health News, Medical News on FOXNews.com. Latest health news. Topics include men's health, women's health, children's health, body & mind and education.", 
   img_url: "http://tools.foxnews.com/sites/tools.foxnews.com/files/images/fox-news-logo.png",
   generated_url: "en"
   ) 
Rss.create_or_find_by!(
       title: 'FOX News - Opinion',
      original_url: "http://feeds.foxnews.com/foxnews/opinion" ,
       description: "Captivating commentary from newsmakers, authors, experts and others on topics you care about from politics to family, faith, values and more.", 
       img_url: "http://tools.foxnews.com/sites/tools.foxnews.com/files/images/fox-news-logo.png",
       generated_url: "en"
   )
# Breitbart
Rss.create_or_find_by!(
    title: 'Breitbart',
   original_url: "http://feeds.feedburner.com/breitbart" ,
    description: "Syndicated news and opinion website providing continuously updated headlines to top news and analysis Rsss.", 
    img_url: "https://www.breitbart.com/t/assets/i/breitbart-logo.png",
    generated_url: "en"
   )
# Huffpost
Rss.create_or_find_by!(
title: 'HuffPost',
original_url: "https://www.huffpost.com/section/front-page/feed?x=1" ,
description: "Read the latest headlines, news stories, and opinion from Politics, Entertainment, Life, Perspectives, and more.", 
img_url: "https://uploads-ssl.webflow.com/5d026beb53e6e65465bbee00/5f215b3fcadab44b23bdd4f8_huffpost-logo.png",
generated_url: "en"
)
Rss.create_or_find_by!(
   title: 'HuffPost - Politics ',
  original_url: "https://www.huffpost.com/section/politics/feed" ,
   description: "The latest news on Donald Trump, Congress, campaigns, elections, policy and everything politics from HuffPost.", 
   img_url: "https://uploads-ssl.webflow.com/5d026beb53e6e65465bbee00/5f215b3fcadab44b23bdd4f8_huffpost-logo.png",
   generated_url: "en"
   )        
# Politico --- contact
Rss.create_or_find_by!(
   title: 'Politico',
  original_url: "https://www.politico.com/rss/politicopicks.xml" ,
   description: "Politics, Policy, Political News Top Stories", 
   img_url: "https://eurosagency.eu/wp-content/uploads/2015/09/arton74.jpg",
   generated_url: "en"
   )    
# Nypost
Rss.create_or_find_by!(
   title: 'New York Post',
  original_url: "https://nypost.com/feed/" ,
   description: "Your Rss for breaking news, news about New York, sports, business, entertainment, opinion, real estate, culture, fashion, and more.", 
   img_url: "https://img.favpng.com/25/15/25/new-york-city-new-york-post-newspaper-new-york-daily-news-the-new-york-times-png-favpng-fmxyqQWzbkiuMVBYmH8HHtUnS.jpg",
   generated_url: "en"
   )     
# yahoo
Rss.create_or_find_by!(
   title: 'Yahoo News - Headlines',
  original_url: "https://www.yahoo.com/news/rss" ,
   description: "The latest news and headlines from Yahoo! News. Get breaking news stories and in-depth coverage with videos and photos.", 
   img_url: "http://l.yimg.com/rz/d/yahoo_news_en-US_s_f_p_168x21_news.png",
   generated_url: "en"
   )


  
    puts 'seed finish!!'
end
