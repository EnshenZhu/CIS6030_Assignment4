# install.packages("ClusterR")
# install.packages("cluster")

# Loading package
library(ClusterR)
library(cluster)

# import the multishapes data from the docker
result <- system("docker exec namenode hdfs dfs -cat ./input/multishapes.csv", intern = TRUE)
writeLines(result, "./kmean/temp_multishape.csv")
multishape_data <- read.csv("./kmean/temp_multishape.csv", header = TRUE, colClasses = c("NULL", NA, NA, NA))

# print(multishape_data)

# subtract the xy_params,
xy_params <- multishape_data[, -3]

# fit into k-mean clustering
set.seed(100) # set the seed
kmean_model <- kmeans(xy_params, centers = 6, nstart = 20) # set the nums of certoids as 3 and iterate 20 times
# kmean_model

# Cluster identification for
# each observation
# kmean_model$cluster

# Confusion Matrix
# cm <- table(iris_data$species, kmean_model$cluster)
# cm
#
# Evaluate and visualize the model
plot(xy_params[c("x", "y")])

plot(xy_params[c("x", "y")], col = kmean_model$cluster)

plot(xy_params[c("x", "y")], col = kmean_model$cluster, main = "K-means with 6 clusters")

## Plotiing cluster centers
kmean_model$centers
kmean_model$centers[, c("x", "y")]

# cex is font size, pch is symbol
points(kmean_model$centers[, c("x", "y")],
       col = 1:3, pch = 8, cex = 5)

## Visualizing clusters
y_kmeans <- kmean_model$cluster
clusplot(xy_params[, c("x", "y")],
         y_kmeans,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste("Cluster Multishape"),
         xlab = 'x',
         ylab = 'y')