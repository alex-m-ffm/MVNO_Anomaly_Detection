library(tidyverse)
library(rvest)
library(httr)

# define user credentials
username <- "user"
password <- "password"

# define where you want the files to be stored
download_path <- "C:/MVNO_Logs/raw/"

# this gets me the directory index
directory <- GET("https://privacyaware.nlehd.de/shr/", 
    authenticate(username, password)
    )

# this gives me the list of files
files <- html_table(content(directory))[[1]][["Name"]] %>% # parse the http response and use the column Name of the first list element
  .[nchar(.)>0] %>% # filter out empty strings
  .[. !="Parent Directory"] # filter out the title row


# download all files
for(i in files){
  GET(paste0("https://privacyaware.nlehd.de/shr/", i),
      authenticate(username, password),
      progress(),
      write_disk(paste0(download_path, i), overwrite = TRUE))
}