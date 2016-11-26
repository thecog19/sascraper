The SA project is a tool to scrape and store LPs from SA in a easy to read format. The basic plan is to scrape a given LP, and store it in a DB, then render the LP in a readable format. At first it will only contain posts by the OP, we will eventually expand to archive all posts. 


Parts 


  Scraper


    Returns all post authors, Post content, and quoted posts
    Can be run from an admin panel by giving it a thread url and login credentials. 

    
  Database


    Stores Post Author, Unique Post ID, Post Content, quoted post AND POST PARENT, in order to make a linked list. 
    Separate DB to save images for backup. 


  Rails


    Displays posts with pagination every 30 posts
    Displays them in order
    Can retain HTML and Images
    Allows user to access another page
    Has a search function that can return statistics
    Allows post by OP only or Everyone. 
