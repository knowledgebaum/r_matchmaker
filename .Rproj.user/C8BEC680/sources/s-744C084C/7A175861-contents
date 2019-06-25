library(readr) ; library(dplyr); library(tidyr); library(dbplyr)
library(stringr); library(odbc); library(DBI); library(tidyr)
#bir_origin <- read_csv("C:/webDev/pycharm/update_mycology_db/data/origin_data/bir.txt")

#bir_origin <- read_csv("C:/webDev/pycharm/update_mycology_db/data/origin_data/bir_origin.txt", col_names = FALSE)

dat = readLines("C:/webDev/pycharm/update_mycology_db/data/origin_data/bir_origin.txt")
dat <- as.vector(dat)



as.data.frame(dat, row.names = NULL)
#dat = as.data.frame(dat)
#dat <- dat[Value]
#dat <- dat[-(1:2),]

#myco_table <- dat #data.frame(bir_origin)


dat$term <- str_extract(myco_table$X1, "(^[A-Z]{3,} [A-Z]{3,}|^[A-Z]{3,})")
dat$content <- str_extract(myco_table$X1, "(?!^[A-Z]{3,} [A-Z]{3,}|^[A-Z]{3,})(  .*$)")

View(dat)



