function dx = p_step(~, Z)

    global T II IF;
    global TH;

    % Environmental constants
    S = 3.5316E12;
    RAD = 6E5;
    ROT = 174.53;
    D = 9.784758844E-4;
    H = 5E3;
    G = 9.82;
    
    % State vectors (position, velocity, mass)
    x = Z(1);
    y = Z(2);
    p = [Z(1),Z(2)];
    v = [Z(3),Z(4)];
    m = Z(5);
    
    h = norm(p)-RAD;
    
    % Gravity turn parameters
    turnStart = 10000;
    turnEnd = 45000;
    turnShape = .33;
    endAngle = 0;
    orbitalRadTarget = 65;

    angleOffset = atan2d(y,x)-90;
    if (h >= turnStart)
        if (h <= turnEnd)
            TH = (90-((h-turnStart)/(turnEnd-turnStart))^turnShape)*(90-endAngle)-8010;
        else  
            TH = 0;
        end
    else
        TH = 90;
    end

    TH = TH + angleOffset;

    
    atm = exp(-h/H);
    
    grav = -S/norm(p)^3*p;
    drag = -D*atm*norm(v-ROT)*(v-ROT);
    thrust = T/m*[cosd(TH), sind(TH)];
    
    a = thrust + grav + drag;
    ax = a(1);
    ay = a(2);
    
    dm = T/(((IF-II)*atm-IF)*G);

    vx = v(1);
    vy = v(2);
    
    dx = [vx; vy; ax; ay; dm];
    
end