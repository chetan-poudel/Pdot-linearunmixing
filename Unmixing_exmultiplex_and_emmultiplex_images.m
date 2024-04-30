%%% Simple linear unmixing script for Guo et al (Science Advances) manuscript submission.
%%% Written by Chetan Poudel, Ziyu Guo, and Joshua Vaughan. (2024)

clear all

% Enter path to the analysis script. 
script_path = 'A:\MATLAB scripts\'; 
cd(script_path)

% Select region of interest (ROI) for unmixing (eg. 1:2048 for the whole image)
roi_row = 1:2048;
roi_column = 1:2048;

% Choose the type of multiplexing you would like to do:
% Excitation multiplexing = 1
% Emission multiplexing = 2
Multiplexing = 1; 

%%
% Excitation multiplexing
if Multiplexing == 1
    % Enter path of the mixed data
    raw_mixed_file = strcat(script_path,'Brain_mixedsignal_3channel_exmultiplex.tif');

    numchannels=3;
    % Calibration matrix (3 X 3) obtained by imaging 3 Pdot solutions at the 3
    % different channels and normalizing the intensities at each channel. 
    load("ExcitationMultiplexCalibrationMatrix.mat")
    % Background noise recorded in the camera for a blank sample in all the
    % channels at the same exposure settings used to image the tissue. 
    bkg = [123 130 101];
end 

% Emission multiplexing
if Multiplexing == 2
    % Enter path of the mixed data
    datapath='A:\MATLAB scripts\'; 
    raw_mixed_file = strcat(script_path,'Brain_mixedsignal_8channel_emmultiplex.tif');
    
    numchannels=8;
    % Calibration matrix (8 X 8) obtained by imaging 8 Pdot solutions at
    % the 8 different channels and normalizing the intensities at each channel. 
    load("EmissionMultiplexCalibrationMatrix.mat")
    % Background noise recorded in the camera for a blank sample in all the
    % channels at the same exposure settings used to image the tissue. 
    bkg = [104 105 102 122 130 103 103 101];
end


%% 
% Unmixing algorithm that unmixes signals on a pixel-by-pixel basis. 
% Works with excitation, emission or excitation+emission multiplexing. 
 
% Load the raw data using the tiffreadVolume command. Command available for
% any recent versions of MATLAB after 2020b.
imgStack = tiffreadVolume(raw_mixed_file);     

% First put the mixed data into a struct for easier indexing.
for k = 1:numchannels
    Mixed(k).st = imgStack(roi_row,roi_column,k);
end

% Start a timer for the unmixing operation.
tic
for m = 1:size(Mixed(1).st,1)
    for n = 1:size(Mixed(1).st,2)
        % collect 3-channel data for each pixel and subtract background first
        b = zeros(numchannels,1);
        for k = 1:numchannels
            b(k) = Mixed(k).st(m,n)- bkg(k);
        end

        %Pixel-by-pixel spectral unmixing of signals in the three channels.
        unmixpixel = lsqnonneg(CM',b);

        % put the unmixed pixels into the output structure
        for k = 1:numchannels
            Unmix(k).st(m,n) = unmixpixel(k);
        end
    end
end
toc


% Write the unmixed data into file
for k = 1:numchannels
    img=cell2mat(struct2cell(Unmix(k)));
    img=uint16(img);
    FileName = strcat(script_path,'Unmixed_dataset.tif');
    imwrite(img,FileName,'WriteMode','Append');
end

%Please rename the Unmixed_dataset file if you wish to run this unmixing script
%multiple times. Otherwise the code will append images to the same output file. 


%%
%This sub-section will print the average intensity per channel before 
% unmixing (Fig 1) and after unmixing (Fig 2) in matrix form.
%It also includes a visualization of the calibration matrix (Fig 3). 

mixedStack = tiffreadVolume(raw_mixed_file);     
mixedStackavg=mean(mixedStack,[1 2]);
mixedStackavg=squeeze(mixedStackavg);
figure(1)
imagesc(mixedStackavg); colormap gray

unmixedStack = tiffreadVolume("Unmixed_dataset.tif");
unmixedStackavg=mean(unmixedStack,[1 2]);
unmixedStackavg=squeeze(unmixedStackavg);
figure(2)
imagesc(unmixedStackavg); colormap gray

load("ExcitationMultiplexCalibrationMatrix.mat")
figure(3)
imagesc(CM); colormap gray