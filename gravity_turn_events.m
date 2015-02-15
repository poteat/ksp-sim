
% 1: turnInitial height reached
% 2: Out of fuel
% 3: Surface collision
% 4: Exit atmosphere
% 5: Dropped below turnFinal
% 6: Projected apoapsis reached (TODO)

function [value, isterminal, direction] = gravity_turn_events(~,Z)
    
    global CRAFT PLANET ATMOSPHERE TARGET
        MF = CRAFT(5);
        R  = PLANET(2);
        S  = PLANET(4);
        AH = ATMOSPHERE(2);
        TI = TARGET(1);
        TF = TARGET(2);
        OT = TARGET(5);
    
    h = hypot(Z(1),Z(2))-R;
    m = Z(5);
    
    x =  Z(1);
    y =  Z(2);
    p = [x,y];
    vx = Z(3);
    vy = Z(4);
    v = [vx,vy];
    d = hypot(x,y);
    s = hypot(vx,vy);
    
    a = 1/(2/d-s^2/S);
    apoapsis = a*(1+sqrt(1-(x*vy-y*vx)^2/(a*S))) - R;    
    
    value = [h-TF; m-MF; h; h-AH; h-TI; apoapsis-OT];
    isterminal = [1; 1; 1; 1; 1; 1];
    direction = [1; -1; -1; 1; -1; 1];
    
end