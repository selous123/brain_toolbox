function [IdxChsSubgPos,IdxChsSubgNeg]=choose_discriminate_subgraph(RatioPos,...
    RatioNeg,NumChsSubg)
%CHOOSE_DISCRIMINATE_SUBGRAPH Summary of this function goes here
%   Choose subgraphs of NumChsSubg-highest ratio score and reture the
%   index.
%Arguments:
%   RatioPos:score of subgraph in positive dataset.
%   RatioNeg:score of subgraph in negative dataset.
%   NumChsSubg:NumChsSubg(1) represent number of chosen subgraph in positive dataset,
%               NumChsSubg(2) represent number of chosen subgraph in negative dataset,
%Outputs  :
%   IdxChsSubgPos:indexes of chosen subgraph in positive dataset
%   IdxChsSubgNeg:indexes of chosen subgraph in negative dataset
%
%Examples :
%Author   :ZHANGTAO
%Data:2018.4.10
% 
%%
NumChsSubgPos=NumChsSubg(1);
NumChsSubgNeg=NumChsSubg(2);
%% Choose the subgraph obtained from positive samples whose 
%  ratio value are top 'NumChsSubg'.
[~,idx]=sort(RatioPos,'descend');
IdxChsSubgPos=idx(1:NumChsSubgPos);
%% Choose the subgraph obtained from negative samples whose 
%  ratio value are top 'NumChsSubg'.
[~,idx]=sort(RatioNeg,'descend');
IdxChsSubgNeg=idx(1:NumChsSubgNeg);
end