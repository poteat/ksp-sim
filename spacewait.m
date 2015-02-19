

function dZ = spacewait(~,Z)
    
    global PLANET
        S  = PLANET(4);

    x = Z(1);
    y = Z(2);
    vx = Z(3);
    vy = Z(4);
    
    p = [x,y];
    
    d = norm(p);

    grav = -S/d^3*p;

    a = grav;

    ax = a(1);
    ay = a(2);
    
    dZ = [vx; vy; ax; ay; 0];

end