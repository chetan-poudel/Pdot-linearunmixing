# Linear Unmixing of Spectral Crosstalk in Pdot-stained tissues 
The MATLAB script in this repository is designed to accompany our manuscript submission to Science Advances by Guo et al in 2024. This simple script takes raw "mixed" images and a calibration matrix as input and applies simple linear unmixing to output "unmixed" images for a number of image channels.
Three example image datasets and calibration matrixes are included. 

The **first dataset** includes files for excitation multiplexing:

(a) Brain_mixedsignal_3channel_exmultiplex.tif

(b) ExcitationMultiplexCalibrationMatrix.mat

This tif file contains the raw image data corresponding to Figure 3 and Figure S7 in the manuscript. Here, a brain slice was stained with 3 polymer dots and imaged in 3 channels. After using the accompanying script, a user can generate the unmixed images shown in the figure below. 

![<Excitation Multiplexing of 3 channels in the mouse brain>](https://github.com/chetan-poudel/Pdot-linearunmixing/blob/main/ExMultiplex.png)


The **second dataset** includes files for emission multiplexing:

(a) Brain_mixedsignal_8channel_emmultiplex.tif

(b) EmissionMultiplexCalibrationMatrix.mat

This tif file contains the raw data corresponding to Figure 2 and Figure S3 in the manuscript. Here, a brain slice was stained with 8 polymer dots and imaged in 8 channels. After using the accompanying script, a user can generate the unmixed images shown in the figure below. 

![<Emission Multiplexing of 8 channels in the mouse brain>](https://github.com/chetan-poudel/Pdot-linearunmixing/blob/main/EmMultiplex.png)


The **third dataset** includes files for excitation + emission multiplexing:

(a) Kidney_mixedsignal_22channel_exemmultiplex.tif

(b) ExEmMultiplexCalibrationMatrix.mat

This tif file contains the raw data corresponding to Figure 5 in the manuscript. Here, a kidney slice was stained with 21 polymer dots and imaged in 22 channels. After using the accompanying script, a user can generate the unmixed images shown in the figure below. Due to GitHub file size restrictions of <100MB, the image has been partly cropped. 

![<Excitation and Emission Multiplexing of 21 channels in the mouse kidney>](https://github.com/chetan-poudel/Pdot-linearunmixing/blob/main/ExEmMultiplex.png)



A calibration matrix is also included for each dataset. This matrix contains normalized contributions of each stain in the individual image channels. This calibration of bleedthrough and cross-excitation was performed by imaging polymer dots in solution.



