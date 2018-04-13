function [predict_labels,true_labels] = kernel_svm(kernel_matrix,labels,num_folds)
%KERNEL_SVM Summary of this function goes here
%   Detailed explanation goes here
%Arguments:
%   kernel_matrix:kernel matrix with shape[num_samples,num_samples]
%   labels:
%Output:
%   result
%Author:ZHANGTAO
%Data:2018.4.10

%%
num_samples = size(kernel_matrix,1);
indexes = KFold(num_samples,num_folds,true);
predict_labels = [];
true_labels = [];
for i = 1:num_folds
    train_labels = labels(indexes{1,i}.train_indexes);
    train_data = kernel_matrix(indexes{1,i}.train_indexes,indexes{1,i}.train_indexes);
    train_data = [(1:size(train_data,1))',train_data];
    test_labels = labels(indexes{1,i}.test_indexes);
    test_data = kernel_matrix(indexes{1,i}.test_indexes,indexes{1,i}.train_indexes);
    test_data = [(1:size(test_data,1))',test_data];
    
    pare=['-b 1','-t 4','-c 2'];
    model = svmtrain(train_labels,train_data,pare);
    [Y_new,accuracy,score] = svmpredict(test_labels,test_data,model,'-b 1');
    predict_labels = [predict_labels;Y_new];
    true_labels = [true_labels;test_labels];
end
[Sen,Spe,ACC]=jb_SensitivitySpecificity(predict_labels,true_labels);

end

