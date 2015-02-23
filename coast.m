

function dZ = coast(~,Z)
    
    global PLANET ATMOSPHERE
    global STAGE STAGE_PTR
        T  = cat(1,STAGE(STAGE_PTR).E.T);
        II = cat(1,STAGE(STAGE_PTR).E.II);
        IF = cat(1,STAGE(STAGE_PTR).E.IF);
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
    
    pang = atan2(y,x)-pi/2;
    vr = [vx-cos(pang)*RS, vy-sin(pang)*RS];
    
    d = norm(p);
    h = d-R;
    
    ap = exp(-h/H);
    
    grav = -S/d^3*p;
    drag = -D*ap*norm(vr)*vr;
    
    drag_ang = atan2(drag(2),drag(1));
    
    throttle = m*norm(drag)/sum(T); % throttle thrust to counteract drag exactly
    thrust = throttle*sum(T)/m*[cos(drag_ang+180), sin(drag_ang+180)];

    a = grav+drag+thrust;
    dm = sum(throttle*T./(((IF-II)*ap-IF)*G));

    ax = a(1);
    ay = a(2);
    
    dZ = [vx; vy; ax; ay; dm];

end