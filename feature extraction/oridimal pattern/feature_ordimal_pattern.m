function [ train_features,test_features ]= feature_ordimal_pattern(...
    train_nets,test_nets,train_labels,test_labels)
%%
%FEA_ORDIMAL_PATTERN Summary of this function goes here
%   Detailed explanation goes here
%   Extract ordimal pattern features from nets data.
%Arguments:
%   train_nets:
%   test_nets :
%   train_labels
%Outputs  :
%%
[train_features,~,model] = ordinal_pattern_vector_get_train(train_nets,train_labels);
[test_features,~]  = ordinal_pattern_vector_get_new(model,test_nets,test_labels );

end

