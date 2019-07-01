%% BACKWARD PROPAGATION AT THE LAST CONVOLUTIONAL LAYER
        
        for p = 1 : DD(L2 + 1)
            for a = 1 : WD(L2 + 1)
                for b = 1 : HD(L2 + 1)
                    
                        for d = 1 : rh
                            g = (p - 1)*WD(L2 + 1)*HD(L2 + 1) + (a - 1) * WD(L2 + 1) + b;
                            i = (a - 1) * rw + c;
                            j = (b - 1) * rh + d;
                            Gijlp(i, j, L2, p) = 0;
                            for h = 1:k(1)
                                Gijlp(i, j, L2, p) = Gijlp(i, j, L2, p) + D(h, 1) * W(h, g, 1);
                            end
                            Gijlp(i, j, L2, p) = Gijlp(i, j, L2, p)*sigmoid(Vijlp(i, j, L2, p))*(1-sigmoid(Vijlp(i, j, L2, p)));
                            Gijlp(i, j, L2, p) = Gijlp(i, j, L2, p)/rh;
                        end
                    
                end
            end
            
            for m = -int8((WK(L2) - 1)/2) : int8((WK(L2) - 1)/2)
                for n = -int8((HK(L2) - 1)/2) : int8((HK(L2) - 1)/2)
                    for o = 1 : DD(L2)
                        
                        delta = 0;
                        delta2 = 0;
                        for i = 1 : WD(L2)
                            for j = 1 : HD(L2)
                                
                                % checking indexes are not negative
                                if ((i+m > 0) && (j + n > 0) && (i+m <= WD(l)) && (j+n <= HD(l)))
                                    delta = delta + Gijlp(i, j, L2, p) * Yablp(i+m, j+n, L2-1, o);
                                    delta2 = delta2 + Gijlp(i, j, L2, p);
                                else
                                    delta = delta;
                                    delta2 = delta2;
                                end
                            end
                        end
                        
                        % skiping negative indexes
                        m2 = m + int8((WK(l)-1)/2) + 1;
                        n2 = n + int8((HK(l)-1)/2) + 1;
                        Wmnklp(m2, n2, o, L2, p) = Wmnklp(m2, n2, o, L2, p) - lr * delta;
                        blp(L2, p) = blp(L2, p) - lr * delta2;
                    end
                end
            end
            
        end