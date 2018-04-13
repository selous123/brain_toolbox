clear;
clc;
%% Set parameters:spar,minsup,size_req
parameters.min_support_pos=36;%正类里面出现36次则认为是频繁模式，一般需要测试选出90%-95%的边
parameters.min_support_neg=37;%负类里面出现37次认为是频繁模式
parameters.size_req=[5,8];%边的个数从5-8,5 6 7 8，一般4-8就可以
parameters.type='HE';%疾病类型
parameters.num_positive_subgraph = 100;
parameters.num_negative_subgraph = 100;

sparsity=0.1;%稀疏度？？？，该值是阈值化的设置


addpath('../data');
%[nets,labels] = load_HE_data();
fileA ='/home/lrh/program/git/brain_toolbox/data/AAL_TC_COBRE_Nor.mat';
fileB ='/home/lrh/program/git/brain_toolbox/data/AAL_TC_COBRE_Pat.mat';
[nets,labels] = load_cobre_dataset(fileA,fileB);
size(nets)
sparsity_nets = threshold_nets_data(nets,sparsity);

addpath('discriminative subnetwork');
%sparsity_nets(:,:,1)
features = feature_discriminative_subnetwork(sparsity_nets,labels,parameters);