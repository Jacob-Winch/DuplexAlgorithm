# DuplexAlgorithm

Here is my implementation of the **DUPLEX algorithm** for data splitting. The DUPLEX algorithm can be used as a model validation technique in linear regression to split a dataset into a prediction and estimation set. This implementation is based on the implementation that we learned in Dr. Alireza Simchi's STAT 378 class at the University of Alberta.

The DUPLEX algorithm is a method of data splitting that ensures that the prediction set of points stresses the linear regression model sufficiently by ensuring that there are influential points in both the estimation and prediction set. The initial DUPLEX algorithm was described by Ronald D. Snee in the 1977 paper, "*Validation of Regression Models: Methods and Examples*." I was further exposed to the algorithm in the textbook *Introduction to Linear Regression Analysis* by Douglas C. Montgomery, Elizabeth A. Peck, and Geoffrey Vining.

The implementation provided in [duplex_algorithm.R](https://github.com/Jacob-Winch/DuplexAlgorithm/blob/main/duplex_algorithm.R) is on The Delivery Time Data set provided in Example 11.3 in *Linear Regression Analysis*. This implementation differs from the one provided in the textbook since it adds points to prediction and estimation sets by determining the point that is furthest away from any point in the estimation/prediction set rather than determining the average distance from all points.

# Usage Guide for DuplexAlgorithm
-[duplex_algorithm.R](https://github.com/Jacob-Winch/DuplexAlgorithm/blob/main/duplex_algorithm.R) can be tailored to a dataset by copying the script and changing the first few lines of the script to match the regressors in a dataset

## Citations: 
- Snee, R. D. (1977). *Validation of Regression Models: Methods and Examples*. Technometrics, 19(4), 415–428. [https://doi.org/10.2307/1267881](https://doi.org/10.2307/1267881)

- Montgomery, D. C., Peck, E. A., & Vining, G. G. (2021). *Introduction to Linear Regression Analysis*, Sixth Edition. John Wiley & Sons, Inc. pp. 393-401

- Simchi. A (2023). STAT 378 Course materials




