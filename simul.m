   
    global T II IF ME MF;
    global mode;
    mode = 1;

    type = 8;

    T = engine_thrusts(type);
    II = engine_atm_isps(type);
    IF = engine_vac_isps(type);
    ME = engine_masses(type);
    
    G = 9.82;
    TWR = 1.5;
    RAD = 6E5;
    ROT = 174.53;
    S = 3.5316E12;
    
    MI = T/(G*TWR);
    MF = (MI+8*ME)/9;
    
    
    opt = odeset('Events',@eventy);
    init = [0, RAD, ROT, 0, MI];

    [t,TWR,et,ey,ei] = ode45(@p_step, [0 1000], init, opt);

    x = TWR(:,1);
    y = TWR(:,2);
    height = hypot(x, y) - RAD;
    vx = TWR(:,3);
    vy = TWR(:,4);


    % Ascent trajectory in scale with Kerbin
    figure(1);
    hold on;
    plot(x, y);
        rectangle('Position',[ - RAD, - RAD, RAD*2, RAD*2],...
                  'Curvature',[1,1]);
        axis([-7e5, 7e5, -7e5, 7e5]);
        axis square;
    title('Ascent trajectory relative to Kerbin');

    % Height across time
    figure(2)
    plot(t,height);
    title('Height from the surface over time');

    figure(3);
    v = hypot(vx,vy);
    p = hypot(x,y);

    energy = v.^2/2 - S./p;
    angmom = dot(p, v, 2);
    eccen = sqrt(1+(2*energy.*angmom.^2)./S^2);
    semimajor = 1./(2./p-v.^2./S);
    apoapsis = semimajor.*(1+eccen);
    
    plot(t,apoapsis-RAD);
    title('Projected apoapsis over time');

    turnStart = 20E3;
    turnEnd = 55E3;
    turnShape = .4;
    endAngle = 0;
    orbitalRadTarget = 75E3;
    figure(4);
    plot(t,(90-((height-turnStart)./(turnEnd-turnStart)).^turnShape).*(90-endAngle)-8010);
    
    
    if (numel(ei)~=0)
        switch ei(1)
            case 1
                max_dv = ey(3);
            case 2
                max_dv = -1;
        end
    else
        fprintf('Flight timed out\n');
        max_dv = 0;
    end
    fprintf('max height:\t%.2f\n',max(height));
    fprintf('y velocity:\t%.2f\n',ey(4));
    fprintf('total velocity:\t%.2f\n',sqrt(ey(3)^2+ey(4)^2));
    fprintf('total vel angle:\t%.2f\n',radtodeg(atan2(ey(3),ey(4))));