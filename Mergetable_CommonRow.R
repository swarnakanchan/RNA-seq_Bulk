library(dplyr)
library(readr)

#Read main table
mytable <-read.csv("diffexpr-H460.csv")
head (mytable)

lookup <- read.csv("GeneSymbol_HumanHg38.csv")
head (lookup)


#Merge table  using left_join().  left_join() means include all rows on the left, or first, data set, but only rows that match from the second one. 

joined_table <- left_join(mytable, lookup)


# Write final table
write.csv(joined_table, file="diffexpr-H460-final.csv")







