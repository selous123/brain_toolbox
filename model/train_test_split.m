function [train_data,test_data,train_labels,test_labels] = train_test_split(nets,labels,proportion,shuffle)
%%
%TRAIN_TEST_SPLIT Summary of this function goes here
%Arguments:
%       nets      :3D array-like with shape[num_nodes,num_nodes,num_samples]
%       labels    :2D array-like with shape[num_samples,1]
%       proportion:number-like with range [0,1],represent proportion of
%           train set and test set
%       shuffle   :shuffle data use randperm
%       stratify  :array-like or [] (default is None)
%           If not None, data is split in a stratified fashion, using this as the class labels.
%           example : binary classification,[-1,1].
%Outputs  :
%       train_data,test_data,train_labels,test_labels
%
%     Split data from a whole dataset into train and test dataset.
%
%%

num_sample = size(nets,3);


if shuffle
    %generate a row vector containing a random permutation of the integers from 1 to n inclusive
    random_number = randperm(num_sample);
    %rearrangement datasets.
    nets = nets(:,:,random_number);
    labels = labels(:,:,random_number);
end

%split data to train data and test data.
num_train_sample = ceil(num_sample*proportion);
train_data = nets(:,:,1:num_train_sample);
train_labels = labels(:,:,1:num_train_sample);
test_data = nets(:,:,num_train_sample+1:end);
test_labels = labels(:,:,num_train_sample+1:end);


