

 
 
TP = 0; TN = 0; FP = 0; FN = 0;
 
for sample = 1 : length_test;
        
        %% INPUT DATA TENSOR
        Y0(:, :, 1) = test(1:height, :, sample)';
        Y0(:, :, 1) = test(height+1:2*height, :, sample)';
        
        %% FORWARD PROPAGATION AT THE CONVOLUTIONAL LAYERS
        forwardCNN;
        
      
        %% CONVERTION OF OUTPUT TENSOR FROM CONVOLUTIONAL LAYERS TO INPUT VECTOR OF FULLY-CONNECTED LAYERS
       
        x = [];
        for p = 1:DD(L2+1)
            for a = 1:WD(L2+1)
                for b = 1:HD(L2+1)
                    x = [x; Yablp(a, b, L2, p)];
                end
            end
        end

        
        %% FORWARD PROPAGATION AT THE FULLY-CONNECTED NETWORKK
        
        % Generating the outputs at all layers for current sample
        for r = 1:L
            if (r == 1)
                V(1:k(r), r) = W(1:k(r), 1:k0+1, r) * [x; 1];
            else
                V(1:k(r), r) = W(1:k(r), 1:k(r-1)+1, r) * [Y(1:k(r-1),r-1);1];
            end
                Y(1:k(r), r) = sigmoid(V(1:k(r), r));
        end
    
        
        %% POSITIVE AND NEGATIVES
        
        % output of the network
        labels = Y(1, L);
        
        % target = labelt(sample);
        
        % comparing network output with target
        if (labelt(sample) == 1) % PRE-ICTAL CASE
            if (labels == 1) % NETWORK DETECTS PRE-ICTAL
                TP = TP + 1;
            else
                FN = FN + 1;
            end
        else             % INTER-ICTAL
            if (labels == 1) % NETWORK DETECTS PRE-ICTAL
                FP = FP + 1;
            else
                TN = TN + 1;
            end
        end
 
end


%% COMPUTATION OF PERFORMANCE METRICS
PPV = TP / (TP + FP);
NPV = TN / (TN + FN);
Accuracy = (TP + TN) / (TP + TN + FP + FN);
TPR = TP / (TP + FN);
TNR = TN / (TN + FP);
F1 = (2 * PPV * TPR)/(PPV + TPR);
MCC = (TP*TN-FP*FN)/sqrt((TP + FP)*(TN + FN)*(TN + FP)*(TP + FN));

saveResults = strcat('TP = ',num2str(TP), ' FP = ',num2str(FP), ' TN = ' ,num2str(TN), ' FN = ' ,num2str(FN), ' PPV = ',num2str(PPV) ,' Accuracy = ',num2str(Accuracy), ' Precision = ',num2str(Precision) ,' Recall = ' , num2str(Recall));
dlmwrite ('PPV.txt', saveResults, '-append', 'delimiter','')

