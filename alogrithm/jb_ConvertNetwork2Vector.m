function [subjects]=jb_ConvertNetwork2Vector(conn_mat_mci)
% compute the elements below the diagonal of matrix.
% permeter:
% conn_mat_mci:   3D
%   1 and 2 D: feature
%   3 D: number of networks.
% subjects:  3D;
%   each row is a subject.
X=conn_mat_mci(:,:,:);


num_fea=size(X,1);
num_sam=size(X,3);

subjects=zeros(num_sam,num_fea*(num_fea-1)/2);


%%it does not need a loop
% but a vector operation
for i=1:num_sam
    feas=[];
    for j=1:num_fea
        feas=[feas X(j,j+1:num_fea,i)];
    end
    subjects(i,:)=feas;
end
end