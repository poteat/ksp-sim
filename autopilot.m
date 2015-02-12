% This function takes in the state of the rocket and decides what action to
% perform based on target parameters.

function [angle, throttle] = autopilot(Z)

    global mode;

    % Orbital ascent parameters (MJ)
    turnStart = 15E3;
    turnEnd = 45E3;
    turnShape = .3;
    endAngle = 0;
    orbitalRadTarget = 75E3;
    
    % Environmental constants
    S = 3.5316E12;
    R = 6E5;

    % State vector components
    x = Z(1);
    y = Z(2);
    vx = Z(3);
    vy = Z(4);
    m = Z(5);
    p = [x,y];
    v = [vx,vy];
    d = norm(p); % Orbital distance
    h = d-R; % Height from surface
    s = norm(v); % Speed
    hv = dot(v,-p); % Height velocity (orthogonal)

    switch mode
        
        case 1 % Vertical ascent
            angle = 90;
            throttle = 1;
            if(h>=turnStart)
                mode = 2;
            end
        case 2 % Gravity turn
            angle = (90-((h-turnStart)/(turnEnd-turnStart))^turnShape)*(90-endAngle)-8010;
            throttle = 1;
            
            energy = norm(v)^2/2-S/norm(p);
            angmom = dot(p,v);
            eccen = sqrt(1+(2*energy*angmom^2)/S^2);
            semimajor = 1/(2/norm(p)-norm(v)^2/S);
            apoapsis = semimajor*(1+norm(eccen)) - R;

            if(h>=turnEnd)
                mode = 2;
            end
        case 3 % Sleep until apoapsis
            angle = 0;
            throttle = 0;
            if(hv<0)
                mode = 4;
            end
        case 4 % Circularization burn
            angle = 0;
            throttle = 0;
    end
    
    % makes angle relative to surface, not coordinate system
    angleOffset = atan2d(y,x)-90; 
    angle = angle + angleOffset;
    
end