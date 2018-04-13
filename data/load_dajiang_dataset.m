function [ nets,labels ] = load_dajiang_dataset(file_path)
%%
%LOAD_DAJIANG_DATASET Summary of this function goes here
%
%Arguments:
%       file_path:file path of Dajiang dataset
%
%Outputs  :
%       nets     :[num_nodes,num_nodes,num_samples]
%       labels   :[num_samples,1]
%
%   Load dajiang dataset.
%
%Example  :
%       file_path='/home/lrh/program/git/brain_toolbox/data/Dajinag_data.mat';
%       [nets,labels] = load_dajiang_dataset(file_path);  
%
%Author:ZHang Tao
%Data :2018.3.31
%%

data = load(file_path);
data_struct = data.subject;
%  struct with fields:
% 
%            ID: {1×211 cell}
%          conn: [90×90×211 double]
%        target: [1×211 double]
%     labelInfo: 'AD-1, LMCI-2, EMCI-3, Normal-4, SMC-5, 0-Error'

ad_data = data_struct.conn(:,:,data_struct.target==1);
lmci_data = data_struct.conn(:,:,data_struct.target==2);
emci_data = data_struct.conn(:,:,data_struct.target==3);
normal_data = data_struct.conn(:,:,data_struct.target==4);
smc_data = data_struct.conn(:,:,data_struct.target==5);

%get ad and normal data
%labels ad_data:-1
%       normal_data:1
nets = cat(3,normal_data,ad_data);
labels = -ones(size(normal_data,3)+size(ad_data,3),1);
labels(1:size(normal_data,3),1) = 1;

end

