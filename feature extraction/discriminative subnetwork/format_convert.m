function DataGSpan=format_convert(DataNet)
%%
%Arguments:
%   DataNet:M*M*N matrix, DataNet(i,j,k) is the weight value between i-th and
%           j-th nodes of the k-th network.
%           M is the number of nodes and N is the number of networks.
%Outputs  :
%   DataGSpan:G: (1,n) cellarray of n graph structures with this layout
%     g.nodelabels: (n,1) discrete integer labels [L_1 ; L_2 ; ... ; L_n];
%     g.edges: (m,2) edges, [from to] at each line:
%       [e_1_{from} e_1_{to} edgelabel_1 ; ... ; e_m_{from} e_m_{to} edgelabel_m]
%       The node indices go from 1 to n.  (They will be converted to 0-(n-1)
%       internally and converted back.)
%     (From gspan.m)
% Author:uranusleon
% Data: 2015.9.10
% Last Modified:2015.9.11
% Modified:2018.4.10 by ZHANGTAO

%%
NumNets=size(DataNet,3);
NumNodes=size(DataNet,1);
DataGSpan=cell(1,NumNets);
for i=1:NumNets
%     disp(['this is ',num2str(i),'th net']);
    MaxNumEdges=NumNodes*(NumNodes-1)/2;
    edges=zeros(MaxNumEdges,3);
    NumEdges=0;
    for row=1:NumNodes-1
        for col=row+1:NumNodes
            if DataNet(row,col,i)~=0
                NumEdges=NumEdges+1;
                edges(NumEdges,:)=[row,col,1];% Set the node indices as 1.
            end
        end
    end
    if NumEdges~=MaxNumEdges
        edges(NumEdges+1:MaxNumEdges,:)=[];
    end
    DataGSpan{i}=struct('nodelabels',uint32((1:NumNodes)'),'edges',uint32(edges));
end
fprintf('The function FormatConver is finished!\n');
end