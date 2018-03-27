function [ features ] = feature_clustering_coefficient( conn_mat_mci )
%FEA_CLUSTERING_COEFFICIENT Summary of this function goes here
%   Detailed explanation goes here

%addpath('../feature extraction');
num_sample = size(conn_mat_mci,3);

features = [];
for i =1:num_sample
    feas_tmp = clustering_coef_wu(conn_mat_mci(:,:,i));
    features = [features,feas_tmp];
end
features = features';
end

