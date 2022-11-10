# install.packages("ClusterR")
# install.packages("cluster")

# Loading package
library(ClusterR)
library(cluster)

# import the multishapes data from the docker
result <- system("docker exec namenode hdfs dfs -cat ./input/multishapes.csv", intern = TRUE)
writeLines(result, "temp_multishapes.csv")
multishape_data <- read.csv("temp_multishapes.csv", header = TRUE, colClasses = c("NULL", NA, NA, NA))

print(multishape_data)