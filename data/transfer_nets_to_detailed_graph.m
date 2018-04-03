function [ graphs ] = transfer_nets_to_detailed_graph( nets )
%TRANSFER_NETS_TO_DETAILED_GRAPH Summary of this function goes here
%Arguments:
%   nets  : the adjacency matrix of the brain graph with shape [num_nodes,num_nodes,num_sample]
%Output   :
%   graph :struct data a 1xN array of graphs
% 		  Graphs(i).am is the weighted adjacency matrix of the i'th graph, 
% 		  Graphs(i).al is the adjacency list of the i'th graph, 
%         Graphs(i).nl.values is a column vector of node labels for the i'th graph.
%         Graphs(i) may have other fields, but they will not be
%                 used here.
%Example:
%       %compute Weisfeiler-Lehman kernel for a set of graphs
%       graph = transfer_nets_detailed_graph(nets);
%       h = 5;
%       [K,~] = WL(graph,h,true);
%
%Author:Zhang Tao
%Data  :2018.3.31


num_samples = size(nets,3);
num_nodes = size(nets,1);
for ind = 1:num_samples
    %transfer weighted matrix to adjacency matrix. 
    graphs(ind).am= (nets(:,:,ind)>=0.5);
    %compute the adjacency list of node j
    for j = 1:num_nodes
        %find indexes whose element equals 1 which represents edge
        graphs(ind).al{j,1} = find(graphs(ind).am(j,:)==1);
    end
    %construct node labels
    graphs(ind).nl.values = [1:num_nodes]';
end

end

