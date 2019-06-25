library(readr) ; library(dplyr); library(tidyr); library(dbplyr)
library(stringr); library(odbc); library(DBI); library(tidyr)

bir_origin <- read_tsv("bir_origin.txt", 
                       col_names = FALSE)

myco_table <- data.frame(bir_origin)

myco_table$term <- str_extract(myco_table$X1, "(^[A-Z]{3,} [A-Z]{3,}\\(?S?\\)?|^[A-Z]{3,})")
myco_table$content <- str_extract(myco_table$X1, "(?!^[A-Z]{3,} [A-Z]{3,}\\(?S?\\)?|^[A-Z]{3,})(  .*$)")

rearranged <- tidyr::spread(myco_table, term )

dplyr::tbl_df(myco_table)


#subset

myco_table = select(myco_table, term, content)
myco_table <- myco_table[-c(1,2),]

#add id column
myco_table$mycoID=NA

#add inside var col
myco_table$internal_variable_num=NA


for (row in 1:nrow(myco_table)){
  print(row)
  ###Myco_ID###
  myco_table[row, 3] = floor(row/15.001) +  1
  #ADD Mushroom Number string#
  #if (myco_table[row, 1] =='NA')
  if(is.na(myco_table[row, 1])) 
  {
    myco_table[row, 1]= "MUSHROOM_ID" #TERM
    myco_table[row, 2]=floor((row)/15) +  1  #COLUMN
    
  }
 
  
  #Inside Mushroom Index
  myco_table[row, 4] = ceiling(row %% 15.001)
  #first column reset
}
#refresh first column
row.names(myco_table) <- 1:nrow(myco_table)

View(myco_table)

write.csv(myco_table, file='myco.csv')

###Attempt to unstack

myco_subset <- select(myco_table, mycoID, content)

 # <- spread(myco_subset, content, mycoID)
df_2 <- spread(myco_table %>% select(-internal_variable_num), term, content)



 #View(df_1)
 View(df_2)

 write.csv(df_2, "myco_table.csv")