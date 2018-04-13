function [ precision,recall ] = plot_pr(predict,ground_truth,plot_bool)
%PLOT_PR Summary of this function goes here
%   Args:
%       predict     :predict labels
%       ground_truth:true lables
%   Return:
%       ...
%Detailed explanation goes here
%plot pr curve
%start point
precision = zeros(length(ground_truth),1);
recall = zeros(length(ground_truth),1);

%TP+FN
num_pos= sum(ground_truth==1);
[~,index] = sort(predict);
ground_truth = ground_truth(fliplr(index));

%true positive:TP
num_true_pos = 0;
%i:TP+FP
for i = 1:length(ground_truth)
    if ground_truth(i) == 1
        num_true_pos= num_true_pos+1;
    end
    precision(i) = num_true_pos/i;
    recall(i) = num_true_pos/num_pos;
end
if plot_bool
    figure;
    plot(recall,precision,'-ro','LineWidth',2,'MarkerSize',3);  
    xlabel('Recall');  
    ylabel('Precison');  
    title('P-R curve');  
end

end

