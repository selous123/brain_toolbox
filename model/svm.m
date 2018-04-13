function [ predict_labels,predict_probs,true_labels ] = svm(data,labels,k_splits,C,kernel_num)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

num_samples = size(data,1);
indexes = KFold(num_samples,k_splits,true);
predict_labels = [];
predict_probs = [];
true_labels = [];

for i =1:k_splits
    train_labels = labels(indexes{1,i}.train_indexes,:);
    test_labels = labels(indexes{1,i}.test_indexes,:);
    train_feas = data(indexes{1,i}.train_indexes,:);
    test_feas = data(indexes{1,i}.test_indexes,:);
    para =['-b 1,-t ' num2str(kernel_num) ' -q -c ' num2str(C)];
    model = svmtrain(train_labels,train_feas,para);
    [Y_new,accuracy,score] = svmpredict(test_labels,test_feas,model,'-b 1');
    predict_labels = [predict_labels;Y_new];
    predict_probs = [predict_probs;score];
    true_labels = [true_labels;test_labels];
end

end

