function [ features ] = feature_discriminative_subnetwork(nets,labels,parameters)
%FEATURE_DISCRIMINATIVE_SUBNETWORK Summary of this function goes here
%   Detailed explanation goes here
%Arguments:
%       nets  :weight matrix of brain network with shape[num_nodes,num_nodes,num_samples] 
%       labels:labels of samples with shape [num_samples,1] , {1,-1}.
%       parameters:struct datatype
%           min_support_pos:minimum occurance number of frequency subgraph
%               in postive dataset
%           min_support_neg:minimum occurance number of frequency subgraph
%               in negative dataset
%           size_req:the size of subgraph in gspan
%           **(min_support_pos,min_support_neg,size_req) is gspan function parameters**
%           num_positive_subgraph:number of frequency subgraph in positive
%               dataset
%           num_negative_subgraph:number of frequency subgraph in negative
%               dataset
%           type:type of disease.
%Outputs  :
%       features:with shape[num_samples,num_features].
%           At (i,j) the number of counts of the j'th
%           subgraph found in the i'th graph is recorded.
%
%Examples :
%       sparsity_nets = threshold_nets_data(nets,sparsity);
%       features = feature_discriminative_subnetwork(sparsity_nets,labels);
%
%Author:ZHANG TAO
%Data:2018.4.9
%% Set parameters:spar,minsup,size_req
minsupPos=parameters.min_support_pos;%正类里面出现36次则认为是频繁模式，一般需要测试选出90%-95%的边
minsupNeg=parameters.min_support_neg;%负类里面出现37次认为是频繁模式
size_req=parameters.size_req;%边的个数从5-8,5 6 7 8，一般4-8就可以
%type=parameters.type;%疾病类型

%% Execute 'FormatConvert' which converts data format from net to what gSpan need.
%nets=getAllSubnet(sparsity,nets);
%DataGSpan: (1,n) cellarray of n graph structures with this layout
%     g.nodelabels: (n,1) discrete integer labels [L_1 ; L_2 ; ... ; L_n];
%     g.edges: (m,2) edges, [from to] at each line:
%       [e_1_{from} e_1_{to} edgelabel_1 ; ... ; e_m_{from} e_m_{to} edgelabel_m]
%       The node indices go from 1 to n.  (They will be converted to 0-(n-1)
%       internally and converted back.)
DataGSpan=format_convert(nets);
IdxPos=(labels==1);
IdxNeg=(labels==-1);
DataGSpanPos=DataGSpan(IdxPos);
DataGSpanNeg=DataGSpan(IdxNeg);


%% Execute gspan to get Positive subgraphs. 
StaTime=clock;
disp(['The program for Positive data starts in ',num2str(StaTime(4)),...
    ':',num2str(StaTime(5))]);
%
%   subg: (1,p) cellarray of p graph structures that appear frequently in G.
%
%   (optional) count: [1,p] uint32 array giving at element i the number of times
%     subgraphs{i} appears in G (duplicates within one graph only counted once).
%
%   (optional) GY: [n,p] double array giving individual counts for each
%       subgraph/graph pair.  At (i,j) the number of counts of the j'th
%       subgraph found in the i'th graph is recorded.  This takes no
%       additional computation time to record.
[subgPos,countPos,GYPos]=gspan(DataGSpanPos,minsupPos,size_req);
endtime=clock;
disp(['The program starts in ',num2str(endtime(4)),...
    ':',num2str(endtime(5))]);
ExeTime=etime(clock,StaTime);
disp(['Execution time is ',num2str(ExeTime)]);


%% Execute gspan to get negative subgraphs.
StaTime=clock;
disp(['The program for negative data starts in ',num2str(StaTime(4)),...
    ':',num2str(StaTime(5))]);
[subgNeg,countNeg,GYNeg]=gspan(DataGSpanNeg,minsupNeg,size_req);
endtime=clock;
disp(['The program starts in ',num2str(endtime(4)),...
    ':',num2str(endtime(5))]);
ExeTime=etime(clock,StaTime);
disp(['Execution time is ',num2str(ExeTime)]);



%% Calculate the discriminative subnetwork
[RatioPos,GYSubgPos]=calculate_ratio(subgPos,countPos,DataGSpanPos,...
    DataGSpanNeg,GYPos,'pos');
[RatioNeg,GYSubgNeg]=calculate_ratio(subgNeg,countNeg,DataGSpanPos,...
    DataGSpanNeg,GYNeg,'neg');

NumChsSubg=[parameters.num_positive_subgraph,parameters.num_negative_subgraph];


[IdxChsSubgPos,IdxChsSubgNeg]=choose_discriminate_subgraph(RatioPos,...
    RatioNeg,NumChsSubg);

features=[GYSubgPos(:,IdxChsSubgPos),GYSubgNeg(:,IdxChsSubgNeg)];


end

