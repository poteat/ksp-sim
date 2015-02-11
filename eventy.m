function [zero, terminal, negative] = eventy(~,x)

    global MF;
    RAD = 6E5;

    % 1: out of fuel
    % 2: surface collision
    zero = [x(5) - MF; hypot(x(1),x(2))-RAD+.0001];
    terminal = [1; 1];
    negative = [0; 0];
    
end