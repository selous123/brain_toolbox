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

feas=[];
for j=1:num_fea-1
    feas_tmp = permute(X(j,j+1:num_fea,:),[3,2,1]);
    feas=[feas feas_tmp];
end
subjects=feas;
end
