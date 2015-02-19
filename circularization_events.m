
% 1: Orbit circularized
% 2: Out of fuel
% 3: Atmosphere entered
% 4: Surface collision

function [value, isterminal, direction] = circularization_events(~,Z)
    
    global CRAFT PLANET ATMOSPHERE
        MF = CRAFT(5);
        R  = PLANET(2);
        S  = PLANET(4);
        AH = ATMOSPHERE(2);
    
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
    
    specific_orbital_energy = (s^2)/2 - S/d;
    angular_momentum = cross(p,v);
    
    semi_major_axis = -S/(2*specific_orbital_energy);
    eccentricity = norm(cross(v,angular_momentum)/S - p/d);
    
    plus_minus = eccentricity*semi_major_axis;
    
    peri = semi_major_axis - plus_minus;
    apo = semi_major_axis + plus_minus;
    
    value = [apo-peri; m-MF; h-AH; h-R];
    isterminal = [1; 1; 1; 1; 1];
    direction = [1; -1; -1; -1];
    
end