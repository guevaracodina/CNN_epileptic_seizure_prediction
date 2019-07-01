        %% FORWARD PROPAGATION AT CONVOLUTIONAL LAYERS
        
for l = 1 : L2
    for p = 1 : DD(l+1)
        for i = 1 : WD(l)
            for j = 1 : HD(l)
                        
                        
                        % Convolution
                        Vijlp(i, j, l, p) = 0;
                        
                        
                            if (l > 1)
                                for m = -int8((WK(l)-1)/2) : int8((WK(l)-1)/2)
                                    for n = -int8((HK(l)-1)/2) : int8((HK(l)-1)/2)
                                        for o = 1 : DD(l)
                                            
                                            % skiping negative indexes
                                            m2 = m + int8((WK(l)-1)/2) + 1;
                                            n2 = n + int8((HK(l)-1)/2) + 1;
                                            
                                            if ((i+m > 0) && (j+n > 0) && (i+m <= WD(l)) && (j+n <= HD(l)))
                                                Vijlp(i, j, l, p) = Vijlp(i, j, l, p) + Yablp(i+m, j+n, l-1, o)*Wmnklp(m2, n2, o, l, p);
                                            else
                                                Vijlp(i, j, l, p) = Vijlp(i, j, l, p);
                                            end
                                        end
                                    end
                                end
                            end
                            
                            if (l == 1)
                                for m = -int8((WK(l)-1)/2) : int8((WK(l)-1)/2)
                                    for n = -int8((HK(l)-1)/2) : int8((HK(l)-1)/2)
                                        for o = 1 : DD(l)
                                            
                                            % skiping negative indexes
                                            m2 = m + int8((WK(l)-1)/2) + 1;
                                            n2 = n + int8((HK(l)-1)/2) + 1;
                                            
                                            if ((i+m > 0) && (j+n > 0) && (i+m <= WD(l)) && (j+n <= HD(l)))
                                                Vijlp(i, j, l, p) = Vijlp(i, j, l, p) + Y0(i+m, j+n, o)*Wmnklp(m2, n2, o, l, p);
                                            else
                                                Vijlp(i, j, l, p) = Vijlp(i, j, l, p);
                                            end
                                            
                                        end
                                    end
                                end
                            end
                            % activation function
                            Vijlp(i, j, l, p) = Vijlp(i, j, l, p) + blp(l, p);
                            Zijlp(i, j, l, p) = sigmoid(Vijlp(i, j, l, p));
            end
        end
                    
                    % pooling
                    for a = 1 : WD(l+1)
                        for b = 1 : HD(l+1)
                            
                            Yablp(a, b, l, p) = 0;
                            c = 1;
                            for d = 1 : rh
                                    Yablp(a, b, l, p) = Yablp(a, b, l, p) + (1/rh)* Zijlp((a-1)*rw+c, (b-1)*rh+d, l, p);
                            end
                           
                            Yablp(a, b, l, p) = Yablp(a, b, l, p) / rh;
                            
                        end
                    end
    end
end
            