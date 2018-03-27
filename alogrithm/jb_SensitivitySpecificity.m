function [Sen,Spe,ACC]=jb_SensitivitySpecificity(prevLabel,trueLabel)
target=trueLabel;
prel=prevLabel;
pospos=find(target==1);
posneg=find(target==-1);
num_pos=length(pospos);
num_neg=length(posneg);
Sen=100*sum(prel(pospos)==1)/num_pos;
Spe=100*sum(prel(posneg)==-1)/num_neg;
ACC=100*sum(prevLabel==trueLabel)/(num_pos+num_neg);