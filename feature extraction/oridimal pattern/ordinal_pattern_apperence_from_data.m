function model2 = ordinal_pattern_apperence_from_data(model,net_mat,label)
%name = 'adhd_1';
%load([name,'_frequent_weight_subgraph_1_fold.mat']);
%load('D:\matlab_workspace\data\new_adhd.mat');
[~,~,net_num]=size(net_mat);
model_para_num = 6;

pos_subgraph_cell=model{1};
pos_freq_cell=model{2};
neg_subgraph_cell=model{3};
neg_freq_cell=model{4};
pos_thres=model{5};
neg_thres=model{6};
level=model{7};
%label=model{8};
pos_up_bound=model{9};
pos_down_bound=model{10};
neg_up_bound=model{11};
neg_down_bound=model{12};


 %for ad
 %load('ad_frequent_weight_subgraph_1_fold.mat');
 %load('D:\matlab_workspace\data\Dajinag_data_conn.mat');
 %net_mat=Data(1, 1).Net;
 %label=Data(1,1).target;
 %label = label';
 %net_num = length(label);
 %name = 'ad';

% for mci
% name = 'mci_2';
% load(strcat(name,'_frequent_weight_subgraph_1_fold.mat'));
% load('D:\matlab_workspace\data\Dajinag_data_conn.mat');
% net_mat=Data(1, 2).Net;
% label=Data(1,2).target;
% label = label';
% net_num = length(label);


alpha = 0.1;

pos_subgraph_cell = pos_subgraph_cell{1};
neg_subgraph_cell = neg_subgraph_cell{1};
pos_freq_cell = pos_freq_cell{1};
neg_freq_cell = neg_freq_cell{1};

pos_fea_cell=cell(level,1);
neg_fea_cell=cell(level,1);
pos_score_cell=cell(level,1);
neg_score_cell=cell(level,1);
for li=1:level
    pos_sub_num=length(pos_freq_cell{li});%pos sub graph number
    pos_fea=ones(net_num, pos_sub_num);
    pos_fea=logical(pos_fea);
    fea=ones(net_num,1);
    fea=logical(fea);
    for si=1:pos_sub_num%to judge if the sample has the same subgraph. 
        fea(:)=true;
        for lj=1:li
            tmp = (net_mat(pos_subgraph_cell{li}{si}(lj,1),pos_subgraph_cell{li}{si}(lj,2),:)-net_mat(pos_subgraph_cell{li}{si}(lj+1,1),pos_subgraph_cell{li}{si}(lj+1,2),:));
            fea=fea & reshape( (tmp > pos_down_bound) & (tmp < pos_up_bound) ,net_num,1); 
        end
        pos_fea(:,si)=fea;
    end
    
    neg_sub_num=length(neg_freq_cell{li});
    neg_fea=ones(net_num, neg_sub_num);
    neg_fea=logical(neg_fea);
    for si=1:neg_sub_num
        fea(:)=true;
        for lj=1:li
            tmp = (net_mat(neg_subgraph_cell{li}{si}(lj,1),neg_subgraph_cell{li}{si}(lj,2),:)-net_mat(neg_subgraph_cell{li}{si}(lj+1,1),neg_subgraph_cell{li}{si}(lj+1,2),:));
            fea=fea & reshape((tmp > neg_down_bound) & (tmp < neg_up_bound),net_num,1); 
        end
        neg_fea(:,si)=fea;
    end
    pos_fea_cell{li}=pos_fea;
    neg_fea_cell{li}=neg_fea;
end
model2 = cell(model_para_num,1);
model2{1}=pos_fea_cell;
model2{2}=neg_fea_cell;
model2{3}=pos_subgraph_cell;
model2{4}=neg_subgraph_cell;
model2{5}=level;
model2{6}=label;
%save( 'ad_frequent_ordianl_pattern_appearence_1_fold','pos_fea_cell','neg_fea_cell','pos_subgraph_cell','neg_subgraph_cell','level','label');
end




