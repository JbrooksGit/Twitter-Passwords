#Install all necessary packages
install.packages("twitteR") #package that provides access to the Twitter API
install.packages("ROAuth") #Used to authenticate twitter credentials (keys)
install.packages("RCurl") #Imported by ROAuth to set up twitter,used for HTTP requests
install.packages("devtools") #Needed to use install_github function
install.packages("plyr")    #text manipulation
install.packages("tm")      #text manipulation
install.packages("stringr") #text manipulation
install.packages("ggplot2") #For creating bar chart
install.packages("wordcloud") #used to create word clouds
install.packages("SnowballC") #text manipulation
install.packages("RColorBrewer") # color palettes

require('devtools') 
require("sentR")

library(RColorBrewer)
library(packageName)
library(twitteR)
library(ROAuth)
library(RCurl)
library(plyr)
library(ggplot2)
library(wordcloud)
library(stringr)
library(tm)

#Store Twitter app keys
consumer_key <- "pDPZ1c9zBN37DwW59ttpF0QCO"
consumer_secret <- "pUsl7TBDBZVhCFfqQnF5xD9tODjNHeWcrYa4WvB1ueVP3Va3vL"
access_token <- "2152800670-1GileZvLLA9OW9QPrnSkWhBUrW0tfkDSf4ZsE69"
access_secret <- "yhU2sOnurqF5sA4wc3YFZk1L0pGM12oFZLZLTsrTWNg13"
#Set up Twitter OAuth
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)


personalGet <- function(searchTerm) {
 

  tweets <- searchTwitter(paste(searchTerm,"exclude:retweets",sep="+"), n=10, lang="en", NULL, resultType="recent")
  tweets.text = laply(tweets,function(t)t$getText())
  #gets only the text of each tweet
  
  tweetTexts <-unlist(lapply(tweets, function(t) { t$text}))
  tweetTexts <- removeURL(tweetTexts)
  #cleans the tweets
  
  #print(tweets.df,quote = FALSE)
  print(tweetTexts,quote = FALSE)
  #tweets should not include quotes
  
  plot.new()
  wordcloud(tweetTexts, min.freq = 1,
            max.words=200, random.order=FALSE, rot.per=0.35, 
            colors=brewer.pal(8, "Dark2"))
}

removeURL <- function(x){
  Cleaned_Tweet <- gsub("http[^[:space:]]*", "", x) #Removes URLs from Tweets
  removeEmoji <- gsub("\\p{So}|\\p{Cn}", "", Cleaned_Tweet, perl = TRUE) #Removes Emojis from Tweets
  Cleanest <- gsub("[^\x01-\x7F]", "", removeEmoji) #Removes even more emojis 
  
}

personalGet(" password is ")