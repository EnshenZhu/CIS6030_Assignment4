# install.packages("ClusterR")
# install.packages("cluster")

# Loading package
library(ClusterR)
library(cluster)

# import the iris data from the docker
result <- system("docker exec namenode hdfs dfs -cat ./input/iris.csv", intern = TRUE)
writeLines(result, "temp_iris.csv")
iris_data <- read.csv("temp_iris.csv", header = FALSE, colClasses = c(NA, NA, NA, NA, NA), col.names = c("sepal_length", "sepal_width", "petal_length", "petal_width", "species"))


# subtract the iris_params,which only contain the sepal and petal numberical values
iris_params <- iris_data[, -5]

# print(iris_data$species)

# fit into k-mean clustering
set.seed(100) # set the seed
kmean_model <- kmeans(iris_params, centers = 3, nstart = 20) # set the nums of certoids as 3 and iterate 20 times
# kmean_model

# Cluster identification for
# each observation
# kmean_model$cluster

# # Confusion Matrix
cm <- table(iris_data$species, kmean_model$cluster)
# cm
#
# Model Evaluation and visualization
plot(iris_params[c("sepal_length", "sepal_width")])
plot(iris_params[c("sepal_length", "sepal_width")],
     col = kmean_model$cluster)
plot(iris_params[c("sepal_length", "sepal_width")],
     col = kmean_model$cluster,
     main = "K-means with 3 clusters")