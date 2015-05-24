##The Code Book

###Raw data
The raw data were obtained from UCI Machine Learning repository. 

####Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

####Attribute Information:

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

The variables that were estimated from the signals are:

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values.
iqr(): Interquartile range
entropy(): Signal entropy
arCoeff(): Autoregression coefficients with Burg order equal to 4
correlation(): Correlation coefficient between two signals
maxInds(): Index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): Skewness of the frequency domain signal
kurtosis(): Kurtosis of the frequency domain signal
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between some vectors.

#### Units
No unit of measures was given since all features were normalized and bounded within [-1,1].

#### Script
The test and the training sets were imported from the unzipped data and merged. (Step 1)
The index file was created to exclude the variables with the names not contatining "std" or "mean" for standart deviation and mean values respectively. (Step 2)

The activity labels were transformed from 1-6 to the descriptive ones: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS. (Step 3)

The variable names were changed to the more decriptive one in the following way: 
- t -> TimeDomain
- f -> FrequncyDomain
- Acc -> Acceleration
- Mag -> Magnitude
- GyroJerk -> AngularAcceleration
- Gyro -> AngularSpeed 
- etc.

the parenthesis were removed
This completes the Step 4 to give tbl_s4 (intermediate data set required by the Step 4)

The obtained data set was grouped by the subject and activity and the mean values of the variables for each group were calculated. The variables in final data set (tbl_s5) were given the new names by the addition of "Mean" in the beginning of each column name.
This completes the Step 5.


