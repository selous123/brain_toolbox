function [ vector_net,label,model ] = ordinal_pattern_vector_get_train( net_mat,label )
model3 = frequent_weight_subgraph_mining_from_data(net_mat,label);
model2 = ordinal_pattern_apperence_from_data(model3,net_mat,label);
pos_fea_cell=model2{1};
neg_fea_cell=model2{2};
%pos_subgraph_cell=model2{3};
%neg_subgraph_cell=model2{4};
level=model2{5};
label=model2{6};
label(label == 0) = -1;
net_num = length(label);
theta=0.1; % to prevent ratio score  is zero

score_type = 1; % to select what kind of score-value to calculate

%%
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
            neg_fea_num = size(neg_fea, 2);            

            pos_fea_score = zeros(pos_fea_num, 1);
            n_pos = sum(label == 1);
            n_neg = sum(label == -1);
            %count the occurrence number of every feature.
            for pi = 1 : pos_fea_num
                ng_pos = sum(pos_fea((label == 1), pi) == 1);
                ng_neg = sum(pos_fea((label == -1), pi) == 1);
                switch score_type
                    case 1  % ratio-score
                        pos_fea_score(pi) = log((ng_pos/n_pos) / ((ng_neg + theta)/n_neg));
                        continue;
                    case 2  % g_test
                        pos_fea_score(pi) = 2 * ng_pos * log((ng_pos/n_pos) / ((ng_neg + theta)/n_neg)) + 2 * (n_pos - ng_pos) * log((n_neg * (n_pos - ng_pos) + theta)/(n_pos * (n_neg - ng_neg) + theta));
                       if isnan(pos_fea_score(pi))
                          pause; 
                       end
                        continue;
                    case 3  % HSIC(linear)
                        pos_fea_score(pi) = ((ng_pos * n_neg - ng_neg * n_pos)^2)/((n_pos + n_neg - 1)^2 * (n_pos + n_neg)^2);
                end
            end
            [sorted, idx] = sort(pos_fea_score, 'descend');
            select_fea(:, 1 : select_fea_num ) = pos_fea(:, idx(1 : select_fea_num ));

            neg_fea_score = zeros(neg_fea_num, 1);
            n_pos = sum(label == -1);
            n_neg = sum(label == 1);
            for pi = 1 : neg_fea_num                
                ng_pos = sum(neg_fea((label == -1), pi) == 1);
                ng_neg = sum(neg_fea((label == 1), pi) == 1);
                switch score_type
                    case 1  % ratio-score
                        neg_fea_score(pi) = log((ng_pos/n_pos) / ((ng_neg + theta)/n_neg));
                        continue;
                    case 2  % g_test
                        neg_fea_score(pi) = 2 * ng_pos * log((ng_pos/n_pos) / ((ng_neg + theta)/n_neg)) + 2 * (n_pos - ng_pos) * log((n_neg * (n_pos - ng_pos) + theta)/(n_pos * (n_neg - ng_neg) + theta));
                        continue;
                    case 3  % HSIC(linear)
                        neg_fea_score(pi) = ((ng_pos * n_neg - ng_neg * n_pos)^2)/((n_pos + n_neg - 1)^2 * (n_pos + n_neg)^2);
                end
            end
            [~, idx2] = sort(neg_fea_score, 'descend');
            select_fea(:, select_fea_num + 1 : 2 * select_fea_num) = neg_fea(:, idx2(1 : select_fea_num));
            vector_net = select_fea;
            model = cell(length(model3)+2,1);
            for model_num=1:length(model3)
                model{model_num} = model3{model_num};
            end
            model{length(model3)+1} = idx;
            model{length(model3)+2} = idx2;
            
end

