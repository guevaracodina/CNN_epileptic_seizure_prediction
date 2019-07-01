% If there is a question regarding this code, an e-mail can be send to roberto.rosas@udlap.mx

clear;

% IMPORTANT: The following instruction has to be updated befor its execution
% IMPORTANT: The update consists in specifying the path where the code is
% found
cd C:\Users\12280\Desktop\RRR\MATLAB\CNNlineal;

%% GENERATION OF TRAINING SET
Data;
Sampling;
crossvalidation;

%% PARAMETERS OF CONVOLUTIONAL AND FULLY-CONNECTED LAYERS
parametersCNN;

%% ALLOCATING SPACE FOR VARIABLES FOR FULLY-CONNECTED AND CONVOLUTIONAL LAYERS
Allocation;

%%  TRAINING

for epochs = 1:40
    
    epochs
    for sample = 1 : WD0 : length_train - width;
        
        %% INPUT DATA TENSOR
        Y0(:, :, 1) = train(1:height, sample:sample + width - 1)';
        Y0(:, :, 2) = train(height + 1:2 * height, sample:sample + width - 1)';
        
        %% FORWARD PROPAGATION AT CONVOLUTIONAL LAYERS
        forwardCNN;
        
      
        %% CONVERTION OF OUTPUT TENSOR FROM CONVOLUTIONAL LAYERS TO INPUT VECTOR OF FULLY-CONNECTED LAYERS  
        % the output tensor is stretched out as a column vector
        x = [];
        for p = 1:DD(L2+1)
            for a = 1:WD(L2+1)
                for b = 1:HD(L2+1)
                    x = [x; Yablp(a, b, L2, p)];
                end
            end
        end

        
        %% FORWARD PROPAGATION AT FULLY-CONNECTED LAYERS
        
        % Generating the outputs at all layers for current sample
        for r = 1:L
            if (r == 1)
                V(1:k(r), r) = W(1:k(r), 1:k0+1, r) * [x; 1];
            else
                V(1:k(r), r) = W(1:k(r), 1:k(r-1)+1, r) * [Y(1:k(r-1),r-1);1];
            end
                Y(1:k(r), r) = sigmoid(V(1:k(r), r));
        end
    
        %% BACKWARD PROPAGATION AT THE FULLY-CONNECTED LAYERS
        % Generating errors at the output fully-connected layer
        E = Y(1:k(L), L) - targets(:, sample);
    
        % Generating deltas (LOCAL GRADIENTS) at the output fully-connected layer
        D(1:k(L), L) = E .* Y(1:k(L), L) .* (1 - Y(1:k(L), L));
    
        % Generating deltas (LOCAL GRADIENTS) at the hidden fully-connected layers
        for r = L-1:-1:1
            D(1:k(r),r) = Y(1:k(r),r) .* (1 - Y(1:k(r),r));
            D(1:k(r),r) = D(1:k(r),r) .* (W(1:k(r+1),1:k(r),r+1)' * D(1:k(r+1),r+1));
        end
    
        % Computation of adjustment for each neuron at each fully connected-layer layer
        for r = L:-1:1
            if (r == 1)
                DW(1:k(r),1:k0+1,r) = -lr * D(1:k(r),r) * [x; 1]';
                W(1:k(r),1:k0+1,r) = W(1:k(r),1:k0+1,r)+DW(1:k(r),1:k0+1,r);
            else
                DW(1:k(r),1:k(r-1)+1,r) = -lr*D(1:k(r),r)*[Y(1:k(r-1),r-1);1]';
                W(1:k(r),1:k(r-1)+1,r) = W(1:k(r),1:k(r-1)+1,r)+DW(1:k(r),1:k(r-1)+1,r);  
            end
        end
        
        %% BACKWARD PROPAGATION AT THE CONVOLUTIONAL LAYERS
        backwardCNN1;
        backwardCNN2;
        
    end
    
    % Computation of the cost function
    COST;
    J
    if (J < tolerance)
        break;
    end
    
end


%% SAVING CONVOLUTIONAL AND FULLY-CONNECTED LAYER VARIABLES

save('CNNvariables22.mat', 'Vijlp', 'Zijlp', 'Yablp', 'Wmnklp', 'blp', 'L2', 'k2', 'WD', 'HD', 'DD', 'WK', 'HK', 'DK', 'WD0', 'HD0', 'DD0', 'rh', 'rw', 'half_window');
save('ANNvariable22.mat', 'W', 'Y', 'V', 'L', 'k', 'kmax', 'k0');
save('TestingSet22.mat', 'test', 'labelt', 'length_test');



%% TESTING THE MLP
load('CNNvariables22.mat');
load('ANNvariable22.mat');
load('TestingSet22.mat');

TEST;