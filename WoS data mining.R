### Automated scraping WoS for science co-authorship network---
## Dan Schofield danschofield888@gmail.com  ---
## Code adapted from Kieran Healy http://stackoverflow.com/questions/27754051/how-to-retrieve-informations-about-journals-from-isi-web-of-knowledge ----

#install.packages("devtools")
#install.packages("RSelenium")

# setup broswer and selenium
library(devtools)
install_github("ropensci/rselenium")
library(RSelenium)
checkForServer()
startServer()
remDr <- remoteDriver(browserName = "chrome")
remDr$open()

remDr$navigate("https://apps.webofknowledge.com/summary.do?product=WOS&doc=1&qid=9&SID=X17tuTt5ehixzqgqs8f&search_mode=AdvancedSearch&update_back2search_link_param=yes")


#Loop to get citation data for each page of results, each iteration will save a text file
for(i in 1:1000){
  # click on 'save to text file'
  result <- try(
    webElem <- remDr$findElement(using = 'id', value = "select2-chosen-1")
  ); if(class(result) == "try-error") next;
  webElem$clickElement()
  
  # click on 'send' on pop-up window
  result <- try(
    webElem <- remDr$findElement(using = "css", "span.quickoutput-action")
  ); if(class(result) == "try-error") next;
  webElem$clickElement()
  
  # refresh the page to get rid of the pop-up
  remDr$refresh()
  
  # advance to the next page of results
  result <- try(
    webElem <- remDr$findElement(using = 'xpath', value = "(//form[@id='summary_navigation']/table/tbody/tr/td[3]/a/i)[2]")
  ); if(class(result) == "try-error") next;
  webElem$clickElement()
  print(i) 
}

##Read all text files into R.. 

# move them manually into a folder of their own
setwd("/Users/danschofield/R projects /Labstep project/WoS data")
# get text file names
my_files <- list.files(pattern = ".txt")
# make list object to store all text files in R
my_list <- vector(mode = "list", length = length(my_files))
# loop over file names and read each file into the list
my_list <- lapply(seq(my_files), function(i) read.csv(my_files[i], 
                                                      skip = 4, 
                                                      header = TRUE,                            
                                                      comment.char = " "))
# check to see it worked
my_list[1:5]
