function [Y_new,score] = svm_once(train_feas,test_feas,train_labels,test_labels,kernel,C)
%SVM Summary of this function goes here
%   Detailed explanation goes here

kernel_num = 0;
pare=['-b 1 -t ' num2str(kernel_num) ' -c ' num2str(C)];
model = svmtrain(train_labels,train_feas,pare);
[Y_new,accuracy,score] = svmpredict(test_labels,test_feas,model,'-b 1');

end

