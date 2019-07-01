%% BACK PROPAGATION AT HIDDEN CONVOLUTIONAL LAYERS

for l = L2-1 :-1 : 1
    for p = 1 : DD(l+1)
        for a = 1 : WD(l+1)
            for b = 1 : HD(l+1)
                
                    for d = 1 : rh
                        i = (a - 1)*rw + c;
                        j = (b - 1)*rh + d;
                        
                        Gijlp(i, j, l, p) = 0;
                        
                        for s = - int8((WK(l+1) - 1)/2):int8((WK(l+1) - 1)/2)
                            for t = - int8((HK(l+1) - 1)/2):int8((HK(l+1) - 1)/2)
                                for q = 1 : DD(l+2)
                                    if ((a-s>0) && (b-t>0) && (a-s <=WD(l+2)) && (b-t <= HD(l+2)))
                                        
                                        % skiping negative indexes
                                        s2 = s + int8((WK(l)-1)/2) + 1;
                                        t2 = t + int8((HK(l)-1)/2) + 1;
                                        
                                        Gijlp(i, j, l, p) = Gijlp(i, j, l, p) + Gijlp(a-s, b-t, l+1, q)*Wmnklp(s2, t2, p, l+1, q);
                                    else
                                        Gijlp(i, j, l, p) = Gijlp(i, j, l, p);
                                    end
                                end
                            end
                        end
                        
                        
                        Gijlp(i, j, l, p) = Gijlp(i, j, l, p) * sigmoid(Vijlp(i, j, l, p)) * (1 - sigmoid(Vijlp(i, j, l, p))) / (rw*rh);
                        
                    
                end
            end
        end 
        
        
       
        for m = - int8((WK(l) - 1)/2):int8((WK(l) - 1)/2)
            for n = - int8((HK(l) - 1)/2):int8((HK(l) - 1)/2)
                for o = 1 : DD(l)
                    delta = 0;
                    delta2 = 0;
                    
                    for i = 1 : WD(l)
                        for j = 1 : HD(l)
                            if ((i+m > 0) && (j+n > 0) && (i+m <= WD(l)) && (j+n <= HD(l)))
                                if (l == 1)
                                    delta = delta + Gijlp(i, j, l, p) * Y0(i+m, j+n, o);
                                else
                                    delta = delta + Gijlp(i, j, l, p) * Yablp(i+m, j+n, l-1, o);
                                end
                                delta2 = delta2 + Gijlp(i, j, l, p);
                            else
                                delta = delta;
                                delta2 = delta2;
                            end
                        end
                    end
                    
                    % skiping negative indexes
                    m2 = m + int8((WK(l)-1)/2) + 1;
                    n2 = n + int8((HK(l)-1)/2) + 1;
                    Wmnklp(m2, n2, o, l, p) = Wmnklp(m2, n2, o, l, p) - lr * delta;
                    blp(l, p) = blp(l, p) - lr * delta2;
                end
            end
        end
        
        
        
    end
end