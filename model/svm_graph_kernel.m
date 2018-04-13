function [ predict_labels,predict_probs,true_labels] = graph_kernel_svm(nets,labels)
%_GRAPHKERNEL_SVM Summary of this function goes here
%   Detailed explanation goes here
%Arguments:
%   nets  :
%   labels:
%Outputs  :
%Author:Zhang Tao
%Data  :2018.3.31
%

addpath('../feature extraction/graph kernel');
h = 5;
kernel_nets = feature_graph_kernel(nets,h);
kernel_nets = kernel_nets{h+1,1};
size(kernel_nets)

num_samples = size(nets,3);
n_splits = 5;
indexes = KFold(num_samples,n_splits,true);
predict_labels = [];
true_labels = [];
predict_probs = [];

for i =1:n_splits
    %kernel(train_nets,train_nets)
    train_labels = labels(indexes{1,i}.train_indexes,:);
    k_train_feas = kernel_nets(indexes{1,i}.train_indexes,indexes{1,i}.train_indexes);
    k_train_feas = [(1:size(k_train_feas,1))',k_train_feas];
    %kernel(test_nets,train_nets)
    test_labels = labels(indexes{1,i}.test_indexes,:);
    k_test_feas = kernel_nets(indexes{1,i}.test_indexes,indexes{1,i}.train_indexes);
    k_test_feas = [(1:size(k_test_feas,1))',k_test_feas];
   

    pare=['-b 1','-t 4','-c 2'];
    model = svmtrain(train_labels,k_train_feas,pare);
    [Y_new,accuracy,score] = svmpredict(test_labels,k_test_feas,model,'-b 1');
    predict_labels = [predict_labels;Y_new];
    predict_probs = [predict_probs;score];
    true_labels = [true_labels;test_labels];
end


end

