# install.packages("ClusterR")
# install.packages("cluster")

# Loading package
library(ClusterR)
library(cluster)
library()

# import the iris data from the docker
result <- system("docker exec namenode hdfs dfs -cat ./input/iris.csv", intern = TRUE)
writeLines(result, "./kmean/temp_iris.csv")
iris_data <- read.csv("./kmean/temp_iris.csv",
                      header = FALSE,
                      colClasses = c(NA, NA, NA, NA, NA),
                      col.names = c("sepal_length", "sepal_width", "petal_length", "petal_width", "species"))

# subtract the iris_params, which only contain the sepal and petal numberical values
iris_params <- iris_data[, -5]

# print(iris_params)

get_data_points(iris_params)