function [zero, terminal, negative] = eventy(~,x)

    global MF;
    
    zero = [x(5) - MF; sign(x(2))+1];
    terminal = [1; 1];
    negative = [0; 0];
    
end