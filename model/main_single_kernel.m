function [ predict_labels,predict_probs,true_labels ] = main_single_kernel( configure )
%MAIN_SINGLE_KERNEL Summary of this function goes here
%   Detailed explanation goes here
%Arguments:
%   configure:
% configure = 
%   struct with fields:
%                     root_dir: '/home/lrh/program/git/brain_toolbox/data/Dajinag_data.mat'
%                  data_format: 'Dajiang-like'
%                    threshold: 1
%                     sparsity: 0.5000
%         feaextraction_method: 'Clustering Coefficient'
%     feaextraction_parameters: ''
%                kernel_method: 'linear'
%                       k_fold: 'ten'
%                      metrics: [1 0 0 1]
%Outputs  :
%Examples :
%Author:ZHANGTAO
%Data:2018.4.12
%

%% Load Data


addpath('../data');
if strcmp(configure.data_format,'Dajiang-like')
    [nets,labels] = load_dajiang_dataset(configure.root_dir);
else
    fileA ='/home/lrh/program/git/brain_toolbox/data/AAL_TC_COBRE_Nor.mat';
    fileB ='/home/lrh/program/git/brain_toolbox/data/AAL_TC_COBRE_Pat.mat';
    [nets,labels] = load_cobre_dataset(fileA,fileB);
end

%% Threshold data
if configure.threshold ==1
    nets = threshold_nets_data(nets,configure.sparsity);
end

%% k-fold
num_samples = size(nets,3);
if strcmp(configure.k_fold,'five')
    k_splits = 5;
elseif strcmp(configure.k_fold,'ten')
    k_splits = 10;
else
    k_splits = num_samples - 1;
end

%% Kernel
if strcmp(configure.kernel_method,'Graph Kernel')
    [predict_labels,predict_probs,true_labels] = svm_graph_kernel(nets,labels);
    return;
elseif configure.kernel_method=='linear'
    kernel_num = 1;
elseif configure.kernel_method=='gaussian'
    kernel_num = 2;
end

%% Feature Extraction
addpath('../feature extraction');
addpath('../feature extraction/discriminative subnetwork');
addpath('../feature extraction/oridimal pattern');
fe_method = configure.feaextraction_method;
if strcmp(fe_method,'Clustering Coefficient')
    features = feature_clustering_coefficient(nets);
elseif strcmp(fe_method,'Connection')
    features = jb_ConvertNetwork2Vector(nets);
elseif strcmp(fe_method,'Discriminative Subnetwork')
    features = feature_discriminative_subnetwork(nets,labels,...
        configure.feaextraction_parameters);
elseif strcmp(fe_method,'Ordinal Patterns')
    indexes = KFold(num_samples,k_splits,true);
    predict_probs = [];
    predict_labels = [];
    true_labels = [];
    for i =1:k_splits
        train_labels = labels(indexes{1,i}.train_indexes,:);
        test_labels = labels(indexes{1,i}.test_indexes,:);
        train_nets = nets(:,:,indexes{1,i}.train_indexes);
        test_nets = nets(:,:,indexes{1,i}.test_indexes);
        [train_features,test_features] = feature_ordimal_pattern(train_nets,test_nets,...
            train_labels,test_labels);
        %kernel_matrix = generate_kernel(features,configure.kernel_method);
        [pred_labels,probs] = svm_once(train_features,test_features,train_labels,test_labels,kernel_num,configure.C);
        predict_probs = [predict_probs;probs];
        predict_labels = [predict_labels;pred_labels];
        true_labels = [true_labels;test_labels];
    end
    return;
end




%% train and test model
[predict_labels,predict_probs,true_labels] = svm(features,labels,k_splits,configure.C,kernel_num);


end

