function [ features ] = brain_network_feature_extraction( fileA,fileB,p )
%%
%BRAIN_NETWORK_FEATURE_EXTRACTION Summary of this function goes here
%Arguments:
%       fileA:file path of normal dataset
%       fileB:file path of patient dataset
%       p    :proportion of weights to preserve
%           range:  p=1 (all weights preserved) to
%                   p=0 (no weights removed)
%
%
%Output   :
%       features:return the features of the brain network

%example   :
%       fileA = '/home/lrh/program/git/brain_software/toolbox/New/AAL_TC_COBRE_Nor.mat'
%       fileB = '/home/lrh/program/git/brain_software/toolbox/New/AAL_TC_COBRE_Pat.mat'
%       p = 0.5;
%       feas = brain_network_feature_extraction(fileA,fileB,p);

%%

%load data
load(fileA)
load(fileB)
%shape[145,90,67]
Nor=AAL_TC_COBRE_Nor;
%shape[145,90,53]
Par=AAL_TC_COBRE_Pat;

%project label vector->with shape(size,1)
Label(1:size(Nor,3),1)=1;
Label(size(Nor,3)+1:size(Par,3)+size(Nor,3))=0;

%for each sample do while
for i=1:size(Nor,3)
    X1=Nor(:,:,i);
    %compute 'Pearson correlation coefficient',represent brain network
    %weights
    N1=corrcoef(X1);
    %Proportional thresholding
    SN1=threshold_proportional(N1, p);
    Net(:,:,i)=SN1;   
end
for i=1:size(Par,3)
    X2=Par(:,:,i);
    N2=corrcoef(X2);
    SN2=threshold_proportional(N2, p);
    Net(:,:,i+size(Nor,3))=SN2;  
end
[features]=jb_ConvertNetwork2Vector(Net);
end

