% Given a state vector Z(x,y,vx,vy,m) calculate dZ/dT...(vx,vy,ax,ay,dm)

function dx = p_step(~, Z)

    global T II IF;
    global TH;

    % Environmental constants
    S = 3.5316E12;
    RAD = 6E5;
    ROT = 174.53;
    D = 9.784758844E-4;
    ATM = 69077.553;
    H = 5E3;
    G = 9.82;
    
    % State vectors (position, velocity, mass)
    x = Z(1);
    y = Z(2);
    p = [Z(1),Z(2)];
    v = [Z(3),Z(4)];
    m = Z(5);
    
    % Non-atmospheric flight prediction
    h = norm(p)-RAD;
    energy = norm(v)^2-S/norm(p);
    angmom = dot(v,p);
    eccen = sqrt(1+energy*angmom^2)/S;
    semimajor = 1/(1/norm(p)-norm(v)^2/S);
    
    apoapsis = semimajor*(1+norm(eccen));
    fprintf('height:\t%.2f\n',h);
    fprintf('apoapsis:\t%.2f\n',energy);

    % Gravity turn parameters
    turnStart = 10E3;
    turnEnd = 45E3;
    turnShape = .33;
    endAngle = 0;
    orbitalRadTarget = 68E3;

    % Autopilot control logic (controls angle and throttle)
    angleOffset = atan2d(y,x)-90;
    if (h >= turnStart)
        if (h <= turnEnd)
            TH = (90-((h-turnStart)/(turnEnd-turnStart))^turnShape)*(90-endAngle)-8010;
            throttle = 1;
        else  
            TH = 0;
            throttle = 0;
        end
    else
        TH = 90;
        throttle = 1;
    end

    TH = TH + angleOffset;

    
    % Physical accelerations and mass change
    atm = exp(-h/H);
    
    grav = -S/norm(p)^3*p;
    if(h<=ATM)
        drag = -D*atm*norm(v-ROT)*(v-ROT);
    else
        drag = 0;
    end
    thrust = throttle*T/m*[cosd(TH), sind(TH)];
    
    a = thrust + grav + drag;
    ax = a(1);
    ay = a(2);
    
    dm = throttle*T/(((IF-II)*atm-IF)*G);

    vx = v(1);
    vy = v(2);
    
    dx = [vx; vy; ax; ay; dm];
    
end