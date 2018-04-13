function [threshold_nets] = threshold_nets_data(nets,sparsity)
%THRESHOLD_NETS_DATA Summary of this function goes here
%   Detailed explanation goes here
%Argument:
%   nets:
%   sparisity
%Outputs:
%   threshold_nets:
%Author:ZHANGTAO
%Data:2018.4.10
number_samples = size(nets,3);

threshold_nets = zeros(size(nets));
for ind = 1:number_samples
    threshold_nets(:,:,ind) =  threshold_proportional(nets(:,:,ind),sparsity);
end

end

