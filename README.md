Getting and Cleaning UCI's Dataset for Recognizing Human Activity Using Smartphone Data
=======================================================================================

UC Irvine's _Human Activity Recognition Using Smartphones Dataset_ contains various sensor data (called features) collected from users' smartphones. Some of the data is raw, meaning that it is a simple time series. For each such characteristic, there is a processed stream that converts the time series data into the frequency domain, using a Fourier transform.  More information about the data set can be found in the file *features_info.txt* in the UCI HAR directory.

The raw data from UCI has been processed in the following ways:
1. The testing and training datasets have been merged.
2. The id of the user on each observation has been added to the data.
3. The activity the user was performing (e.g., WALKING) has also been added to the data.
4. Only the mean and standard deviation of each feature is reported.

In addition, a second data set, called *summary-observations.csv* was produced, which has the average value of each feature for each user when he or she is performing one of the activities. E.g., there is an entry for Joe when he is WALKING, and another entry when he is SITTING.
