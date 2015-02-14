
% 1: Atmosphere exited
% 2: Out of fuel
% 3: Surface collision
% 4: Fell into gravity turn zone

function [value, isterminal, direction] = coast_events(~,Z)
    
    global CRAFT PLANET ATMOSPHERE TARGET
        MF = CRAFT(5);
        R  = PLANET(2);
        AH = ATMOSPHERE(2);
        TF = TARGET(2);
    
    h = hypot(Z(1),Z(2))-R;
    m = Z(5);
    
    value = [h-AH; m-MF; h; h-TF];
    isterminal = [1; 1; 1; 1; 1];
    direction = [1; -1; -1; -1];
    
end