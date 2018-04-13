function [features] = feature_graph_kernel(nets,h)
%%
%FEATURE_GRAPH_KERNEL Summary of this function goes here
%   Extract features by graph kernel 
%Arguments:
%   nets:weight matrix of brain network with shape[num_nodes,num_nodes,num_samples] 
%   h   :a natural number: number of iterations of WL
%
%Output   :
%   features:features of brain network extracted by graph kernel with
%       shape[num_samples,num_features]
%
%
%Example  :
%       feas = feature_graph_kernel(nets,h);
%
%
%Author   : Tao Zhang
%Data     : 2018.03.30
%
%%
%addpath('../../data');
graph = transfer_nets_to_detailed_graph(nets);
%Graphs - a 1xN array of graphs
% 		  Graphs(i).am is the adjacency matrix of the i'th graph, 
% 		  Graphs(i).al is the adjacency list of the i'th graph, 
%                 Graphs(i).nl.values is a column vector of node
%                 labels for the i'th graph.
%                 Graphs(i) may have other fields, but they will not be
%                 used here.

[feas,~] = WL(graph,h,0);
features = feas';

end

