function [ Sen,Spe,ACC] = ConnectionClassification(filenameA,filenameB,p)
%CONNECTION Summary of this function goes here
%   Detailed explanation goes here
load(filenameA)
load(filenameB)
%%
%with shape->[height,width,sample]
%shape[145,90,67]
Nor=AAL_TC_COBRE_Nor;
%shape[145,90,53]
Par=AAL_TC_COBRE_Pat;
%project label vector->with shape(size,1)
Label(1:size(Nor,3),1)=1;
Label(size(Nor,3)+1:size(Par,3)+size(Nor,3))=0;

%for each sample do while
%feature extraction
for i=1:size(Nor,3)
    X1=Nor(:,:,i);
    N1=corrcoef(X1);
    SN1=threshold_proportional(N1, p);
    Net(:,:,i)=SN1;   
end
for i=1:size(Par,3)
    X2=Par(:,:,i);
    N2=corrcoef(X2);
    SN2=threshold_proportional(N2, p);
    Net(:,:,i+size(Nor,3))=SN2;  
end
[Fea]=jb_ConvertNetwork2Vector(Net);


size(Fea);
size(Label);
for i=1:size(Fea,1)
    Test_fea=Fea(i,:);Test_label=Label(i,:);
    Train_fea=Fea;Train_label=Label;
    Train_fea(i,:)=[];Train_label(i,:)=[];
    pare=['-b 1','-t 0','-c 2'];
    model=svmtrain(Train_label,Train_fea,pare);
    [Y_new, accuracy, score] = svmpredict(Test_label,Test_fea, model,'-b 1');
    Y_all(i,1)=score(1);
end
%ACC=1-(size(find(Y_all~=Label),1)/39);
%[Sen,Spe,ACC]=jb_SensitivitySpecificity(Y_all,Label)
Label
Y_all
auc = plot_roc(Y_all,Label)

end


