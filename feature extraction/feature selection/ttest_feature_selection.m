function [features] = ttest_feature_selection(raw_features,labels)
%TTEST_FEATURE_SELECTION Summary of this function goes here
%   Detailed explanation goes here
%Arguments:
%       raw_features:raw features with shape [num_samples,num_features].
%       labels      :labels with shape [num_samples,1],values of labels is \in {-1,1}
%Outputs  :
%       features    :features processed by ttest
%Example  :
%        ttest_feature_selection(raw_features);
%Author   :Tao Zhang
%Data     :2018.4.3

raw_feas_pat = raw_features((labels==-1),:);
raw_feas_nor = raw_features((labels==1),:);
num_features = size(raw_features,2);
p = ones(num_features,1);

%for one features in all samples ,we do ttest2 to clarify whether the features in 
%different labels are the same distribution  
for i = 1:num_features
    [~,p(i)] = ttest2(raw_feas_pat(:,i),raw_feas_nor(:,i));
end

%order the probility of ttest
%the smaller value of p,the smaller the correlation
[~,ind] = sort(p);
features = raw_features(ind,:);

end

