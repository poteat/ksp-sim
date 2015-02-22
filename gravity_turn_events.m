
% 1: turnFinal height reached
% 2: Out of fuel
% 3: Surface collision
% 4: Exit atmosphere
% 5: Dropped below turnInitial
% 6: Projected apoapsis reached

function [value, isterminal, direction] = gravity_turn_events(~,Z)
    
    global PLANET ATMOSPHERE TARGET
    global STAGE STAGE_PTR
        MF = STAGE(STAGE_PTR).MF;
        R  = PLANET(2);
        S  = PLANET(4);
        AH = ATMOSPHERE(2);
        TI = TARGET(1);
        TF = TARGET(2);
        OT = TARGET(5);
    
    x =  Z(1);
    y =  Z(2);
    vx = Z(3);
    vy = Z(4);
    m =  Z(5);
    
    p = [x,y,0];
    v = [vx,vy,0];
    d = norm(p);
    s = norm(v);
    h = d-R;
    
    eng = s^2/2-S/d;
    angm = cross(p,v);
    e = norm(cross(v,angm)/S-p/d);
    a = -S/(2*eng);
    
    apoapsis = a*(1+e)-R;
    
    value = [h-TF; m-MF; h; h-AH; h-TI; apoapsis-OT];
    isterminal = [1; 1; 1; 1; 1; 1];
    direction = [1; -1; -1; 1; -1; 0];
    
end