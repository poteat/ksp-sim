

function dZ = coast(~,Z)
    
    global CRAFT PLANET ATMOSPHERE
        T  = CRAFT(1);
        II = CRAFT(2);
        IF = CRAFT(3);
        G  = PLANET(1);
        R  = PLANET(2);
        RS = PLANET(3);
        S  = PLANET(4);
        D  = ATMOSPHERE(1);
        H  = ATMOSPHERE(3);

    x = Z(1);
    y = Z(2);
    vx = Z(3);
    vy = Z(4);
    m = Z(5);
    
    p = [x,y];
    v = [vx,vy];
    
    pang = atan2d(y,x)-90;
    vr = [vx-cosd(pang)*RS, vy-sind(pang)*RS];
    
    d = norm(p);
    h = d-R;
    
    ap = exp(-h/H);

    grav = -S/d^3*p;
    drag = -D*ap*norm(vr)*vr;
    
    drag_ang = atan2d(drag(2),drag(1));
    
    throttle = m*norm(drag)/T; % throttle thrust to counteract drag exactly
    thrust = throttle*T/m*[cosd(drag_ang+180), sind(drag_ang+180)];

    a = grav+drag+thrust;
    dm = throttle*T/(((IF-II)*ap-IF)*G);

    ax = a(1);
    ay = a(2);
    
    dZ = [vx; vy; ax; ay; dm];

end