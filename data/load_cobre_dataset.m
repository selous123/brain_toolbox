function [nets,labels] = load_cobre_dataset(filenameA,filenameB)
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
%Example:
%       fileA ='/home/lrh/program/git/brain_toolbox/data/AAL_TC_COBRE_Nor.mat';
%       fileB ='/home/lrh/program/git/brain_toolbox/data/AAL_TC_COBRE_Pat.mat';
%       nets,labels = load_cobre_dataset(fileA,fileB);
%Author:Zhang Tao
%Data : 2018.3.31
%
%
%LOAD_DATASET Summary of this function goes here
%   Detailed explanation goes here
%%
load(filenameA);
load(filenameB);
%with shape->[height,width,sample]
%shape[145,90,67]
normal_data=AAL_TC_COBRE_Nor;
%shape[145,90,53]
patient_data=AAL_TC_COBRE_Pat;
timeseries_data = cat(3,normal_data,patient_data);
%project label vector->with shape(size,1)
labels = -ones(size(normal_data,3)+size(patient_data,3),1);
labels(1:size(normal_data,3),1)=1;

p=0.5;
nets = ones(size(timeseries_data,2),size(timeseries_data,2),size(timeseries_data,3));
%use pearson correlation coefficient to build brain graph
for ind =1:size(timeseries_data,3)
    X1=timeseries_data(:,:,ind);
    N1=corrcoef(X1);
    SN1=threshold_proportional(N1, p);
    nets(:,:,ind)=SN1;
end
end

