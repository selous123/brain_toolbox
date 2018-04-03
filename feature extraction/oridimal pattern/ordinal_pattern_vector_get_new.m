function [ vector_net,label ] = ordinal_pattern_vector_get_new( model3,net_mat,label )
model = cell(length(model3)-2,1);
for model_num=1:(length(model3)-2)
    model{model_num} = model3{model_num};
end
model2 = ordinal_pattern_apperence_from_data(model,net_mat,label);
pos_fea_cell=model2{1};
neg_fea_cell=model2{2};
pos_subgraph_cell=model2{3};
neg_subgraph_cell=model2{4};
level=model2{5};
label=model2{6};
label(label == 0) = -1;
net_num = length(label);
theta=0.1; % to prevent ratio score  is zero so division can not do

score_type = 1; % to select what kind of score-value to calculate
%% 分类
    select_fea_num=10;
     li=level;
            % calculate the score of every feature,and select the best k features 
            select_fea = zeros(net_num, 2 * select_fea_num);

            % we have many frequent pattern with different level so mearge all kind of fp to one list.
            pos_fea = pos_fea_cell{1};
            for lj = 2 : li
                pos_fea = [pos_fea, pos_fea_cell{lj}];
            end
            pos_fea_num = size(pos_fea, 2);
            neg_fea = neg_fea_cell{1};
            for lj = 2 : li
                neg_fea = [neg_fea, neg_fea_cell{lj}];
            end
            
            idx = model3{length(model3)-1};
            idx2 = model3{length(model3)};
            select_fea(:, 1 : select_fea_num ) = pos_fea(:, idx(1 : select_fea_num ));
            select_fea(:, select_fea_num + 1 : 2 * select_fea_num) = neg_fea(:, idx2(1 : select_fea_num));
            vector_net = select_fea;
end



