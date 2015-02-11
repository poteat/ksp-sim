   
    global T II IF ME MF;

    type = 8;

    T = engine_thrusts(type);
    II = engine_atm_isps(type);
    IF = engine_vac_isps(type);
    ME = engine_masses(type);
    
    G = 9.82;
    TWR = 1.5;
    RAD = 6E5;
    ROT = 174.53;
    
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
    fprintf('x velocity:\t%.2f\n',ey(3));
    fprintf('y velocity:\t%.2f\n',ey(4));
    fprintf('total velocity:\t%.2f\n',sqrt(ey(3)^2+ey(4)^2));
    fprintf('total vel angle:\t%.2f\n',radtodeg(atan2(ey(3),ey(4))));