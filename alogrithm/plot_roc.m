function [ auc ] = plot_roc( predict,ground_truth )
%PLOT_ROC Summary of this function goes here
%   Args:
%       predict     :predict labels
%       ground_truth:true lables
%   Return:
%       ...
%Detailed explanation goes here
%plot roc curve

%start point
x = 1.0;
y = 1.0;
pos_num = sum(ground_truth==1);
neg_num = sum(ground_truth==0);

x_step = 1/neg_num;
y_step = 1/pos_num;
[~,index] = sort(predict);
ground_truth = ground_truth(index);


for i =1:length(ground_truth)
    if ground_truth(i)==1
        y = y-y_step;
    else
        x = x-x_step;
    end
    X(i) = x;
    Y(i) = y;
end

figure;
plot(X,Y,'-ro','LineWidth',2,'MarkerSize',3);  
xlabel('虚报概率');  
ylabel('击中概率');  
title('ROC曲线图');  
%计算小矩形的面积,返回auc  
auc = -trapz(X,Y);
end

