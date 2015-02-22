
% 1: Success
% 2: Out of fuel
% 3: Surface collision
% 4: Exit atmosphere

function [value, isterminal, direction] = vertical_ascent_events(~,Z)
    
    global PLANET ATMOSPHERE TARGET
    global STAGE STAGE_PTR
        MF = STAGE(STAGE_PTR).MF;
        R  = PLANET(2);
        AH = ATMOSPHERE(2);
        TI = TARGET(1);
    
    h = hypot(Z(1),Z(2))-R;
    m = Z(5);
    
    value = [h-TI; m-MF; h; h-AH];
    isterminal = [1; 1; 1; 1];
    direction = [1; -1; -1; 1];
    
end