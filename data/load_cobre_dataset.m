function [nets,labels] = load_cobre_dataset(filenameA,filenameB,proportion)
%%
%Arguments:
%       filenameA:file path of normal data
%       filenameB:file path of patient data
%       proportion:proportion of train and test dataset.
%Outputs  :
%       nets  :brain network weights with shape [90,90,120]
%       labels:labels with shape [120,1]
%           if patient label==-1
%           else normal label==1
%
%
%LOAD_DATASET Summary of this function goes here
%   Detailed explanation goes here
%%
load(filenameA)
load(filenameB)
%with shape->[height,width,sample]
%shape[145,90,67]
normal_data=AAL_TC_COBRE_Nor;
%shape[145,90,53]
patient_data=AAL_TC_COBRE_Pat;
nets = cat(3,normal_data,patient_data);
%project label vector->with shape(size,1)
labels(1:size(Nor,3),1)=1;
labels(size(Nor,3)+1:size(Par,3)+size(Nor,3))=-1;


end

