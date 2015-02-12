% Given a state vector Z(x,y,vx,vy,m) calculate dZ/dT...(vx,vy,ax,ay,dm)

function dZ = p_step(t, Z)

    global T II IF;

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
    h = norm(p)-RAD;
    
%    [angle, throttle] = autopilot(Z);
    angle = 0;
    throttle = 0;

    % Physical accelerations and mass change
    atm = exp(-h/H);
    
    grav = -S/norm(p)^3*p;
    if(h<=ATM)
        drag = -D*atm*norm(v-ROT)*(v-ROT);
    else
        drag = 0;
    end
    thrust = throttle*T/m*[cosd(angle), sind(angle)];
    
    a = thrust + grav + drag;
    ax = a(1);
    ay = a(2);
    
    dm = throttle*T/(((IF-II)*atm-IF)*G);

    vx = v(1);
    vy = v(2);
    
    
    dZ = [vx; vy; ax; ay; dm];
    
    dZ
end