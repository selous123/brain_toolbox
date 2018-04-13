function [kaux] = combine_multi_kernel(kernels,beta)
%COMBINE_MULTI_KERNEL Summary of this function goes here
%   Detailed explanation goes here
%Arguments:
%   kernels:with shape [num_samples,num_samples,num_kernels]
%   beta : weights of kernels,with shape [num_kernels,1]
%Outputs:
%   kaux:combine kernels by sum multipy the weights:beta.
%Author:ZHANGTAO
%Data:2018.4.10

%%
num_kernels = size(kernels,3);
kaux = zeros(size(kernels(:,:,1)));
for ind =1:num_kernels
    kaux = kaux + beta(ind).*kernels(:,:,ind);
end

end

