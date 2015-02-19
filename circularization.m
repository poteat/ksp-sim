
% Simply burn in the direction of current velocity
function dZ = circularization(~,Z)
    
    global CRAFT PLANET
        T  = CRAFT(1);
        IF = CRAFT(3);
        G  = PLANET(1);
        S  = PLANET(4);

    x = Z(1);
    y = Z(2);
    vx = Z(3);
    vy = Z(4);
    m = Z(5);
    
    p = [x,y];
    
    d = norm(p);
    
    ang = atan2(vy,vx); 

    grav = -S/d^3*p;
    thrust = T/m*[cos(ang), sin(ang)];

    a = grav+thrust;
    dm = -T/(IF*G);

    ax = a(1);
    ay = a(2);
    
    dZ = [vx; vy; ax; ay; dm];

end