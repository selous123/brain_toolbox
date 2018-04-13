function [Ratio,GYSubg]=calculate_ratio(subg,count,DataPos,DataNeg,GY,type)
% CALCULATE_RATIO Summary of this function goes here
%   Detailed explanation goes here
%Argument:
%   subg: (1,p) cellarray of p graph structures that appear frequently in G.
%       with the same structure of DataPos constructed by FORMATCONVERT
%       Function to suit for gspan package.

%   count: [1,p] uint32 array giving at element i the number of times
%       subgraphs{i} appears in G (duplicates within one graph only counted once).

%   DataPos:(1,n) cellarray of n Positive Dataset graph structures with this layout
%       g.nodelabels: (n,1) discrete integer labels [L_1 ; L_2 ; ... ; L_n];
%       g.edges: (m,2) edges, [from to] at each line:
%           [e_1_{from} e_1_{to} edgelabel_1 ; ... ; e_m_{from} e_m_{to} edgelabel_m]
%           The node indices go from 1 to n.  (They will be converted to 0-(n-1)
%           internally and converted back.)
%   DataNeg:Negitive Dataset.same with DataPos

%   GY: [n,p] double array giving individual counts for each
%       subgraph/graph pair.  At (i,j) the number of counts of the j'th
%       subgraph found in the i'th graph is recorded.  This takes no
%       additional computation time to record.
%   type:{'pos','neg'}
%Outputs :
%   Ratio :[num_samples,num_features],At (i,j) the ratio of the j'th
%       subgraph found in the i'th graph is recoreded.
%
%       **The ratio of the frequent degree on this class to the frequent
%       degree on another class**
%       $$RatioPos=\frac{\frac{NumSubgPos}{NumPos}} {\frac{NumSubgNeg+\sigma}{NumNeg}}$$
%
%   GYSubg:[num_samples,num_features],At (i,j) the number of counts of the j'th
%       subgraph found in the i'th graph(all graphs,include positive and negative samples)
%       is recorded.              

%Example :
%Author:ZHANGTAO
%Data:2018.4.10
%%
stime=clock;
NumPos=length(DataPos);
NumNeg=length(DataNeg);
sigma=0.2;

t1=clock;
if strcmp(type,'pos')
    % NumSubgPos(i) is the number of times subg{i} appear in 'DataPos'.
    NumSubgPos=count;
    %tmp:calculate the number of count of the subgraph found in the negative
    %data graph
    tmp=exist_num(DataNeg,subg);
    % NumSubgNeg(i) is the number of times subg{i} appear in 'DataNeg'.
    NumSubgNeg=sum(tmp);
    GYSubgPos=[GY;tmp];
    GYSubg=GYSubgPos;
else
    if strcmp(type,'neg')
        tmp=exist_num(DataPos,subg);
        NumSubgPos=sum(tmp);
        NumSubgNeg=count;
        GYSubgNeg=[tmp;GY];
        GYSubg=GYSubgNeg;
    end
end
disp(['to get GYSubg,the time is ',num2str(etime(clock,t1))]);
if strcmp(type,'pos')
    %calculate ratio use the above formual in the comments.
    RatioPos=(double(NumSubgPos)/NumPos)./(((double(NumSubgNeg)+sigma))/NumNeg);
    Ratio=RatioPos;
else
    if strcmp(type,'neg')
        RatioNeg=(double(NumSubgNeg)/NumNeg)./(((double(NumSubgPos)+sigma))/NumPos);
        Ratio=RatioNeg;
    end
end
endtime=clock;
CostTime=etime(endtime,stime);
disp(['the cost time is ',num2str(CostTime)]);
end



%%
function GY=exist_num(DataGph,subg)
% Function EXIST_NUM calculate the number of times subg
% duplicates within one graph only counted once
stime=clock;
NumGph=length(DataGph);
NumSubg=length(subg);
GY=zeros(NumGph,NumSubg);

for i=1:NumGph
    for j=1:NumSubg
        isExist=GraphMatch(DataGph{i},subg{j});
        if isExist==1
            GY(i,j)=1;
        end
    end
end
endtime=clock;
CostTime=etime(endtime,stime);
disp(['The time of ExistNum is ',num2str(CostTime)]);
end

%% 
function isExist=GraphMatch(graph,subgraph)
% Function GraphMatch judges whether the subgraph(one subgraph) exists in the graph.
% =====INPUT=====
% graph & subgraph
% The format of 'graph' is the same as the gspan's format.
% =====OUTPUT=====
% isExist    if isExist=1,the 'subgraph' exist in the graph.
% Copyright @uranusleon 
% Finished:2015.9.14
Edges=graph.edges;
subEdges=subgraph.edges;
NumEdgesSubg=size(subgraph.edges,1);
NumMatch=0;% 'NumMatch' is the number of edges which exist in both graph and subgraph.
subedge=zeros(NumEdgesSubg,3);
subedge(:,1)=subgraph.nodelabels(subEdges(:,1));
subedge(:,2)=subgraph.nodelabels(subEdges(:,2));
subedge(:,3)=subEdges(:,3);
for i=1:NumEdgesSubg
    if subedge(i,1)>subedge(i,2)
        tmp=subedge(i,1);
        subedge(i,1)=subedge(i,2);
        subedge(i,2)=tmp;
    end
    EdgeExist=EdgeMatch(Edges,subedge(i,:));
    if EdgeExist~=0
        NumMatch=NumMatch+1;
    end   
end
if NumMatch==NumEdgesSubg
    isExist=1;
else
    isExist=0;
end
end

%%
function EdgeExist=EdgeMatch(Edges,edge)
FromNode=edge(1);
ToNode=edge(2);
ToNodeSet=Edges(Edges(:,1)==FromNode,2);
if sum(ToNodeSet==ToNode)~=0
    EdgeExist=1;
else
    EdgeExist=0;
end
end