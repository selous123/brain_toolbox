function [indices] = KFold( num_samples,n_splits,shuffle)
%UNTITLED Summary of this function goes here
%
%Arguments:
%       num_samples:number of samples
%       n_splits   :Number of folds. Must be at least 2.
%       shuffle    :Whether to shuffle the data before splitting into batches.
%Outputs  :
%       indices    :cell data.store struct type data.
%
%   Example  :
%       num_samples = size(nets,3);
%       n_splits = 5;
%       indices = KFold(num_samples,n_splits,shuffle=false);
%       for i =1:n_splits
%           train_nets = nets(:,:,indices{1,i}.train_indexes);
%           test_nets = nets(:,:,indices{1,i}.test_indexes);
%       end
%   generate k-fold indices.
%

%%
%returns randomly generated indices for a K-fold cross-validation of N observations
index = crossvalind('Kfold', num_samples, n_splits);
all_indexes = 1:num_samples;
if shuffle
    all_indexes = randperm(num_samples);
end
indices = [];
for ind = 1:n_splits
    indices{1,ind}.test_indexes = all_indexes(index==ind);
    indices{1,ind}.train_indexes = all_indexes(index~=ind);
end
end

