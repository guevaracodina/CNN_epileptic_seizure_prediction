

 
 
J = 0; 
 
for sample = 1 : length_validate;
        
        %% INPUT DATA TENSOR
        Y0(:, :, 1) = validate(1:height,  :, sample)';
        Y0(:, :, 1) = validate(height+1:2*height,  :, sample)';
        
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

        
        %% FORWARD PROPAGATION AT THE FULLY-CONNECTED LAYERS
        
        % Generating the outputs at all layers for current sample
        for r = 1:L
            if (r == 1)
                V(1:k(r), r) = W(1:k(r), 1:k0+1, r) * [x; 1];
            else
                V(1:k(r), r) = W(1:k(r), 1:k(r-1)+1, r) * [Y(1:k(r-1),r-1);1];
            end
                Y(1:k(r), r) = sigmoid(V(1:k(r), r));
        end
    
        
        %% OUTPUT ERROR
        E = Y(1:k(L), L) - labelv(:, sample);
        J = J + E' * E;
end

J = 0.5 * J;