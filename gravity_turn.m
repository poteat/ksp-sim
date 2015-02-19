

function dZ = gravity_turn(~,Z)
    
    global CRAFT PLANET ATMOSPHERE TARGET
        T  = CRAFT(1);
        II = CRAFT(2);
        IF = CRAFT(3);
        G  = PLANET(1);
        R  = PLANET(2);
        RS = PLANET(3);
        S  = PLANET(4);
        D  = ATMOSPHERE(1);
        H  = ATMOSPHERE(3);
        TI = TARGET(1);
        TF = TARGET(2);
        TS = TARGET(3);
        AF = TARGET(4);

    x = Z(1);
    y = Z(2);
    vx = Z(3);
    vy = Z(4);
    m = Z(5);
    
    p = [x,y];
    v = [vx,vy];
    
    pang = atan2(y,x)-pi/2;
    vr = [vx-cos(pang)*RS, vy-sin(pang)*RS];
    
    d = norm(p);
    h = d-R;
    
    ap = exp(-h/H);
    
    ang = real(pi/2-((h-TI)/(TF-TI))^TS)*(pi/2-AF)-pi^2/4+atan2(y,x);

    grav = -S/d^3*p;
    drag = -D*ap*norm(vr)*vr;
    thrust = T/m*[cos(ang), sin(ang)];

    a = grav+drag+thrust;
    dm = T/(((IF-II)*ap-IF)*G);

    ax = a(1);
    ay = a(2);
    
    dZ = [vx; vy; ax; ay; dm];
    
end