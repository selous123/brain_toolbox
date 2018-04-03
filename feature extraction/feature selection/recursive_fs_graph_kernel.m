function [features] = recursive_fs_graph_kernel(nets,raw_features,labels,ROIs)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%Arguments:
%       nets:weight matrix
%       raw_features:raw features with shape [num_samples,num_features].
%       labels      :labels with shape [num_samples,1],values of labels is \in {-1,1}
%       ROIs        :with shape [num_features,1].代表每个特征所属于的脑区
%Outputs  :
%       features    :features processed by ttest
%Author   :ZHANG TAO
%Data     :2018.4.3
addpath('../../model');
num_features = size(raw_features,2);
position_nets = ROIs;
nets = nets(position_nets,position_nets,:);
sort_of_features = 1:num_features;

for index = 1:num_features
    num_rois = size(nets,1);
    acc = zeros(num_rois,1);
    for ind =1:num_rois
        %delete ind'th ROI
        tmp_nets = nets;
        tmp_nets(ind,ind,:) = [];
        acc(ind) = graph_kernel_svm(tmp_nets,labels);
    end
    [~,ind] = max(acc);
    nets(ind,ind,:) = [];
    sort_of_features(index) = ind;
end

features = raw_features(:,sort_of_features);
end

