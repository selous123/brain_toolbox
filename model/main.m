function [ACC] = main()
%MAIN Summary of this function goes here
%   Detailed explanation goes here

%%
%read data
addpath('../data');
fileA = '/home/lrh/program/git/brain_toolbox/data/AAL_TC_COBRE_Nor.mat';
fileB = '/home/lrh/program/git/brain_toolbox/data/AAL_TC_COBRE_Pat.mat';
[nets,labels] = load_cobre_dataset(fileA,fileB);
%%
%feature extraction
addpath('../feature extraction/oridimal pattern');
addpath('../feature extraction');
[features] = feature_clustering_coefficient(nets);
%[features] = jb_ConvertNetwork2Vector(nets);
%features with shape[num_samples,num_features]

%%
%train model
num_samples = size(nets,3);
n_splits = 5;
indexes = KFold(num_samples,n_splits,true);
predict_labels = [];
true_labels = [];


for i =1:n_splits
    train_labels = labels(indexes{1,i}.train_indexes,:);
    test_labels = labels(indexes{1,i}.test_indexes,:);
%     train_nets = nets(:,:,indexes{1,i}.train_indexes);
%     test_nets = nets(:,:,indexes{1,i}.test_indexes);
    
    train_feas = features(indexes{1,i}.train_indexes,:);
    test_feas = features(indexes{1,i}.test_indexes,:);
%     [train_feas,test_feas] = feature_ordimal_pattern(train_nets,...
%         test_nets,train_labels,test_labels);
    C = 2;
    para =['-b 1,-t 0 -q -c ',num2str(C)];
    model = svmtrain(train_labels,train_feas,para);
    [Y_new,accuracy,score] = svmpredict(test_labels,test_feas,model,'-b 1');
    predict_labels = [predict_labels;Y_new];
    true_labels = [true_labels;test_labels];
end

[Sen,Spe,ACC]=jb_SensitivitySpecificity(predict_labels,true_labels)
end

