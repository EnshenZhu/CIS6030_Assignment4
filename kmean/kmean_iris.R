# install.packages("ClusterR")
# install.packages("cluster")

# Loading package
library(ClusterR)
library(cluster)

# import the iris data from the docker
result <- system("docker exec namenode hdfs dfs -cat ./input/iris.csv", intern = TRUE)
writeLines(result, "./kmean/temp_iris.csv")
iris_data <- read.csv("./kmean/temp_iris.csv",
                      header = FALSE,
                      colClasses = c(NA, NA, NA, NA, NA),
                      col.names = c("sepal_length", "sepal_width", "petal_length", "petal_width", "species"))


# subtract the iris_params, which only contain the sepal and petal numberical values
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
# Evaluate and visualize the model
plot(iris_params[c("sepal_length", "sepal_width")])

plot(iris_params[c("sepal_length", "sepal_width")], col = kmean_model$cluster)

plot(iris_params[c("sepal_length", "sepal_width")], col = kmean_model$cluster,
     main = "K-means with 3 clusters")

## Plotiing cluster centers
kmean_model$centers
kmean_model$centers[, c("sepal_length", "sepal_width")]

# cex is font size, pch is symbol
points(kmean_model$centers[, c("sepal_length", "sepal_width")],
       col = 1:3, pch = 8, cex = 3)

## Visualizing clusters
y_kmeans <- kmean_model$cluster
clusplot(iris_params[, c("sepal_length", "sepal_width")],
         y_kmeans,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste("Cluster iris"),
         xlab = 'sepal_length',
         ylab = 'sepal_width')