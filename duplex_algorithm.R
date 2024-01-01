
remove_elements_from_vector <- function(elements_to_remove, vector){
  
  for (i in 1:length(elements_to_remove)) {
    vector <- vector[vector != elements_to_remove[i]]
  }
  return(vector)
}

add_point_to_points <- function(point, points){
  return(c(points, point))
}

update_rounded_sorted_distance <- function(rounded_sorted_distance, point_str, rounded_distance_matrix){
  return(remove_elements_from_vector(rounded_distance_matrix[colnames(rounded_distance_matrix) == point_str], rounded_sorted_distance))
}

update_rounded_distance_matrix <- function(rounded_distance_matrix, point_str){
  return(rounded_distance_matrix[, colnames(rounded_distance_matrix) != point_str])
}


data <- read_excel("textbook.xls")

# Since Observation 15 and 23, and 16 and 32, are near neighbours in the x space
# We will average their x1 and x2 values and use the average 

x1 <- data$`Number of Cases, x1`
x2 <- data$`Distance, x2 (ft)`

# Since Observation 15 and 23, and 16 and 32, are near neighbours in the x space
# We will average there x1 and x2 values and use the average 
X <- data.frame(x1, x2)

X[15,]$x1 <- (X[15,]$x1 + X[23,]$x1) / 2
X[15,]$x2 <- (X[15,]$x2 + X[23,]$x2) / 2
X[16,]$x1 <- (X[16,]$x1 + X[32,]$x1) / 2
X[16,]$x2 <- (X[16,]$x2 + X[32,]$x2) / 2

X <- X[-c(23, 32),]
x1 <- X$x1
x2 <- X$x2

s11 <- (length(x1)-1)*var(x1)
s22 <- (length(x2)-1)*var(x2)


Z <- cbind((x1-mean(x1))/sqrt(s11),
           (x2-mean(x2))/sqrt(s22))

T <- chol(t(Z)%*%Z)

W <- Z%*%solve(T)

distance <- dist(W, method = "euclidean")

sorted_distance = sort(distance, decreasing = TRUE)

distance_matrix = as.matrix(distance)

rounded_distance_matrix <- apply(distance_matrix, MARGIN = c(1, 2), FUN = function(x) round(x, digits = 6))

colnames(rounded_distance_matrix) <- rownames(X)
rownames(rounded_distance_matrix) <- rownames(X)

rounded_sorted_distance = round(sorted_distance, digits = 6)

estimation_points = c()

prediction_points = c()

# Add the two points with the largest distance to the estimation points
for(i in 1:2){
  point = which(rounded_distance_matrix == rounded_sorted_distance[1],
                arr.ind = TRUE)[i]
  
  point_str = as.character(point)
  
  estimation_points = add_point_to_points(point, estimation_points)
  
}

# Update the distance and sorted distance matrix
for(i in 1:length(estimation_points)){
  
  point_str = as.character(estimation_points[i])
  
  rounded_sorted_distance = update_rounded_sorted_distance(rounded_sorted_distance, point_str, rounded_distance_matrix)
  
  rounded_distance_matrix = update_rounded_distance_matrix(rounded_distance_matrix, point_str)
  
}


# Add the next two points to the prediction points
for(i in 1:2){
  point = which(rounded_distance_matrix == rounded_sorted_distance[1],
                arr.ind = TRUE)[i]
  
  point_str = as.character(point)
  
  prediction_points = add_point_to_points(point, prediction_points)
  
}

# Update the distance and sorted distance matrix
for(i in 1:length(prediction_points)){
  
  point_str = as.character(prediction_points[i])
  
  rounded_sorted_distance = update_rounded_sorted_distance(rounded_sorted_distance, point_str, rounded_distance_matrix)
  
  rounded_distance_matrix = update_rounded_distance_matrix(rounded_distance_matrix, point_str)
  
}


# Add the remaining points
# Alternating between adding to estimation and to prediction
remaining_points <- colnames(rounded_distance_matrix)

i = 1
while (length(remaining_points) >= 2){
  
  if ((i %% 2) == 1){
    furthest_to_estimation_points <- max(rounded_distance_matrix[rownames(rounded_distance_matrix) %in% as.character(estimation_points)])
    point <- as.integer(colnames(rounded_distance_matrix)[which(rounded_distance_matrix == furthest_to_estimation_points, arr.ind = TRUE)[2]])
    
    estimation_points <- add_point_to_points(point, estimation_points)
    point_str <- as.character(point)
    
    if(length(remaining_points) == 2){
      prediction_points <- add_point_to_points(as.integer(remaining_points[remaining_points != point_str]), prediction_points)
      remaining_points <- remaining_points[remaining_points != point_str]
    }
    
    else{
      rounded_distance_matrix <- update_rounded_distance_matrix(rounded_distance_matrix, point_str)
      remaining_points <- colnames(rounded_distance_matrix)
    }
    
    
    
    
    i = i + 1
  }else {
    
    furthest_to_prediction_points <- max(rounded_distance_matrix[rownames(rounded_distance_matrix) %in% as.character(prediction_points)])
    point <- as.integer(colnames(rounded_distance_matrix)[which(rounded_distance_matrix == furthest_to_prediction_points, arr.ind = TRUE)[2]])
    
    prediction_points <- add_point_to_points(point, prediction_points)
    point_str <- as.character(point)
    
    if(length(remaining_points) == 2){
      estimation_points <- add_point_to_points(as.integer(remaining_points[remaining_points != point_str]), estimation_points)
      remaining_points <- remaining_points[remaining_points != point_str]
    }
    
    else{
      rounded_distance_matrix <- update_rounded_distance_matrix(rounded_distance_matrix, point_str)
      remaining_points <- colnames(rounded_distance_matrix)
    }
    i = i + 1
  }
}

estimation_points

prediction_points














