function [ nets,labels ] = load_HE_data()
%LOAD_HE_DATA Summary of this function goes here
%   Detailed explanation goes here
path = '/home/lrh/program/git/brain_toolbox/data/DataHE.mat';
load(path);
nets = DataHE;
labels = TgtHE;

end

