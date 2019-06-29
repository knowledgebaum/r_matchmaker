library(readr) ; library(dplyr); library(tidyr); library(dbplyr)
library(stringr); library(odbc); library(DBI); library(tidyr);
#library(RSQLite); library(sqldf ); library(XLConnect)

input <- c(
  "input/puf_origin.txt"
  
  
  
)

output <- c(
  "output/puf_origin.csv"
  
  
  
  
  
)

out_to_csv <- function(input, output) {
      
    myco_data <- read_tsv(input, col_names = FALSE)
    
    
    myco_table <- data.frame(myco_data)
    
    myco_table$term <- str_extract(myco_table$X1, "(^[A-Z]{3,} [A-Z]{3,}\\(?S?\\)?|^[A-Z]{3,})")
    myco_table$content <- str_extract(myco_table$X1, "(?!^[A-Z]{3,} [A-Z]{3,}\\(?S?\\)?|^[A-Z]{3,})(  .*$)")
    
    
    dplyr::tbl_df(myco_table)
    
    View(myco_table)
    #subset
    
    myco_table = select(myco_table, term, content)
    myco_table <- myco_table[-c(1,2),]
    
    #add id column
    myco_table$mycoID=NA
    
    #add inside var col
    myco_table$internal_variable_num=NA
    
    num_props = 19
    
    for (row in 1:nrow(myco_table)){
      print(row)
      ###Myco_ID###
      myco_table[row, 3] = floor(row/18.001) +  1
      #ADD Mushroom Number string#
      #if (myco_table[row, 1] =='NA')
      if(is.na(myco_table[row, 1])) 
      {
        myco_table[row, 1]= "MUSHROOM_ID" #TERM
        myco_table[row, 2]=floor(row/18.001) +  1  #COLUMN
      }
      
      #Inside Mushroom Index
      myco_table[row, 4] = ceiling(row %% 18.001)
      #first column reset
    }
    #refresh first column
    row.names(myco_table) <- 1:nrow(myco_table)
    
    View(head(myco_table))
    
    write.csv(myco_table, file='myco.csv')
    
    ###Attempt to unstack
    
    myco_subset <- select(myco_table, mycoID, content)
    
     # <- spread(myco_subset, content, mycoID)
    spread_df <- spread(myco_table %>% select(-internal_variable_num), term, content)
    
    
    
     View(head(spread_df))
    
     write.csv(spread_df, output)
}
 
#for (i in 1:3){
#  out_to_csv(input[i],output[i])
#}
